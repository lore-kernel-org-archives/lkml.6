Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3451AECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EC8208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHMU/oR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EC8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeISMTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeISMTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:19:19 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF1B208A3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537339372;
        bh=JJTzJVR6CXFC95ntnj1X5FbqkHNij0221zM2Lp9CKBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KHMU/oR+l0pWPBNIuCc9O5QurYpcINiMA8ImTTZ+TIfBatMLIwqUv9J41BegHDAM7
         G7a9tOhuHNZpYbKmPXQBRfRmAf9rW8f3spl5dnclT1rz83GPHnpBI+iyx75hJthMRs
         8G2ffloHEH3GyfDA9uOA2Gh0dL38Eu3gW1+zCsro=
Received: by mail-wm1-f42.google.com with SMTP id o18-v6so5484811wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:42:52 -0700 (PDT)
X-Gm-Message-State: APzg51COrPBpTFEm86dg3BSGfZ86Z8KSKa4QuUlNgLTSrREusz5RUBB1
        C+wySBRIiib70MCVzE4LoyYaCJbS7z7M40M87ZA=
X-Google-Smtp-Source: ANB0Vdbkx34XrV+Hi93+9W17Ro2eM/Tz+yGuajvmXLAh5r5DDYln/NqgI6UbeMVjKD5gXXJiqQS8IzLucz5MI11DbZQ=
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr19645351wmn.145.1537339370475;
 Tue, 18 Sep 2018 23:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <201809191129.m6L5SG90%fengguang.wu@intel.com>
In-Reply-To: <201809191129.m6L5SG90%fengguang.wu@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 19 Sep 2018 08:42:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcSLyQq3k30Duu8hMF68ABuRS6UwTu5UPY1wDZQ_0azvQ@mail.gmail.com>
Message-ID: <CAJKOXPcSLyQq3k30Duu8hMF68ABuRS6UwTu5UPY1wDZQ_0azvQ@mail.gmail.com>
Subject: Re: arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
 linux/crc32poly.h: No such file or directory
To:     lkp@intel.com
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 at 05:57, kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5211da9ca526a5adddee1ccd078e6e33a583ab36
> commit: faa16bc404d72a5afb857c924c83a5f691f83386 lib: Use existing define with polynomial
> date:   8 weeks ago
> config: powerpc-skiroot_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout faa16bc404d72a5afb857c924c83a5f691f83386
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
>                     from arch/powerpc/boot/decompress.c:42:
> >> arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error: linux/crc32poly.h: No such file or directory
>     #include <linux/crc32poly.h>
>              ^~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>
> vim +18 arch/powerpc/boot/../../../lib/xz/xz_crc32.c
>
>   > 18  #include <linux/crc32poly.h>
>     19  #include "xz_private.h"
>     20

Just for the record, fixed some time ago here:
https://patchwork.ozlabs.org/patch/963258/

Best regards,
Krzysztof
