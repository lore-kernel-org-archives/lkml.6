Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71337C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD421872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGf35ywY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfADNOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:14:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54947 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfADNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:14:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so1101131wmh.4;
        Fri, 04 Jan 2019 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VKUS3AQfXcygqeYSH6mD+eitqtVhh9PvZs1yWSBOqWQ=;
        b=JGf35ywYlZUMYrz8hHD2/pHyT6yLFZykXCqu5zvxPwfwg4ZRQPrMk2fNmCCEB0f818
         HVt+Nuf4VLShoQuz6NxUvTstqX1rzh4y49Bfbwz041Wj9RMBudryY0Ly437DbT3Uh4+I
         y9PUm0x1+QDnodLWtvOix+FTJn7ReTbmZQh4Sfca4JxV7DA7sj5lhw2NN+zaxG0/YqTD
         ulCF2FygMEat/5FLzpEqMuupozhtBHCLNoTennsGmTMEXmMGVBfOUaH/nTT5kBk9sIaj
         PWaRHam3JR0wixHkZRLEFZYTOCLIzUoHssTX8rbNPkEclbFejn1HQAQDRSASugGIsKTe
         z4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VKUS3AQfXcygqeYSH6mD+eitqtVhh9PvZs1yWSBOqWQ=;
        b=SaxSy2CGH0sNIs5hlmuvg3GiWQAyihcb5m547Jrzu7u6dXYs8OYZTHI2mpHoA263VT
         X3rze30Q/YLlnU6ZEQOveFZ/EjtpviEcgdB2opU/27OLHjNwLZpLiGZw0V/SyHft8OnW
         qsGZRUv7p783ynQVWnm0d6jkANHlsUe5TQCWsWG6QSfhdAuI7+9xJzfmhiR3h/TKi1m4
         NrEsrfoy99Nhrj7jRyCI7j+9XmxVX7I0OjimqyJNs3eaFwYQB45DslspVoqrcMMjjcH3
         3ZcadeAIUVLK8FVZAYuKDzUOnLorNWkZcoplE7BSoc+WRqucBnOzUiaOzCirPJXNKut0
         EsEQ==
X-Gm-Message-State: AJcUukesmYEvKm55hNo7UjI0q3UDdC/bcEdROaldKkzM+CaDl9yMoAhE
        E63TqrQt5EtdZMf1H+LaMWQ=
X-Google-Smtp-Source: ALg8bN5JrfschHPRNf6zpUFehcRqxLHIg5hmKnlVPKYY/tYPcYhXJl7eVIVYMHpSMRkpL90TB//4pQ==
X-Received: by 2002:a1c:22c5:: with SMTP id i188mr1328537wmi.39.1546607636648;
        Fri, 04 Jan 2019 05:13:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c1sm888045wmb.14.2019.01.04.05.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 05:13:55 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:13:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alban Bedel <alban.bedel@avionic-design.de>
Cc:     David Airlie <airlied@linux.ie>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: hdmi: Fix audio to work with any pixel clock
 rate
Message-ID: <20190104131354.GA9903@ulmo>
References: <20161214172039.5615-1-alban.bedel@avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20161214172039.5615-1-alban.bedel@avionic-design.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 06:20:39PM +0100, Alban Bedel wrote:
> The audio setting implementation was limited to a few specific pixel
> clocks. This prevented HDMI audio from working on several test devices
> as they need a pixel clock that is not supported by this implementation.
>=20
> Fix this by implementing the algorithm provided in the TRM using fixed
> point arithmetic. This allows the driver to cope with any sane pixel
> clock rate.
>=20
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> ---
>  drivers/gpu/drm/tegra/hdmi.c | 163 ++++++++++++++-----------------------=
------
>  1 file changed, 54 insertions(+), 109 deletions(-)

I had completely forgotten about this one, but then ran into this issue
myself yesterday and only then I started remembering this patch. It did
apply almost cleanly and still works perfectly. I made a couple of minor
modifications (see below) and applied this for v4.22.

> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index cda0491ed6bf..b6078d6604b1 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> +#include <asm/div64.h>

Turned this into #include <linux/math64.h> which I think is the more
canonical way to get at do_div() nowadays.

> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> @@ -112,68 +113,11 @@ static inline void tegra_hdmi_writel(struct tegra_h=
dmi *hdmi, u32 value,
>  }
> =20
>  struct tegra_hdmi_audio_config {
> -	unsigned int pclk;
>  	unsigned int n;
>  	unsigned int cts;
>  	unsigned int aval;
>  };
> =20
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_32k[] =3D {
> -	{  25200000, 4096,  25200, 24000 },
> -	{  27000000, 4096,  27000, 24000 },
> -	{  74250000, 4096,  74250, 24000 },
> -	{ 148500000, 4096, 148500, 24000 },
> -	{         0,    0,      0,     0 },
> -};
> -
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_44_1k[] =3D=
 {
> -	{  25200000, 5880,  26250, 25000 },
> -	{  27000000, 5880,  28125, 25000 },
> -	{  74250000, 4704,  61875, 20000 },
> -	{ 148500000, 4704, 123750, 20000 },
> -	{         0,    0,      0,     0 },
> -};
> -
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_48k[] =3D {
> -	{  25200000, 6144,  25200, 24000 },
> -	{  27000000, 6144,  27000, 24000 },
> -	{  74250000, 6144,  74250, 24000 },
> -	{ 148500000, 6144, 148500, 24000 },
> -	{         0,    0,      0,     0 },
> -};
> -
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_88_2k[] =3D=
 {
> -	{  25200000, 11760,  26250, 25000 },
> -	{  27000000, 11760,  28125, 25000 },
> -	{  74250000,  9408,  61875, 20000 },
> -	{ 148500000,  9408, 123750, 20000 },
> -	{         0,     0,      0,     0 },
> -};
> -
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_96k[] =3D {
> -	{  25200000, 12288,  25200, 24000 },
> -	{  27000000, 12288,  27000, 24000 },
> -	{  74250000, 12288,  74250, 24000 },
> -	{ 148500000, 12288, 148500, 24000 },
> -	{         0,     0,      0,     0 },
> -};
> -
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_176_4k[] =
=3D {
> -	{  25200000, 23520,  26250, 25000 },
> -	{  27000000, 23520,  28125, 25000 },
> -	{  74250000, 18816,  61875, 20000 },
> -	{ 148500000, 18816, 123750, 20000 },
> -	{         0,     0,      0,     0 },
> -};
> -
> -static const struct tegra_hdmi_audio_config tegra_hdmi_audio_192k[] =3D {
> -	{  25200000, 24576,  25200, 24000 },
> -	{  27000000, 24576,  27000, 24000 },
> -	{  74250000, 24576,  74250, 24000 },
> -	{ 148500000, 24576, 148500, 24000 },
> -	{         0,     0,      0,     0 },
> -};
> -
>  static const struct tmds_config tegra20_tmds_config[] =3D {
>  	{ /* slow pixel clock modes */
>  		.pclk =3D 27000000,
> @@ -411,52 +355,49 @@ static const struct tmds_config tegra124_tmds_confi=
g[] =3D {
>  	},
>  };
> =20
> -static const struct tegra_hdmi_audio_config *
> -tegra_hdmi_get_audio_config(unsigned int sample_rate, unsigned int pclk)
> +static int
> +tegra_hdmi_get_audio_config(unsigned int audio_freq, unsigned int pix_cl=
ock,
> +			    struct tegra_hdmi_audio_config *config)
>  {
> -	const struct tegra_hdmi_audio_config *table;
> -
> -	switch (sample_rate) {
> -	case 32000:
> -		table =3D tegra_hdmi_audio_32k;
> -		break;
> -
> -	case 44100:
> -		table =3D tegra_hdmi_audio_44_1k;
> -		break;
> -
> -	case 48000:
> -		table =3D tegra_hdmi_audio_48k;
> -		break;
> -
> -	case 88200:
> -		table =3D tegra_hdmi_audio_88_2k;
> -		break;
> -
> -	case 96000:
> -		table =3D tegra_hdmi_audio_96k;
> -		break;
> -
> -	case 176400:
> -		table =3D tegra_hdmi_audio_176_4k;
> -		break;
> -
> -	case 192000:
> -		table =3D tegra_hdmi_audio_192k;
> -		break;
> -
> -	default:
> -		return NULL;
> -	}
> -
> -	while (table->pclk) {
> -		if (table->pclk =3D=3D pclk)
> -			return table;
> -
> -		table++;
> +	const int afreq =3D 128 * audio_freq;
> +	const int min_n =3D afreq / 1500;
> +	const int max_n =3D afreq / 300;
> +	const int ideal_n =3D afreq / 1000;

Made all of these unsigned and added a new min_delta variable to track
abs(config->n - ideal_n). This is both to avoid recomputing it and also
=2E..

> +	int64_t min_err =3D (uint64_t)-1 >> 1;
> +	int n;
> +
> +	config->n =3D -1;
> +
> +	for (n =3D min_n; n <=3D max_n; n++) {
> +		uint64_t cts_f, aval_f;
> +		int64_t cts, err;
> +
> +		/* compute aval in 48.16 fixed point */
> +		aval_f =3D ((int64_t)24000000 << 16) * n;
> +		do_div(aval_f, afreq);
> +		/* It should round without any rest */
> +		if (aval_f & 0xFFFF)
> +			continue;
> +
> +		/* Compute cts in 48.16 fixed point */
> +		cts_f =3D ((int64_t)pix_clock << 16) * n;
> +		do_div(cts_f, afreq);
> +		/* Round it to the nearest integer */
> +		cts =3D (cts_f & ~0xFFFF) + ((cts_f & BIT(15)) << 1);
> +
> +		/* Compute the absolute error */
> +		err =3D abs((int64_t)cts_f - cts);
> +		if (err < min_err ||
> +		    (err =3D=3D min_err &&
> +		     abs(n - ideal_n) < abs(config->n - ideal_n))) {

=2E.. make this conditional slightly more readable.

Thanks,
Thierry

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwvXA8ACgkQ3SOs138+
s6E02g//SVnV7dwtNJePGsBETNV8HaMndDdsttiAPhdpG7Ka8X33Yl4SneMAIQKi
CKu42Aixrk98P96973y680Yd+KoWr3g9K3hzFP9JV1duR6KQQeXQx6R70MEp5sI8
G6i69oPmgeewq8BN1VXwdyid9n72YDl+pVLVUOhlDNSP4Q7XQP+CnYS6oUXYpLhD
1M6NZsYI0OH0Yb/jkfN0ricw5cnaqMpgYuGi/3hlMQN5s8zkwpHayXkeuP1DJ8cq
O6aLa7/WcYZgu/ULDkxLLlFcIuAcJic2/vnKITK+yHkcscVIvpv5PmYytq1laRyT
NC9hJpZmZKhvM1VxA7CbJYUS3uwSGtDL8HcNTptZx291ZVvKZshs8ZdnopWRo8AP
M1S5rQqJ4n8WwiFX8fwg3rI9OUxoKVyZN142GnQfV1X/7wQUMOU2UEyYCJDwdAFs
E9Vspxd31oIvdnrOYyOAvVeXJMaZB3x/mEUUmPi1fx0bwkfeoZnWQ06nYiwdPeP4
hHpl5cJSEp8Aez8M6K5dwTOCiEXu3uHvfiULJJ34zz8sXFeJWZyjeg2eGshXxVOA
RLSCbw8oLg7Y98QIpIuX7K2rBRRaXppEQhK4v8jOQzh5W/zNXrFxw/VY2kYoMTBK
SqZL/YqC/9ZFDxPERYvY0fWa+n+Qzre36x3b/UafEt730SNXcUM=
=k/ss
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
