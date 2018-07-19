Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6C920673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bFteLAY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6C920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbeGSRf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:35:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbeGSRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2jhj4DXQ3/3ZwZfiXWQkMJMkCgZN9DYlpJGWYlRo+cc=; b=bFteLAY0vVowvlQmqsaCzQnd3
        hfpbaf2jetQuTDpctZnugwCAY/w7pFEibKYI4+KBqIK2scq1gk+Qde8hpQPCeHC56CR4KtOKd2BMm
        4MKt2wOKuG9lD53Hl/NFV/NZRH/SqjjgXXWUY4RgX+WdiyJoPuwhxLV0C3Pq2gzPbficw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgC9f-0007Ht-0x; Thu, 19 Jul 2018 16:51:51 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgC9e-0005CW-AH; Thu, 19 Jul 2018 17:51:50 +0100
Date:   Thu, 19 Jul 2018 17:51:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 2/2] spi: add SPI controller driver for UniPhier SoC
Message-ID: <20180719165150.GI27938@sirena.org.uk>
References: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com>
 <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com>
X-Cookie: I'm having an emotional outburst!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 03:51:57PM +0900, Keiji Hayashibara wrote:

This all looks good, just a small number of fairly minor things - mostly
style points.

> @@ -0,0 +1,532 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * spi-uniphier.c - Socionext UniPhier SPI controller driver
> + *
> + * Copyright 2012      Panasonic Corporation
> + * Copyright 2016-2018 Socionext Inc.
> + */

Please make the entire comment a C++ one, it makes things look a bit
more joined up/intentional.

> +#define BYTES_PER_WORD(x)			\
> +({						\
> +	int __x;				\
> +	__x = (x <= 8)  ? 1 :			\
> +	      (x <= 16) ? 2 : 4;		\
> +	__x;					\
> +})

Could this be replaced with an inline function?  The usage seems fine
but it's a bit big for a macro.  The end result should be similar.

> +static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
> +{
> +	struct uniphier_spi_priv *priv = dev_id;
> +	u32 val, stat;
> +
> +	stat = readl(priv->base + SSI_IS);
> +	val = SSI_IC_TCIC | SSI_IC_RCIC | SSI_IC_RORIC;
> +	writel(val, priv->base + SSI_IC);
> +
> +	/* rx fifo overrun */
> +	if (stat & SSI_IS_RORID) {
> +		priv->error = -EIO;
> +		goto done;
> +	}
> +
> +	/* rx complete */
> +	if ((stat & SSI_IS_RCID) && (stat & SSI_IS_RXRS)) {

> +	}
> +
> +	return IRQ_HANDLED;
> +
> +done:
> +	complete(&priv->xfer_done);
> +	return IRQ_HANDLED;

This will unconditionally report IRQ_HANDLED even if none of the flags
were set by the hardware which will cause problems if something goes
wrong - the interrupt will continually be serviced and the interrupt
framework won't be able to mitigate or provide diagnostics.  It's better
to return IRQ_NONE if nothing is detected from the hardware.

> +static const struct of_device_id uniphier_spi_match[] = {
> +	{ .compatible = "socionext,uniphier-scssi", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_spi_match);

The binding document also listed socionext,uniphier-mcssi as a
compatible but this driver doesn't match that.

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltQwaUACgkQJNaLcl1U
h9D+vwf/QB0hDRvgpwKmsrintp5L0X9C5QHXOlJY9upI8zLuckq/za5oagV+3isN
/jUpnSHwOHpitUVQGu+oYEA5cSsDAzlht+PPS2MlA1ApnxcDvYA9sBpqceuSkS/d
iFxYiLKJc0ayZvwnWEbhUWHPMeTnLtLZBYKRp5RjYYozFY7Gz1ggESNZx6pvtq6u
aAsYSFDBeXfAtFtC7GRVVxMu3t1XPLy5KHkWrfLEW5Rgs6B/w4qVUq76BoiujmKn
NDmjrD8JVZaasa86k+WkhNAHXVmy6S9158TFRQnfJ8KaqqUqHlctZ/WEQEiDxBxK
ELZDhU7KwTsn18UcFNOZqMWNZiIIwQ==
=QLcy
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
