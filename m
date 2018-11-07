Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA6F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA6F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeKHFTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:19:05 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45129 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHFTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:19:05 -0500
Received: by mail-oi1-f177.google.com with SMTP id p144-v6so14844243oic.12;
        Wed, 07 Nov 2018 11:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IeEUQE/QIQAqRZEVX4kdlNEKWROD5nBGu5ezQOuTX9Q=;
        b=V4bb3NmRQGgWhJPss1j8opJIL0hrzqvDRA1zyWXN84DZ5Vh9bmL9Lj7qdmRhJS00hM
         slo/4AW/DGUfLBttgha/PfBRYwPgR+rAeXKZtNGlYKeXUdPGCFlJs6nPJdxT0/kQnDKt
         a9d0vY/jTZdr83VC2oiaNH1WCWQics79+M4jfx9I1kyN+EwR4qwrmWmgVWpac2KGyGLt
         Ej8q1dUeH8R0vVjNtK7MNko8uZvu0/hGRLzuYLLQJsksBnrA33ouJ0EYhjgSS2ITyQ1e
         ewpDn3QHun4FW9He6B9VNNThfhkrlcZP7TsPLdFf/RX0f9AE1liEDwnAD9Q34Dh+sXSM
         a3mg==
X-Gm-Message-State: AGRZ1gKHt6Tn06xrYv09gy2u4fhKjtuTRrR3zxv/JYCLFrNcdtFKs5em
        X9bvSM+1VWvaSMakngI+sJYH8re6NhFOVXf6II3VSDbE
X-Google-Smtp-Source: AJdET5fQX9yQnzf74OuJVXOF06TQpbpv6wVdVhVjZaTUcl/9ICy+HL9bl7ppHBf1KOlwQ9sJ/ZYs36AesgzY2HXYwGo=
X-Received: by 2002:aca:d415:: with SMTP id l21-v6mr987139oig.107.1541620035382;
 Wed, 07 Nov 2018 11:47:15 -0800 (PST)
MIME-Version: 1.0
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 7 Nov 2018 20:47:03 +0100
Message-ID: <CA+7wUsw9a3ecPHtPsMF71zjzmNqyASFP-X6Z_DVa108akVcN-g@mail.gmail.com>
Subject: Makefile:611: include/config/auto.conf: No such file or directory
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

Since commit:

80463f1b7bf9 kbuild: add --include-dir flag only for out-of-tree build

I can no longer run the bindeb-pkg rule. For example:

$ make O=wii ARCH=powerpc wii_defconfig
$ make -j8 O=wii ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- bindeb-pkg
...
  WRAP    arch/powerpc/boot/dtbImage.wii
INFO: Uncompressed kernel (size 0x89aa8c) overlaps the address of the
wrapper(0x600000)
INFO: Fixing the link_address of wrapper to (0x900000)
rm arch/powerpc/boot/wii.dtb
 fakeroot -u debian/rules binary
make KERNELRELEASE=4.19.0-rc3-wii+ ARCH=powerpc KBUILD_SRC= intdeb-pkg
/bin/bash ../scripts/package/builddeb
Makefile:611: include/config/auto.conf: No such file or directory
***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
make[11]: *** [syncconfig] Error 1
make[10]: *** [syncconfig] Error 2
make[9]: *** [include/config/auto.conf] Error 2
make[8]: *** [__sub-make] Error 2
cp: cannot stat '/tmp/linux/scripts/kconfig/Makefile:69: recipe for
target '\''syncconfig'\'' failed'$'\n''/tmp/linux/Makefile:555: recipe
for target '\''syncconfig'\'' failed'$'\n''Makefile:646: recipe for
target '\''include/config/auto.conf'\'' failed'$'\n''Makefile:24:
recipe for target '\''__sub-make'\'' failed': No such file or
directory

Would you be able to provide a patch to fix this ?

Thanks much,
