Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6935620989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qiVN8Weu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6935620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbeLFF2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:28:36 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27082 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFF2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:28:35 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wB65SQNt007698;
        Thu, 6 Dec 2018 14:28:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wB65SQNt007698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544074107;
        bh=kzOtbb4tpevJktViBvDn68r+SLqFyOEmV1kscoO1tEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qiVN8Weuqpe4mLmoq/haZ2oC3ZTdHR9uDs5wjKEXf23wjXYUb7Xfd2z0V1+TDOByS
         W/GDWHpm91i84QQQ0YuoBZ5L2+4f0tnB7prEMPBAZlinexfwLUNRocSXzG1YeByjzg
         dqWkodbIi/VssmrC6wOtGrKtWrXhibtVenKhRdlkTtokGzV81TyLL80zVr44OjDDn2
         pAo6p7yzTnOA8arX8M2ySFbQhnNDRQtzxOWErQ+H6r98r2iUWl0odIZXlxgv4HxYJY
         XnEHJE3r/yPSNXVDl7i1/R9xYx6mpDdxyf0QzVyeuoupToXB7+uIqP9IOK0Ntud1XH
         KKQ9tOhG8/rEw==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id v70so5227735vkv.7;
        Wed, 05 Dec 2018 21:28:27 -0800 (PST)
X-Gm-Message-State: AA+aEWZ6w33e4NQm3wgSzXCdZbVxZ21hVR1PhttnE5dd4uh8JiHcwV5L
        OQQ4CUw8aIg6lTF7rmItWXqkcK7SmeqfG/R7zaY=
X-Google-Smtp-Source: AFSGD/UMPfjeDcQ2hjoTWawGDn22MDr4+s/+D+76eRfuI9z6/9V0gEPlDwmU6JLYffk2cRE6rIX/bG5PzNlUcOzyzIg=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr11618110vki.84.1544074106175;
 Wed, 05 Dec 2018 21:28:26 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com> <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
In-Reply-To: <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 6 Dec 2018 14:27:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
Message-ID: <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Dec 6, 2018 at 12:41 AM Michal Simek <monstr@monstr.eu> wrote:
>
> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> > "make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
> > but it never works because Makefile assumes "system.unstrip" is
> > the name of DT.
> >
> > $ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
> >   [ snip ]
> > make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
> > make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
> > make: *** Waiting for unfinished jobs....
> >
> > Rip off the never-working target.
> >
> > In my understanding, simpleImage.<dt> works like a phony target that
> > generates multiple images. Reflect the behavior to the help message.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/microblaze/Makefile | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> > index 0823d29..97e1384 100644
> > --- a/arch/microblaze/Makefile
> > +++ b/arch/microblaze/Makefile
> > @@ -89,9 +89,7 @@ define archhelp
> >    echo '* linux.bin    - Create raw binary'
> >    echo '  linux.bin.gz - Create compressed raw binary'
> >    echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
> > -  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
> > -  echo '                   - stripped elf with fdt blob'
> > -  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
> > +  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt>.dts linked in'
> >    echo '  *_defconfig      - Select default config from arch/microblaze/configs'
> >    echo ''
> >    echo '  Targets with <dt> embed a device tree blob inside the image'
> >
>
> I understand what you are trying to say but I would still like to keep
> information about unstrip file.
> It is correct that it is not build target. It is just generated file and
> message above was used for description what it is.
> Definitely agree that this should be the part of targets but it should
> be in description.
> The same is for missing description for simpleImage.<dt>.strip and
> simpleImage.<dt>.ub files.
>
> Thanks,
> Michal
>

If we want to be precise to the current behavior,
we could describe more.
(Is it too much?)


Architecture specific targets (microblaze):
* linux.bin    - Create raw binary
  linux.bin.gz - Create compressed raw binary
  linux.bin.ub - Create U-Boot wrapped raw binary
  simpleImage.<dt> - Create the following images with
arch/macroblaze/boot/dts/<dt>.dts linked in
                     simpleImage.<dt>        : raw image
                     simpleImage.<dt>.ub     : raw image with U-Boot header
                     simpleImage.<dt>.unstrip: ELF (identical to vmlinux)
                     simpleImage.<dt>.strip  : stripped ELF
  *_defconfig      - Select default config from arch/microblaze/configs




If you want to modify as you like,
I will not touch it though.





BTW, "make ARCH=microblaze help" looks like follows:

* linux.bin    - Create raw binary
  linux.bin.gz - Create compressed raw binary
  linux.bin.ub - Create U-Boot wrapped raw binary
  simpleImage.<dt> - ELF image with /boot/dts/<dt>.dts linked in
                   - stripped elf with fdt blob
  simpleImage.<dt>.unstrip - full ELF image with fdt blob
  *_defconfig      - Select default config from arch/microblaze/configs




Since "arch" is not set anywhere, $(arch) is empty,
"ELF image with /boot/dts/<dt>.dts linked in" looks strange.



--
Best Regards
Masahiro Yamada
