Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 207A4C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D507C208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D507C208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbeFNNrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:47:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33897 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754967AbeFNNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:47:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4948A80445; Thu, 14 Jun 2018 15:47:46 +0200 (CEST)
Date:   Thu, 14 Jun 2018 15:47:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: omap3isp: zero-initialize the isp cam_xclk{a,b}
 initial data
Message-ID: <20180614134746.GA3893@amd>
References: <20180609083912.27807-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20180609083912.27807-1-javierm@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-06-09 10:39:12, Javier Martinez Canillas wrote:
> The struct clk_init_data defined in isp_xclk_init() is a variable in the
> stack but it's not explicitly zero-initialized. Because of that, in some
> cases the data structure contains values that confuses the clk framework.
>=20
> For example if the flags member has the CLK_IS_CRITICAL bit set, the clk
> framework will wrongly prepare the clock on registration. This leads to
> the isp_xclk_prepare() callback to be called which in turn calls to the
> omap3isp_get() function that increments the isp device reference counter.
>=20
> Since this omap3isp_get() call is unexpected, this leads to an unbalanced
> omap3isp_get() call that prevents the requested IRQ to be later enabled,
> due the refcount not being 0 when the correct omap3isp_get() call happens.
>=20
> Fixes: 9b28ee3c9122 ("[media] omap3isp: Use the common clock framework")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Tested-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsicgIACgkQMOfwapXb+vIc+QCaA08BHdkBq3L8yBjYX29F9SY+
icQAnRv0bf7Aoyg1VCD/4+s73ttzV7i/
=Cwz9
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
