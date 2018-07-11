Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61212087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jsomLmNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61212087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbeGKM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:26:16 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:31768 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732985AbeGKM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:26:16 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6BCM5Vp003589;
        Wed, 11 Jul 2018 21:22:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6BCM5Vp003589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531311726;
        bh=PjKqybW8YWqA5SJBqpSHEKjTnbNoo9buTC0d2EPEOZU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jsomLmNHugasKnv2glce72FdmK9RAcxxyqxwlOrsBzjB0Bmw98nQmwe0XLn+nZAjK
         71b4AafSuwcekb1ZV2ebtECVjgVdqJvQI5IKZCEEYFBD7hm1nbeN+5xrRza/qfMPy9
         VMi1wjv/VAlAxxCOQgPja/CoFXjq6dw0yXJ3DFYa59JhxTdijcDlLVBy32o9KFDd+W
         58vxm2zaqn8PB2P73W0Z+txVoxhj8sD6gw+wCZSM3QCQclYvwFuxLt4BsrW7TQcFjX
         eTemdIKPBTIK06oA9TZaF1nJUcjkVxJz0djYf0MRJ5x9TV4tmCSo5OmRkNWxM2chTa
         YsxhJSkQuU6PQ==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id t14-v6so16052057uao.8;
        Wed, 11 Jul 2018 05:22:05 -0700 (PDT)
X-Gm-Message-State: APt69E1xBhIA6TqnWU8PZISS4AAnWBFyirT04MRfKQkAbOXkj+F+DoPN
        /Ye6fCUX8Vnwv05gSSV5rR+iXxIVc+mPlV6bdZs=
X-Google-Smtp-Source: AAOMgpcHknBC1/QoQ4TkDzx38//6knVLdCjCHdPFICMXuRIix3Cu83oAbLGqX0vqQg8BHoH48KEdJwq4RDSbwZEPkX4=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr16742580uah.144.1531311724579;
 Wed, 11 Jul 2018 05:22:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 05:21:24
 -0700 (PDT)
In-Reply-To: <20180708152004.21679-5-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de> <20180708152004.21679-5-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 11 Jul 2018 21:21:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
Message-ID: <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from top-level Kconfig
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-09 0:19 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Instead of duplicating the source statements in every architecture just
> do it once in the toplevel Kconfig file.
>
> Note that with this the inclusion of arch/$(SRCARCH/Kconfig moves out of
> the top-level Kconfig into arch/Kconfig so that don't violate ordering
> constraits while keeping a sensible menu structure.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index dd4f3d3e644f..7ab7b148181b 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -168,10 +168,6 @@ config PGTABLE_LEVELS
>         default 3 if X2TLB
>         default 2
>
> -source "init/Kconfig"
> -
> -source "kernel/Kconfig.freezer"
> -
>  menu "System type"
>
>  #
> @@ -553,8 +549,6 @@ endchoice
>
>  endif
>
> -source "arch/sh/mm/Kconfig"


I noticed at least sh is broken
because "arch/sh/mm/Kconfig" is no longer included by anyone.

I am not doing further tests.


Please test *ALL* architectures.

If possible, matrix tests (arch, config-target), where
arch = arm, arm64, ...
config-target = allyesconfig, allnoconfig, alldefconfig, ...


Note:
scripts/diffconf is helpful.

-- 
Best Regards
Masahiro Yamada
