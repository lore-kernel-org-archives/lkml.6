Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B29C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCC420871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="n260AeEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCC420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeKSTFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:05:05 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:26321 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKSTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1542616926;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=AyiAKQum+RXiTls/RHPxHM7VRX12kcluwAqKaf04WlI=;
        b=n260AeEXzfr526EwCkn5fXNOjT0kG9e+sP8YXs9nzfklFsl8jNtu4YvIx3+RHwSk2O
        FRvWJMyjuGBp5bzag8H/QQ/GLqtHDGFM82LkktnOLfHZwV4BotgrOjsGFXUx5RXRClGI
        J8M2R+OBsyYkUHAoIy42jpSPZMtY+QBL8sDInXKkl+sk0gglXFcweLoxEFIG1nNY/zJZ
        BH/rmnsSB8vm/KmDGvCh++0YaXb07lK11Mh3rPsKIi3QT4htrvmc7R0jcFlDkCUYSQEA
        BaZxqML0JBSBMd8qsPaiLJk4+6V1qOqVvqWIBo+8DDArFIyzw4Z4IwD7akzgxc3HQhZT
        FZvg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zowDCvpOU="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.4 DYNA|AUTH)
        with ESMTPSA id c01a4cuAJ8fxApe
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 19 Nov 2018 09:41:59 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH RFC 4/5] gnss: sirf: add a separate supply for a lna
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20181118215801.12280-5-andreas@kemnade.info>
Date:   Mon, 19 Nov 2018 09:41:58 +0100
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1647CDC4-61E5-4673-B092-1124BAFC50D5@goldelico.com>
References: <20181118215801.12280-1-andreas@kemnade.info> <20181118215801.12280-5-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 18.11.2018 um 22:58 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> Devices might have a separate lna between antenna output of the gps
> chip and the antenna which might have a separate supply
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> drivers/gnss/sirf.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index 6a0e5c0a2d62..f7573ca2dacd 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -30,6 +30,7 @@ struct sirf_data {
> 	struct serdev_device *serdev;
> 	speed_t	speed;
> 	struct regulator *vcc;
> +	struct regulator *lna;
> 	struct gpio_desc *on_off;
> 	struct gpio_desc *wakeup;
> 	int irq;
> @@ -217,6 +218,7 @@ static int sirf_runtime_suspend(struct device *dev)
> 
> 	if (!data->on_off)
> 		return regulator_disable(data->vcc);
> +	regulator_disable(data->lna);
> 	ret = sirf_set_active(data, false);
> 
> 	if (ret)
> @@ -245,13 +247,20 @@ static int sirf_runtime_resume(struct device *dev)
> 		if (ret)
> 			goto err_close_serdev;
> 	}
> +
> +	ret = regulator_enable(data->lna);
> +	if (ret)
> +		goto err_disable_vcc;
> +
> 	ret = sirf_set_active(data, true);
> 
> 	if (!ret)
> 		return 0;
> 
> +err_disable_vcc:
> 	if (!data->on_off)
> 		regulator_disable(data->vcc);
> +
> err_close_serdev:
> 	serdev_device_close(data->serdev);
> 	return ret;
> @@ -340,6 +349,12 @@ static int sirf_probe(struct serdev_device *serdev)
> 		goto err_put_device;
> 	}
> 
> +	data->lna = devm_regulator_get(dev, "lna");
> +	if (IS_ERR(data->lna)) {
> +		ret = PTR_ERR(data->lna);
> +		goto err_put_device;
> +	}
> +
> 	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
> 			GPIOD_OUT_LOW);
> 	if (IS_ERR(data->on_off))
> -- 
> 2.11.0
> 
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

Looks good and to do what it is designed for.

Acked-by: H. Nikolaus Schaller <hns@goldelico.com>

BR and thanks,
Nikolaus

