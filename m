Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97898ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D44206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="irR2ClqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D44206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbeIUWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:12:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57946 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390556AbeIUWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7dpZtqbThb11C7s+xKRZTkBc+I/YuQOIYRpNiExjkD0=; b=irR2ClqMwpX+5JN/vqMJMwtaN
        txgOzFG6TVnxhq4k+f09GOwC/o1lVskzo+SL8/NBhJK8gQex0+SaxfTIWxY+xs3Muqli6+2Wywodt
        TjuBJkbQqL+0yD7xFgzmnfTjIMOgv6LuOux+GlC/tB9Ani9SaQXUjoBb8DEbXj3esP9aE=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3OC3-0000dy-9a; Fri, 21 Sep 2018 16:22:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 22140440078; Fri, 21 Sep 2018 17:22:07 +0100 (BST)
Date:   Fri, 21 Sep 2018 09:22:06 -0700
From:   Mark Brown <broonie@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     perex@perex.cz, bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qdsp6: remove duplicated include from q6adm.c
Message-ID: <20180921162206.GC20825@sirena.org.uk>
References: <1537525498-38843-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <1537525498-38843-1-git-send-email-zhongjiang@huawei.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 21, 2018 at 06:24:58PM +0800, zhong jiang wrote:
> We include wait.h twice in q6adm.c. it is unnecessary. hence remove
> it.  Further, order the include files as alphabet.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulGq4ACgkQJNaLcl1U
h9B7twf9G4ChRYRRAcBqwM5jvFC9cAyLvJVZcUFQBNnvIGF5W9n15TKGfJq/T2wy
r5zQZqzyCqPEZ6p6voxZgHnA2zNUIQAcyW/XztI5/7/lLIXRaeKlPWA9XIZljGvO
3x32WuzOpn/Dn25Tn5Dkbnqm0gStw2LGJzPPdvIU2N7bHFtGlqHipYEIJpIKp8As
0D47HnHeakPvt41a70Ef7y7jO8OZtUiE1GTDJQTsXfNi4Y339kuIW5C24VPTDhz2
XoTNENkMQjz3iNL6bMJChof3z40cpMihrgx1f4PvEHOYs7rtXjinthfxldtOYUVc
wtG7EbmpZ+2ZCWNqjarGlqCFAdosbQ==
=Db15
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
