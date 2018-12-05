Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4301BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF25E213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="g2Mc8Ypy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF25E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeLEL2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:28:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeLEL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vr9tgcVHTh8iiUQZzai9FfjRca3WGPSQTxY477+SLsA=; b=g2Mc8Ypy6cXQQpM7U8HoFCB6j
        SBydPD1h2mp13rEErwiczdEkF98+I7cL/o8msV5++uvuJ8m68dLUFUMum5B4/8ZV55sHTdytzlsGY
        0tUSh5olEzVV1ROFkynDv2DLeRKchfSlu9eHPV4oEDxxuT34/G305d9msuNZ9ePx+94sU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUVM0-0003HO-Rk; Wed, 05 Dec 2018 11:28:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8180C112533F; Wed,  5 Dec 2018 11:28:32 +0000 (GMT)
Date:   Wed, 5 Dec 2018 11:28:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on reg read and
 write
Message-ID: <20181205112832.GA6205@sirena.org.uk>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
 <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <50cffd9e-74f4-b0af-5eed-3dad5f32d8f9@amd.com>
 <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 05, 2018 at 10:21:04AM +0000, Adam Thomson wrote:

> If the previous I2C access failed, how can we be sure that the write back to HW
> of 0xFF even succeeds? More importantly these error returns won't necessarily
> stop subsequent calls to controls within the Codec I believe, so you could still
> see unwanted writes to HW via I2C, if I2C is sporadically operational. Again I
> don't see this update resolving that. The key thing is to resolve why even just
> one I2C transaction fails.

Right, it's just not clear what we can constructively do if the I2C bus
falls to bits other than log things and the I2C controllers will
generally do that themselves.  There's no guarantee what made it
through to the device or what will in future make it through to the
device.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwHtl8ACgkQJNaLcl1U
h9DiPgf/dRdws2pJQNwVjMZCeXaIWamfcvHKqKCY0obEy89cZkRWM/SWVu/M1bj3
5pzLBIjk5b/tJh4/yFcK1ioJjiEpCk76HGlFnUp9+wDFeO8TOJVNppe72gmN9QrA
fq2PjmoDPV3STxHwDzy0/5Q4pCiS3K1qFLTfY/pK8PFowuk+y/SLVNnsb34HlH7c
6OOIGiUJNn3a6cKBTeyN2VH9tasRbsBeap4q8DZJRt2Q6+6Jp3/cLtSO7HKqLghK
hDkNILIx9pymLYIn9zGntO46IyP+R28+TP6lGafnFvfj/eoz+BJTYsxg26qdRP+0
WIuaOyr/YmzRZ3yjFs8Pn7SdVXj1Kw==
=0djV
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
