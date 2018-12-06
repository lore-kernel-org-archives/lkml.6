Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A7B20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2mIdiaBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A7B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeLFFJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:09:43 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17092 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFFJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:09:42 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wB659POx024823;
        Thu, 6 Dec 2018 14:09:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wB659POx024823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544072965;
        bh=Q14TTszRC0hOLLnvUnoEJ8pXkxxnNqLH9l7LvryZJCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2mIdiaBiYNtd62bc1o+8my7DrieDtcb5j587v23GD7gVqu/aXC6OUWYSVd5hMiMs1
         mtTmIgpRT1XWi+cN99k9HH9jN9idtymKqHrUAYHiYOhcwUh07XGiJ7kY3Xro1Rlvup
         Vug7QjvVvG1xueNy2i3TkYEWXeSvhlqN//pV2zNKcKW7BPCUsCwx40z3swDRf9oJBM
         Ntas2pr5TjzFlGHlKEuv6nZCMQ1TYtrhUguVBk9mJPOqOoYUU3vxSfbn49CwkXKRgU
         EcpMrASOv4bgFTYCmBppv//rNFQr/gBEJSdwXiroC+jeTFz7DusmugAkKD8aW/BqRC
         9rTwDzVRQVjPA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h18so13567010vsj.4;
        Wed, 05 Dec 2018 21:09:25 -0800 (PST)
X-Gm-Message-State: AA+aEWaWWrxxD0dhA1jiLpSlg/z66TL+Lw4xN+jfGrO6eWbk6df2tqRD
        5Vwf26G5Tdaik3ifIqgMjsVrxSP7Z22Pn5DnzzE=
X-Google-Smtp-Source: AFSGD/XKwRxTCy2aVVGMpSFoMpCppGnpi6OmhIHlJfjSOMj+HIsmm+WbmelIDNLXvJqbyONN2I18ZZwhTReirRg2YT0=
X-Received: by 2002:a67:a858:: with SMTP id r85mr11718186vse.215.1544072964462;
 Wed, 05 Dec 2018 21:09:24 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com> <dd726c23-7c37-2b38-5b9f-a4edc391511d@monstr.eu>
In-Reply-To: <dd726c23-7c37-2b38-5b9f-a4edc391511d@monstr.eu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 6 Dec 2018 14:08:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtiP2xnB3hK92QJ_GadnViCG7kxXW73RmjzQAxJM4GKQ@mail.gmail.com>
Message-ID: <CAK7LNARtiP2xnB3hK92QJ_GadnViCG7kxXW73RmjzQAxJM4GKQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot images
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Dec 6, 2018 at 1:41 AM Michal Simek <monstr@monstr.eu> wrote:
>
> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> > This patch set fixes various issues in microblaze Makefiles.
> >
> > BTW, "simpleImage.<dt>" works like a phony target to generate the
> > following four images, where the first three are just aliases.
> >
> >  - arch/microblaze/boot/simpleImage.<dt>:
> >          identical to arch/microblaze/boot/linux.bin
>
> It is not - fdt section should be empty.
> simpleImage has this section filled.
>
> >
> >  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
> >          identical to vmlinux
>
> The same here with filled section.


vmlinux is built anyway
for whatever target you are building.

What is the point of making a copy of vmlinux?
They are the same.
You can confirm it by 'diff'

$ export CROSS_COMPILE=microblaze-linux-
$ make ARCH=microblaze  defconfig
$ make -j8 ARCH=microblaze   simpleImage.system
$ diff arch/microblaze/boot/simpleImage.system.unstrip  vmlinux






> >
> >  - arch/microblaze/boot/simpleImage.<dt>.ub:
> >          identical to arch/microblaze/boot/linux.bin.ub
>
> as above.
>
> >
> >  - arch/microblaze/boot/simpleImage.<dt>.strip:
> >          stripped vmlinux
>
> And this is there because unstrip version is quite huge and for early
> issues you need to know only some symbols that's why debugger is not
> overflow with stuff which none needs.
> Maybe this is not an issue now but that strip version is used a lot.
>
>
> >
> > I am not sure how much useful those copies are,
> > but, I tried my best to keep the same behavior.
> >
> > IMHO, I guess DTB=<dt> would be more sensible,
> > but it is up to Michal.
>
> What do you mean by this exactly?


As I showed above,
arch/microblaze/boot/simpleImage.system.unstrip
is exactly the same as vmlinux.



arch/microblaze/boot/simpleImage.<dt>
is objcopy'ed binary of vmlinux.

arch/microblaze/boot/simpleImage.<dt>.ub
is objcopy'ed binary of vmlinux, with u-boot header prepended.

You have already build-rules for them.



It is true that the stripped image only exist in simpleImage,
but I think "arch/microblaze/boot/vmlinux.strip"
is a more sensible name.



What I want to point out is:
    "Which file should be compiled in",
    is a part of the configuration.
    We generally do not change the final
    target name just for the difference of
    configuration.
    For example, ARM just uses "vmlinux", "Image", "zImage", etc.
    Never duplicate target-specific copies depending on configuration.


Why does microblaze create copies for each DT
instead of using generic image like linux.bin, linux.bin.ub, etc. ?

If using generic image names is acceptable,
"make simpleImage.<dt>" is just a shorthand of
"make DTB=<dt> vmlinux linux.bin linux.bin.ub vmlinux.strip"


Only the benefit of this approach is,
you can keep all images for multiple boards at the same time.

$ make ARCH=microblaze simpleImage.board1
$ make ARCH=microblaze simpleImage.board2
$ make ARCH=microblaze simpleImage.board3




Since I do not know how many users rely on this usage,
I said "it is up to you".









> Definitely thanks for looking at this.
> Michal
>
>
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
>
>


-- 
Best Regards
Masahiro Yamada
