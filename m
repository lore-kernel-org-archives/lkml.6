Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30683ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D906A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dVpeOyht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D906A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeGWSFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:05:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35068 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGWSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sHuArVerEjtBCoU0Mw1TWW0ySCpUBCVRbkmzJtbRS9I=; b=dVpeOyht58gdiUHqC3rKir2G1
        DlaxArV73hxQELG8/G1mZq3v0NAns+CAqvz2R+c0lIhnUcHMMQD7pXFJyu1g1Zcj79tU89pmDgLjM
        ih6AEA8Xei0oXnRGxdC8rahmt+FyLWo6LT8KUjU21d8VdLppYQg6JTUzAog0jiBqBiw6Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fheEc-0004NI-Nd; Mon, 23 Jul 2018 17:02:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 788B4112387B; Mon, 23 Jul 2018 18:02:58 +0100 (BST)
Date:   Mon, 23 Jul 2018 18:02:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, linux-media@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH -next v4 1/3] regmap: add SCCB support
Message-ID: <20180723170258.GE13981@sirena.org.uk>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-2-git-send-email-akinobu.mita@gmail.com>
 <20180718152832.ylu6rlcsaom2q4xm@ninjato>
 <20180718153140.GP5700@sirena.org.uk>
 <20180720215344.6it2k5wckxvwx25p@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <20180720215344.6it2k5wckxvwx25p@ninjato>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 11:53:44PM +0200, Wolfram Sang wrote:

> Here is it:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/smbus_xfer_unlock-immutable

Thanks, pulled in now.

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWCkEACgkQJNaLcl1U
h9CUSwf/ff7c4xQ3H5UVhWpnejDy6b/lHNNiaXrNY25CTtpjuxEX1WndcpmFYvpg
/T15gDyN+Dny+vgyXQKGsUvMjnVkq2JUFt7IgS9o+fuBjEWHsBI0tQtNeUrom1Zq
NmpTd4vo2+bl+8B5W/JvRsdQgwYStObWTIYQ0kE0NKoLvsEGnXgNbN2ODw6ULxPP
/CCRjd6WWgfdqgePs35YzX28Fk3gCiSG72/XcVBqfi9L8OZGCqe80wjwkZWDYKm8
8NczvX0NjWBaDbze7X6EzDHJtLhuB8UNzRlB2B81uharBAe+xKQidKpg4iq01/9o
6VESvzgunrriKHiMaX949CE8fGAWEg==
=NakS
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
