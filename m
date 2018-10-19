Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858CAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E82148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3IRRqAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4E82148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJSVL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:11:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45841 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:11:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id e10-v6so38120740qtq.12;
        Fri, 19 Oct 2018 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96hz6EhFgEc1BSlQGsWFNwOcwLVKwGkXH+9+l6XZgF8=;
        b=V3IRRqAzgkAoqk6DA9MJN9dmeiMuW1Wftya01sVbd8lCY/1ASPAzX7Je5rk0N/ERmp
         4gu8nJumb19PT+QzVVkJLfCDYNG7oleh027CYy7CBaWSZKOX/OaHuinDc6ldbPbB1X2L
         HEkH0zfYa9SleB+Y3xupI5RnwGfqqT700z5zKi/UkoVQghCW48KIJGf5aJUfMjgXqwft
         amjWnTEH70GjkyZxQb8Az6Fx3CPibF1r+EMQaQ456sxvi+N7phlvhue5QAHtzfnLyAIu
         OKLW3jFdjLiUK0gX5ILxeG68NVYQrcZlckS89RoeDlP67rwjVCtslyNr3y3YgEVDgLkU
         k2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96hz6EhFgEc1BSlQGsWFNwOcwLVKwGkXH+9+l6XZgF8=;
        b=ee9TwyGEHl9vRQmub6ukgPOVU0qjsbHFsD8F3mPB6uWZ4Zf9FRR2gzIj0BZZDzsYEQ
         1z1CzNBDaIy7rP9UzXXYlGpRQ50VFZKv4PYWeGSV2pzslz1zMIasrmNyOJAyJzaGt8Nw
         j3ZSED9BIsa+PAl63vlOt5X9PMjcRKjBpRFRkSrcMZFQPA/OplkvkbaGmBp61KTCCuQL
         zKiEJmAlZrbcT84oWchHgS052mcBkWDa5ZD18msJrrVkAa/Hl79fWICEn7rRFrR6n5AR
         Aforr8kUskAmr3QSCdqk06A8tJ4GTSlihPmUcUyT56rnRanCU78UJ9QZxazwpD/sJ1s3
         Ozqg==
X-Gm-Message-State: AGRZ1gIMmbqx5h+GEave9bfopQ8kCtvicvyDMrl8y/SDpQ+T7VG1rmAE
        dDkuUZ9L8ElHbyPOthnY81RxI1KXoJSphtB6RSE=
X-Google-Smtp-Source: ACcGV61t2pyR+dOl/F2YGz12HEYD5JUX5ACwarWgiHTb/RrB7AAVPvmSXkuITRW6SV2Zrf0QLrUW20MxlttqPZFDUcQ=
X-Received: by 2002:ac8:191a:: with SMTP id t26-v6mr1249266qtj.327.1539954352070;
 Fri, 19 Oct 2018 06:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-5-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-5-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:05:40 +0300
Message-ID: <CAHp75Veb++-F3yd9r5h305UQFvBFosRQvmPDfTTMFak9ZNVc7g@mail.gmail.com>
Subject: Re: [PATCH 04/15] Platform: OLPC: Remove an unused include
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Also, the header is x86 specific, while there are non-x86 OLPC machines.

Same concern. as per patch 2.

Also, you might want to sort headers in alphabetical order.

>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index f99b183d5296..35a21c66cd0d 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -15,7 +15,6 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/olpc-ec.h>
> -#include <asm/olpc.h>
>
>  struct ec_cmd_desc {
>         u8 cmd;
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
