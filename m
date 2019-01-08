Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04641C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69E3206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ZDw+Ubpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfAHOJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:09:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39314 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfAHOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so1986993pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8cM+kAXFL+8+AKuvU4SrjiPU40Ah66XIhWFYAtDRTRo=;
        b=ZDw+Ubpjw479aAo3fr761ssfrSZAR7dwocsU4M4iyjHvgVITm9stI4okOM+GiMPUin
         vlwscVezktbOv01q14nwLJ3xq24mLySbznsRj6W0U+Wvh/1RQLOR7C5vflgjOgwhYzSK
         FzXhc+etNz/R3gnErXrVBvFjTR7YRFSLoxFtTDm7kmHYuC+wp+UXcFqS7oPni4oG3tDi
         lij1pP7eJMYe5+HTjBEoI16YR+hderRzyT8LY8XmvYM2LgpMytfX3fX9+LZLqd5nwSiN
         SX9TQcFzvFEPKvBzfs00bdBgaSd5M9UBXovNw70vpr3cklXccsnq4FeRx5ROnX567vec
         6swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8cM+kAXFL+8+AKuvU4SrjiPU40Ah66XIhWFYAtDRTRo=;
        b=pwtp9QQPMyod9JHIJ46cECrCzS4OIpm9Ej/RZqdQKrqzMd2DcCMafLThZgVbJHiZtu
         7nKmww8HTv9EZNDp24ABGmknA9aeaxK1A9TF0sHjioIpLagHhb7OZP09rv2Coq129Rs2
         3ldYKY7z0SRexlgE9Bs3GG0TU+HJO0PXHG4GMFQkXePKmigMNMsUn6dLdCh+uuD2WVYK
         vz8F6ePcOrr2Ygn0JaJPypl8AjVHD4Osv9U7W5oLEWMVXOnY4JMK6dUr9/lBDKkxWkcj
         9UXw0o9VRCecOSQVlMWUS4Em1M7sx6OqW8Ra9rFTieP/a9ga+Q1l9wPcECOa7FQ9PSI9
         hd3w==
X-Gm-Message-State: AJcUukepiFxxk/VcgU+8qxDvi6k1JqvZKDWyISItRhCVsDYKLkm38GTL
        Bc+APqwPr3SVptTBl544SIcF5w==
X-Google-Smtp-Source: ALg8bN45AGQC2Hr/saQQLYBVHO+4qKbLOljy9eX7AFPium17siPfBsIvkKkb0q5gsC7roLlGOXmioQ==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr1657106pgq.189.1546956529239;
        Tue, 08 Jan 2019 06:08:49 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id c4sm143031535pfm.151.2019.01.08.06.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 06:08:48 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C6F5730025E; Tue,  8 Jan 2019 17:08:44 +0300 (+03)
Date:   Tue, 8 Jan 2019 17:08:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     Jiri Kosina <jikos@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190108140844.tgabxo325enuvu6y@kshutemo-mobl1>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <d4846cb2-2a4b-b8b3-daac-e5f51751bbf1@suse.cz>
 <nycvar.YFH.7.76.1901052016250.16954@cbobk.fhfr.pm>
 <fb0414ea-953b-0252-b1d1-12028b190949@suse.cz>
 <047f0582-a4d3-490d-7284-48dfdf9e9471@petrovitsch.priv.at>
 <nycvar.YFH.7.76.1901081235380.16954@cbobk.fhfr.pm>
 <8c9feac8-fecb-a56a-afaf-c1352a666991@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9feac8-fecb-a56a-afaf-c1352a666991@petrovitsch.priv.at>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:53:00PM +0100, Bernd Petrovitsch wrote:
> On 08/01/2019 12:37, Jiri Kosina wrote:
> > On Tue, 8 Jan 2019, Bernd Petrovitsch wrote:
> > 
> >> Shouldn't the application use e.g. mlock()/.... to guarantee no page 
> >> faults in the first place?
> > 
> > Calling mincore() on pages you've just mlock()ed is sort of pointless 
> > though.
> 
> Obviously;-)
> 
> Sorry for being unclear above: If I want my application to
> avoid suffering from page faults, I use simply mlock()
> (and/or friends) to nail the relevant pages into physical
> RAM and not "look if they are out, if yes, get them in" which
> has also the risk that these important pages are too soon
> evicted again.

Note, that mlock() doesn't prevent minor page faults. Mlocked memory is
still subject to mechanisms that makes the page temporary unmapped. For
instance migration (including NUMA balancing), compaction, khugepaged...

-- 
 Kirill A. Shutemov
