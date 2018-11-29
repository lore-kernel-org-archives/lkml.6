Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E577C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465C20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NhBM40yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C465C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeK2Wb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:31:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37010 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK2Wb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mmyxat2j0T3rX1EgiMvbFihUD3EU+z4e0d0gHeuNlgk=; b=NhBM40yrWGXSS0cDPQHSWqQ3p
        QKRTz6098TeWvd2CG/U/l9OW8Nrlt9MSg9OKV76LHJ69JCn2tptOK7P6nMa6cJbFrw3G47mlMH4GK
        lt8KUGfApm9a5p6Fq8EngAFY6S5NWphvPKFRhii0KlEMua8FMn0HtLDYDRPFMrvBNY7m0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gSKST-0001mx-0W; Thu, 29 Nov 2018 11:26:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9475411251C0; Thu, 29 Nov 2018 11:26:12 +0000 (GMT)
Date:   Thu, 29 Nov 2018 11:26:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Grant Grundler <grundler@chromium.org>
Cc:     RyanS.Lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>,
        perex@perex.cz, tiwai@suse.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        ryan.lee.maxim@gmail.com
Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Message-ID: <20181129112612.GB10570@sirena.org.uk>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
 <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
 <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2018 at 05:55:48PM -0800, Grant Grundler wrote:
> On Wed, Nov 28, 2018 at 9:07 AM Ryan Lee <RyanS.Lee@maximintegrated.com> wrote:

> > >Not seeing a changelog here like I asked for :(

> > Actually I added changelog as below. Do you mean this is not sufficient?

> The text is probably sufficient but not in a format that Mark can
> directly apply.
> Please take a quick look at Documentation/process/submitting-patches.rst.

> Mark wants the "commit message" to be before the '---' line. So move
> the "Changes:" text up to become the commit message and drop the
> "Changes" line. That should explain why this commit is needed and
> include the S-o-B line.

Right.  If you compare what's in git and what you're sending with other
commits and mails and make sure everything looks similar you're probably
on the right track.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv/zL8ACgkQJNaLcl1U
h9BeRQgAgAjGco/fX0T1ZBLAAW+icaDcGI7xh+x8uPXi7r+v6p8h3eIr2fYnunq9
9qFo5RF4YcQYJ8LecDnKQaaH7hqWUzhz2+I1A91LkCylSW2CesdurtGHUuKpsSaa
cX8+2P1oisBbkaz5JB/cUWp9mvmhK/IUv1nSK6FOw3QorC7kdz4lwBX+nP6d/7Vy
LAtyClMoffoP2INZj02SL/UTIR42QgKqgeZd1okNzOGy69CUAyDx3XBONyULTejY
unSa8STYd7SkpivuQ+XT1YDOI0YAWnNAschHq4eJhTFjaMohJIfuDe1bCuN/pXG6
UwW3ucG47FB4Af7bNvebS7PLaK0hMQ==
=vLKa
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
