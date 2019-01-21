Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D19C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F382089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548098302;
	bh=wEkndWLMDP6LH1wOU9vVma4IGlHYZtNcl2q0AIQN42s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d6AIoRntZ1OkPvY1z0bzB37dJjv3tkqU/7PHWSpOqbqprXQyZurlwRZjhrB2UOHOH
	 ILMQ8kqUsljeSbu+mMMyYvvF8og6Oc+E1oWjDvmuFebjm6RDggDkkiz4GUorfIvhCI
	 QWnvxKFg9Eul0ZzgHqO2EQpNm2M9yQNCuu2Nb4ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfAUTSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:18:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAUTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ahi+dxguvwUuZsF+8UEgo9xEwYr6sdmy1TqWwWNKKrg=; b=NQPzqF3t54TN5eY8xloDb9A5I
        Dr5MlEc6Spj4SFS0MTdZmAyY9AhkCOO6WAMQjuj1soP53DOYcBdY2HDNIs04UpL3PHzRIDCJ3Af6g
        PeQZGxg+2W5gLNEW15CHtfOhsWraxRksNUJf0DuWKTz4v4KwRdLCvZH5NTYDqNtrphk7M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glf5N-0004zU-5g; Mon, 21 Jan 2019 19:18:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9DB561127D00; Mon, 21 Jan 2019 19:18:16 +0000 (GMT)
Date:   Mon, 21 Jan 2019 19:18:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        boris.brezillon@free-electrons.com, thierry.reding@gmail.com
Subject: Re: [PATCH 0/1] pwm-regulator: reduce noise on EPROBE_DEFER
Message-ID: <20190121191816.GH12679@sirena.org.uk>
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 07:37:22PM +0100, Martin Blumenstingl wrote:
> pwm-regulator can be a bit noisy during boot.
>=20
> One example are the 32-bit Amlogic SoCs when using
> multi_v7_defconfig (which has CONFIG_REGULATOR_PWM=3Dy and

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGGvcACgkQJNaLcl1U
h9A5rgf6AtxZSaBfnctsJOk/GS0x/WFOmJUoUIpp7rv7v2vkx/BA45InnEMRVvBY
gcYd/xIOpOPMj/rhYooVuOfPtRjBxh64Wh8hDR7Kjn1EtJv4INM1rr2O4hKATupB
JuR5lNtrnFb20nmN/fsi7aearRB74Pohikt22TI/Bi2yyTxwb1bIE4b/her0/s7u
kWN2U7IhZGsHu3a99e7vJhb0yNT7tSldrb6tyKcJIrWbMY3co6ZdQYzYJgF1m5fV
MVgy7m2rjNuDqAAMrUIEZbBTts41fbNNi+BuSr7XFoXBZML6/Aenc01qk6nRkPRq
aj6eZJp/3Dn9gW1aGpD4VNGpk1eSEQ==
=WlEa
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
