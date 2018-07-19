Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF8120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF8120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGSNB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:01:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51935 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeGSNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:01:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id h3-v6so5563302wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvnmnPXJlQ0Um8Q0bTBreV7ZaIgy5mO3yM9Z9xMGshE=;
        b=hq/aQ3rH4gaa08eIDul7MxF+ue0McWRatn620/8TFInP/dFzEGAKBnJxKfjopqkB9e
         BTqJojd5vUzm4KXUPzy/XOgiSvNtdwSBQ3w8i4xzSZgtxncUIBBbxVxNr0LyuSIzS3JW
         nckW/6ttvTdybG38MWMi6isR0gI9vTo8Xck4qN0xcgrNqt88Jb8gkc44YHY0bpic839Y
         D+94QTCgEZZ7zgNyJVWOsr1oiDJ8vvC75ap+Lwemppprip36jA2G81rpwoqcI/FjHJxT
         i5aakKZPTbpUYNWFmhUeLxTphTCHHWQ5fmvWk6fZVGx2lrkSuK3k1TOiUlYrpz26wmtT
         mrJA==
X-Gm-Message-State: AOUpUlGkXTe9ipJNGvk54KVsJlfTVwUDOCa8bXEAv+X0JmAFOTfTcFBW
        kT3+tLwn7sdyvNEwEfg11BM=
X-Google-Smtp-Source: AAOMgpfsx+1jN0Q5bR798wblOm+s8S4WAwCeCpMvKAwcXz9siRSVuiIDlTsq0ZUcDN2X6koFTlf72Q==
X-Received: by 2002:a1c:dacb:: with SMTP id r194-v6mr4080780wmg.56.1532002743433;
        Thu, 19 Jul 2018 05:19:03 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g204-v6sm3352700wmd.26.2018.07.19.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:19:02 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 285F1124167; Thu, 19 Jul 2018 14:19:02 +0200 (CEST)
Date:   Thu, 19 Jul 2018 14:19:02 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/3] mm/page_alloc: Move ifdefery out of
 free_area_init_core
Message-ID: <20180719121902.GB8750@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-2-osalvador@techadventures.net>
 <20180718141150.imiyuust5txfmfvw@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718141150.imiyuust5txfmfvw@xakep.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:11:50AM -0400, Pavel Tatashin wrote:
> On 18-07-18 14:47:20, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > Moving the #ifdefs out of the function makes it easier to follow.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Hi Oscar,
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> Please include the following patch in your series, to get rid of the last
> ifdef in this function.

Hi Pavel,

I am about to send v2 with this patch included, but I just wanted to let you know
this:

> +		zone_set_nid(nid);

This should be:

zone_set_nid(zone, nid);

I fixed it up in your patch, I hope that is ok.

Thanks 
-- 
Oscar Salvador
SUSE L3
