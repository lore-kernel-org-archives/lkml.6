Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18436C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E952086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="09Er2Wjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E952086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeH2Lt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbeH2Lt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:49:56 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70DF208A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535529260;
        bh=+H2ib91lwvVewJjgeuTX0Wi2nA5sDXLzVGwbnvSCCgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=09Er2Wjwc2yeFwWnOrOVwwAnO+4dJHki1gWdskPShZvpGEomO+onlBaYc+un7z3FO
         15Mnqx3ucvh/5y6/5E8bAR2c4m0nqBYmh4+YJh3oQTJjeWmgcfR9Xi7Jm748q4zBkF
         o3GVJrZrl77feUks3tVEO3XVjlbDB0V6mT+TD6os=
Received: by mail-wr1-f54.google.com with SMTP id z96-v6so3836195wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:54:19 -0700 (PDT)
X-Gm-Message-State: APzg51BCkOX5YA1RkXC9x/LfpeylcBFJz5TjvJdfUf0b8DwAdl2IuyMj
        SUt/fJnhxy1WhD9jCsofgwwRkflNdcyy06XiD+U=
X-Google-Smtp-Source: ANB0VdZqiP6qX3gwLX2ER8JsF7v9IW1R1FT3jljUJ/4Wz5ZcEkNTgHzlOlY9VVumqoxhcW/amjtNKJJhG8I9RSpYKBo=
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr3671989wra.100.1535529258404;
 Wed, 29 Aug 2018 00:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <201808231135.g1h963MQ%fengguang.wu@intel.com>
In-Reply-To: <201808231135.g1h963MQ%fengguang.wu@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 09:54:07 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdWA36UuLeeD7faLDVXnFZryahbO=KNsAnutGmLoFJ0LQ@mail.gmail.com>
Message-ID: <CAJKOXPdWA36UuLeeD7faLDVXnFZryahbO=KNsAnutGmLoFJ0LQ@mail.gmail.com>
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

On Thu, 23 Aug 2018 at 05:44, kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   815f0ddb346c196018d4d8f8f55c12b83da1de3f
> commit: faa16bc404d72a5afb857c924c83a5f691f83386 lib: Use existing define with polynomial
> date:   4 weeks ago
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
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Sorry for late reply, I was on vacation.

Reported also few days later by Michal Kubecek:
https://lkml.org/lkml/2018/8/28/863

I fixed it here:
https://patchwork.ozlabs.org/patch/963258/

Best regards,
Krzysztof
