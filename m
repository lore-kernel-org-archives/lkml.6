Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7348F223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OPbZi6bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7348F223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeHJNIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:08:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJNIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0KcMYBQ9DTiYZVnhEKSe/9Zi5YTO1tq2Vf7iwGCU9AY=; b=OPbZi6bJ561BYsa3u/sB3a58T
        83pfT5A2EADG425iXNjCfnOG6icgfT284G7UHikOJIvhtvWRGv/Syv8IfR6YPcZWGRcwWK7hZLr1h
        8Vg5SjRPxB8G0Ncr/z9FBoagFAW14pIs2LnXPGmQly8xEGcm56FM+DKG4A1JqqgFHKiGA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fo4oq-0004gL-W7; Fri, 10 Aug 2018 10:38:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AF471112435B; Fri, 10 Aug 2018 11:38:56 +0100 (BST)
Date:   Fri, 10 Aug 2018 11:38:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v6 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180810103856.GB20971@sirena.org.uk>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
 <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
X-Cookie: Words are the voice of the heart.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 11:46:20AM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read without range semantics.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttaz8ACgkQJNaLcl1U
h9AjNQf/buHO0/HMfa6dgryJ+K7ERaW4OvogB34AF9dEiXKgWwZpFggKVav9mHHp
TRt2fk5D2f0dPLwWBUGOSPEFNsfMd3BI9MeUvNHgD6mKky/AX+Fa0GntaSRC3dr2
DG+Zx1nz3Lq5EwVwvxuMGc9BkIqwcqX5G+LLwhOz030/6dvuSyGpfLUddt24ruvW
Pu10QpfpcnWPKViZqwGAUf8TCELqKmBVC0TNU9aps/PLjc46FZqtKrt4mWTsdUDG
6lR5RrwOgrJZ1/k7nZQKxnURll6hdSgVDNpEhHZHDqxdL/h4RnaY/KtR0KsEjaxN
QEEhDPHRiwZNbYLvAgYvGF/IwijfNg==
=Bhv7
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
