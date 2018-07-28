Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5DFC67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4972720873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jSoQ8gER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4972720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeG1EIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:08:51 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:38591 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeG1EIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:08:51 -0400
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com [209.85.217.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w6S2i6du000505
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 11:44:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w6S2i6du000505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532745847;
        bh=3bC6VNXoMq39JKqJOFluJdU8pcaf7GPqKbkwomi9Sm4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jSoQ8gERx5K1unIQnWxOCy8YbRBGFeMWlaDsg/04ziAh0tnrKAQZfKbb2puiwIofU
         viBRv2xdev61VXM6PgmrtVwoH+OAzucsvidStMa0oUnsyJVdpV0IQtpdthqOW5NxZy
         geGJUUK+zSEhwLyXnFoQL877hNho/xyiiTXtzdOcbk+mmoo77kkyna59M85nKfvkhF
         oFpFd1Tu3VsWUExpIV4UyN+Cl+0SCaphzQ7qKmd55H7CdWqk0JeWJ952F2TgYi6pZ8
         GKrlET1+mjoPPZn8XRjesa4BFE4BnY/+gqesRwT5tXzv0YYeGn8bb+yKUZ2SG4x3he
         NkcwIHKP0kLOg==
X-Nifty-SrcIP: [209.85.217.175]
Received: by mail-ua0-f175.google.com with SMTP id r18-v6so4569439ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 19:44:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlHrcHSmBmiVajBZEmM2sacSWX2RmQkyaChAMUasWOreRz83Iamu
        Gaq/tRFpngW/cIUzDkjbkpl74U4mpCxKJgbB578=
X-Google-Smtp-Source: AAOMgpfYIBGECx7Y/o4PnluptF0pRF8AlMidNuSZ3uR5Az9cAmoR6IkLmPw1mZ3VtDh8BbWRnKP3UWdoXpoNTS3DFDI=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr6219410uaf.199.1532745845879;
 Fri, 27 Jul 2018 19:44:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 19:43:25
 -0700 (PDT)
In-Reply-To: <1530853931-12061-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530853931-12061-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 28 Jul 2018 11:43:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_XrYKuv7OgTEt9RSGLbCe-XumV4QNKUtS2YT9HWMk3Q@mail.gmail.com>
Message-ID: <CAK7LNAS_XrYKuv7OgTEt9RSGLbCe-XumV4QNKUtS2YT9HWMk3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: remove unneeded -Iinclude/drm compiler flag
To:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunming Zhou <david1.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-07-06 14:12 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> I refactored the include directives under include/drm/ some time ago.
> This flag is unneeded.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Ping?


> ---
>
>  drivers/gpu/drm/scheduler/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/Makefile b/drivers/gpu/drm/scheduler/Makefile
> index bd0377c..7665883 100644
> --- a/drivers/gpu/drm/scheduler/Makefile
> +++ b/drivers/gpu/drm/scheduler/Makefile
> @@ -20,7 +20,6 @@
>  # OTHER DEALINGS IN THE SOFTWARE.
>  #
>  #
> -ccflags-y := -Iinclude/drm
>  gpu-sched-y := gpu_scheduler.o sched_fence.o
>
>  obj-$(CONFIG_DRM_SCHED) += gpu-sched.o
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
