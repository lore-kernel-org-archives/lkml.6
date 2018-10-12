Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1030C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D152086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnadBu+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJLSLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:11:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:11:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so11759429wmf.1;
        Fri, 12 Oct 2018 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P4FMXU+dr2OS/jhn7+79OVEFnzX+vIBjUnpiLGCuw2w=;
        b=RnadBu+YR3q3S7N9VEPJTIwzNH0dr4wvWJZmLhEdT2fMAp/3rTVaI+ApDgcgvVvcyC
         ZJc9pfW6gs8AjU9mT8CvnvV2Px+NusXBZaYTFB5tD/g8wIY829Yi4OvRCnmsCu4mkqRQ
         Tmcy4ukdf2s9zx0D7iaifYeGlV7jAIZL6IrD9hcVXb5NX4Z/MhMteGWj+m3Kz6bYaz24
         LZQe80pDI2YtMd0qHL7HiblzUZ4c+y37W5bCbzgFg34GUJpZZj2L3614JHz2wOe0/Luj
         fskseEwfOFXo35di4ZOK3r4M3edwHGB7XyUsrOA1fAsFjcagrbZElZvBzs3BWtq3X2vM
         QBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P4FMXU+dr2OS/jhn7+79OVEFnzX+vIBjUnpiLGCuw2w=;
        b=ByeAOH4SjbrUGp7I2+BZJbVSHqsy/VYlnl8OdOw6nLaWdhZEK9w6IuH4XJIYvcRykl
         b5Dr0kq/oxuRSNKdt9FoCsiWCo4/dnZb/GX1SliaTDEpGkCHkKShKo2yj38l+H0LKio0
         NLkCGrYq19QHcqTm5Sz3EBc+GJp1h2A9Gg0txsAlfLZqh4i9hCxDYptTHjEdnOYZo91b
         aJmOJiq4g+HgZlwQR/0S4/TSsOeTDstwJugr3JSWAsRzDtAmk4wRhONxCewagpxp3qF+
         FExpeAc2McvU1wd5GTJdWn0NwrNdgZPQQGZc85PR1bUkMgxS2wbLvQcEOb79kDsPXtjF
         HLbw==
X-Gm-Message-State: ABuFfog3jxBSU+z/qKrwzs2OjO5ncgrj8cVkC9GldViYI3TwqckHpZoV
        HdtnXjj8IsQboJuYaeKOOeg=
X-Google-Smtp-Source: ACcGV62S3HkJvdTRDL250zivG74jUNgIPfDtULo1wA0m8CxOHtaRGIyGya9hD7dW4SzJZcmsIbX4zg==
X-Received: by 2002:a1c:6355:: with SMTP id x82-v6mr4960967wmb.145.1539340799194;
        Fri, 12 Oct 2018 03:39:59 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id s7-v6sm8552340wmd.0.2018.10.12.03.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:39:58 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:39:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 12/24] pwm: jz4740: Use regmap and clocks from TCU
 driver
Message-ID: <20181012103957.GF9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-13-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:23PM +0200, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
>=20
> It also provides us with clocks, that can be (un)gated, reparented or
> reclocked from devicetree, instead of having these settings hardcoded in
> this driver.
>=20
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: Drop requirement of probing from devicetree
>    =20
>      v7: No change
>=20
>  drivers/pwm/Kconfig      |   2 +
>  drivers/pwm/pwm-jz4740.c | 124 +++++++++++++++++++++++++++++++----------=
------
>  2 files changed, 83 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a4d262db9945..58359bf22b96 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -202,6 +202,8 @@ config PWM_IMX
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	depends on COMMON_CLK
> +	select INGENIC_TIMER
>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
>  	  machines.
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index a7b134af5e04..1bda8d8e9865 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -14,21 +14,21 @@
>   */
> =20
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>

Why do you need this?

Thierry

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAef0ACgkQ3SOs138+
s6Etkw/8CDqjDhw3dT5o3iLxU8WHHcL1syZVxtoMp8myKzUL83S+RIRFfWhrXYrg
0GoMLZCuuq5YQAFmH2IyOrcyQNP8za88WJmW6ahO5rUj2dToorEqD2kijC8Z1YY4
gJBm2OpTKROOUoZdP3fUkcLsJradOzua+wrzHeKkIOwleWWIRC4yXnfkPSlvYdAH
0ul5Nhteg6ulN25WE8uPEFGqWPgMAA0+tU64/COQ4V9Yg7P5YJbERNax72Dm7v0N
eIppDnmtbVtt+SvJ+QAM8NgZogMhJnkdf8T7Ax8UPGMG6JSxmVsSz0hCMB5IVenF
Lfp5u68cXO6hxyhku3ss4nthU8QMprEsM55chBEHvXyH7+4IsB6U+WEfc5tGxxN+
AJcQgan0mRO179DjdCYtxcELpJVRLglzhpjTIJisip+Kp0WtxJPd7wYtovMVlEHl
VyqEXCearUquqFdJ3R20ZN5sUanv5miTaK9QpNYdQrkCv9t3/KK5KdutUZDpyDD7
3kubTcLr4W3cSqwrq2GJF6KV+9b6VdLUeZgmPHvAj/81pfHFb3j7Q9gmjJLgGgBr
tVNXoCLSOaWWya9qrLPeKoZmm90zG3NpEoyExycPdai8qDGLIuhOspNZ7SG/ixFw
eKm2sG95UCmCkGVSaIUVTZRgslDEv63kjKKG6qoza9kEMRjmqCg=
=TBBW
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
