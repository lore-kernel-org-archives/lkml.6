Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5387D20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPAzZzur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5387D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeGJK7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:59:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54607 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933220AbeGJK7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:59:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so24055271wmf.4;
        Tue, 10 Jul 2018 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8i7wzyDnvkKOJAeVUfzSgfOixULcC4eWS0ZBmJ9Aw8k=;
        b=qPAzZzurqMJPOoCY+nuk4nDLKxh2hzXEbO5qfhlUSmmSAnRqLp0kap8BAVM5hTbWdW
         8UpoofMcrcZFyDhNzVePuCYxFgryvk0Na+6/aPf5IA1KQIOsJC0a/FDfAKnRV5urfuhQ
         wEOlV4lJORZ4fWh86GBvVBzH/k0ptMj6uq6hPadiubejJEx3NJ5ehrCqaPbMF6sT4XOe
         Y0vRwjszjlmCFWjtawlhYCtZCm0R7Kx3wSyZLyo8PWa6hT0cJkY+rIMLI8eyDNfqmGWu
         dzGsxzBGUu6xuKJVL5G4rgWtDq2n816CVQDDfNFSxRSfHWLExe9wOxdpYTFFrfYyQ1sc
         eaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8i7wzyDnvkKOJAeVUfzSgfOixULcC4eWS0ZBmJ9Aw8k=;
        b=p1Oh22+/mpcveuy6cclfDyw8m6c5y84Y7vLh+5j3WwW9j6DVqHpW1OEv4+PQ+ZHD2Y
         G/Cg30d2w+Ce8ahaRuzM6JdN5BBPDuCWqJv3GSotWRd3kAkQ71B6M95opqYknOc36cly
         HRv6fNAqfIpfFhJnPpqhkUFZkiF+txKXp7j2vcQ3rXskCDuCR0f9a60UpFpq0L/VoymI
         SHVNijNRFESD5aYJIU+TFvanmkcxDRoUfejbTnNPR7ZWlUdmY3cJEwVKH2dN6xyfR/K5
         KJ57FakGPnvmS2vraiFjCbq3GrutRg2ZxdtNzPk3YYDZl6ucc29ApnyBIjFErWwSSCKX
         TnXQ==
X-Gm-Message-State: APt69E0N4DYv/5M8SztrWJrojExYOTMoOD3krzZ92i56OeFGwUc8C33a
        YxIhQDD/knyOOruOMNi73/s=
X-Google-Smtp-Source: AAOMgpcsEfyglgx/FYjj/VlA+K4Syr5WZZec7sF8Gu6yeWEBufD+dRF45i1JsvvvxKjfVimzFwydCQ==
X-Received: by 2002:a1c:c44f:: with SMTP id u76-v6mr14108251wmf.43.1531220370565;
        Tue, 10 Jul 2018 03:59:30 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id 31-v6sm9130921wra.26.2018.07.10.03.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:59:29 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:59:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com
Subject: Re: [PATCH v5 4/4] drm/panel: p079zca: support Innolux P097PFG panel
Message-ID: <20180710105928.GN1504@ulmo>
References: <20180702102721.3546-1-heiko@sntech.de>
 <20180702102721.3546-5-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline
In-Reply-To: <20180702102721.3546-5-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:27:21PM +0200, Heiko Stuebner wrote:
> From: Lin Huang <hl@rock-chips.com>
>=20
> Support Innolux P097PFG 9.7" 1536x2048 TFT LCD panel, it reuse
> the Innolux P079ZCA panel driver.
>=20
> Changes in v2:
> - None
> Changes in v3:
> - None
> Changes in v4:
> - None
> Changes in v5:
> - Document source of init-commands
> - 4 lanes per DSI interface
>=20
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 200 +++++++++++++++++-
>  1 file changed, 196 insertions(+), 4 deletions(-)

Applied with two small changes, see below.

> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/=
drm/panel/panel-innolux-p079zca.c
> index 630b0c2549ef..8d25b87bfbd6 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -20,6 +20,15 @@
> =20
>  #include <video/mipi_display.h>
> =20
> +struct panel_init_cmd {
> +	int len;

I changed the type here to size_t for consistency.

> +	const char *data;
> +};
> +
> +#define _INIT_CMD(...) { \
> +	.len =3D sizeof((char[]){__VA_ARGS__}), \
> +	.data =3D (char[]){__VA_ARGS__} }
> +
>  struct panel_desc {
>  	const struct drm_display_mode *modes;
>  	unsigned int bpc;
> @@ -30,6 +39,7 @@ struct panel_desc {
> =20
>  	unsigned long flags;
>  	enum mipi_dsi_pixel_format format;
> +	const struct panel_init_cmd *init_cmds;
>  	unsigned int lanes;
>  	const char * const *supply_names;
>  	unsigned int num_supplies;
> @@ -121,13 +131,43 @@ static int innolux_panel_prepare(struct drm_panel *=
panel)
>  	if (err < 0)
>  		return err;
> =20
> -	/* T2: 15ms - 1000ms */
> -	usleep_range(15000, 16000);
> +	/* p079zca: t2 (20ms), p097pfg: t4 (15ms) */
> +	usleep_range(20000, 21000);
> =20
>  	gpiod_set_value_cansleep(innolux->enable_gpio, 1);
> =20
> -	/* T4: 15ms - 1000ms */
> -	usleep_range(15000, 16000);
> +	/* p079zca: t4, p097pfg: t5 */
> +	usleep_range(20000, 21000);
> +
> +	if (innolux->desc->init_cmds) {
> +		const struct panel_init_cmd *cmds =3D
> +					innolux->desc->init_cmds;
> +		int i;

I made this unsigned.

Thierry

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEkZAACgkQ3SOs138+
s6FwsQ/+N/cFVjeZX8z087RvxJQ+AU8jhZzuE9DxbqUyfLMGoM9a1WpW5MT4QP8c
wCNY/K68aB3Ipt4BUf2hz/YZZJc3C/V9G5OhABTcwf0OVNzE0IVwUsb3J2gvu3XU
CU/MsvvHu9etFJ9am4kkm5QQHwYXO5i1ZCuJWSrenBfL6IaWS6k3ZTYKl4t+f9mA
p+K5qxqCnlA2kQXzLu3b1FcogjP5HUX7k/ghFoNh8PeAVNoMZpPqSFLePGxem4z+
ITcht2pwKDKpE+ovETw6jRhCVETM37RhX7LYwg1emuOz114hprvnj87D8eWG3TSD
fb39I8ACR+IfK+sT8/ppX4TR5F41++07OdL8TriUcUuuuHq1Vm6cidqVKokFzfY4
iymNaFmZPKGCU3MDwMI+PuSGo9aPgIM+fo0Y+XkZyajDGqNCZcZrasCoTF78tGjV
YhcOHff49dgCbJNjwZ6nnKu9tI0VzA2YfOnBpKONdzIgJUnQJEEhlzuBMY2zT9K9
chkNAdnOeOGaaewL2IcoBda2h1MgGrmoNlMWGUNJe4T1gp2FTDOiQc+uyrl6BmMI
OXAe5Lgm/bUkUL5MJ6KT1UYmkFOZigp6g//CVPnkHKoLGXnFoGGyEtaCVSt4wsyH
NfTvRtQIFSIUTTw+Ap/Su2Wj0vVrj/Qm9otDMukiC6s39gEMHN8=
=HoHv
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
