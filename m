Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34421476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltSB+1Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B34421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeJROsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:48:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54477 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeJROsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:48:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so4227543wma.4;
        Wed, 17 Oct 2018 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qICEez6k7NHcxNO4YWd73U9T/lhEOGHEvPbel/lRMWk=;
        b=ltSB+1JfyToAvpfuJDvBQ0yyoFB5rghWq/sdK2i6wAB0rgHz1/EbJsJKckkbAR+MK4
         rS30I4u1mDXSUGJ0qAtE/aCTZzZCKb21KT7uuTP+EfTbWtoX+kG+y08Ts2dXRhCzMx7C
         b9pLCeUu8V73zWg0EhuoNLcOjzQE4CrUgltozKcLWIkmtOdYaYNvGUHiag3enlqm3qyB
         uD2M9wWarJtYH0/Rs1z+efnQhWHQ3tVk42mwiwXrQNToCONsJEZ1TLl6ldzZzqzxjW6O
         D8v7ivJK16EJDXdfPkgt+1crF2kw3gxtq0Grs6yCkmLdCNSJhKf1EfW/RDOc2UnPgu91
         CCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qICEez6k7NHcxNO4YWd73U9T/lhEOGHEvPbel/lRMWk=;
        b=aHjBds+/ipVHgcje20Mr/hwBUv408XJ9DTEdLA6U8AwJRK5Qc3PE02KMG8fZkLqOqi
         6+gNeyKO3KJVgBw51Rr9CvRG0z12vVjAEibU2mijfxvMo0hjQPDlks+uGXPKBq3VcPCh
         LpPi5vUyIDxRVaFHNdIFFR72ZuUrYhSFQV9AOaljnPujt8eE8yDY1aBb+AAZvf4hiQ1f
         om4u1h3JJ6vqbQfakc/0jHhn8M1j4W7BhQlGa3GAasgNX2CFpIgApjgUG6aHE/D5MqVF
         tLJY5f/+iz9ZMV16Y8MDc7rY3rwk7DRmM6N4ou7akfwsFBSjnLzYu7My/JCuoalPsFlA
         UVkA==
X-Gm-Message-State: ABuFfojxgC00XmAq4KRY/XdX2dhIGIuU2h7206MQuelG7Be/d4kKv9cC
        ANaGWxNt0hViji94XuZgDP8=
X-Google-Smtp-Source: ACcGV62JfCiqmfa2jydJtDNSCwqxdY0S44IT11jtfkZGbfh+7tmLOCgg4MstSHYGhDZ3n+xteHjq0w==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr6425626wmz.4.1539845332648;
        Wed, 17 Oct 2018 23:48:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j46-v6sm26662792wre.91.2018.10.17.23.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 23:48:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 08:48:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181018064849.GA42813@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
 <5BC76181.90105@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BC76181.90105@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> On 10/16/2018 03:33 AM, Ingo Molnar wrote:
> > 
> > * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > 
> >>>> Regarding testing, basic build, boot and sanity testing have been
> >>>> performed on hikey960 mainline kernel with debian file system.
> >>>> Further aobench (An occlusion renderer for benchmarking realworld
> >>>> floating point performance) showed the following results on hikey960
> >>>> with debain.
> >>>>
> >>>>                                         Result          Standard        Standard
> >>>>                                         (Time secs)     Error           Deviation
> >>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> >>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> >>>
> >>> Wow, +13% speedup, impressive! We definitely want this outcome.
> >>>
> >>> I'm wondering what happens if we do not track and decay the thermal 
> >>> load at all at the PELT level, but instantaneously decrease/increase 
> >>> effective CPU capacity in reaction to thermal events we receive from 
> >>> the CPU.
> >>
> >> The problem with instantaneous update is that sometimes thermal events 
> >> happen at a much faster pace than cpu_capacity is updated in the 
> >> scheduler. This means that at the moment when scheduler uses the 
> >> value, it might not be correct anymore.
> > 
> > Let me offer a different interpretation: if we average throttling events 
> > then we create a 'smooth' average of 'true CPU capacity' that doesn't 
> > fluctuate much. This allows more stable yet asymmetric task placement if 
> > the thermal characteristics of the different cores is different 
> > (asymmetric). This, compared to instantaneous updates, would reduce 
> > unnecessary task migrations between cores.
> > 
> > Is that accurate?
> 
> Yes. I think it is accurate. I will also add that if we don't average
> throttling events, we will miss the events that occur in between load
> balancing(LB) period.

Yeah, so I'd definitely suggest to not integrate this averaging into 
pelt.c in the fashion presented, because:

 - This couples your thermal throttling averaging to the PELT decay
   half-time AFAICS, which would break the other user every time the
   decay is changed/tuned.

 - The boolean flag that changes behavior in pelt.c is not particularly
   clean either and complicates the code.

 - Instead maybe factor out a decaying average library into
   kernel/sched/avg.h perhaps (if this truly improves the code), and use
   those methods both in pelt.c and any future thermal.c - and maybe
   other places where we do decaying averages.

 - But simple decaying averages are not that complex either, so I think
   your original solution of open coding it is probably fine as well. 

Furthermore, any logic introduced by thermal.c and the resulting change 
to load-balancing behavior would have to be in perfect sync with cpufreq 
governor actions - one mechanism should not work against the other.

The only long term maintainable solution is to move all high level 
cpufreq logic and policy handling code into kernel/sched/cpufreq*.c, 
which has been done to a fair degree already in the past ~2 years - but 
it's unclear to me to what extent this is true for thermal throttling 
policy currently: there might be more governor surgery and code 
reshuffling required?

The short term goal would be to at minimum have all the bugs lined up in 
kernel/sched/* neatly, so that we have the chance to see and fix them in 
a single place. ;-)

Thanks,

	Ingo
