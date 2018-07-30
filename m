Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D240FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2981320881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BaIjCpEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2981320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeG3M3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:29:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36216 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeG3M3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MAhP5YsjQ22SVLry3sCKH/tsrDi4C95KwaHN1UhjDzs=; b=BaIjCpEzJ72XL1w4BQcPB6CxG
        qCO+g9DqbXlj1mObqc//g+2FH3nLT01t+fuppLSFK7StyVn8Fx8X080BjICnLdMX0b5zWc2gjYeHV
        svtLUTXVBj+/27oeYwnlHxJkIGx6Y4F3PK32YVbp6i+42ti6BCYTG2l2E/T1G39/7eWUE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5ox-00051t-DG; Mon, 30 Jul 2018 10:54:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0650C1124216; Mon, 30 Jul 2018 11:54:35 +0100 (BST)
Date:   Mon, 30 Jul 2018 11:54:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer function
Message-ID: <20180730105434.GI5789@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline
In-Reply-To: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 06:13:42PM +0800, Akshu Agrawal wrote:
> There are cases where a pointer function populates
> runtime->delay, such as:
> ./sound/pci/hda/hda_controller.c
> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
>=20
> Also, in some cases cpu dai used is generic and the pcm
> driver needs to set delay.
>=20
> This delay was getting lost and was overwritten by delays
> from codec or cpu dai delay function if exposed.

I'm not 100% clear how this patch is supposed to work.

> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd=
_pcm_substream *substream)
>  	snd_pcm_sframes_t codec_delay =3D 0;
>  	int i;
> =20
> +	/* clearing the previous delay */
> +	runtime->delay =3D 0;
> +
>  	for_each_rtdcom(rtd, rtdcom) {
>  		component =3D rtdcom->component;
> =20

Here we reset runtime->delay to 0.

> @@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd=
_pcm_substream *substream)
>  	}
>  	delay +=3D codec_delay;
> =20
> -	runtime->delay =3D delay;
> +	runtime->delay +=3D delay;
> =20
>  	return offset;
>  }

but here we change the only assignment to delay from a straight
assignment to an accumilation.  I'm a bit confused as to the intended
difference - when will this be doing something other than setting
runtime->delay to the value we originally accumilated in delay which was
what we were doing anyway?

The two examples you mention just do a straight assignment to delay so
they're not going to be compatible with accumilating in delay, it feels
like we'd do better to add an explicit delay operation for them too to
match what we're doing with CODECs but perhaps I'm missing something
here.

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte7moACgkQJNaLcl1U
h9D7Ogf9EEnFRQaJzcEvMxcXWGfpH67sMPsepAF3DfO24Y88skr2RlBooq4Pxs6r
SNr6Rxgm8OJgX4LkAbmGrvuPKZZGeEDxi+pSJJewueB6/Sh+oilp3GFVaXxJBSea
8hnFVMDLf3JKLPL93kRLyibAI52h+3d3BUTH71MIERP9JqeeHcHYhbN65+vcz//k
I4lMN/v2etok6lQtdmEPSeD6phJBJFkZPe8Nycqm2T8xKJLq1e6kptTjVuaCvmVN
IdmbAMCOqULeGAKCw5IMYcr4U3I7mh0UufoJbMef1Bg1a5CEwBw5z670uoC6g0up
9H33GILgjFhfo3M86aYahTkaGrvU4A==
=0aig
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
