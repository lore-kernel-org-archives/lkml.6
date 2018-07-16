Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F86ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4DA20846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cghk16Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4DA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeGPB3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:29:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeGPB3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:29:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so433823wro.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqcjGGFWlD/UvkgTC4/e/u6/IDFLtLiTnLPArkfXW3w=;
        b=cghk16KidnYPduRRHa0xSsXLE+fr/SdYYwGynqkt+xJ63xvpimsAIXfiPKDkd4Cgwf
         lXdXYyX00nhYr5WiNzGinBZRt70oq/WZsCjCxw2LVWpMS8OvaNzLHlAQb0sMXgkYpWux
         sdaAmqmXbFNNjB7gUHFsMW6/PEifFVhwq5IGH4XinvkJogRQkRNIywNkAkvTnYceva8R
         GiP70P2X2KWpI05noh4cCBKs9SgO7e2uLoUZ+D4l1ZF2kqqlRvmPCtA+zfi9Q5sx9mhH
         lxMKFEcirTdjK/GieI22x2ADfDjsAiyaI6N1D888c/qPwAx+lWwuU7B9rTXT3/UGRvvn
         kTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqcjGGFWlD/UvkgTC4/e/u6/IDFLtLiTnLPArkfXW3w=;
        b=tt4Pjr+uIOWrE/4LAvCia5/J5eVcGksaGf9BDiA7zZVT3SvA6JWbwK7kEqlca6fry3
         6YbSzCG9w937MnJCGS7FoibZRHu++F8BzvAnMIqcl+9rC7BFvtpmAYPIiwlzdDsGeEox
         RWIrQRmXkKHrwkKbF74dbxIP4Eiod+AfcmUPpmXpV8aIiOsH/JarFuiNIh51VLdl0ZRs
         OEbJPmz9dzpqxr4n3KxAqJ8PetyBaXCI71ACxgu8EURFJfzxN9SIUfGIAKDajd+r9wem
         pfowHwOWV2r/r9P0B+YcGq31sO10+wc0fLgsDMGskryDGwWO3MUqVC20hSUEvzJZc9at
         5+EA==
X-Gm-Message-State: AOUpUlHq9BpoFGxMLdLoo+7vUBuMjn6SwxN64dQtOKdx4VpGtVjq8s/f
        A44kKm4xo+7q/rYgIAQBSHw=
X-Google-Smtp-Source: AAOMgpfu7T9hDPoLlioLE2YHzI0hli1LkWAW1xB8WgUgB0Q7moT2jb0OeVU4lPmOJ0MCtR9xG16N2A==
X-Received: by 2002:adf:cc0a:: with SMTP id x10-v6mr9971094wrh.242.1531703100793;
        Sun, 15 Jul 2018 18:05:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o13-v6sm10272177wmc.8.2018.07.15.18.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 18:05:00 -0700 (PDT)
Date:   Mon, 16 Jul 2018 03:04:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Subject: Re: [PATCH 7/7] x86,switch_mm: skip atomic operations for init_mm
Message-ID: <20180716010457.GA28744@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
 <20180710142833.26231-8-riel@surriel.com>
 <20180715230430.GD30102@gmail.com>
 <1531698583.26425.3.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531698583.26425.3.camel@surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> On Mon, 2018-07-16 at 01:04 +0200, Ingo Molnar wrote:
> > * Rik van Riel <riel@surriel.com> wrote:
> > 
> > > +		/*
> > > +		 * Stop remote flushes for the previous mm.
> > > +		 * Skip the idle task; we never send init_mm TLB
> > > flushing IPIs,
> > > +		 * but the bitmap manipulation can cause cache
> > > line contention.
> > > +		 */
> > > +		if (real_prev != &init_mm) {
> > > +			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
> > > +						mm_cpumask(real_pr
> > > ev)));
> > > +			cpumask_clear_cpu(cpu,
> > > mm_cpumask(real_prev));
> > 
> > BTW., could this optimization be (safely) extended to all (or most)
> > !task->mm 
> > kernel threads?
> > 
> > In particular softirq and threaded irq handlers could benefit greatly
> > I suspect in 
> > certain networking intense workloads that happen to active them.
> 
> Yes, it could.
> 
> Are there kernel threads that use something other than
> init_mm today?

Yeah, I think that's the typical case - so at minimum the comment should be fixed:

 > > > +	 * Skip the idle task; we never send init_mm TLB flushing IPIs,

and it should say 'skip kernel threads', right?

Thanks,

	Ingo
