Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FCECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A8121477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N+TgSGdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A8121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390943AbeIUWVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:21:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44240 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390281AbeIUWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rM3YFzC592u/Ruld8gNJDOXm5+6G+BkszvYnnvZ/XEo=; b=N+TgSGdto6iHm6mRFNT9WzShs
        G8juaPmqn0e6sjksSRw+j/7rHgA2N8RQ45OkF0ovnOU92rFAjDjfT/m3r7NrxiNu4TmB4/IFSfS3x
        gliz+qOlr6YcYUIloxRfAGgFh4DARDJDH4xKS0xJBt3oNqZR7GChgvU5pXcaRvVFfwmis=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3OLA-0000eb-R8; Fri, 21 Sep 2018 16:31:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C7C27440078; Fri, 21 Sep 2018 17:31:34 +0100 (BST)
Date:   Fri, 21 Sep 2018 09:31:34 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Message-ID: <20180921163134.GD20825@sirena.org.uk>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <20180920224055.164856-2-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20180920224055.164856-2-ryandcase@chromium.org>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 20, 2018 at 03:40:55PM -0700, Ryan Case wrote:

> +static int qcom_qspi_setup(struct spi_device *spi)
> +{

> +	/*
> +	 * Ensure that the configuration goes through by reading back
> +	 * a register from the IO space.
> +	 */
> +	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);

Your setup() function shouldn't be affecting the status of the hardware
for any other SPI devices using the controller, otherwise it might
disturb an active transfer.  prepare_message() is typically the best
place to do this stuff.

Otherwise this looks good.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulHOUACgkQJNaLcl1U
h9AQAgf/Zh+oen4pzwNai7h7WkEDetUqq8QAgw3/J0FeM13RQmJLz0TTqfn7mKGD
5BbkdhnehODoAedL7aZEImHgmp5rx/IcUlqixyeDDkZaAPpXRqNEQuAJKNGlZWWG
MpedK4gy41VbTEfDTPEYIvFzA6MoPrF/yA96qC6g6RgGWR4QpO+8DbXsFeyoxH9u
h48XP4ttP2Cwz1mn+KpdblKH8MZnXZM2JuDEHfoQsxNtmLInWhISVFvh5/qx2JbG
GPhXkkaBoD0S5vzvf09Fcc4g/L2Va4c/MqZ7dzmYtXD6br8UYRZ8cawEcpj+Atdu
eajQ1OiCkL6TEjJz0yJ9iGzeGUJbzw==
=l2cj
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
