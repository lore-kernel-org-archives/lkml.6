Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E352070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519563;
	bh=xE1rOsSzNNSHc0gxYnZyCrlPrBTFrPS50dz+q4CfMMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DosGvPfaUT+bGNZdL2K+FKBLBQ8fUdmWjUIt5FLok14D6yCA9nN+KDdorKzyCNjE0
	 CirkMMEzakwgeduOFQNk2rueie+OT1FZ1JiOxIZlCW1OitnjKzW/G4xSSQ+YKjmNhK
	 FnM+pRnXsa1VZjL8SORT5VlaR2uwF/BXpJ5XsVqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfACMqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50336 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfACMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3UN2Z4Lhi52Of9oICiclLetZvUTViyAJcU1y29EeWbo=; b=vgBcqXekbUpkU8txYJFHJl/51
        5w9xrweNU9BDvnSPZcU3FVvtFdhYeH+70LiMq9hmaZmZk/wQwAa+HM/B0Hplxk4Ru68loPhFg7LB2
        kviFNU34ss5JVj0s7/nx3Ao8hXMF80BEUeiekODNNQXI9grUxMK3/wPwFDWzXYpKQZx/k=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gf2Nn-0005UB-S3; Thu, 03 Jan 2019 12:45:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0C20F440080; Thu,  3 Jan 2019 12:45:55 +0000 (GMT)
Date:   Thu, 3 Jan 2019 12:45:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     b-ak <anur.bhargav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190103124554.GS1846@sirena.org.uk>
References: <20190102170633.GA9724@Ideapad-330S>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKys6zTV8iyMJiwY"
Content-Disposition: inline
In-Reply-To: <20190102170633.GA9724@Ideapad-330S>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKys6zTV8iyMJiwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 10:36:33PM +0530, b-ak wrote:
> During the bootup of the kernel, as soon as the DAPM framework kicks in
> it pushes the codec into standy mode.
>=20
> The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
> the probe function.
> This leads to an OOPS when the DAPM tries to put it into standy by calling
> clk_disable_unprepare()
>=20
> This patch fixes that problem.

This isn't the best way of fixing this because it makes it look like
there's a missing disable in the removal process.  What would be better
would be to do what other drivers do and check to see what state we're
transitioning from before we disable the clock in set_bias_level().  See
drivers like wm8903.c for examples.

--NKys6zTV8iyMJiwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuBAIACgkQJNaLcl1U
h9BrYwf+KCEnm5TdZGt2KnnUoIaVh4hWECHkX/qObLnXclv5IAMaPVq0Kh/BsjUe
QeAyAioFfWsaTUwvG6BFPuG2roPQhR/QP97gxE3awnbH1VvL7TfjdVgmIi76ds53
Y5MxRRCN5g8Z4QhE/13lHMiPr4DH21gizaFMy/o7Z0/o9kGLxsn1WB6JopLh6f42
KQldT7VW7zix5LElg5ATUE1J2pkljeFVMXjjw71EJQSeyFFlpg2Xjaiq3jIIjHjh
0kEeiBSnuOK3i1ZUGmu0EdUvdbdGbqUOIZEpsgCb3tKYdPLG+7GvmNs34rUZiaMq
mQm2/dA1mWJK3m6v8YSmKIlTWCz03w==
=weB4
-----END PGP SIGNATURE-----

--NKys6zTV8iyMJiwY--
