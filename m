Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8965C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC2F21775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hosFmEkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC2F21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeHCSmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:42:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40600 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeHCSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TGfsI3KrJh7WjKU4hMVN7RcJ3t3maMdVnD2NrbRePtY=; b=hosFmEkUVmeZkPXkELPTh8y7x
        ZyBkcl9MB1qlSDFdNojI+o1hpoBD8WkDdNGiPKNUycCWRoRyDIbKodrQOfRpytUQuVY0Lf22d05e8
        5u9kz4UAmaAZbKyqKKTMR/3cHsJWgETkPvCc7TAsQaQ/MTYnmJmoFo7Cne6PvN0ttlGDk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fldCK-0003l2-Ur; Fri, 03 Aug 2018 16:45:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8386F1123AA1; Fri,  3 Aug 2018 17:45:04 +0100 (BST)
Date:   Fri, 3 Aug 2018 17:45:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     valdis.kletnieks@vt.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Message-ID: <20180803164504.GF6591@sirena.org.uk>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2018 at 11:41:39AM -0500, Gustavo A. R. Silva wrote:
> On 08/03/2018 11:26 AM, valdis.kletnieks@vt.edu wrote:
> > On Wed, 01 Aug 2018 14:56:16 -0500, "Gustavo A. R. Silva" said:

> > Wait, what? This looks like the sort of bug -Wimplicit-fallthrough is supposed
> > to catch.  Unless for 'case WM8994_SYSCLK_OPCLK:' we actually do want to do a
> > whole bunch of snd_soc_component_update_bits() calls and then return -EINVAL
> > whether or not that case succeeded?

> Yeah, it seems like a bug. Can someone confirm this?

> Notice that this code has been there since 2010.

Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
noticed.

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltkho8ACgkQJNaLcl1U
h9DkAAf9E//pNerxjDyXizhdfm6UO/DYGAcnytURqh48UBox/K+4WEvzHMDGGylL
Si5WIP5K49waMc5sK9AjPbSn6X89mkagChE5O5EPohCccVLMkilWTAE90rBLVhr9
606FTIIOUATb6zFk6f83PQ8LmzZ3H1CHzy/H2qPtc7RUgnQEFnNlK8z/9OTTsiKU
pvz3cC3Ga2r+bq31njxXF5l4niW5higDBF2qb0fLHqEA/qlCdee5pLJ/IgQd8zmO
xcm3W7UGXJA6aAo9Jl/9h8C6jA6nX85tiv16Mjm+P1GMeVUnNwegAbA2I355OjDm
Lg9ztCy1+TUANlNJC3PyDMtOQSF2Fg==
=KHID
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
