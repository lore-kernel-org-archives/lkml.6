Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2F920874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2F920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeFUDJI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:09:08 -0400
Received: from mx.socionext.com ([202.248.49.38]:40843 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754071AbeFUDJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:09:07 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Jun 2018 12:09:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 04EB2180237;
        Thu, 21 Jun 2018 12:09:06 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 21 Jun 2018 12:09:06 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 6491940361;
        Thu, 21 Jun 2018 12:09:05 +0900 (JST)
Received: from DESKTOPFLNNJ4T (unknown [10.213.132.95])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3233912013E;
        Thu, 21 Jun 2018 12:09:05 +0900 (JST)
From:   "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To:     "Abylay Ospan" <aospan@netup.ru>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        <linux-media@vger.kernel.org>
Cc:     "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        =?iso-2022-jp?B?U3V6dWtpLCBLYXRzdWhpcm8vGyRCTmtMWhsoQiAbJEI+IUduGyhC?= 
        <suzuki.katsuhiro@socionext.com>
References: <20180529010920.20320-1-suzuki.katsuhiro@socionext.com>
In-Reply-To: <20180529010920.20320-1-suzuki.katsuhiro@socionext.com>
Subject: Re: [RESEND PATCH] media: helene: fix xtal frequency setting at power on
Date:   Thu, 21 Jun 2018 12:09:01 +0900
Message-ID: <001f01d4090d$34a04310$9de0c930$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHT9umtSSa4XH16V0CMcjXSHW020qRqK2tg
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mauro,

Ping...

If I got some mistake, please comment it...

Regards,
--
Katsuhiro Suzuki


> -----Original Message-----
> From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Sent: Tuesday, May 29, 2018 10:09 AM
> To: Abylay Ospan <aospan@netup.ru>; Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org>; linux-media@vger.kernel.org
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
> <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Suzuki, Katsuhiro/鈴木 勝博
> <suzuki.katsuhiro@socionext.com>
> Subject: [RESEND PATCH] media: helene: fix xtal frequency setting at power on
> 
> This patch fixes crystal frequency setting when power on this device.
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Acked-by: Abylay Ospan <aospan@netup.ru>
> 
> ---
> 
> Changes from before:
>   - Add Abylay's Ack
> 
> ---
>  drivers/media/dvb-frontends/helene.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/helene.c
> b/drivers/media/dvb-frontends/helene.c
> index 0a4f312c4368..8fcf7a00782a 100644
> --- a/drivers/media/dvb-frontends/helene.c
> +++ b/drivers/media/dvb-frontends/helene.c
> @@ -924,7 +924,10 @@ static int helene_x_pon(struct helene_priv *priv)
>  	helene_write_regs(priv, 0x99, cdata, sizeof(cdata));
> 
>  	/* 0x81 - 0x94 */
> -	data[0] = 0x18; /* xtal 24 MHz */
> +	if (priv->xtal == SONY_HELENE_XTAL_16000)
> +		data[0] = 0x10; /* xtal 16 MHz */
> +	else
> +		data[0] = 0x18; /* xtal 24 MHz */
>  	data[1] = (uint8_t)(0x80 | (0x04 & 0x1F)); /* 4 x 25 = 100uA */
>  	data[2] = (uint8_t)(0x80 | (0x26 & 0x7F)); /* 38 x 0.25 = 9.5pF */
>  	data[3] = 0x80; /* REFOUT signal output 500mVpp */
> --
> 2.17.0



