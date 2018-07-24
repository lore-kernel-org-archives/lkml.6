Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B159620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XPvrLBAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B159620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbeGXSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:06:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=smU+gF6kwz+oR987+eA+tS2/aZiOfhyatg61cj3eHuo=; b=XPvrLBAqGv0yqCAbU4Fn2Lp65
        NJ9PmOu8XVKk21Ic4ivEdqCQp2Q5XEPKa/BErKmSnq9OprF8bco4VDm4dLtNkkAm1wuBD6vd9wuOu
        eUNI+1PAwQSWCpikGvb0ZU4+6Vt8Bz7awMT8B+QgmgwJxsdTT5nWE3G3IIWbxqD5piQWw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fi0dw-0005fy-7c; Tue, 24 Jul 2018 16:58:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 65ED71123A86; Tue, 24 Jul 2018 17:58:35 +0100 (BST)
Date:   Tue, 24 Jul 2018 17:58:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: da7219: Allow pdata to specify a VDDIO
Message-ID: <20180724165835.GO13268@sirena.org.uk>
References: <20180722232822.34641-1-djkurtz@chromium.org>
 <2E89032DDAA8B9408CB92943514A0337019830B8F8@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="68uOmRXIw+u8y5pO"
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337019830B8F8@SW-EX-MBX01.diasemi.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--68uOmRXIw+u8y5pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 02:41:26PM +0000, Adam Thomson wrote:
> On 23 July 2018 00:28, Daniel Kurtz wrote:

> > Provide a new device property to let such systems specify a different
> > VDDIO if needed (e.g., 1.8V).

> I'm not sure what the general view on this is. In the past it was suggest=
ed
> the regulator framework was the way to go to pass this kind of informatio=
n,
> but obviously ACPI platforms don't tend to use it.

> Mark, what is your feeling on this? Would you be in favour of some kind o=
f=20
> fixed voltage regulator representation, similar to the patch for the AMD
> platform (ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002),
> albeit tweaked to avoid asynchronous probe() issues, or is this a reasona=
ble
> route? Personally in my mind, and in an ideal world, I'd prefer just one =
method
> for retrieving this data in the codec driver, but that may not be sensibl=
e.

Yeah, keeping things consistent if we can seems like a definite win
which points towards using regulators here.  One other thing that
concerns me with using device properties here is what exactly we'd be
expecting to set them - I'd not expect system integrators to suddenly
start adding such properties.

--68uOmRXIw+u8y5pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXWroACgkQJNaLcl1U
h9DRbQf/f9qcI/FZGoXzYAQJISjJeHSz0eZ81Q6qSqn7jRcnPmZHqJjVfxmuoavu
sBvaTCi++RQhAvx6PqEpmnMoQpAQCto0/N8b8jcBUn+SKAPn90cvWwKpNnSCZksF
5t3hjH6SGq57f0vg3PwF4HcjSwRjp9NRleTsPqARgD8lbqKwHHW67PCmt3E/jG7O
09dXqpw28uH/chkRg/aH9ruiNBEufd6x6dXMXQMiEWMVam5I0JrH+o1BabG6uCF2
Big/B4j32E+i9jz1jbv8DRUVybFWxNaNXECV0dre7sPnBTOeJ6xbXGYhVEXuLB6Z
bIIjAwwTaaJd4KXnz//7b8wMmbpK5A==
=nY4j
-----END PGP SIGNATURE-----

--68uOmRXIw+u8y5pO--
