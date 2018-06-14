Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65F2FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27247208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27247208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754669AbeFNH1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:27:38 -0400
Received: from mx.socionext.com ([202.248.49.38]:10382 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeFNH1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:27:36 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 14 Jun 2018 16:27:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4EEE51800A6;
        Thu, 14 Jun 2018 16:27:35 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 14 Jun 2018 16:27:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C6AEF403A7;
        Thu, 14 Jun 2018 16:27:34 +0900 (JST)
Received: from DESKTOPFLNNJ4T (unknown [10.213.132.95])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 99859120142;
        Thu, 14 Jun 2018 16:27:34 +0900 (JST)
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
References: <20180529010640.18604-1-suzuki.katsuhiro@socionext.com>
In-Reply-To: <20180529010640.18604-1-suzuki.katsuhiro@socionext.com>
Subject: Re: [RESEND PATCH] media: helene: fix tuning frequency of satellite
Date:   Thu, 14 Jun 2018 16:27:31 +0900
Message-ID: <00c701d403b1$28015e20$78041a60$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHT9ulgQYo/mSROPkSzg34vWBLf9KRfdA+w
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch is wrong, I got a mistake.

DTV_FREQUENCY for satellite delivery systems, the frequency is in 'kHz' not 'Hz',
so original code is correct. 

Please forget this patch. Sorry for confusing...


Regards,
--
Katsuhiro Suzuki

> -----Original Message-----
> From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Sent: Tuesday, May 29, 2018 10:07 AM
> To: Abylay Ospan <aospan@netup.ru>; Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org>; linux-media@vger.kernel.org
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
> <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Suzuki, Katsuhiro/鈴木 勝博
> <suzuki.katsuhiro@socionext.com>
> Subject: [RESEND PATCH] media: helene: fix tuning frequency of satellite
> 
> This patch fixes tuning frequency of satellite to kHz. That as same
> as terrestrial one.
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  drivers/media/dvb-frontends/helene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/helene.c
> b/drivers/media/dvb-frontends/helene.c
> index 04033f0c278b..0a4f312c4368 100644
> --- a/drivers/media/dvb-frontends/helene.c
> +++ b/drivers/media/dvb-frontends/helene.c
> @@ -523,7 +523,7 @@ static int helene_set_params_s(struct dvb_frontend *fe)
>  	enum helene_tv_system_t tv_system;
>  	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
>  	struct helene_priv *priv = fe->tuner_priv;
> -	int frequencykHz = p->frequency;
> +	int frequencykHz = p->frequency / 1000;
>  	uint32_t frequency4kHz = 0;
>  	u32 symbol_rate = p->symbol_rate/1000;
> 
> --
> 2.17.0



