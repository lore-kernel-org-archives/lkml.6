Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C9A214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q3HkxWTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C9A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeHPFIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:08:06 -0400
Received: from ozlabs.org ([203.11.71.1]:34531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbeHPFIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:08:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rVGx014Tz9s8k;
        Thu, 16 Aug 2018 12:12:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534385579;
        bh=wXu/4H7u+Tsch4PEFT8sE3lfADl45x2mpPcGYLCEDIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q3HkxWTbTT1imGUsyDA3dly8thEKDjIUJ4z8Wby4WVaO2PaJaZnR1kyvJKDKN4AUS
         TBi30GkT70gYDOooZhEq7EKPB3VGGzuQUuW3Rm3VaV3zYRJpj+5zJDnrQ5RIL8EMPF
         +c7/M6V9z0GDa0jOinrNLkekuIoykgfiQ04fLD12Pfprfp1BbErCsi3IqbShsN+vhS
         0u2QX1ZZXV+8237kCvJ+i7oZgGy6XDOkm2P3M7DFLBdTDJ+nirXMe39hU3GI+krtqm
         /ylRGu0IvtGJQAI9JrITlhR+L+bcZAiSvFnKUvV28DZP0kyiFIsy/i//2xEeA5jvJt
         Uw/zR9yomi/zg==
Date:   Thu, 16 Aug 2018 12:12:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>
Subject: Re: linux-next: manual merge of the mfd tree with the drm-intel
 tree
Message-ID: <20180816121256.0435930e@canb.auug.org.au>
In-Reply-To: <20180726151006.345e8397@canb.auug.org.au>
References: <20180726151006.345e8397@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ex_lo=vQHCdeSqjX49RZ7=."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ex_lo=vQHCdeSqjX49RZ7=.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 26 Jul 2018 15:10:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the mfd tree got a conflict in:
>=20
>   drivers/gpu/drm/i915/intel_display.h
>=20
> between commit:
>=20
>   6075546f57f8 ("drm/i915/icl: store the port type for TC ports")
>=20
> from the drm-intel tree and commit:
>=20
>   9c229127aee2 ("drm/i915: hdmi: add CEC notifier to intel_hdmi")
>=20
> from the mfd tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/gpu/drm/i915/intel_display.h
> index 0a79a46d5805,1f176a71e081..000000000000
> --- a/drivers/gpu/drm/i915/intel_display.h
> +++ b/drivers/gpu/drm/i915/intel_display.h
> @@@ -126,24 -126,30 +126,48 @@@ enum port=20
>  =20
>   #define port_name(p) ((p) + 'A')
>  =20
> + /*
> +  * Ports identifier referenced from other drivers.
> +  * Expected to remain stable over time
> +  */
> + static inline const char *port_identifier(enum port port)
> + {
> + 	switch (port) {
> + 	case PORT_A:
> + 		return "Port A";
> + 	case PORT_B:
> + 		return "Port B";
> + 	case PORT_C:
> + 		return "Port C";
> + 	case PORT_D:
> + 		return "Port D";
> + 	case PORT_E:
> + 		return "Port E";
> + 	case PORT_F:
> + 		return "Port F";
> + 	default:
> + 		return "<invalid>";
> + 	}
> + }
> +=20
>  +enum tc_port {
>  +	PORT_TC_NONE =3D -1,
>  +
>  +	PORT_TC1 =3D 0,
>  +	PORT_TC2,
>  +	PORT_TC3,
>  +	PORT_TC4,
>  +
>  +	I915_MAX_TC_PORTS
>  +};
>  +
>  +enum tc_port_type {
>  +	TC_PORT_UNKNOWN =3D 0,
>  +	TC_PORT_TYPEC,
>  +	TC_PORT_TBT,
>  +	TC_PORT_LEGACY,
>  +};
>  +
>   enum dpio_channel {
>   	DPIO_CH0,
>   	DPIO_CH1

This is now a conflict between Linus' tree and the mfd tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ex_lo=vQHCdeSqjX49RZ7=.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt03agACgkQAVBC80lX
0Gx6KAf9Gkj+UMsAWDisxNjEYdpuUiNb6jRkRKhhQLbFJhLrhVCTrXZPdO8RAu/a
IeWxHtIY1NtTdJzklsFAmZs5f0WrGEbwsAeM+O26fk/JH9+c+pBoZKyB1FIxF2Qo
EeEBeY9V81YXpg7YAaRyH3Wp7ZOF8doZ2un5hFWMFcrO8/i//uIqK3HRIuZF4Dw2
mjVPH+pOt9x3ZioQBl6aQag4C4fmvYaePUQYa6Qs2zXUByX/7kb4Dkk1ONZZM3uu
roF6nw6ucFFXbiYxIFbNLILoa+2Q3SUH3GWTbugmAfgjFGimj09o3jotvXC0s4Ob
N+5ROcveDzQlIsQVXkKaoLJ8iS13yA==
=x9sD
-----END PGP SIGNATURE-----

--Sig_/ex_lo=vQHCdeSqjX49RZ7=.--
