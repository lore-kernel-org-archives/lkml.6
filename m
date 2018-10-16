Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C42C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014AB21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kq9Dgv5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014AB21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeJQBDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36870 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeJQBDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:15 -0400
Received: by mail-it1-f193.google.com with SMTP id e74-v6so33106758ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKAUkAPuPDlFBmtURpYNjxr6/i+74M1VNtdiYpnxyyY=;
        b=Kq9Dgv5exf0x8iHKWtuCHgz/+KVeOJGl3cQGnIHXGmJFlGOx1m6QG6KPlV5wycgtIc
         vxaVh9MQuZkFFNkbT13ZoBd22N4NFiv6Xm6aEWfkSeMjj1FgWdBq1JqPhw4EkPMJOrmD
         9xdpq7/HNOtX8RAOYArnl6nlVLFwmIH3jJBh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKAUkAPuPDlFBmtURpYNjxr6/i+74M1VNtdiYpnxyyY=;
        b=rbsJqlp/ccxE4UtDy69w6Jxmry+WkPt5XKnWGv6lgAxobVNMcBs4VJUPlJ2llJ4Rfi
         h22Rn7AmT54Ja9q2yReAuNC1BLziliVc+ZNS83dRsc9OuzFTG8g/g05Nycg26wOJu1Kk
         IbX2ZJ92rrZF3pl0GBq4KkmcoO19aNGbfrrAy/YqAPLHsdKPMNdl6FmyXYlOb55dVaXO
         gKORIO2pCmPJKNdsWiWHyyWOBDKwj27GtzlHaeCav8nepZaf0D9TGTDnERCxtY8zvlIE
         ae7E6FzXLhWBfqj1XXwz0/EwKu2yQa1Mr4AcfPiusnXAaAYar05ja8HLH2a/zC2WODGe
         +eMw==
X-Gm-Message-State: ABuFfoiuEzRFGsU/vfLAz/bW4LC6yYBH+upp4joAyL54cZndzfyNE+sF
        fFnWfWSjnynFg3HHilXud9mhoxo2SF2w2XhAUSUEWg==
X-Google-Smtp-Source: ACcGV6305ioHwj8dYF2Nk7LTC2KpaoSw7BixDiB4+NRhIiYyEXKaTj/TYkKlUiaCoZEtkMK0AgcPBtDtPKgyKHI8iiM=
X-Received: by 2002:a02:844c:: with SMTP id l12-v6mr18462723jah.137.1539709912620;
 Tue, 16 Oct 2018 10:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
 <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
 <5BBE3751.7000908@linaro.org> <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
In-Reply-To: <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 16 Oct 2018 19:11:41 +0200
Message-ID: <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     l.luba@partner.samsung.com
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        b.zolnierkie@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Thu, 11 Oct 2018 at 13:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
>
> On 10/10/2018 07:30 PM, Thara Gopinath wrote:
> > Hello Lukasz,
> >
> > On 10/10/2018 11:35 AM, Lukasz Luba wrote:
> >> Hi Thara,
> >>
> >> I have run it on Exynos5433 mainline.
> >> When it is enabled with step_wise thermal governor,
> >> some of my tests are showing ~30-50% regression (i.e. hackbench),
> >> dhrystone ~10%.
> >
> > That is interesting. If I understand correctly, dhrystone spawns 16
> > threads or so and floods the system. In "theory", such a test should not
> > see any performance improvement and degradation. What is the thermal
> > activity like in your system? I will try running one of these tests on
> > hikey960.
> I use this dhrystone implementation:
> https://github.com/Keith-S-Thompson/dhrystone/blob/master/v2.2/dry.c
> It does not span new threads/processes and I pinned it to a single cpu.
>
> My thermal setup is probably different than yours.
> You have (on hikey960) probably 1 sensor for whole SoC and one thermal
> zone (if it is this mainline file:
> arch/arm64/boot/dts/hisilicon/hi3660.dtsi).
> This thermal zone has two cooling devices - two clusters with dvfs.
> Your temperature signal read out from that sensor is probably much
> smoother. When you have sensor inside cluster, the rising factor
> can be even 20deg/s (for big cores).
> In my case, there are 4 thermal zones, each cluster has it's private
> sensor and thermal zone. There is no 'SoC sensor' or 'PCB sensor',
> which is recommended for IPA.
> >>
> >> Could you tell me which thermal governor was used in your case?
> >> Please also share the name of that benchmark, i will give it a try.
> >> Is it single threaded compute-intensive?
> >
> > Step-wise governor.
> > I use aobench which is part of phoronix-test-suite.
> >
> > Regards
> > Thara
> >
> I have built this aobench and run it pinned to single big cpu:
> time taskset -c 4 ./aobench

Why have you pinned the test only on CPU4 ?
Goal of thermal pressure is to inform the scheduler of reduced compute
capacity and help the scheduler to take better decision in tasks
placement.
So I would not expect perf impact on your test as the bench will stay
pinned on the cpu4
That being said you obviously have perf impact as shown below in your results
And other tasks on the system are not pinned and might come and
disturb your bench

> The results:
> 3min-5:30min [mainline]
> 5:15min-5:50min [+patchset]
>
> The idea is definitely worth to investigate further.

Yes I agree

Vincent
>
> Regards,
> Lukasz
>
>
>
