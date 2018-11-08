Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC020857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZNUTWV5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FC020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeKHL57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:57:59 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45045 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:57:58 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA82OcX4017986;
        Thu, 8 Nov 2018 11:24:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA82OcX4017986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541643879;
        bh=FzkD13h1/QJSOXHOh6YknjUjQcwUZFOxzHd/uHqnNSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZNUTWV5UZ8SyUIZUS2NJifkUoNK9fFiKmXL1aSnTBmXd7BSWnJxmElah52cNrE0Li
         KZPwz4HnzjUYXTDyH/oQNCFMTkDIPFp6AgU7Khdm33TLBnNjPhbqA6qDNNOfXkRjNm
         50OUMExjzT/mwD8RR9BpwJp9pNrX3pExuNrpJzuo+Cfg+5hdQFI7TIJCiEq01Do11O
         EgW8TtWHn/vgf46kmFDdtKFgw9bAFYGnCQPpX4hDa+1y7BDFAg5k07s826EDvojNT3
         +SnAPUeAAnuxdJbKaLADHIesW5lA8v3FCtMCHlROTOGqitTievu+bPY6ZQ0S88yfuZ
         9CQIElySaPoTg==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id x1so4367531vsc.10;
        Wed, 07 Nov 2018 18:24:39 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ+GD0IRoeLGRPMac5nwa4xe9kLR/8l56rm5rG57P87UrlIF07O
        4pdo0JrvD+8dSm88HDUkipdad7zI7WJw4u6J5+c=
X-Google-Smtp-Source: AJdET5eysM5ZyWkSgc+anFkaocl8ivOXl3gUA8vEv017XtN+hOqjLzpnuP9xlU6P11OLI4K3DhMLH33WC3FzfOIVjCw=
X-Received: by 2002:a67:485:: with SMTP id 127mr1217641vse.54.1541643877935;
 Wed, 07 Nov 2018 18:24:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+7wUsw9a3ecPHtPsMF71zjzmNqyASFP-X6Z_DVa108akVcN-g@mail.gmail.com>
In-Reply-To: <CA+7wUsw9a3ecPHtPsMF71zjzmNqyASFP-X6Z_DVa108akVcN-g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 8 Nov 2018 11:24:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUbPF+QB7zjEjc2q=UQp4NGxrh3O33ML=bdtziER2gmA@mail.gmail.com>
Message-ID: <CAK7LNASUbPF+QB7zjEjc2q=UQp4NGxrh3O33ML=bdtziER2gmA@mail.gmail.com>
Subject: Re: Makefile:611: include/config/auto.conf: No such file or directory
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, Nov 8, 2018 at 4:48 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> Hi Yamada-san,
>
> Since commit:
>
> 80463f1b7bf9 kbuild: add --include-dir flag only for out-of-tree build
>
> I can no longer run the bindeb-pkg rule. For example:
>
> $ make O=wii ARCH=powerpc wii_defconfig
> $ make -j8 O=wii ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- bindeb-pkg
> ...
>   WRAP    arch/powerpc/boot/dtbImage.wii
> INFO: Uncompressed kernel (size 0x89aa8c) overlaps the address of the
> wrapper(0x600000)
> INFO: Fixing the link_address of wrapper to (0x900000)
> rm arch/powerpc/boot/wii.dtb
>  fakeroot -u debian/rules binary
> make KERNELRELEASE=4.19.0-rc3-wii+ ARCH=powerpc KBUILD_SRC= intdeb-pkg
> /bin/bash ../scripts/package/builddeb
> Makefile:611: include/config/auto.conf: No such file or directory
> ***
> *** Configuration file ".config" not found!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> make[11]: *** [syncconfig] Error 1
> make[10]: *** [syncconfig] Error 2
> make[9]: *** [include/config/auto.conf] Error 2
> make[8]: *** [__sub-make] Error 2
> cp: cannot stat '/tmp/linux/scripts/kconfig/Makefile:69: recipe for
> target '\''syncconfig'\'' failed'$'\n''/tmp/linux/Makefile:555: recipe
> for target '\''syncconfig'\'' failed'$'\n''Makefile:646: recipe for
> target '\''include/config/auto.conf'\'' failed'$'\n''Makefile:24:
> recipe for target '\''__sub-make'\'' failed': No such file or
> directory
>
> Would you be able to provide a patch to fix this ?


This is the one:
https://patchwork.kernel.org/patch/10667541/


It is already sitting in linux-next,
and I will also send a pull request to Linus shortly.




-- 
Best Regards
Masahiro Yamada
