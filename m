Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB24920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bEogNpHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB24920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeGXKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:13:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46990 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeGXKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:13:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so2429532pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4MTPCzM9245R9qY9OFIyiDdXqPHqNElACNry2zq5aq4=;
        b=bEogNpHJzhOQF/qpx4NSvAfUFN3HzV77JLehnUVaLom0p4SoOqbGTCJ8mOm5p8Numl
         1ynp5m/2quvaLAa+dIQK4FJlP67V8G0juXc3ESGGOD7nfMXqoCOV6U/A1cXw2Z4AG9JV
         kg3oZL/yJT4W49/TremBP2KeQxnrkElrCTEpr4WeWy4whRhwqHyVyID3ruuJZ5MbgTlt
         QOCqQvn/maAzjGpfUmcW06JUGSBD7XGqrPq+VibpYwaXppDTxKOer53Z0utLLI/KDoB6
         bSMkrXgxJjXmSHH7DyStpcSw/c04ZhKLiE0A/8x+mvalu3SM8tQmy/DNL8gdNrQMS/dm
         5SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4MTPCzM9245R9qY9OFIyiDdXqPHqNElACNry2zq5aq4=;
        b=sp2kXHDuWBnZss7TP5pEfiCKSYnu/FpZmPnrTFOnrnr24hL4dNG+u8wcYBjkza6MKq
         5SL+htcqjqvp9pFLuhB0KPgANWp1RZYg0jgDfnJoZvbq9qAYh3oaSdshNBv8g2AGxO9m
         P5C60pI6X5Qfw8pGyPeon7CLITyKO6nP+cZcONigvE1847IAS+SErP1EV1fsAHgrpc/6
         s7Sy3NOPCQy7+fvooRgeLbtrFS084a0WD1kJZ4Q3RFBNK1j336z551n49iXQkKuBgKiH
         NnFRQNerkC2DoEeMvyytbvhcnLJL53FYOyTdqE5ERMOyTO0qvzR3cB7IXRpJfsVRQVqK
         KLUg==
X-Gm-Message-State: AOUpUlEyu4E0UcOw9Tra3xdtpgwzE/L/XrZQOzZd3B8Mmi3L9kX0iuIQ
        A+4nRvarPZbKzFb8ZmxjrvRk3GiV/xIttw==
X-Google-Smtp-Source: AAOMgpdHhDD9NY92ZCucIVCCYqOc5KsvRnrvaISSvLDHhBcU1vC2IlnWpvruZqdV2Y25OXVWg8XSGg==
X-Received: by 2002:a63:5758:: with SMTP id h24-v6mr15453294pgm.432.1532423286132;
        Tue, 24 Jul 2018 02:08:06 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id c9-v6sm12473765pgp.38.2018.07.24.02.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 02:08:05 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D92FA3002A3; Tue, 24 Jul 2018 12:08:00 +0300 (+03)
Date:   Tue, 24 Jul 2018 12:08:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
Message-ID: <20180724090800.g43mmfnuuqwczzb2@kshutemo-mobl1>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
 <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
 <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
 <20180722035156.GA12125@bombadil.infradead.org>
 <alpine.DEB.2.21.1807231323460.105582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807231427550.103523@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807231427550.103523@chino.kir.corp.google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:33:08PM -0700, David Rientjes wrote:
> On Mon, 23 Jul 2018, David Rientjes wrote:
> 
> > > > The huge zero page can be reclaimed under memory pressure and, if it is, 
> > > > it is attempted to be allocted again with gfp flags that attempt memory 
> > > > compaction that can become expensive.  If we are constantly under memory 
> > > > pressure, it gets freed and reallocated millions of times always trying to 
> > > > compact memory both directly and by kicking kcompactd in the background.
> > > > 
> > > > It likely should also be per node.
> > > 
> > > Have you benchmarked making the non-huge zero page per-node?
> > > 
> > 
> > Not since we disable it :)  I will, though.  The more concerning issue for 
> > us, modulo CVE-2017-1000405, is the cpu cost of constantly directly 
> > compacting memory for allocating the hzp in real time after it has been 
> > reclaimed.  We've observed this happening tens or hundreds of thousands 
> > of times on some systems.  It will be 2MB per node on x86 if the data 
> > suggests we should make it NUMA aware, I don't think the cost is too high 
> > to leave it persistently available even under memory pressure if 
> > use_zero_page is enabled.
> > 
> 
> Measuring access latency to 4GB of memory on Naples I observe ~6.7% 
> slower access latency intrasocket and ~14% slower intersocket.
> 
> use_zero_page is currently a simple thp flag, meaning it rejects writes 
> where val != !!val, so perhaps it would be best to overload it with 
> additional options?  I can imagine 0x2 defining persistent allocation so 
> that the hzp is not freed when the refcount goes to 0 and 0x4 defining if 
> the hzp should be per node.  Implementing persistent allocation fixes our 
> concern with it, so I'd like to start there.  Comments?

Why not a separate files?

-- 
 Kirill A. Shutemov
