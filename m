Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2ED20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jlSCQlJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2ED20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGSI41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:56:27 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38335 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeGSI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:56:27 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6J8EKWp004674
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:14:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6J8EKWp004674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531988061;
        bh=wdkom5pGY4Zw4zIGSIfgPphEwdD+/nKM44WLn9dc/3E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jlSCQlJ78ArY5P+sVHIHb7spIuiSV403Gnyp0NBBGVfJenbdUnxL7IYdqOObqMFM1
         Refe2DQ6wiHHxr15ke0KqLzj2YwPEDJVMMa92znMChUIxXMUY+ECzHY+AE4+aowsbC
         pdISOvs/zREWh6LpP94VFXmd1WyqWdfKnERDlinENsbuiOolCs7ICcxbx4Bi8ag+a1
         lzOBPmBhcDxIlJqTi3XS3oztb4lbeEj7BUd4KN0xki9XxaiX+Yak7AAbXG0JGZ4s1E
         k3XaN3iaWR2yMCTlQKo2uDLAJzZ2FSNGl/qfP9lsqPK9x3aeFQ7OibKBmo86pDZI6p
         fTvGvkNOr2zuw==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id o82-v6so2103618vko.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:14:21 -0700 (PDT)
X-Gm-Message-State: AOUpUlHFnhBkXg6YZPAjZWghLEIbW0F5bGhLcZAoTHJJZRz23PKGm2z/
        Vln1s/7L1yMqVXHxWLE9G8+xMCdw4dDqnuHVQsQ=
X-Google-Smtp-Source: AAOMgpdf4BF20ori9OnxK3oMkzv4qIaY0FFWf4im8Zj147Oup+oTRnuOgexz5LBdMtaQc9b3nHnjgvh19KFQOKAxWOw=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr5195796vkj.160.1531988059933;
 Thu, 19 Jul 2018 01:14:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 01:13:39
 -0700 (PDT)
In-Reply-To: <1531981133-25881-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1531981133-25881-1-git-send-email-hayashibara.keiji@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 17:13:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASajYVUUz0Ggvpco9HhZVwp0Yw_t82Lq6YKXgsN0wLDGA@mail.gmail.com>
Message-ID: <CAK7LNASajYVUUz0Ggvpco9HhZVwp0Yw_t82Lq6YKXgsN0wLDGA@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier: add reset control support for SPI
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 15:18 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>
> Add reset control for SPI controller on UniPhier SoCs.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  drivers/reset/reset-uniphier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index e9030ff..5605745 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -202,6 +202,12 @@ static const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
>  #define UNIPHIER_PERI_RESET_FI2C(id, ch)               \
>         UNIPHIER_RESETX((id), 0x114, 24 + (ch))
>
> +#define UNIPHIER_PERI_RESET_SCSSI(id)                  \
> +       UNIPHIER_RESETX((id), 0x110, 17)
> +
> +#define UNIPHIER_PERI_RESET_MCSSI(id)                  \
> +       UNIPHIER_RESETX((id), 0x114, 14)
> +
>  static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
>         UNIPHIER_PERI_RESET_UART(0, 0),
>         UNIPHIER_PERI_RESET_UART(1, 1),
> @@ -212,6 +218,7 @@ static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
>         UNIPHIER_PERI_RESET_I2C(6, 2),
>         UNIPHIER_PERI_RESET_I2C(7, 3),
>         UNIPHIER_PERI_RESET_I2C(8, 4),
> +       UNIPHIER_PERI_RESET_SCSSI(11),
>         UNIPHIER_RESET_END,
>  };
>
> @@ -227,6 +234,8 @@ static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
>         UNIPHIER_PERI_RESET_FI2C(8, 4),
>         UNIPHIER_PERI_RESET_FI2C(9, 5),
>         UNIPHIER_PERI_RESET_FI2C(10, 6),
> +       UNIPHIER_PERI_RESET_SCSSI(11),
> +       UNIPHIER_PERI_RESET_MCSSI(12),
>         UNIPHIER_RESET_END,
>  };
>
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
