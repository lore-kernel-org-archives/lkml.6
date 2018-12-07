Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCDF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RHVRUbiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCDF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLGKWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:22:13 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17062 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:22:13 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wB7AM8fp027207;
        Fri, 7 Dec 2018 19:22:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wB7AM8fp027207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544178129;
        bh=Yf6AxDu4U7+8MLpvY0iO13bqhI+uAvo7nNS0cd6bD0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RHVRUbiFgFn5gStlm+jBVupTU3D6qRDTREjc4KRmKt+hLa7/TZgLiACUzFAAeOiQp
         KHeJ0ctjoidumzw1Z1hZY2uWb5EYmK11G3pcX3MoqzD7rQ2PnB2Kx7xgfbbD7pvmXn
         C3uiifsyHrNKSAAby2XAscm+kKeP5TN7oNSGcOrzD2xZWcHBTxA7hc/Ro3yD5AvT25
         OI7qOMP9wqP7zzGIhzkVgGpl6XMSWMRoNPQFwH7Oa9FDTeJwJTbO2omsyulQ4HVZyQ
         YTKhnh8WuOd0Gtnzo/yx01UELyRy7hOcdG8IzSX0Zn3zClzqx91AJcSqHC2MWVmaCY
         3+oPKO1Nq0KPg==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id j3so1221762uap.3;
        Fri, 07 Dec 2018 02:22:08 -0800 (PST)
X-Gm-Message-State: AA+aEWa9ilb60J9S3sRXHtPaOXdWT8d6HnCShXGjFmLIut4bWAjrvyF0
        17DQ2ntk6FRoHp08Z1X3VNfLJ82pVbIl0WQIVAk=
X-Google-Smtp-Source: AFSGD/Xyv3As9wDc3LB8RvuCVPPmJyXXIjcGuGhZIRjF/hlpaI/od94qpdU0WpYrURNiEjXhLgJCeHeZyC8Rbej5l0M=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr677500uam.89.1544178127626;
 Fri, 07 Dec 2018 02:22:07 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
 <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu> <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
 <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
In-Reply-To: <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 7 Dec 2018 19:21:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROT8u5P1c4cXnDZwxZ-9RDGX_n2Xrbfu0TaPG68-EGzQ@mail.gmail.com>
Message-ID: <CAK7LNAROT8u5P1c4cXnDZwxZ-9RDGX_n2Xrbfu0TaPG68-EGzQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 9:54 PM Michal Simek <monstr@monstr.eu> wrote:
>
> On 06. 12. 18 6:27, Masahiro Yamada wrote:
> > Hi Michal,
> >
> > On Thu, Dec 6, 2018 at 12:41 AM Michal Simek <monstr@monstr.eu> wrote:
> >>
> >> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> >>> "make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
> >>> but it never works because Makefile assumes "system.unstrip" is
> >>> the name of DT.
> >>>
> >>> $ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
> >>>   [ snip ]
> >>> make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
> >>> make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
> >>> make: *** Waiting for unfinished jobs....
> >>>
> >>> Rip off the never-working target.
> >>>
> >>> In my understanding, simpleImage.<dt> works like a phony target that
> >>> generates multiple images. Reflect the behavior to the help message.
> >>>
> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>> ---
> >>>
> >>>  arch/microblaze/Makefile | 4 +---
> >>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> >>> index 0823d29..97e1384 100644
> >>> --- a/arch/microblaze/Makefile
> >>> +++ b/arch/microblaze/Makefile
> >>> @@ -89,9 +89,7 @@ define archhelp
> >>>    echo '* linux.bin    - Create raw binary'
> >>>    echo '  linux.bin.gz - Create compressed raw binary'
> >>>    echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
> >>> -  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
> >>> -  echo '                   - stripped elf with fdt blob'
> >>> -  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
> >>> +  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt>.dts linked in'
> >>>    echo '  *_defconfig      - Select default config from arch/microblaze/configs'
> >>>    echo ''
> >>>    echo '  Targets with <dt> embed a device tree blob inside the image'
> >>>
> >>
> >> I understand what you are trying to say but I would still like to keep
> >> information about unstrip file.
> >> It is correct that it is not build target. It is just generated file and
> >> message above was used for description what it is.
> >> Definitely agree that this should be the part of targets but it should
> >> be in description.
> >> The same is for missing description for simpleImage.<dt>.strip and
> >> simpleImage.<dt>.ub files.
> >>
> >> Thanks,
> >> Michal
> >>
> >
> > If we want to be precise to the current behavior,
> > we could describe more.
> > (Is it too much?)
> >
> >
> > Architecture specific targets (microblaze):
> > * linux.bin    - Create raw binary
> >   linux.bin.gz - Create compressed raw binary
> >   linux.bin.ub - Create U-Boot wrapped raw binary
> >   simpleImage.<dt> - Create the following images with
> > arch/macroblaze/boot/dts/<dt>.dts linked in
>
> type - microblaze
> maybe <dtb> here.


I will keep <dt> as is.

I see more <dt> references a few lines below:


  echo '  Targets with <dt> embed a device tree blob inside the image'
  echo '  These targets support board with firmware that does not'
  echo '  support passing a device tree directly. Replace <dt> with the'
  echo '  name of a dts file from the arch/microblaze/boot/dts/ directory'
  echo '  (minus the .dts extension).'






-- 
Best Regards
Masahiro Yamada
