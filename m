Return-Path: <thierry.reding@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525081921; cv=none;
        d=google.com; s=arc-20160816;
        b=Yl5L6zj662Lc9qXIhHXK1CUE4hiu+M544OQNwNee1EBRorAAyKbbTosXLKgjGtOb2u
         B3rhYUn/UAVwcLJrdTdsppaDFono/NsDslbA/xG1lG7t2j2J3r8TslOy/zfxK6747oMP
         Ve6qM5XtB/7WeBKej2RE3ncPMekuC4FJloi6xxV8VVh3s2cCr7fWmKULEoa/zecRr44D
         GBgUOyRPQNAI0/zWqI+bOZDyJcGMf1We9NWtVzX6Y3kjCdFSjhQF/8xGoScm7QViZimd
         3EdtfYyKL8a5eSmUGt9/49T7HwyblAHF1yoaWWgugqAnqYYgec6sE5l13kFTm87FLXDp
         3XLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=wT74rgCsD1mNwP5LYNX6hwgUMiGnfTDE1Mk9TZ12klM=;
        b=NMoq/eS0zdPQhUbioiD0nLfsZjgbF5UrNMKPhJwwCugsCxE3oHxcgGanZtqsgLCVCT
         57V6YGorKr6JGXLGo2R0zl8422XxYs/5Ii8HpmtQ481ecJL8IDqulGI662K9X3aciWuZ
         zqONmNCJBMThC4c2d+8NlZfWUDc+kGHiERoB7NhbCeXVLyNZCLvXX/SjTujmUetsZfpY
         Uao31c61Ni+Ry2UVY7TBpLvzfVklLZ+ATFluy2S2TbqmBst+f8k1DDzXAGTj1+fX213B
         EucwB2XnduLIH1VsIkvGWeGsOxhQbtTCVjx9PSsp35Ys1ronPwin+AomdPK6MeJfjzVT
         D3Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GsLv83/W;
       spf=pass (google.com: domain of thierry.reding@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.reding@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GsLv83/W;
       spf=pass (google.com: domain of thierry.reding@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.reding@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqjkRatoThS6f8A7TvuGDJlcDG9CSgN+lURYRBO4Kg+67ZVdy+zeVvXa5loHgKNyXq5rTDaMw==
Date: Mon, 30 Apr 2018 11:51:59 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rajkumar Rampelli <rrajk@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
	jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com,
	arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org,
	xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de,
	krzk@kernel.org, ard.biesheuvel@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
Subject: Re: [PATCH V2 1/9] pwm: core: Add support for PWM HW driver with pwm
 capture only
Message-ID: <20180430095159.GD2476@ulmo>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520845385709681?=
X-GMAIL-MSGID: =?utf-8?q?1599164301290484067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 10:10:36AM +0530, Rajkumar Rampelli wrote:
> Add support for pwm HW driver which has only capture functionality.
> This helps to implement the PWM based Tachometer driver which reads
> the PWM output signals from electronic fans.
>=20
> PWM Tachometer captures the period and duty cycle of the PWM signal
>=20
> Add conditional checks for callabacks enable(), disable(), config()
> to check if they are supported by the client driver or not. Skip these
> callbacks if they are not supported.
>=20
> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> ---
>=20
> V2: Added if conditional checks for pwm callbacks since drivers may
>     implements only pwm capture functionality.
>=20
>  drivers/pwm/core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..f70fe68 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -246,6 +246,10 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
>  	if (ops->apply)
>  		return true;
> =20
> +	/* driver supports capture operation */
> +	if (ops->capture)
> +		return true;
> +
>  	return false;
>  }
> =20
> @@ -495,7 +499,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pw=
m_state *state)
>  			 * ->apply().
>  			 */
>  			if (pwm->state.enabled) {
> -				pwm->chip->ops->disable(pwm->chip, pwm);
> +				if (pwm->chip->ops->disable)
> +					pwm->chip->ops->disable(pwm->chip, pwm);

This is not a good idea. It means that you'll be able to successfully
configure a capture-only PWM channel for output. I think all of the
output configuration functions should return an error (-ENOSYS?) for
capture-only devices, much like we return -ENOSYS for pwm_capture() if
the driver doesn't implement capture support.

Thierry

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm5z8ACgkQ3SOs138+
s6GW/A/+MImm7BmQSd+UOQUP4N0vddntkXN9FGKsxb1wIZPQBPMKfmH5xpBzfb61
hz1s8KLWOpgqEZQVs7eVp2ICQEOXNgwKdCWbHPsHIU+FUf5zd1ESd7rNu9IrddhR
ZM2lU8YGaREnIFPt2dFpjLVuXA8ak7id02RdeoylpLRaTlgcdE3q1AEY5ewnTNRn
JLI4eEroYAfwtJVC5PSvdZvD5Diq2H+ASe+McYSAbTg8+rHQ3w4KMmTIKoEiv4Us
UCwF89+zCm3K+AVcvdCe2jBSc2OtZm6QXY9BrhIBnGf4D9fGWBTQ0cmZpHtcxHhf
YOqyb+tM1rFgZutFgcrJ2fmFRZp2wrJjGByilhwEWfrdM57zrCQSLPWdnELOIETM
4aGyI1cmKc2DIdXI4Ksv7PRN3LBvvxq8H0Revozmi1MfNWrcB2Qr7sgvBNYTHTfi
T5TWD8oWJ6rs9E+JUJd7SU2fimoDft7i7bbA26mKFN65Y+i7jgCi3d/lTDhVMMA0
nby4wCgKDGnTK9vXsNK93WhUB5R3d6jXAgOePb3UotYIcE2z4hUv8I0Rp24PJWh4
s4zL38OPugoEI0iPfTodURu1m7F1QK2wOdd48OzQBRiQ9nFXywm8KLVxVLZoSck6
xsY1+I848Lu/UNHULnbaCY163rDTcM9/PJwRFrnuCA2Lpr/9M/s=
=yusN
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
