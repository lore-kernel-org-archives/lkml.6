Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A01C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188C8208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uYxl9csg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188C8208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeGHCcm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:32:42 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23258 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeGHCcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:32:41 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w682WJHK001705;
        Sun, 8 Jul 2018 11:32:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w682WJHK001705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531017139;
        bh=lAOfl8UtCkFdSQTVtY85zD9So3UHlU8AHXAMFeeA4Vc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uYxl9csgPPkTTF6fjV4bprWkZvKYBsCHuEp5Cue7NbkVINkcbBpMD/KzG4S76jY70
         SpO+Y3FRcT9NjL05gELJNg7umciQ85roxdFgUy6vVCxGQo2aaU6/N6ztzMa6OeSRMq
         H7yFK4cxMo2UVXGbyZ1OzTJbf8ApE4SPIYTptB8rcRkCyuEgjOLy2mm5anrdRZ2FpK
         RdDtriULGt3Sa5oxRNAoFiidXOsxw9lKOVZYe1hVL5HIrbfgFgjsFXZUoaGYdCn7DJ
         fZCNfP3Qme9tzEFFx3x8ebKD3o9XSr7/OU7Quej2VE45WGyO0dNHgyc4nom8BhVaCC
         jlS9Bhk0JeqIA==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id l143-v6so1422030vke.1;
        Sat, 07 Jul 2018 19:32:19 -0700 (PDT)
X-Gm-Message-State: APt69E07sRjU3E9O4cfuMp5gSYq9qEwGqF8XbgmSaR9e0x51XpZEYatC
        JorCS1JpJaYnEFIfIFabLhxx3dw9SyXzeIv+B0w=
X-Google-Smtp-Source: AAOMgpcI7fDm8Mi6OMPoYMVr33jwIFFQUd4fP/bdMwru/AD8sSnpLCYipwRYVtLYuWG63dK/pgAjll7qIPQNdZYLXQQ=
X-Received: by 2002:a1f:d982:: with SMTP id q124-v6mr9000374vkg.166.1531017138421;
 Sat, 07 Jul 2018 19:32:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 19:31:37 -0700 (PDT)
In-Reply-To: <20180707010709.16648-8-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com> <20180707010709.16648-8-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 11:31:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3DDC8JasQTCeOnYJCGoCsuPQcqHsSNm2BaLzaGR2e4g@mail.gmail.com>
Message-ID: <CAK7LNAS3DDC8JasQTCeOnYJCGoCsuPQcqHsSNm2BaLzaGR2e4g@mail.gmail.com>
Subject: Re: [PATCH 7/7] Kbuild: Use HOST*FLAGS options from the command line
To:     Laura Abbott <labbott@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-07 10:07 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> Now that we have the rename in place, reuse the HOST*FLAGS options as
> something that can be set from the command line and included with the
> rest of the flags.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d925af1fb11b..77c74b3cf30b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -360,10 +360,11 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
>  HOSTCC       = gcc
>  HOSTCXX      = g++
>  KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
> -               -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
> -KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
> -KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
> -KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS)
> +               -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
> +               $(HOSTCFLAGS)
> +KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> +KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> +KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS) $(HOST_LOADLIBES)


Please use HOSTLDLIBS instead of HOST_LOADLIBES.

All of these must be documented in Documentation/kbuild/kbuild.txt





-- 
Best Regards
Masahiro Yamada
