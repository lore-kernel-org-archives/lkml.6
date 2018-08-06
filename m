Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E46C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D04621715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyw8gubQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D04621715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbeHFTbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:31:42 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:45518 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHFTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:31:42 -0400
Received: by mail-io0-f170.google.com with SMTP id k16-v6so11632217iom.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=og55HE4hlGpsSAfftRfbzLhcNwVrXOhmkjhoQYF4bDY=;
        b=Vyw8gubQnZT5Jdo8eLAB8vXWWv31wdn7WFl4EzJzodNzPf+8Ic8QTAJSplMFKznGUW
         VXr9Q67xuR/GagjMJGOQCbj8B9KrMMczWPv1+WqSM0x7TYN5Prhc026f+vH5jJWtopG2
         itjuSatjDkj7U8Onl7W6Icwwosk+ZHYGLiqzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=og55HE4hlGpsSAfftRfbzLhcNwVrXOhmkjhoQYF4bDY=;
        b=DMPyWxqzNzd2Wvjie9TnvDpjI0v4qErXGXaOt4L/+gJw4XQp8KQIwjqqNOsf1Zfbr1
         Mh+Etlsu58jQ9GUwamcuOLXDJDdie3a2LleS+M/PaCcgs2m2/kaqNDkLKNpfvSeR2JQp
         JX6KkbGqtwef5bzd3qY9C3Ff8yJqshH2+JHwpzfudLnZdiNNbmfKwXeHC9UAa6oHWHTm
         DzmGLCmoua55N57c/aWqrnz6CMde4q/hJ9Q6+8KONKclOySbfpw2Ystdg1hNMZuGmdX3
         Agv0/JzGmbFLO3VoXoeN32jfp2L18OiQf4/0y+4S4muFHw6OuDUK6LUxVGNyCd90QsDF
         JvYw==
X-Gm-Message-State: AOUpUlHflRPvgfCc9hTddyGXcRUknG90uZ1gpLNtdahYgNfK6eUaK76w
        F7EedGM7NApIgWqEwkJ7EWAQ06dKwhozxtVAMA2b0A==
X-Google-Smtp-Source: AA+uWPx/8XYldhTHbIf0REiwOy/vZwO+HUEKGkq/LzwlRpAUuaQUA8cS+sj5kaWBdNULZAGh+CTC/BW/5GKal7UiXwo=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr16616138iob.60.1533576098187;
 Mon, 06 Aug 2018 10:21:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 10:21:37 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
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
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 19:21:37 +0200
Message-ID: <CAKv+Gu_8Rq6X24ZOYvG7+kQQGSGYAZuu_co4k1nJS8K7rkrWMA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 19:09, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>
>> On 6 August 2018 at 14:42, Robin Murphy <robin.murphy@arm.com> wrote:
>> > On 06/08/18 11:25, Mikulas Patocka wrote:
>> > [...]
>> >>>
>> >>> None of this explains why some transactions fail to make it across
>> >>> entirely. The overlapping writes in question write the same data to
>> >>> the memory locations that are covered by both, and so the ordering in
>> >>> which the transactions are received should not affect the outcome.
>> >>
>> >>
>> >> You're right that the corruption couldn't be explained just by reordering
>> >> writes. My hypothesis is that the PCIe controller tries to disambiguate
>> >> the overlapping writes, but the disambiguation logic was not tested and it
>> >> is buggy. If there's a barrier between the overlapping writes, the PCIe
>> >> controller won't see any overlapping writes, so it won't trigger the
>> >> faulty disambiguation logic and it works.
>> >>
>> >> Could the ARM engineers look if there's some chicken bit in Cortex-A72
>> >> that could insert barriers between non-cached writes automatically?
>> >
>> >
>> > I don't think there is, and even if there was I imagine it would have a
>> > pretty hideous effect on non-coherent DMA buffers and the various other
>> > places in which we have Normal-NC mappings of actual system RAM.
>> >
>>
>> Looking at the A72 manual, there is one chicken bit that looks like it
>> may be related:
>>
>> CPUACTLR_EL1 bit #50:
>>
>> 0 Enables store streaming on NC/GRE memory type. This is the reset value.
>> 1 Disables store streaming on NC/GRE memory type.
>>
>> so putting something like
>>
>> mrs x0, S3_1_C15_C2_0
>> orr x0, x0, #(1 << 50)
>> msr S3_1_C15_C2_0, x0
>>
>> in __cpu_setup() would be worth a try.
>
> It won't boot.
>
> But if i write the same value that was read, it also won't boot.
>
> I created a simple kernel module that reads this register and it has bit
> 32 set, all other bits clear. But when I write the same value into it, the
> core that does the write is stuck in infinite loop.
>
> So, it seems that we are writing this register from a wrong place.
>

Ah, my bad. I didn't look closely enough at the description:

"""
The accessibility to the CPUACTLR_EL1 by Exception level is:

EL0              -
EL1(NS)          RW (a)
EL1(S)           RW (a)
EL2              RW (b)
EL3(SCR.NS = 1)  RW
EL3(SCR.NS = 0)  RW

(a) Write access if ACTLR_EL3.CPUACTLR is 1 and ACTLR_EL2.CPUACTLR is
1, or ACTLR_EL3.CPUACTLR is 1 and SCR.NS is 0.
"""

so you'll have to do this from ARM Trusted Firmware. If you're
comfortable rebuilding that:

diff --git a/include/lib/cpus/aarch64/cortex_a72.h
b/include/lib/cpus/aarch64/cortex_a72.h
index bfd64918625b..a7b8cf4be0c6 100644
--- a/include/lib/cpus/aarch64/cortex_a72.h
+++ b/include/lib/cpus/aarch64/cortex_a72.h
@@ -31,6 +31,7 @@
 #define CORTEX_A72_ACTLR_EL1                   S3_1_C15_C2_0

 #define CORTEX_A72_ACTLR_DISABLE_L1_DCACHE_HW_PFTCH    (1 << 56)
+#define CORTEX_A72_ACTLR_DIS_NC_GRE_STORE_STREAMING    (1 << 50)
 #define CORTEX_A72_ACTLR_NO_ALLOC_WBWA         (1 << 49)
 #define CORTEX_A72_ACTLR_DCC_AS_DCCI           (1 << 44)
 #define CORTEX_A72_ACTLR_EL1_DIS_INSTR_PREFETCH                (1 << 32)
diff --git a/lib/cpus/aarch64/cortex_a72.S b/lib/cpus/aarch64/cortex_a72.S
index 55e508678284..5914d6ee3ba6 100644
--- a/lib/cpus/aarch64/cortex_a72.S
+++ b/lib/cpus/aarch64/cortex_a72.S
@@ -133,6 +133,15 @@ func cortex_a72_reset_func
        orr     x0, x0, #CORTEX_A72_ECTLR_SMP_BIT
        msr     CORTEX_A72_ECTLR_EL1, x0
        isb
+
+       /* ---------------------------------------------
+        * Disables store streaming on NC/GRE memory type.
+        * ---------------------------------------------
+        */
+       mrs     x0, CORTEX_A72_ACTLR_EL1
+       orr     x0, x0, #CORTEX_A72_ACTLR_DIS_NC_GRE_STORE_STREAMING
+       msr     CORTEX_A72_ACTLR_EL1, x0
+       isb
        ret x19
 endfunc cortex_a72_reset_func
