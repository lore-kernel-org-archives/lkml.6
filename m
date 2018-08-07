Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62DBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636C921770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="PIpEDQmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636C921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbeHGSz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:55:57 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41886 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbeHGSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:55:57 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so1633400iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eKZOHbYgDIbHoNOX3tyBqBQamx+bpWaKoh+4+8/kq88=;
        b=PIpEDQmRYEq8FL/CefR1NORbolvrBYosMGsXZY8Z2EX/JhCGOA0tltLXH493hf0ufP
         uWeLp5TQadTbtKPjn5Yo686XIeWVCziH5RRN5LP9QzMCGKK+vBCbNX6WvhaFbe1suqVM
         6nD0SXAWRNV2IbRWi2+mMVXvAlYIQHDwNsyPLpAR2bNgbdsGlOp8jwwrAv2GVL1MSUpi
         3oCKnqxXMbs1VcK7vh+MrBvZ/OnHNPCAKBTyRr9NDTPcq52ZxuOzuxt+FScYxsiYRWTW
         pMV1iCFXy3AlMzkdf3XFfeckEPOW78XGvaWqex+LwXLBk44tw9qkEhJZJOsdS2/9wyPy
         hnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eKZOHbYgDIbHoNOX3tyBqBQamx+bpWaKoh+4+8/kq88=;
        b=tjx/h4n9MK3MpGvps0BRGcUURwp3KAKy3zIZuRqQX37wL3FzRf79c+7SI8uuMQZXab
         4al8UOLg5Ctyv/9AIMiuzEmTRswBPH7JPx3R87FTNi/WkmlIhy1bAd3Giw1S9ItHcw+E
         sZu7Ov6fk117cyz0wfIMRPWsJnCtprqdfpNTonvIv7J4ZBSGShbZfIYP5YLvH0W2i6sz
         hKTps5EucoI4dyUczqfa4MgcP1s7NCylH9KZ9FVHCi/cyIfF8ESSXRSNjRjvNZI48CAd
         QNtaFKY6O7Y1PrPO1f5cZigOjA1hebnweqTCXd9u6hloM9RNDDVE7ZrQvY/socYQZeTI
         HOvA==
X-Gm-Message-State: AOUpUlHt+Y29DwEHg60RwdBPTB1ssLeEN119AMr6fiApnb1EADYbVbXi
        s3Kswxpk1wp46NzxonmJnW9PKOfD6cD3cHPKGp2U+A==
X-Google-Smtp-Source: AAOMgpfGu8AkoVr/dfA9L5T6gTd0UhvPDx4w6zeL+/8PUNQynVhVFh+MVd33cFZ6Y/I4GYoSXSIf3MYHTE6EY6nDico=
X-Received: by 2002:a5e:c60c:: with SMTP id f12-v6mr20297912iok.108.1533660049316;
 Tue, 07 Aug 2018 09:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com> <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
 <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_8Rq6X24ZOYvG7+kQQGSGYAZuu_co4k1nJS8K7rkrWMA@mail.gmail.com>
 <alpine.LRH.2.02.1808061552090.11930@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 7 Aug 2018 18:40:36 +0200
Message-ID: <CAPv3WKdCMpy6KarducQEtSYP35zdELhparkmPPMKGMUhsdk1Qw@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, mpatocka@redhat.com
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard, Mikulas,

pon., 6 sie 2018 o 22:11 Ard Biesheuvel <ard.biesheuvel@linaro.org> napisa=
=C5=82(a):
>
> On 6 August 2018 at 21:54, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
> >
> >> On 6 August 2018 at 19:09, Mikulas Patocka <mpatocka@redhat.com> wrote=
:
> >> >
> >> >
> >> > On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
> >> >
> >> >> On 6 August 2018 at 14:42, Robin Murphy <robin.murphy@arm.com> wrot=
e:
> >> >> > On 06/08/18 11:25, Mikulas Patocka wrote:
> >> >> > [...]
> >> >> >>>
> >> >> >>> None of this explains why some transactions fail to make it acr=
oss
> >> >> >>> entirely. The overlapping writes in question write the same dat=
a to
> >> >> >>> the memory locations that are covered by both, and so the order=
ing in
> >> >> >>> which the transactions are received should not affect the outco=
me.
> >> >> >>
> >> >> >>
> >> >> >> You're right that the corruption couldn't be explained just by r=
eordering
> >> >> >> writes. My hypothesis is that the PCIe controller tries to disam=
biguate
> >> >> >> the overlapping writes, but the disambiguation logic was not tes=
ted and it
> >> >> >> is buggy. If there's a barrier between the overlapping writes, t=
he PCIe
> >> >> >> controller won't see any overlapping writes, so it won't trigger=
 the
> >> >> >> faulty disambiguation logic and it works.
> >> >> >>
> >> >> >> Could the ARM engineers look if there's some chicken bit in Cort=
ex-A72
> >> >> >> that could insert barriers between non-cached writes automatical=
ly?
> >> >> >
> >> >> >
> >> >> > I don't think there is, and even if there was I imagine it would =
have a
> >> >> > pretty hideous effect on non-coherent DMA buffers and the various=
 other
> >> >> > places in which we have Normal-NC mappings of actual system RAM.
> >> >> >
> >> >>
> >> >> Looking at the A72 manual, there is one chicken bit that looks like=
 it
> >> >> may be related:
> >> >>
> >> >> CPUACTLR_EL1 bit #50:
> >> >>
> >> >> 0 Enables store streaming on NC/GRE memory type. This is the reset =
value.
> >> >> 1 Disables store streaming on NC/GRE memory type.
> >> >>
> >> >> so putting something like
> >> >>
> >> >> mrs x0, S3_1_C15_C2_0
> >> >> orr x0, x0, #(1 << 50)
> >> >> msr S3_1_C15_C2_0, x0
> >> >>
> >> >> in __cpu_setup() would be worth a try.
> >> >
> >> > It won't boot.
> >> >
> >> > But if i write the same value that was read, it also won't boot.
> >> >
> >> > I created a simple kernel module that reads this register and it has=
 bit
> >> > 32 set, all other bits clear. But when I write the same value into i=
t, the
> >> > core that does the write is stuck in infinite loop.
> >> >
> >> > So, it seems that we are writing this register from a wrong place.
> >> >
> >>
> >> Ah, my bad. I didn't look closely enough at the description:
> >>
> >> """
> >> The accessibility to the CPUACTLR_EL1 by Exception level is:
> >>
> >> EL0              -
> >> EL1(NS)          RW (a)
> >> EL1(S)           RW (a)
> >> EL2              RW (b)
> >> EL3(SCR.NS =3D 1)  RW
> >> EL3(SCR.NS =3D 0)  RW
> >>
> >> (a) Write access if ACTLR_EL3.CPUACTLR is 1 and ACTLR_EL2.CPUACTLR is
> >> 1, or ACTLR_EL3.CPUACTLR is 1 and SCR.NS is 0.
> >> """
> >>
> >> so you'll have to do this from ARM Trusted Firmware. If you're
> >> comfortable rebuilding that:
> >>
> >> diff --git a/include/lib/cpus/aarch64/cortex_a72.h
> >> b/include/lib/cpus/aarch64/cortex_a72.h
> >> index bfd64918625b..a7b8cf4be0c6 100644
> >> --- a/include/lib/cpus/aarch64/cortex_a72.h
> >> +++ b/include/lib/cpus/aarch64/cortex_a72.h
> >> @@ -31,6 +31,7 @@
> >>  #define CORTEX_A72_ACTLR_EL1                   S3_1_C15_C2_0
> >>
> >>  #define CORTEX_A72_ACTLR_DISABLE_L1_DCACHE_HW_PFTCH    (1 << 56)
> >> +#define CORTEX_A72_ACTLR_DIS_NC_GRE_STORE_STREAMING    (1 << 50)
> >>  #define CORTEX_A72_ACTLR_NO_ALLOC_WBWA         (1 << 49)
> >>  #define CORTEX_A72_ACTLR_DCC_AS_DCCI           (1 << 44)
> >>  #define CORTEX_A72_ACTLR_EL1_DIS_INSTR_PREFETCH                (1 << =
32)
> >> diff --git a/lib/cpus/aarch64/cortex_a72.S b/lib/cpus/aarch64/cortex_a=
72.S
> >> index 55e508678284..5914d6ee3ba6 100644
> >> --- a/lib/cpus/aarch64/cortex_a72.S
> >> +++ b/lib/cpus/aarch64/cortex_a72.S
> >> @@ -133,6 +133,15 @@ func cortex_a72_reset_func
> >>         orr     x0, x0, #CORTEX_A72_ECTLR_SMP_BIT
> >>         msr     CORTEX_A72_ECTLR_EL1, x0
> >>         isb
> >> +
> >> +       /* ---------------------------------------------
> >> +        * Disables store streaming on NC/GRE memory type.
> >> +        * ---------------------------------------------
> >> +        */
> >> +       mrs     x0, CORTEX_A72_ACTLR_EL1
> >> +       orr     x0, x0, #CORTEX_A72_ACTLR_DIS_NC_GRE_STORE_STREAMING
> >> +       msr     CORTEX_A72_ACTLR_EL1, x0
> >> +       isb
> >>         ret x19
> >>  endfunc cortex_a72_reset_func
> >
> > Unfortunatelly, it doesn't work. I verified that the bit is set after
> > booting Linux, but the memcpy corruption was still present.
> >
> > I also tried the other chicken bits, it slowed down the system noticeab=
ly,
> > but had no effect on the memcpy corruption.
> >
>
> OK, it was worth a shot
>
> Let's wait and see if Marcin has any results.
>

After some self-caused setup issues I was able to run the test on my
MacchiatoBin with the kernel v4.18-rc8. It's been running for 1h+ now,
loading the CPU to 100% and no single error event...

I built the binary file with:
gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc=
 -O2

Maybe it's the older firmware issue? Please send the full bootlog with
the very first line after reset. My board rev is v1.3 and I use
mainline UEFI (newest edk2 + edk2-platforms) + newest publicly
available ARM-TF and earliest firmware for this board.

Best regards,
Marcin
