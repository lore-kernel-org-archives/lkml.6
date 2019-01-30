Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D81C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA2720870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfA3JGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:06:06 -0500
Received: from mx.socionext.com ([202.248.49.38]:31190 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfA3JGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:06:06 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jan 2019 18:06:05 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 7CFAE1800F6;
        Wed, 30 Jan 2019 18:06:05 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 30 Jan 2019 18:06:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 4C7074036D;
        Wed, 30 Jan 2019 18:06:05 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 315DE12185F;
        Wed, 30 Jan 2019 18:06:05 +0900 (JST)
Date:   Wed, 30 Jan 2019 18:06:05 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] regulator: uniphier: Constify uniphier_regulator_ops
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190130071110.26050-2-axel.lin@ingics.com>
References: <20190130071110.26050-1-axel.lin@ingics.com> <20190130071110.26050-2-axel.lin@ingics.com>
Message-Id: <20190130180604.4DEA.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:11:10 +0800 <axel.lin@ingics.com> wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/uniphier-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
> index 6ba0ae405f2b..9026d5a3e964 100644
> --- a/drivers/regulator/uniphier-regulator.c
> +++ b/drivers/regulator/uniphier-regulator.c
> @@ -32,7 +32,7 @@ struct uniphier_regulator_priv {
>  	const struct uniphier_regulator_soc_data *data;
>  };
>  
> -static struct regulator_ops uniphier_regulator_ops = {
> +static const struct regulator_ops uniphier_regulator_ops = {
>  	.enable     = regulator_enable_regmap,
>  	.disable    = regulator_disable_regmap,
>  	.is_enabled = regulator_is_enabled_regmap,

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards,
Kunihiko Hayashi


