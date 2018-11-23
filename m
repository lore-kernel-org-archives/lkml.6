Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72909206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="erVo7NNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72909206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439823AbeKXA2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:28:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394909AbeKXA2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K6K8v09SQQo495JMhVMn2SAT2J7VN90bAzdStrYCPoM=; b=erVo7NNPKUgDbbNrCuyAfkkeO
        bbEexUkChnk9EC2bv0knY6m9bUFOd3iQUGg8M+HFQcEuSqMcWvOswU84AGZak4dn/oopgAyp1rgWP
        2zr4qt1+Hg3g4/5XvSEhJKw4WgNHIjVIUF6vAL9aPAkr7f8mYNiWcVLZQMfp1FNMj6RSk=;
Received: from [176.12.107.140] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gQBki-00014t-QY; Fri, 23 Nov 2018 13:44:12 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EC941440078; Fri, 23 Nov 2018 13:44:11 +0000 (GMT)
Date:   Fri, 23 Nov 2018 13:44:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
Message-ID: <20181123134411.GG2089@sirena.org.uk>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181113174539.GB2089@sirena.org.uk>
 <03b902d9-49a8-9acd-6f98-048f117b1e93@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OMIeU0UG8ajn+69Z"
Content-Disposition: inline
In-Reply-To: <03b902d9-49a8-9acd-6f98-048f117b1e93@microchip.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OMIeU0UG8ajn+69Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 03:44:31PM +0000, Andrei.Stefanescu@microchip.com w=
rote:

> Thank you for your review. While working on the next version I realized t=
hat
> the implementation should change a bit. The mcp16502 PMIC has separate=20
> registers
> for each of its operating modes (Performance, Active, Low-power, Hibernat=
e).
> So, it is possible to setup the values for Low-power (Linux standby) and
> Hibernate (Linux suspend-to-ram) and these values would not be affected by
> changes made during runtime (which are made to the ACTIVE registers).

This is totally normal for regulators, it's the only way that suspend
modes can function sensibly since suspend mode configuration is
typically not capable off supplying the processor.  If your driver is
currently trying to use the normal operating registers then it's buggy.

> This means that the calls to suspend_set_* are not necessary to be made e=
ach
> time the board suspends. My idea is to add three functions to the=20
> regulator_ops
> (setup_suspend_standby/mem/max) which would be called after the regulator=
 is
> registered and which would set the values found inside the devicetree
> in the regulator-state-standby/mem/disk subnodes.

There is no need to add new operations, we already have a number of
suspend specific operations covering enable state, modes and voltage.
You should just use those, there's already code to call them.

--OMIeU0UG8ajn+69Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv4BCsACgkQJNaLcl1U
h9D3lgf+MSPw3VUd37AGGy6UX8e9wrtZWONnJ9xKEgagrfT1n9PgKR3WOAdGfUJP
WIzVHqG6cMpkr6aYaxrBuQwv/65WH+6oZKowe3+JWBZOjdFeNABdWVwNZpTH2U/m
fZlC0tjL8trJX+qA7ARsUlb2e6p3eRfAwYUiIdzTR+D//B7nB47bqvNG1WROB9ui
mt9rf8u16YlCqzgzNPM44CkUdykA+MPzbSr7oTW2GI9/+olP9oBXJvDghHLcJJdl
DHuzZmzjEler3Ne7cgVY6RV5zlaaqL296QAGYO2ObG9Qln1YMiESuGo/hwSyKO6M
BFqN/69OsA3HYGct4Hwt2ZYAetXiIQ==
=LKzK
-----END PGP SIGNATURE-----

--OMIeU0UG8ajn+69Z--
