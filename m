Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD9C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF8D255EC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gPT44A+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF8D255EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeGBAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:40:09 -0400
Received: from ozlabs.org ([203.11.71.1]:49011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbeGBAkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:40:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41JpLZ3Q93z9s4Z;
        Mon,  2 Jul 2018 10:40:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530492007;
        bh=0z3k3QXp5ngfTtTvlLBoEN9VrG4uiaGBjFFWadcm9ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gPT44A+lCeoswNAgw7uAdrSsCZlbsZrRNaolBY0rXiLkSn0LvJzfm/SAa/KlZl5ch
         Y0Gu5twt65Gp0ADjREClS1QeAa0OsCCy1LGS0wuQPYinqM/fGnyF7rwo6oDegxVnCe
         Qk5CVfj4UMP6jAFuRwflhObT8kBAw1np7XzbXJhofBr9oPhrZiLgezx2taHqQuaRTj
         wMLLaO/mP8YIc2In4ekfgUgiI3jO7CMVXiEh+B4kD3loaau0M5IzWnvx+auvqCrbgK
         2QeyneuNgLTBss9lVdlqSXdVt9kbbkJGJl86whUttRfnNURcT690sOQAAvjak98/Wc
         qY3/CtKkkKHYw==
Date:   Mon, 2 Jul 2018 10:40:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg KH <greg@kroah.com>, Gavin Schenk <g.schenk@eckelmann.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] siox: don't create a thread without starting it
Message-ID: <20180702104005.09da057a@canb.auug.org.au>
In-Reply-To: <20180702093404.747c4148@canb.auug.org.au>
References: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
        <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
        <20180629073858.5gwpfwqo2ccb4jaa@pengutronix.de>
        <20180702093404.747c4148@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oOn2gN+=7HsqatyAw7Gfzvm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oOn2gN+=7HsqatyAw7Gfzvm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Just cc'ing a more recent address for Greg ...

On Mon, 2 Jul 2018 09:34:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi Uwe,
>=20
> On Fri, 29 Jun 2018 09:38:58 +0200 Uwe Kleine-K=C3=B6nig <u.kleine-koenig=
@pengutronix.de> wrote:
> >
> > On Thu, Jun 28, 2018 at 09:57:42AM +0200, Uwe Kleine-K=C3=B6nig wrote: =
=20
> > > Greg, you applied the initial patches creating drivers/siox. I assume
> > > you will continue to apply siox patches and tell if I should search a
> > > different path for these.   =20
> >=20
> > I put the two patches that I'd like to get in during the next merge
> > window into a branch in my repository:
> >=20
> > 	https://git.pengutronix.de/git/ukl/linux siox/next
> >=20
> > I assume you wouldn't object to add this branch to linux-next? =20
>=20
> Added from today.  Is this a continuing effort, or should I just remove
> the tree once Greg has merged it?
>=20
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.=20
>=20
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and=20
>      * destined for the current or next Linux merge window.
>=20
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell

--Sig_/oOn2gN+=7HsqatyAw7Gfzvm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls5dGUACgkQAVBC80lX
0GxDcAf7BVP7jeMsC8rLKWZ+v1t3xmagQmSeN0u8Ef9KSCTp8brD80wyS3cvttYN
SGyx/hPkSeBw82cVSyXgnSUljp1lXeHmy5GzVzUCRU1FWQOx9k5E0Brrz4WmWhe3
TqcQdYxbbPpTCxm/U9SHSINRjcQx6nhXPTmUjCgt+9Vs6rYARw/M1L+I2cucoePN
ocD3a+x5y090pNdp1UhuKSr9iwQoDGYG0FCwDCb9PIE5FqCfTznd58VwX3gE6opt
8nefetFlSG4HZLWAe3KHhRwclYmkTDVvNQzf5cfHvy/P8N20DViMgoAII4TR0IYR
HUnpfBlY+2/Xyt1ry+RS8au/OFbjRQ==
=ZLYV
-----END PGP SIGNATURE-----

--Sig_/oOn2gN+=7HsqatyAw7Gfzvm--
