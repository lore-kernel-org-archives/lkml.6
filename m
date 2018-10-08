Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214CFC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DD320882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Y1X5k5bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DD320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJHQpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:45:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48754 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+vDy0Yg/gqFZiGphqvuBKm1xbuILtNuwzztyQtuzPPM=; b=Y1X5k5bMdi5wXSBAeHujzKYuW
        KWpxa6V9D3G6dxCJirYLpJt/k1zmkkxbnEiY81tH0OeXD6Bpfh6hE3fzrzjIh/K6YCixmwT6yDQ4H
        eD3aPwGjlrw2Xkui75WjIvix8M5uFEDPGZCFmeuUxFPaCTh0QIFsi/VYACjcVQrUwBb70=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9Rvl-0002MH-Fb; Mon, 08 Oct 2018 09:34:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3EC111122339; Mon,  8 Oct 2018 10:34:25 +0100 (BST)
Date:   Mon, 8 Oct 2018 10:34:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>, tiwai@suse.de
Subject: Re: [PATCH AUTOSEL 4.18 28/48] sound: don't call skl_init_chip() to
 reset intel skl soc
Message-ID: <20181008093425.GB5684@sirena.org.uk>
References: <20181005161424.20521-1-sashal@kernel.org>
 <20181005161424.20521-28-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20181005161424.20521-28-sashal@kernel.org>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 12:14:04PM -0400, Sasha Levin wrote:
> From: Yu Zhao <yuzhao@google.com>
>=20
> [ Upstream commit 75383f8d39d4c0fb96083dd460b7b139fbdac492 ]
>=20
> Internally, skl_init_chip() calls snd_hdac_bus_init_chip() which
> 1) sets bus->chip_init to prevent multiple entrances before device
> is stopped; 2) enables interrupt.

And here.

>=20
> We shouldn't use it for the purpose of resetting device only because
> 1) when we really want to initialize device, we won't be able to do
> so; 2) we are ready to handle interrupt yet, and kernel crashes when
> interrupt comes in.
>=20
> Rename azx_reset() to snd_hdac_bus_reset_link(), and use it to reset
> device properly.
>=20
> Fixes: 60767abcea3d ("ASoC: Intel: Skylake: Reset the controller in probe=
")
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  include/sound/hdaudio.h       | 1 +
>  sound/hda/hdac_controller.c   | 7 ++++---
>  sound/soc/intel/skylake/skl.c | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index c052afc27547..138e976a2ba2 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -355,6 +355,7 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus);
>  void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus);
>  void snd_hdac_bus_enter_link_reset(struct hdac_bus *bus);
>  void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus);
> +int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset);
> =20
>  void snd_hdac_bus_update_rirb(struct hdac_bus *bus);
>  int snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int st=
atus,
> diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
> index 11057d9f84ec..74244d8e2909 100644
> --- a/sound/hda/hdac_controller.c
> +++ b/sound/hda/hdac_controller.c
> @@ -385,7 +385,7 @@ void snd_hdac_bus_exit_link_reset(struct hdac_bus *bu=
s)
>  EXPORT_SYMBOL_GPL(snd_hdac_bus_exit_link_reset);
> =20
>  /* reset codec link */
> -static int azx_reset(struct hdac_bus *bus, bool full_reset)
> +int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
>  {
>  	if (!full_reset)
>  		goto skip_reset;
> @@ -410,7 +410,7 @@ static int azx_reset(struct hdac_bus *bus, bool full_=
reset)
>   skip_reset:
>  	/* check to see if controller is ready */
>  	if (!snd_hdac_chip_readb(bus, GCTL)) {
> -		dev_dbg(bus->dev, "azx_reset: controller not ready!\n");
> +		dev_dbg(bus->dev, "controller not ready!\n");
>  		return -EBUSY;
>  	}
> =20
> @@ -425,6 +425,7 @@ static int azx_reset(struct hdac_bus *bus, bool full_=
reset)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(snd_hdac_bus_reset_link);
> =20
>  /* enable interrupts */
>  static void azx_int_enable(struct hdac_bus *bus)
> @@ -479,7 +480,7 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, boo=
l full_reset)
>  		return false;
> =20
>  	/* reset controller */
> -	azx_reset(bus, full_reset);
> +	snd_hdac_bus_reset_link(bus, full_reset);
> =20
>  	/* clear interrupts */
>  	azx_int_clear(bus);
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index f0d9793f872a..c7cdfa4a7076 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -844,7 +844,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
>  		return -ENXIO;
>  	}
> =20
> -	skl_init_chip(bus, true);
> +	snd_hdac_bus_reset_link(bus, true);
> =20
>  	snd_hdac_bus_parse_capabilities(bus);
> =20
> --=20
> 2.17.1
>=20

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7JKAACgkQJNaLcl1U
h9C7Xgf/RVSyhckeShF54sD6LD7X2UDGlEJfazLWtK2Es+BsT/BEhgdp/MDP29nr
ZDzflW+21Wu+uvOcApJXSt5DarehJZAmc0k6kAzuLXOLZq2zupqM3adjtfncE5SC
eSvJSOyrnkHqo5SusdfRbE/R15s1pBNUs72l/GGezsGJEtYIUCHvKlsahllPaxeg
szWlzeUdLgx6OB4KZZoSHl47wFoVtZSao5XG5ceGXAlK6Z8f2QzFZXC+jSN37FBW
qG/rmFAgkop+chGtx3tkRuvymYmZybzxDCswpn1+CipHvPaFKhYwZ7zh1v1vMBNp
0fxGBCl/2KE5hgEL4Js9DtKORTk0Ow==
=ssFB
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
