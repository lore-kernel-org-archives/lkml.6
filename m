Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D31DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E9620873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="138ooqGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E9620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeLLOMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:12:06 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53737 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeLLOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:12:05 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wBCEBx3l022715;
        Wed, 12 Dec 2018 23:12:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wBCEBx3l022715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544623920;
        bh=yZi4pgbqv9auihsP0UypF0PJ6OMwUo/ZGFkGyxCpJQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=138ooqGiduTmIhNmoGo97wetW368L9L+zWcMWDbJZhNSmrtNWUG9YgFzS7yOcfHNx
         7wnbwY4nrV1Ge4FySWhFRWgPVdY08BSZkkQ5gI9U3CRQXdfXgcizBTiV+wrlQOOD8Y
         8K4MqCMJXRJQexL4Njr4K21CbCr8fg5GBqjnG5WzLBylCVCUHiPKbYu4pwgUggoEXP
         CmnZueuQzkSaOkNAVf947JSAPbU7wr5ySKCPvY42zwBkxlKwQBadMxu2Qct5n04gf+
         F2DToEYNRnLgbbQxYSUU5EYgkb0B3hWiRFMt2JEqntMKzBetlcnBlFz+uGjnghZqhx
         REd6Yj8zl7NyA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id b74so11118783vsd.9;
        Wed, 12 Dec 2018 06:11:59 -0800 (PST)
X-Gm-Message-State: AA+aEWathumDijZoR1UTOGgT2yNZxN+RLDUFahPIFg9pNk2LIfeELOBr
        dBSMXWQI9xaL9UN5t3AkvFaIsknWR0jAmWw6SZc=
X-Google-Smtp-Source: AFSGD/Vc0QztHaNg3Ld7mebjFKcikVFegmnibQVgWjHpY3xwWiBOei0Zf4OMgidB+ZbOOZeB00oGx/ATnmrHQGeFLAs=
X-Received: by 2002:a67:485:: with SMTP id 127mr9660683vse.54.1544623918469;
 Wed, 12 Dec 2018 06:11:58 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <19c7bdab-8df8-f7c6-7921-9a4d43dbca64@monstr.eu> <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
 <938f1368-5e07-0178-5b99-d8331ce216f8@xilinx.com> <18fb7c8b-2b47-eb39-d80b-7137e7db466b@xilinx.com>
 <CAK7LNAT-RuvvwGy5Tf01_rWk4EtD0H+y4UPF=aa7B3YB8v692g@mail.gmail.com> <44c60aca-c9de-8459-aefa-5d95111f8e8e@xilinx.com>
In-Reply-To: <44c60aca-c9de-8459-aefa-5d95111f8e8e@xilinx.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Dec 2018 23:11:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAStadqOeS90pa_V0RarW8ePmp0YhvZPq_Y5-hwnRDVg4Q@mail.gmail.com>
Message-ID: <CAK7LNAStadqOeS90pa_V0RarW8ePmp0YhvZPq_Y5-hwnRDVg4Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot images
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:50 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 08. 12. 18 7:14, Masahiro Yamada wrote:
> > On Sat, Dec 8, 2018 at 12:20 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>
> >> On 07. 12. 18 14:29, Michal Simek wrote:
> >>> On 07. 12. 18 12:29, Masahiro Yamada wrote:
> >>>> On Thu, Dec 6, 2018 at 11:55 PM Michal Simek <monstr@monstr.eu> wrote:
> >>>>>
> >>>>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> >>>>>> This patch set fixes various issues in microblaze Makefiles.
> >>>>>>
> >>>>>> BTW, "simpleImage.<dt>" works like a phony target to generate the
> >>>>>> following four images, where the first three are just aliases.
> >>>>>>
> >>>>>>  - arch/microblaze/boot/simpleImage.<dt>:
> >>>>>>          identical to arch/microblaze/boot/linux.bin
> >>>>>>
> >>>>>>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
> >>>>>>          identical to vmlinux
> >>>>>>
> >>>>>>  - arch/microblaze/boot/simpleImage.<dt>.ub:
> >>>>>>          identical to arch/microblaze/boot/linux.bin.ub
> >>>>>>
> >>>>>>  - arch/microblaze/boot/simpleImage.<dt>.strip:
> >>>>>>          stripped vmlinux
> >>>>>>
> >>>>>> I am not sure how much useful those copies are,
> >>>>>> but, I tried my best to keep the same behavior.
> >>>>>>
> >>>>>> IMHO, I guess DTB=<dt> would be more sensible,
> >>>>>> but it is up to Michal.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Masahiro Yamada (7):
> >>>>>>   microblaze: fix cleaning of boot images
> >>>>>>   microblaze: adjust the help to the real behavior
> >>>>>>   microblaze: move "... is ready" message to arch/microblaze/Makefile
> >>>>>>   microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
> >>>>>>   microblaze: add linux.bin* and simpleImage.* to PHONY
> >>>>>>   microblaze: fix race condition in building boot images
> >>>>>>   microblaze: remove the unneeded code just in case file copy fails
> >>>>>>
> >>>>>>  arch/microblaze/Makefile          | 14 +++++++++-----
> >>>>>>  arch/microblaze/boot/Makefile     | 33 +++++++++++++++++----------------
> >>>>>>  arch/microblaze/boot/dts/Makefile |  5 +----
> >>>>>>  3 files changed, 27 insertions(+), 25 deletions(-)
> >>>>>>
> >>>>>
> >>>>> One more thing I have in my mind for a while is that will be good to
> >>>>> configure kernel build flags from DT and completely get rid of these
> >>>>> symbols.
> >>>>>
> >>>>> XILINX_MICROBLAZE0_USE_MSR_INSTR
> >>>>> XILINX_MICROBLAZE0_USE_PCMP_INSTR
> >>>>> XILINX_MICROBLAZE0_USE_BARREL
> >>>>> XILINX_MICROBLAZE0_USE_DIV
> >>>>> XILINX_MICROBLAZE0_USE_HW_MUL
> >>>>> XILINX_MICROBLAZE0_USE_FPU
> >>>>>
> >>>>> It means setup CPUFLAGS based on extracting that values from DT that it
> >>>>> all the time match the hardware.
> >>>>> It will also simplify all the CPUFLAGS logic which is in
> >>>>> arch/microblaze/Makefile.
> >>>>>
> >>>>> Do you have any idea how this can be done?
> >>>>
> >>>>
> >>>> I have no idea.
> >>>>
> >>>> Parsing DTS with sed or something would be possible, but ugly.
> >>>>
> >>>> In my opinion, the kernel should be multi platform image,
> >>>> in other words, it is the least common denominator
> >>>> of supported platforms.
> >>>>
> >>>> So, the kernel should enable all features that may or may not be used
> >>>> depending on platform.
> >>>>
> >>>> I do not know if this works for MB.
> >>>
> >>> Microblaze is soft core CPU where you can select if you want to have it
> >>> with multiplier, divider, barrel shifter, etc.
> >>> You can of course say that you don't have them and you have "universal"
> >>> kernel but very slow.
> >>> That's why user has to setup these configs which are converted to cflags
> >>> to say GCC what can be used.
> >>> And these configs can be simply parsed from dt.
> >>>
> >>> For example like this based on dtb (quick hack)
> >>>
> >>> for i in `echo use-msr-instr use-pcmp-instr use-barrel use-div
> >>> use-hw-mul use-fpu`; do
> >>>       UPPER=`echo $i | tr '-' '_' | tr '[a-z]' '[A-Z}'`
> >>>       echo $i $UPPER;
> >>>
> >>>       VAR=`fdtget -t i $FILE/arch/microblaze/boot/dts/system.dtb /cpus/cpu@0/
> >>> xlnx,$i`
> >>>       FLAGS+="CONFIG_XILINX_MICROBLAZE0_${UPPER}=${VAR} "
> >>> done
> >>>
> >>> make $FLAGS
> >>>
> >>>
> >>> When simpleImage is requested dt could be parsed to setup proper build
> >>> flags.
> >>
> >> One more thing I found is that I have done these changes
> >>
> >> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
> >> index bbd6968ce55b..dc6a6fee3ae2 100644
> >> --- a/arch/microblaze/kernel/setup.c
> >> +++ b/arch/microblaze/kernel/setup.c
> >> @@ -153,11 +153,13 @@ void __init machine_early_init(const char
> >> *cmdline, unsigned int ram,
> >>  #endif
> >>
> >>  #if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
> >> +#error MSR is enabled
> >>         if (msr) {
> >>                 pr_info("!!!Your kernel has setup MSR instruction but ");
> >>                 pr_cont("CPU don't have it %x\n", msr);
> >>         }
> >>  #else
> >> +#error MSR is not enabled
> >>         if (!msr) {
> >>                 pr_info("!!!Your kernel not setup MSR instruction but ");
> >>                 pr_cont("CPU have it %x\n", msr);
> >>
> >> and run MSR with 1
> >> make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
> >> arch/microblaze/kernel/setup.o
> >> it errors #error MSR is enabled
> >> and all is good.
> >>
> >> And when I run MSR with 0
> >> make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=0
> >> arch/microblaze/kernel/setup.o
> >> also getting #error MSR is enabled
> >> which is wrong.
> >>
> >> Is there any rule what can be setup at compilation time?
> >
> > You are trying to do very specific things,
> > I do not have a clean solution.
> >
> > I do not mind whatever you do in arch-Makefile.
>
> ok.
>
> >
> > If you look at stack_protector_prepare in arch/powerpc/Makefile,
> > it is parsing a file with awk to setup compiler flags.
>
> Ok. Will do more experiments with it.
>
> Can you please at least confirm me that config options passed via
> command line as above should be used instead of that one in .config?
> (Just want to understand why USE_MSR is so special that it is not
> working properly).




make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1

does not work.

It overrides only references in Makefiles.



C files still refer to include/generated/autoconf.h
which is created based on Kconfig.


KBUILD_CPPFLAGS +=
-DCONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=$(CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR)

might work although it is ugly.

(At least, CONFIG_ prefix should be ripped off)



-- 
Best Regards
Masahiro Yamada
