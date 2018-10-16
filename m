Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6219EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F0520881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0QG9ErD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F0520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJPPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:22:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37752 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:22:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so22162784wmt.2;
        Tue, 16 Oct 2018 00:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PilUNQpZQSyIi39y+c1LoG3f6sg2puV3ViOIFVB1NG0=;
        b=m0QG9ErDd9dT7vwSD6MfZ6+mDrRbj5sFNUianLofiVKTK5a6XGlOkP7qOgu2a0HUMw
         luENEoWDRKCCfMoJM7JBuA4BDUaM1DhxJBt2MBOWfD+rX7J3xqxTYQN8EWAJcTRLO0YA
         CoJO2PxBRdNsK6vDqCmCjCCCsqUj7ysFZI3RxIkABq4dlebzRTCLh6qysD8zs6bDO/7c
         b/3fPyir8RizjrVgKBkioUyrU6mmqNoF1n0iiQOBUI/OUOu0CRA+uZw/reGDOU/Rdk5X
         tDeWJToHBsT4IlAMKkG3bsgB3lMqPpn6VQbWs+akUA8U981nu39dUmoxr/9U8J1pWtkQ
         UCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PilUNQpZQSyIi39y+c1LoG3f6sg2puV3ViOIFVB1NG0=;
        b=G3abSh0bP8eJrAYbvHkCXKnYpk6asT9MRvoLEP4fbT9OcO1BG2xr1Q2GdBJ3J9KAOd
         MsJXjOoUsCVEI7vgfs3mbfCDzdwOarT8V5dXaDlVPhVFFyGI+6iu5gKL2GBONcuMRMwX
         oaUEssU/MnaYhQhmwErEwbostMnF6FMm/YGKDeX4TPMG1/Rd/WcDfuxcQBFGsn5m/hh6
         9bYytn77OPZu0ckU1zdQmYW0YF0mDXBuZMiPCNFGvN3zchG1zOBKGgwELC+GEPm8lWF2
         Wr4VkWnSFJSVXQFLwiDt340ufLEsRsgGFPDfU5hLInB10dhOa15XgR3IS7n8zXoWr9+W
         xv4Q==
X-Gm-Message-State: ABuFfohfw4zhn6+TTDnE2XgUH0qu8RsiKGQu38i5sofE/UTLrgEjEq3E
        aS6T897jZ839U0N/PcOM9ZU=
X-Google-Smtp-Source: ACcGV62GqkDuWL261R8KhOtAn3EyvPB6vH/MJpqRU9FEComFFVdn/Fpw62BpjOHPVeJ8Lz0DL9Uy0w==
X-Received: by 2002:a1c:7913:: with SMTP id l19-v6mr15096534wme.84.1539675188785;
        Tue, 16 Oct 2018 00:33:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s132-v6sm10131127wme.14.2018.10.16.00.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 00:33:08 -0700 (PDT)
Date:   Tue, 16 Oct 2018 09:33:05 +0200
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
Message-ID: <20181016073305.GA64994@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <5BBE1E1F.3030308@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BBE1E1F.3030308@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> >> Regarding testing, basic build, boot and sanity testing have been
> >> performed on hikey960 mainline kernel with debian file system.
> >> Further aobench (An occlusion renderer for benchmarking realworld
> >> floating point performance) showed the following results on hikey960
> >> with debain.
> >>
> >>                                         Result          Standard        Standard
> >>                                         (Time secs)     Error           Deviation
> >> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> >> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> > 
> > Wow, +13% speedup, impressive! We definitely want this outcome.
> > 
> > I'm wondering what happens if we do not track and decay the thermal 
> > load at all at the PELT level, but instantaneously decrease/increase 
> > effective CPU capacity in reaction to thermal events we receive from 
> > the CPU.
> 
> The problem with instantaneous update is that sometimes thermal events 
> happen at a much faster pace than cpu_capacity is updated in the 
> scheduler. This means that at the moment when scheduler uses the 
> value, it might not be correct anymore.

Let me offer a different interpretation: if we average throttling events 
then we create a 'smooth' average of 'true CPU capacity' that doesn't 
fluctuate much. This allows more stable yet asymmetric task placement if 
the thermal characteristics of the different cores is different 
(asymmetric). This, compared to instantaneous updates, would reduce 
unnecessary task migrations between cores.

Is that accurate?

If the thermal characteristics of the cores is roughly symmetric and the 
measured CPU-intense load itself is symmetric as well, then I have 
trouble seeing why reacting to thermal events should make any difference 
at all.

Are there any inherent asymmetries in the thermal properties of the 
cores, or in the benchmarked workload itself?

Thanks,

	Ingo
