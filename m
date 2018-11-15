Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A75FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C316C21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JEKS40JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C316C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeKPFlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:41:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kc6jaMDSIsYk92ov3wcXzIrCZOGTxxflOp+FIETUNLs=; b=JEKS40JX3MPm+xY9+0kTR45/2
        h6Uobwp9i7QFJ+PRMT5gC9Z4mgG/EuAkQug72qjSHzgZ2Ot6/uVydDXTUsAiq9crp67XIiN0ky8om
        eAoVxPowS2IrYOhjio6FeijFRlwShefmEwE4VG20SN3LpmBPdXEBvw01hh0irkpWxKrco=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNN8-0006Dr-NW; Thu, 15 Nov 2018 19:32:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6DA17440078; Thu, 15 Nov 2018 19:32:08 +0000 (GMT)
Date:   Thu, 15 Nov 2018 11:32:08 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org
Subject: Re: [PATCH 1/2] ASoC: rt5663: Add documentation for power supply
 support
Message-ID: <20181115193208.GO2089@sirena.org.uk>
References: <20181115041334.79446-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0MVPm7EaLRZfIY9d"
Content-Disposition: inline
In-Reply-To: <20181115041334.79446-1-cychiang@chromium.org>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0MVPm7EaLRZfIY9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 12:13:33PM +0800, Cheng-Yi Chiang wrote:

> +++ b/Documentation/devicetree/bindings/sound/rt5663.txt
> @@ -36,6 +36,9 @@ Optional properties:
>    "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges=
 of
>    impedance in the impedance sensing function.
> =20
> +- avdd-supply: Power supply for AVDD, providing 1.8V.
> +- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
> +

These should be mandatory properties, the device is going to need power
to work.  The regulator API will handle incompletely specified boards
for you, that's not a problem.

--0MVPm7EaLRZfIY9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvtybcACgkQJNaLcl1U
h9CoJQf/VdQDU6fQnTd8fQFAhMHF7OlBxmiyfzkgRvOmPDLMSMTfV2zJcLfMT2XB
Z/FhyT0K5yMmPTbtIPBSrM4v0ECaQyOxHtUAomZQAQ32umS9ap5IiH1m8LTboKD/
K19ektcrbWvmg3CwQRW+KZy4QwDdbyCoFjWxfMNz4aelzcKReenOtnicQ/DvZ4R3
VVqLIK3IXKxOwW9gjx2/6GQDMR40xiNw8f1wCx7tbbX531on686Kwculduepbd0T
87AjYOI3JtgbzYDzVSJYzgkN/fP81pV7JzKwglcG0Qg5C1BuBW0pvjXIMvULMtk/
Gngq6BUSnmvtwz8Ye4hrE63kymarqw==
=4gfH
-----END PGP SIGNATURE-----

--0MVPm7EaLRZfIY9d--
