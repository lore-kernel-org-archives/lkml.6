Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A41C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073BE20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073BE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeFUCys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:54:48 -0400
Received: from mx.socionext.com ([202.248.49.38]:40656 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754283AbeFUCyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:54:47 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Jun 2018 11:54:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 096CC6006F;
        Thu, 21 Jun 2018 11:54:47 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 21 Jun 2018 11:54:46 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 6854640361;
        Thu, 21 Jun 2018 11:54:46 +0900 (JST)
Received: from DESKTOPFLNNJ4T (unknown [10.213.132.95])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 4640B12013E;
        Thu, 21 Jun 2018 11:54:46 +0900 (JST)
From:   "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To:     "Mark Brown" <broonie@kernel.org>, <alsa-devel@alsa-project.org>
Cc:     "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180621024346.13131-1-suzuki.katsuhiro@socionext.com>
In-Reply-To: <20180621024346.13131-1-suzuki.katsuhiro@socionext.com>
Subject: Re: [PATCH] ASoC: uniphier: remove redundant check of PLL ID
Date:   Thu, 21 Jun 2018 11:54:43 +0900
Message-ID: <001e01d4090b$34b3b5f0$9e1b21d0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHUCQmucCMySucUq0WpkFRSZ9mnCaRqA6cQ
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got mistake (forget to remove unused variable).
I'll send v2. Sorry for confusing.

Regards,
--
Katsuhiro Suzuki


> -----Original Message-----
> From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Sent: Thursday, June 21, 2018 11:44 AM
> To: Mark Brown <broonie@kernel.org>; alsa-devel@alsa-project.org
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
> <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Suzuki, Katsuhiro/鈴木 勝博
> <suzuki.katsuhiro@socionext.com>
> Subject: [PATCH] ASoC: uniphier: remove redundant check of PLL ID
> 
> This patch removes redudant check of PLL ID. struct uniphier_aio_pll
> enable member has already been checked at is_valid_pll().
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  sound/soc/uniphier/aio-cpu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
> index 2d9b7dde2ffa..cfe69ab44b63 100644
> --- a/sound/soc/uniphier/aio-cpu.c
> +++ b/sound/soc/uniphier/aio-cpu.c
> @@ -224,10 +224,6 @@ static int uniphier_aio_set_pll(struct snd_soc_dai *dai,
int
> pll_id,
> 
>  	if (!is_valid_pll(aio->chip, pll_id))
>  		return -EINVAL;
> -	if (!aio->chip->plls[pll_id].enable) {
> -		dev_err(dev, "PLL(%d) is not implemented\n", pll_id);
> -		return -ENOTSUPP;
> -	}
> 
>  	ret = aio_chip_set_pll(aio->chip, pll_id, freq_out);
>  	if (ret < 0)
> --
> 2.17.1



