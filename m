Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D926308
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WtgDB6T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813D926308
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935887AbeFZOSr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:18:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934063AbeFZOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pNVlFMUgqEzbbua+EVgQjwdOvyJ9IVralZn1xyEAUy0=; b=WtgDB6T335K9IJVDqs5n2pdcn
        N6wWpmMJzrSEpUtf6s3RIZpEbattkkMbCZiY1QPTszPNFag27L78DFhCZZ4qzfphhyktlCrERe+mC
        nZrZw8bFYBsHYNeXB1/f2zt5PpgoB5KRvbp5BdKu9OoZwJTmbanaLk4536VcuSAld8ayo=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXonm-0001HL-W1; Tue, 26 Jun 2018 14:18:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7160D440070; Tue, 26 Jun 2018 15:18:37 +0100 (BST)
Date:   Tue, 26 Jun 2018 15:18:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     jiada_wang@mentor.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
Message-ID: <20180626141837.GF1779@sirena.org.uk>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
 <1530008318.2900.44.camel@baylibre.com>
 <20180626115526.GC1779@sirena.org.uk>
 <1530014920.2900.50.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <1530014920.2900.50.camel@baylibre.com>
X-Cookie: PARDON me, am I speaking ENGLISH?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 02:08:40PM +0200, Jerome Brunet wrote:

> From comment here and in other mails, I get that you are not big fan of D=
PCM :)
> It is indeed a complex beast ...

> It there anything else we can use to represent audio routing within the S=
oC ?
> The SoC I'm working on make heavy use of this, unfortunately.=20

The goal is to be able to propagate digital configuration along audio
paths in much the same way as we currently do for power with DAPM.  Lars
did a presentation with a good writeup of a proposal for that at ELC-E a
few years ago.  Unfortunately the only person that is really able to
find time to work on this at the minute is Morimoto-san, this is what
his componentization changes are driving towards - part of the design is
that everything in the system will be a component and we can therefore
treat every device identically.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsySzkACgkQJNaLcl1U
h9BeMAf/S/+T+a9a2BmSaYJTz8xBAweB70bnNa1smJN+ebaAu6zaz5OqOoCzrlh3
LDmZHNQYSVxx28hdko1q7ZjLE42mOWY7Xrs5DEBRCuJHJtfeXzFWsNyAv9tOyBEf
CxwnWsSQNeQftrI9XH1+2CITMbUJ9PR3Ifvu2X2ua5VhJP82qfOLed12H7yWYy6A
fU36dYPLWd5V9l6kFHiO9tbnhLUaVCXx4Faa/HgkmzIp0fzSjRdGU65+K7vjPXaj
GHpNKo3jR+3INlv43zPHwatYpGcmrvGwwQW92TAes8/Nj/Q6Nn7B5yqJAhOUMiiw
aoA4AxHRlnspfQlhZxB/nIXNG7TkTQ==
=aRcD
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
