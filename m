Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laTR+n85"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74CFF601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeFFINV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:13:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34386 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbeFFINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:13:18 -0400
X-Google-Smtp-Source: ADUXVKJ7P7TbWnO+xXeNmrkswXcTmSr0eO83MZo+UfDQOg/uCP3/4sV0p7PO0l6ig1PGZDMC1PaJOQ==
Date: Wed, 6 Jun 2018 10:13:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Message-ID: <20180606081314.GC11810@ulmo>
References: <20180525160523.29124-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20180525160523.29124-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 06:04:54PM +0200, Arnd Bergmann wrote:
> When compile-testing the pwm driver without also enabling the
> stm32_timers MFD, we run into a link error:
>=20
> drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
> pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst=
_read'
>=20
> We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
> can be built with CONFIG_COMPILE_TEST on all architectures, so we do
> get the coverage through allmodconfig and randconfig builds even
> when we make it a hard dependency.
>=20
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think Lee already picked up a patch by Fabrice that fixes this by
adding a dummy implementation, see:

	http://patchwork.ozlabs.org/patch/916435/

I prefer your solution, though, because the dummy is pretty redundant if
we can just make this a hard-dependency and still get the same coverage.

Thierry

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXl5oACgkQ3SOs138+
s6EhkQ/+Nb9QA68rmBNxxuyFBujn6V180hqcmJV/+5diFzHDzABHk+WvAV8sZN+e
ngGg/65oOx+TRLLFHwbvKl0rzIh1k2BMGnpjZXcQvMFXzacf9Asgi6+7vecvedk0
6fU6PX+Gro9AUq5MPxshKdh/84Nze7RZuI6knW5TbUIcAe8k0UJvgHduJkSLWWKE
HDoCANXoLasVnH2zlgAdd545G7prAdfibCViAHBjB5MhBskHT9Qm6qzjrr/QnwBl
z7HyWhDlsE6o667LbhM2ygdjPMPfWZ3gz1IxJLJzUEPw4TMTps3YFg9LHFSAo35S
0IAo8gbTj29lipzIAhZcqRqeJmzMg5ORth37VmHUqqVmbqxKlM+kY1AAa4jH5N7x
xTbs6MPoFyNewGGlGpO64J7+lGAEfCDkPu7QXXejZdl+f3bmkCptFpNgm6xlECnD
s+0ac85ozmAdeSL9KcfSAoh651EY0sBzL6DswMwThBLDe26+eJyFECEaKO0L0Wvg
Dy+/SINKyVnzzHaVRjAudPOJUx7K4r49B7RMEUCguoXL0T4LCfobGxt3VZSP+RmL
dyaggBY7DBmK/CKHsv0+CsQP8BP1BHHhie2JE4AkhKxn341Vshd7vVNYzf7FFHq3
aefP/py+5DgMw9eIs0OboqOwSuFn82kdP9Dh+hWmix5CMk3cBfU=
=hpfr
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
