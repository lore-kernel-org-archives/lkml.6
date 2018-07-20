Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1793ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE66120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JyxjcD0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE66120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbeGTNE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:04:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbeGTNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GznxiN2ki440fk9Up3gnopY4Ka1wr9Pu6L9DdkDRFiY=; b=JyxjcD0jX7+YWxjO9zdswvN53
        PN00ndwwl4M0aNw/vAHppPKMExiPu6zMwejGL9TXLpyTxlRE/bXackwb9j05PQ+lv7duiCeTLesxV
        htlncPhVvZTo3+KjfkpPmZ4HdPVWVgWueDcrnWlreTC6hMIEn06xjnjUuY2DG/g21Jf5c=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUKT-0008LB-1D; Fri, 20 Jul 2018 12:16:13 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUKS-00062p-Fy; Fri, 20 Jul 2018 13:16:12 +0100
Date:   Fri, 20 Jul 2018 13:16:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Message-ID: <20180720121612.GC10784@sirena.org.uk>
References: <20180720080424.31505-1-marcel@ziswiler.com>
 <20180720080424.31505-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20180720080424.31505-2-marcel@ziswiler.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 10:04:24AM +0200, Marcel Ziswiler wrote:

> -			dev_err(&pdev->dev, "could not get codec-reset GPIO\n");
> +			dev_err(&pdev->dev, "could not get codec-reset GPIO: "
> +					    "%d\n", ret);

Don't split strings over lines like this, it causes problems when people
grep for errors.  It's better to go over 80 columns.

>  	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
>  					    "nvidia,codec-sync-gpio", 0);
>  	if (!gpio_is_valid(ac97->sync_gpio)) {
> -		dev_err(&pdev->dev, "no codec-sync GPIO supplied\n");
> +		ret = ac97->sync_gpio;
> +		dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n", ret);
>  		goto err_clk_put;
>  	}

This isn't reporting an error code associated with the attempt to find a
codec-sync GPIO, it's the result of some other operation.

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR0osACgkQJNaLcl1U
h9AVmwf/e4WjlzV4DYAbjzGF9Ht1ig2O1wJA0BPK4/21DHuYhCAkLkLXbGoE3HKD
j+0NjjLNSqdSeuQChz+tY0Tw12CIupCNSInA6+AS6cQ/OaAPlaTnNuPjDpF3aXWs
aoxbZ+OclgsvtoHU3q7Oq1EHDJTuYBRMIQsw3fZmSG2L9ZX3u86S6spEE2pdVifW
ZMHRfbqeIFJpnuVnhHEecYH3y4ZaK1oxOCqpzPWSpcnbSTotMzXSGQLZtc9Voyn7
tS4/aTY3iMsLa/RUpC9PMCBvPdn4Hj9zzWkOeDz1AviKsW0eJaMdAlg2m8f9it8E
c0gfHvC1bc0xNsqpQQLp2doD2OwWYA==
=qJDp
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
