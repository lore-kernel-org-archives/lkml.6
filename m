Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC23C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E103021E20
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PGRj0MMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E103021E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeHIQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:11:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xIg3B6XjXo4SC3ghZd4m0TMiYa5ELlj2ECEt+ZiPj0I=; b=PGRj0MMmZqz7/qSRoMfv9gI3y
        59jFHPMJAXaBWwPdHegPMZfMYXivC2LcxFeuwEkdUTcU/3HHxwriDxtpDRCLsnCj0qeju+baeNRu7
        TkV4jMA8HsTVkTOmKmUWZ7Y+GAxjmuI9n3sx0JjabePNMAIR0woW3V6Y2N4VOEb6yZTo8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnlGq-0003VL-24; Thu, 09 Aug 2018 13:46:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 76A701124347; Thu,  9 Aug 2018 14:46:31 +0100 (BST)
Date:   Thu, 9 Aug 2018 14:46:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: adav80x: mark expected switch
 fall-through
Message-ID: <20180809134631.GE6132@sirena.org.uk>
References: <20180808191933.GA27767@embeddedor.com>
 <20180809093002.GB6132@sirena.org.uk>
 <a68c854c-013a-8cb2-49de-5bb109b27fc3@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <a68c854c-013a-8cb2-49de-5bb109b27fc3@metafoo.de>
X-Cookie: UNIX enhancements aren't.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 01:23:58PM +0200, Lars-Peter Clausen wrote:
> On 08/09/2018 11:30 AM, Mark Brown wrote:

> It is. But it might make sense to re-order the code to look like
>=20
>     case 54000000:
>         if (source !=3D ADAV80X_PLL_SRC_XIN)
>             return -EINVAL;
>=20
>         pll_ctrl1 |=3D ADAV80X_PLL_CTRL1_PLLDIV;
>         break;

> It is just as many lines added when adding the /* fall through */, but it
> makes it more obvious what is going on.

Yes, it's much more obvious.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsRbYACgkQJNaLcl1U
h9ColAf/b3zsDx1DzEB8I/VXJaCz65P+JXcCj/ZN5peRT9ab2DqWsuOR9kENYpPo
dCdbDihUX2xJQHczo8kcWJ04jRIv6CYW7AfUx3mGPIobuhlpBbBgBlbUGw8MsV5T
RQCLuiQK4NM+mmJtRqOzEh9nfzXaR0ZzxYSNDs6b3r4qcVcoNN4Or8AebOyrpH1C
f8SdozqynmFfnfeNJVAE5JEEReEIjW7PO5MrspoDG0ZcmPdF+Qtwgah/sRdaU14k
ReVk1XQSHicQYkJlUJWB9S5XKe3gDaW6BtW3b6lmwfKtlR7QieuJtxnRxgDLDKe8
vsoTG7ZxMpWHmBzKDJ64iOY2JmzDog==
=oCwW
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
