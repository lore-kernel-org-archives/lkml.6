Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D839DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24C42089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546878550;
	bh=oez4o7YkftVNdBLLC7MMIwazQiWu1Vv6/vxqapAcyaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eQ0Bk485M9maQ5mRxfYg9/FuuiFamBJf7b+s/LCP0A7YsdBjgdNs2DzBoUttPzvAf
	 o9QUi6nV/Sdzl9PgTJumkhqtCIsePHozn7S/uR1oTauLSoVjQ8H5Eaa8O0mcPdU7I2
	 Q4FBQuDPGb7PYHuRCVEcP7N9tQBAgNneaRhC+kd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfAGQ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:29:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbfAGQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QFbkdOcc4Vakj8FaonWmGa7XLFzcp4C7IaWwXYRdoOM=; b=o4eQ5JZ7p5A58HKbz7yJ3i1L/
        H3pZJL2S8otoaWO0JV4KTLaICmYynZKipHp4TK5Ht1rlI7fWft3hDdY0vm0srGJlaUpmIU0AmpIgo
        bIVM5QLe9vvIdu8SLJsXvjFs6nL79kaHRQy0tQgY+VLnf0JP7baToyhZGhXIBygEvte7I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggXld-0007Sp-92; Mon, 07 Jan 2019 16:28:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD2951127491; Mon,  7 Jan 2019 16:28:44 +0000 (GMT)
Date:   Mon, 7 Jan 2019 16:28:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt298: Variable "val" and "buf" in
 rt298_jack_detect() could be uninitialized
Message-ID: <20190107162844.GK9570@sirena.org.uk>
References: <20190104215253.16278-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJAclU0AInkryoed"
Content-Disposition: inline
In-Reply-To: <20190104215253.16278-1-yzhai003@ucr.edu>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJAclU0AInkryoed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2019 at 01:52:53PM -0800, Yizhuo wrote:

>  {
>  	struct snd_soc_dapm_context *dapm;
>  	unsigned int val, buf;
> +	int ret = 0;

It's bad practice to just initailize like this without a reason - it
tends to just mask actual cases where we miss error handling by ensuring
that it's always initialized.

>  			if (0x0070 == (val & 0x0070)) {
>  				*mic = true;
>  			} else {
>  				regmap_update_bits(rt298->regmap,
>  					RT298_CBJ_CTRL1, 0xfcc0, 0xe400);
>  				msleep(300);
> -				regmap_read(rt298->regmap,
> +				ret = regmap_read(rt298->regmap,
>  					RT298_CBJ_CTRL2, &val);
> +				if (ret)
> +					return ret;

We've started doing some writes to the device (which you've not added
checks for) here but then if the read fails we just bomb out with an
error code - are you sure that none of the writes need to be reverted?

--IJAclU0AInkryoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzfjsACgkQJNaLcl1U
h9B8ZAf/crhqUm6mmOd0Zu21moCGdovWEr4Dks4ovW6tH+i8R8DPPlFwFrrwqoUC
AmfutDFZo0Ee87LDb6olzsVWECeXWeQpuv4DyKz+nmpnjUSqbZ0Vqgc0abSTHY8b
9PY/xrggQsOYc4vsW+/1NpmkZ/ATsaQ8zzNJyX0H4Ywt/BPTSoT7R8PGGxo//gC1
1LN7TgNgWxa/tHknt8d6tvDCfW1miFApieGEmPyZSpDoUY1qfceMvdkD+2gX80wF
P+ZwDvKykq6kGNH2/nVYPc8pErH/ADtMmHR3fpOlKEcG3Rv7I3iiboPmevqyJVZl
Ml8x0GeaTZMAsvhfdKEFRKFTo+5JRg==
=tyXZ
-----END PGP SIGNATURE-----

--IJAclU0AInkryoed--
