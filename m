Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F90C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5F920883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieHJbrhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5F920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeGJK5s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:57:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51365 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeGJK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:57:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so24229220wmc.1;
        Tue, 10 Jul 2018 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2ZvRn0EZ2K7KiUUUigqC29I8Xv0GVvAwNM53uXzTFw=;
        b=ieHJbrhBPZn3NkZfAdcOp6JGDXm+3RDT9uLknBlEGzSefKt9Itkwb59Uu6CpSJspkD
         nTFT7lhFqMC89lhX7EWKlFV9HrXOyxkEdGho9Sp3OWlku+NeiE42X9UIf64NKMPqUu+4
         5hs9jz89+UaS3cu48i6N61PcMRSYMtGAJCwp5JlAXWOxtExKrLQPE/s0shduqnnIUrVL
         S5ZBPYsdS+TRsyYt1fSGaJgqbQ1OgD68a3bBUFziAcc73pfNrWoJJdwiGwvfeXyM9dBv
         XLv0fNeLm0BYLyOMyCh/bBceixiZlepN0zHthKJHL1MJt3yR8lVA85o1k3qeVsTvcNMF
         TRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2ZvRn0EZ2K7KiUUUigqC29I8Xv0GVvAwNM53uXzTFw=;
        b=ntmbj3QHCpVcxQEIzhpb6RSdMMuf4A0eR1rrDsEv2B2WGo9t5Nao2+I31PBj04jDY2
         0S9DpIZOk/p5SBgKEwwRR1Qs5PO1P7/UHk0rZTEH7S7w1wuMDXj+sK9ub9SkZ+MB1uY6
         kbyI1QIOVHCvOAanOGFOhuUgvFJVGWcJvm+c1KDGiGccps7B0fzeMDc9xiRsd11Utsiv
         pnYM/ebf/5cEgxVxPCHMO0/O7LUfGJbVdaB5sEFaxuJfh4cL8jHnGOqEZsYI1oUTMrE9
         J0sYQLpupxg4+hyQNWGNN1FzjEuv2jxwvzRSJJ6caMDME3ezF58tywgceAUWY99+Z7A3
         WqvQ==
X-Gm-Message-State: APt69E2FiuiYWHFuuMK6ngkMgyKIb9ZXNHffPkADCF8VNMpWHxkSuSJo
        OD2Wlzi5Ww/KcrydDbnCc64=
X-Google-Smtp-Source: AAOMgpdZfvpyvX7dAU86ZXqb30aYwlWBEGdKkM+y+vr4iXoOZ3ohS8hPVd0hy3cjv1L0o0wTs4EX2Q==
X-Received: by 2002:a1c:2094:: with SMTP id g142-v6mr13464940wmg.144.1531220265278;
        Tue, 10 Jul 2018 03:57:45 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id a17-v6sm14443514wrr.81.2018.07.10.03.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:57:44 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:57:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com
Subject: Re: [PATCH v5 1/4] drm/panel: p079zca: refactor panel driver to
 support multiple panels
Message-ID: <20180710105743.GK1504@ulmo>
References: <20180702102721.3546-1-heiko@sntech.de>
 <20180702102721.3546-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
In-Reply-To: <20180702102721.3546-2-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:27:18PM +0200, Heiko Stuebner wrote:
> From: huang lin <hl@rock-chips.com>
>=20
> Refactor Innolux P079ZCA panel driver, let it support
> multi panels from Innolux that share similar power sequences.
>=20
> Panels may require different power supplies so use regulator bulk
> interfaces and define per panel supply-names.
>=20
> Changes in v2:
> - Change regulator property name to meet the panel datasheet
> Changes in v3:
> - this patch only refactor P079ZCA panel to support multi panel,
>   support P097PFG panel in another patch
> Changes in v4:
> - Modify the patch which suggest by Thierry
> Changes in v5:
> - use regulator_bulk to handle different supply number
>=20
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 143 ++++++++++++------
>  1 file changed, 100 insertions(+), 43 deletions(-)

Applied with minor changes, see below.

> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/=
drm/panel/panel-innolux-p079zca.c
> index bb53e0850764..840ad4a6a6a6 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -20,12 +20,29 @@
> =20
>  #include <video/mipi_display.h>
> =20
> +struct panel_desc {
> +	const struct drm_display_mode *modes;

I renamed this to "mode" because there is always only one.

> +	unsigned int bpc;
> +	struct {
> +		unsigned int width;
> +		unsigned int height;
> +	} size;
> +
> +	unsigned long flags;
> +	enum mipi_dsi_pixel_format format;
> +	unsigned int lanes;
> +	const char * const *supply_names;
> +	unsigned int num_supplies;
> +};
> +
>  struct innolux_panel {
>  	struct drm_panel base;
>  	struct mipi_dsi_device *link;
> +	const struct panel_desc *desc;
> =20
>  	struct backlight_device *backlight;
> -	struct regulator *supply;
> +	struct regulator_bulk_data *supplies;
> +	unsigned int num_supplies;
>  	struct gpio_desc *enable_gpio;
> =20
>  	bool prepared;
> @@ -77,9 +94,7 @@ static int innolux_panel_unprepare(struct drm_panel *pa=
nel)
>  	/* T8: 80ms - 1000ms */
>  	msleep(80);
> =20
> -	err =3D regulator_disable(innolux->supply);
> -	if (err < 0)
> -		return err;
> +	regulator_bulk_disable(innolux->desc->num_supplies, innolux->supplies);

I kept the error check and return here.

Thierry

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEkSUACgkQ3SOs138+
s6G5yA//f2D9uNuTm2WZxbSpNglRCQnqDnGKXpoRObsJpnLHrPmPO6U8hvr+OtOE
iyQRjIAmmWTM/LnEPv1VYcYaQFaxNgJ9GzYCUPE6pdxYOZ86yJUyGwpjJrzaHEGN
WMYta4vuwgDJNX2MzZUuVwm7EtXr93BzQa7myz0qpVGHaXMUi/+fR5ilL12J4upD
KwRw0zmqzAi+vVkstpnr5gTV6mLr3KF1FV1V/Y7iv7kCizZXLOyx6GWVAL3dvWTK
nmrxs+CWbzpH/zWRAETbpwbpfD7OHIoKiUP0PazuIkcm61xOJClpqKDr/TDtSmLa
ikZnPM8C7GNryVwpTk/qK0uUHLbRg7z5tp9CTUFm+T46pb7XpAHCZkGGDEX2q8q/
/qdS7xZg94JTN6KVd9O2GyBzNbrjceq+iawhHs+/dFmXlTmH/q2pVcd2np0m4yCC
Zkf8BdAz032Utaxbs2LgyKynPPN814JVac4YTTE21Mv0q9LQrv300Kq577MsR0Ph
Tj6VFpEh+gDkmT3OINCUoU3L5IqLGwotx88526tVE06i737V6E8dMV5uG8TPSpfB
S5gdhuNdxVO8ZYVI8/C1tfF02t+z5rzebwit0VM/BY6XDYwt+A5AFiwqDhvrmyKh
nH/vQUZidJR9hCt+8fnTZx0aoDkjeJGL+v2aS2gvcftj4Fh9Q4Q=
=08iG
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
