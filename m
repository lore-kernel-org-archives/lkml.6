Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3082C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247F12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VyOVATQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfBVEg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:36:58 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59217 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBVEg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:36:58 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1M4aerm032003
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:36:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1M4aerm032003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550810201;
        bh=wB4J53dyh1eupnmHqfUtT/Kz2aR6kGsZBFys8/QxeGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VyOVATQHQKL3ZE3qZVJoK742P59+nkOwvgITjn64ddcY0kntZMB+ORXW//3efsBVc
         NgNtOyWDjuODlg1ksXQsgxKkr4uXaEBcSxlKiDktIFwBFLmviEBQowR9+GXVR/fZ9I
         M0i/ZWmnF4xeRJrLO9B0TBmEA9r7a4yzLjXLh8aMk6jwDEI+zSNu0Slu9/OGplhnXF
         JQgLO+sE7P29jacwCTiUpiqVo9wi+70qpc+DdpUBSMdDXzVwSnl+g8XBFq6c/ZKSz9
         bVbgSd3t4+pxV2uQ7Jw8rOz/37B7KU8hVHIdDHr71KlCv0Ax/EL0pplfQ8rFggGDBX
         DrQE3A4CSrfZA==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id z11so821079uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 20:36:40 -0800 (PST)
X-Gm-Message-State: AHQUAuZt+gWSUTtpzKICFOLVLhf3QZXcoeuBVlX89ya5PG/KApP8/1HM
        njllMfMQtCtq0Gr5e/GWJRrXVvo9ztHzjMZ5sV8=
X-Google-Smtp-Source: AHgI3IZlDjchrAeRouuKwDRRTgZLgPZIO5SJAptQLwhNEyV2dOkYlPiYTlVkmQUj4S4Qo8CSoLZgjX43u4SL3iYXMiM=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr1235772uak.55.1550810199426;
 Thu, 21 Feb 2019 20:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20190221132853.32043-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20190221132853.32043-1-sakari.ailus@linux.intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Feb 2019 13:36:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR99+J1LOiy66+QA_uYf328B6EfecrBk0iUvuQEDnf5pQ@mail.gmail.com>
Message-ID: <CAK7LNAR99+J1LOiy66+QA_uYf328B6EfecrBk0iUvuQEDnf5pQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] headers_install.sh: Support __aligned(x) for
 uAPI headers
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Michael Forney <forney@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:29 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The headers-install.sh already supports __packed conversion to
> __attribute__((packed)) for uAPI headers but it does not support similar
> __aligned(x) conversion.
>
> Add support for __aligned(x).


I am not a big fan of sed scripting in headers_install.sh

Is it a problem to write __attribute__((aligned(x)) in UAPI headers?



> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  scripts/headers_install.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index 593f8879c641..9ed490f33a3a 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -36,6 +36,7 @@ do
>                 -e 's/__attribute_const__([[:space:]]|$)/\1/g' \
>                 -e 's@^#include <linux/compiler(|_types).h>@@' \
>                 -e 's/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g' \
> +               -e 's/(^|[^a-zA-Z0-9])__aligned(\([0-9 ]*\))([^a-zA-Z0-9_]|$)/\1__attribute__((aligned\2))\3/g' \
>                 -e 's/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g' \
>                 -e 's@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @' \
>                 "$SRCDIR/$i" > "$OUTDIR/$FILE.sed" || exit 1
> --
> 2.11.0
>


-- 
Best Regards
Masahiro Yamada
