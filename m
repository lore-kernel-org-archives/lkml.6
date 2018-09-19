Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D671C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1983B2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="p4oj5YDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1983B2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbeISXZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:25:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50820 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeISXZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4VOFTD1AepX+8sEBg0Let5oupMO5p7Bq950W2Zd6ZZM=; b=p4oj5YDReFkR796aRcBOvdrC3
        k0ZzfHTnNkE/DsLAZBWbdhGbGPgpcKg7Ga4ySypkGvQ/DdTNA/z1Q+USgMpS72TX0cmlnHG35NF9P
        uo2Wf6D615wTApw16V50QlcGff+LT4Hq+4AS1+2UxDXdE75cSp6x5DCBH7NkhzvEVjzMo=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2gYI-0004wF-Gw; Wed, 19 Sep 2018 17:46:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3838F440078; Wed, 19 Sep 2018 18:46:12 +0100 (BST)
Date:   Wed, 19 Sep 2018 10:46:12 -0700
From:   Mark Brown <broonie@kernel.org>
To:     masonccyang@mxic.com.tw
Cc:     tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 1/2] spi: Add MXIC controller driver
Message-ID: <20180919174612.GG2471@sirena.org.uk>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
 <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/zLL6W406Aotuby1"
Content-Disposition: inline
In-Reply-To: <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/zLL6W406Aotuby1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 17, 2018 at 03:16:18PM +0800, masonccyang@mxic.com.tw wrote:

> +static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
> +
> +	if (!lvl) {
> +		if (mxic_spi_clk_setup(spi))
> +			return;
> +		if (mxic_spi_clk_enable(mxic))
> +			return;
> +		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
> +		       mxic->regs + HC_CFG);
> +		writel(HC_EN_BIT, mxic->regs + HC_EN);
> +		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> +		       mxic->regs + HC_CFG);

Like Boris says having the clock management in the chip select
operations is not good - it's not just redundant with runtime PM, it's
potentially broken if a device does something like using an inverted
chip select.  The chip select operation should just be managing the chip
select, nothing else.  If it does other things it's going to end up
being broken for some cases.

Otherwise this looks good.

--/zLL6W406Aotuby1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluii2MACgkQJNaLcl1U
h9D50Qf9G9sFzVoF5k2uw3dJxs3w76wu7spHMRRe/DRf1QSI/vHfzhuBGfCL8Xo6
Z78sgnpiC2Nqa2Uu/oKQdQ9+70SQlb9K3F+o5KwV2eIk6tZpFiMGRN6Y/YFoFvGw
aLrj/8ruutokwFGxibqEJdTAp/ErE+6ND6cdRln0SAH+VUW/4dzNZbB5LS8NtMJR
c32ZJaUeN90+UBqYalxG4tm8zSodDv2HqQ4DzfdBIl0KWZqM2g4qjVPbWeFH7KFW
JPAr35PWWnmTUeYWXrrdm17pAn7xfQMJLjrDDjcuRb3AjqL7XMRtAoxeFiaDcfQR
f/YWGn4PwtE2acggALgCrE/u0z669w==
=5LGp
-----END PGP SIGNATURE-----

--/zLL6W406Aotuby1--
