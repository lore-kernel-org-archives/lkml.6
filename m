Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAADC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F98F21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182513;
	bh=8bDLhtpjqtcPwLHO7MLpXhYHnIxJfSLZ5TPp6p5Oo+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aELY0b8GSNuF7Kb1ITLPTyjwLubUKxDeP6FwGQgohwsxxEOug7ns5saKqZyXqLSzL
	 g+RAGjCy5XztpuTvT+77hPEZ+MWr4ceyqe9BnYBpIQ1OCXee6m6gl6SgK8HMt3TPxe
	 fBK6Aervd7jL5OsTRHk17x9Y96wLhbqhSNEaLKl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfAVSlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:41:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45726 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfAVSlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W1s/pmqV5vhs0LtDo8Cq1aKgFIwXi/634gbbLgxxFRo=; b=RCZF/cp04KttuN7DhWHEUn6Nl
        88fiXIvmRKnHbQ1KRMZFMXHxTQGQ4n5VFLfTqWWRV2G+LB4rFhZVEpxTbe0XTUCSaNVOhRUljDaiZ
        VudTLXY+ZHxLrwfekQHfYoQIdD9noprF5r9QIDVQdBgnGuml3GXjlh3Cx0onTaEz+ioOU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm0za-00076A-RM; Tue, 22 Jan 2019 18:41:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0B1951127A85; Tue, 22 Jan 2019 18:41:46 +0000 (GMT)
Date:   Tue, 22 Jan 2019 18:41:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 2/8] ASoC: wcd9335: add support to wcd9335 codec
Message-ID: <20190122184146.GF7579@sirena.org.uk>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 03:06:10PM +0000, Srinivas Kandagatla wrote:

This all looks good apart from a couple of small things that should be
easy to fix:

> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 62bdb7e333b8..1c4904940621 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1100,6 +1100,12 @@ config SND_SOC_UDA1380
>          tristate
>  	depends on I2C
> =20
> +config SND_SOC_WCD9335
> +	tristate "WCD9335 Codec"
> +	depends on SLIMBUS
> +	select REGMAP_SLIMBUS
> +        tristate
> +
>  config SND_SOC_WL1273
>  	tristate
> =20

You should add this to SND_SOC_ALL_CODECS.

> +static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
> +{
> +	struct wcd9335_codec *wcd =3D data;
> +	unsigned long status =3D 0;
> +	int i, j, port_id;
> +	unsigned int val, int_val =3D 0;
> +	bool tx;
> +	unsigned short reg =3D 0;
> +
> +	for (i =3D WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0, j =3D 0;
> +	     i <=3D WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1; i++, j++) {
> +		regmap_read(wcd->if_regmap, i, &val);
> +		status |=3D ((u32)val << (8 * j));
> +	}
> +
> +	for_each_set_bit(j, &status, 32) {
> +		tx =3D (j >=3D 16 ? true : false);
> +		port_id =3D (tx ? j - 16 : j);

=2E..

> +	return IRQ_HANDLED;
> +}

This will report that it handled the interrupt unconditionally, this
means that if the interrupt fires in error or there's some bug the
interrupt will never be acknowledged (it looks like the chip requires
acks?) but the interrupt core won't be able to notice and handle the
problem as effectively as it could've done.  It's better to report
IRQ_NONE if nothing as handled so that the core can do error handling.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHY+kACgkQJNaLcl1U
h9CzfAf+OswX/S78qZTnvpZvhvVLvWu85Z4ncjctQIVF4XxsKHLMkRXl+Im9ZYff
48+Ol00x2bc8SCf6+5Lph6yaCV8bcSnbjSCnBgcwj2xuKrRWFkClL9A2oUKrzv7L
HCv2C2IB8QG7BiAOaEHjZFlKEk5jL+o/RCKrJsdl4gb8hafUEgbs91bd1LcnZh7v
aN94GltoAgV7Rb3pWMkIyBnLJnusEBZBKACPZ5993SRMGtOK0BDV9s61ENOYpDJg
agLlLCOaFMAB5QaB272lchyc84017fc1b0x3WIphY0q3MnV3hGsk0unLSc+qv/Ew
+jULVBImyVna0PDWOAXsG8GeVh1CAw==
=CcPS
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
