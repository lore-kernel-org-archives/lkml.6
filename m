Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF2CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E03253E8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oK18TwR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E03253E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030288AbeGBK3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:29:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965174AbeGBK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ycPjBgTgiAj4oD8+DTIRjumu5DvUjM2BRQiTEdSiUWE=; b=oK18TwR6p36UkL0wDGIAYhXJN
        S3ZSWROEyXHw+sxEbHqMsQkOQvt4r5K2JkqKpIh7Qo8BK4V3biBF4UP5Qr6ibDX2nQDP2Sjq0MWYM
        dDo/Q6VnmgSLuMJKkuT4tjudmxzJt7tKIRCLsIebmH7gRt5QaKck4BtStkcj+xW8npedc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZw4j-00047Y-VD; Mon, 02 Jul 2018 10:28:54 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZw4j-0007M6-Ez; Mon, 02 Jul 2018 11:28:53 +0100
Date:   Mon, 2 Jul 2018 11:28:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180702102853.GI18211@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Content-Disposition: inline
In-Reply-To: <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:

> --- /dev/null
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +

Please make the entire header block C++ so it looks intentional.

> +	cmd.data =3D bypassed ? PMIC4_BOB_MODE_PASS : pmic_mode;

Please just write normal if statements, the ternery operator isn't
really helping legibility.

> +static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] =3D=
 {
> +	[REGULATOR_MODE_INVALID] =3D -EINVAL,
> +	[REGULATOR_MODE_STANDBY] =3D PMIC4_LDO_MODE_RETENTION,
> +	[REGULATOR_MODE_IDLE]    =3D PMIC4_LDO_MODE_LPM,
> +	[REGULATOR_MODE_NORMAL]  =3D -EINVAL,
> +	[REGULATOR_MODE_FAST]    =3D PMIC4_LDO_MODE_HPM,
> +};

This mapping is really weird, I'd expect one of the modes to correspond
to the normal operating mode of the regulator. =20

> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mo=
de)
> +{
> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] =3D {
> +		[RPMH_REGULATOR_MODE_RET]  =3D REGULATOR_MODE_STANDBY,
> +		[RPMH_REGULATOR_MODE_LPM]  =3D REGULATOR_MODE_IDLE,
> +		[RPMH_REGULATOR_MODE_AUTO] =3D REGULATOR_MODE_INVALID,
> +		[RPMH_REGULATOR_MODE_HPM]  =3D REGULATOR_MODE_FAST,
> +	};

Same here, based on that it looks like auto mode is a good map for
normal.

> +	if (mode >=3D RPMH_REGULATOR_MODE_COUNT)
> +		return -EINVAL;

Why not use ARRAY_SIZE?

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5/mQACgkQJNaLcl1U
h9AsNgf/WigCKmujnVVYbm5ON5iapR9oanwpQCSh0Iq+B/SFfWkiPB/V6a5icJs8
REO1PpgyY08Of0V6BrYSnweEhQCiPYzje6XIPomR6rSEddf6c/ga8+78LNQJxHoq
K9yqW8a7pM6KG7gf/C8qUZ4d7JERXX8xlZUmniLpd9wg9Y6izxq9VNda0AvIr5Fl
9qT4hlcbXODcJEnCrWm8Sq09BsZmwK3yF2Gl8zzkSEP10XSiE1V5tzCLZqS0X07R
YjwpFaPhg72qqGyXEPqFiywuzOs3vhf6ZAxg5nn9J5n4pKUW792FCRcb+mDdaaCB
HTwARsp/0mY3ptkKJcDpxxwDua8YNw==
=Bx5z
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--
