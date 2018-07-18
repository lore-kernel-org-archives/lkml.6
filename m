Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8AE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vJdUZvVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8AE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeGRLUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:20:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeGRLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SvArZ9DRC++M3nz2kexMQFJFSRrI2jgTICTRvmiUVF8=; b=vJdUZvVdTFqd7jpLrgW1dfiGZ
        sQo0kbYN5n9Xm92gNgWglk68WM+9MqsIYctB4U7RdMppo4J4U+8WreuT6JkRyjBISrlYjH40/K9Hb
        KKbfUoFloQwGHnQAx07PyT4WnA+v0HPXn1ExkLMqRVFT+uHrBHFZUyXp0dKVI0A5Rcl04=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffjv4-0003RS-SV; Wed, 18 Jul 2018 10:42:54 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffjv3-00033T-Cc; Wed, 18 Jul 2018 11:42:53 +0100
Date:   Wed, 18 Jul 2018 11:42:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] regulator: allow drivers in modules to register
 fixed regulators
Message-ID: <20180718104253.GB5700@sirena.org.uk>
References: <20180718004909.213735-1-djkurtz@chromium.org>
 <20180718004909.213735-2-djkurtz@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20180718004909.213735-2-djkurtz@chromium.org>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 06:49:08PM -0600, Daniel Kurtz wrote:
> Sound machine drivers tend to live in modules. Sometimes such a machine
> driver needs to register a fixed regulator to provide to a codec.
>=20
> Export regulator_register_always_on() such that this is possible.

Given that your driver is for a device you shouldn't be using this
function, anything you're creating should be parented off that device
and so you should be registering normally.

> Change-Id: I2906f96df278b5fa65d40d3a777bf6d3d91841d2

Please don't include noise like this in upstream submissions.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPGawACgkQJNaLcl1U
h9Bd/Qf8DXopyA3B47MsgcJvfQAHHxTutvbv+vLun4GuNqX97m3IbxUqeyBssEG5
VcABeBgRpTX/8UOW/SRwgX+7DFp2dDAH+NE0DDVoC84pe9RAsBPi1PLpKP0N/XG+
OwrJcM33ZNHL1cI27di7XpHt1QeunClZE4omd5wFr8mTQDLQnKgf2+dlTOkwCT5Z
8dG7i/mYaJO5Jeb3VUg/Ts9xMJ7AQktBpl3QXp7w3+9oDUp/goHfHSzjK8RcZXQt
JJ5FNqzx92onv6d82nFazCEk43bP+L/FCFO9+K/xjbeLxLZiLQt1MReXiTexsDu/
72a1jJJuR1TyN5ZHKVrVuppYeCF5tQ==
=v9oj
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
