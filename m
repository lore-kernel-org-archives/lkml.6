Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4DEC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E037206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HfLsV01S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E037206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeKUDSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:18:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AJu4NwmXEQnlGYXmdz5l0Qxidh9A0KBT6TBkBFc3oc4=; b=HfLsV01SxWWRAIlhV542RuTwt
        5ogAaSQO9pDKL1AOTJPtV4CECRnb0S4jzAlj0ca8tQPaeMjJrsXYrDUWGRsohDBo164hHD+Bqd0F7
        lNh7FFpo/GfAjbx6fXk+8ntfBOlfyaKPaipeYWcsyaTCuvYI1YulbzeaSjP98N6CEJyZ8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP9Br-0001oE-KI; Tue, 20 Nov 2018 16:47:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 158721124DC2; Tue, 20 Nov 2018 16:47:55 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:47:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Applied "regulator: core: add enable_count for consumers to
 debug fs" to the regulator tree
Message-ID: <20181120164755.GL3894@sirena.org.uk>
References: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
 <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com>
 <20181120164125.GK3894@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Content-Disposition: inline
In-Reply-To: <20181120164125.GK3894@sirena.org.uk>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 04:41:25PM +0000, Mark Brown wrote:
> On Tue, Nov 20, 2018 at 08:37:04AM -0800, Doug Anderson wrote:
>=20
> > Hold up!  How does this compile for you?  It looks as if you landed it
> > before ("regulator: core: Only count load for enabled consumers")
> > which is the patch that adds "enable_count" to the consumer structure.
>=20
> > I'm just working on my replies to you about the dependencies on these
> > patches but they're definitely not separate...
>=20
> Dunno, but my script for applying things does a build after each patch
> and didn't complain so...  are you sure it's not e-mails getting
> reordered?

Wait, no - I didn't apply that but my tree does compile at the minute
because my test config doesn't have debugfs enabled.  If I turn that on
then the relevant code gets built and I see an error.  I'll drop this.

This does, however, beg the question why this is a separate patch in the
first place?

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0OroACgkQJNaLcl1U
h9AMSwf/VXULShmTWXvm6feWe07WVyB5DsMzXzlauxQf9vmv82XPVCzzsES3uDhD
Hfjcuj0CdndhGOZjEQ8gSl5GFfelhVEsbFsOdLgpU1EfZK1PkU3OHvBN3rbxf1Z+
tsUOr5+cuDGEndJgZU+lE6BJVhSdE5jyOWPAtd0bz0vMCJZpbY7GHto+dy0SXjpN
imhxHJmsjBQiUWb2k3OHTSHeSf/rm4yqpaxbdIGVdIj93Ao+wRwYkp/96Vkfvsa5
y9P06bMCq3kO+2pISyG3RMz85Mb52jHXd9xIvZS7Zj7z0JADvXnXV3P9/hn4JJVH
7arCu1+dCSPofv0rmSHtvK38A+TF0g==
=cujW
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--
