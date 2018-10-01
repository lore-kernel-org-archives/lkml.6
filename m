Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50A208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lWGO7EpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA50A208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeJAWNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:13:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57680 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbeJAWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VgzU1MDDX0ITpmlBsARB7c2IRse31LXcqUNo/1Eq9N4=; b=lWGO7EpJED8aC33I/kTx7urMe
        oia9DXOZrj4UAa/9uXjqJjMxy0Z8Wq33kLoCJwgoRIh1YYtIP5MiYNF4dAgSqqQ31M037pnesuQeR
        /3q5PheaKXF/c99ds6yXAxlnzZ1K4MZuaPe7htOGB+d2alc/KZ6dPtSWkeNmLvnsFMyuA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g70Dt-0007xM-LD; Mon, 01 Oct 2018 15:35:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 341B91121CA5; Mon,  1 Oct 2018 16:35:01 +0100 (BST)
Date:   Mon, 1 Oct 2018 16:35:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     masonccyang@mxic.com.tw
Cc:     tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 1/2] spi: Add MXIC controller driver
Message-ID: <20181001153501.GD19099@sirena.org.uk>
References: <1538120112-15530-1-git-send-email-masonccyang@mxic.com.tw>
 <1538120112-15530-2-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
In-Reply-To: <1538120112-15530-2-git-send-email-masonccyang@mxic.com.tw>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2018 at 03:35:11PM +0800, masonccyang@mxic.com.tw wrote:

This looks mostly good, a couple of fairly small things:

> +static int mxic_spi_clk_enable(struct mxic_spi *mxic)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(mxic->send_clk);
> +	if (ret)
> +		goto err_send_clk;
> +
> +	ret = clk_prepare_enable(mxic->send_dly_clk);
> +	if (ret)
> +		goto err_send_dly_clk;
> +
> +	return ret;
> +
> +err_send_dly_clk:
> +	clk_disable_unprepare(mxic->send_dly_clk);
> +err_send_clk:
> +	clk_disable_unprepare(mxic->send_clk);

You should only undo operations that succeeded in the error path, if
something failed you don't need to revert it.

> +static int mxic_spi_setup(struct spi_device *spi)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
> +	unsigned long freq = spi->max_speed_hz;
> +	int ret;
> +
> +	ret = clk_set_rate(mxic->send_clk, freq);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_set_rate(mxic->send_dly_clk, freq);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * A constant delay range from 0x0 ~ 0x1F for input delay,
> +	 * the unit is 78 ps, the max input delay is 2.418 ns.
> +	 */
> +	mxic_spi_set_input_delay_dqs(mxic, 0xf);

This is changing the hardware state for all slaves, not just the device
being configured - setup() isn't supposed to do that (yes, it's a
confusing API but unfortunately a legacy one that'll be a pain to clean
up).  prepare_transfer_hardware() is usually a better place to do this.

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluyPqQACgkQJNaLcl1U
h9D+OAf+OsIceza4zPHL128gdHi4SlAfaeWnDUGRfFSOdl18iGjgRQC+7WpCexxK
qMYJ5/rdWJYZp5PunuGP2c9shVpCwLjfvfWRnAGPkvIhTrF1YlLH3weDDemaHg9p
YsyCdRzj9lrQes2LixuTk1YmET3BncPCEMQ+1dV9cNP9TlY6UrTfiBloMOfgWtrJ
eYL8i3dXnpuyXhT47xdeuX5s0gbhumZK8R4cQvFnVg34ctQiekn9RRLs0RtmDwIZ
PyJ7FFjn+llo2X72XrmUl3sGUadsF5UEDrW0F1aCmH4n4VaaAnk5XhoaT3EiLHVr
gHjBC7zA5IIrmJVnYcPNwa99s2N7Iw==
=AGZk
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
