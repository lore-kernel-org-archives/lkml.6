Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06FA20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMHOHXxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeLTR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:28:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45446 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeLTR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:28:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so2392160edb.12;
        Thu, 20 Dec 2018 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V94iLiMyPP8tk7f4N1vvciBO9eqw97ZdzT7GjIusVXM=;
        b=vMHOHXxCGDBcPy2X1BXUfjyAHQ1+GApjs9RiGJcVt2kzkZ9e1r7jFDS9AaSREtX7T6
         /IaxGX1wvF57kiMI1oAak1GhgMM6RQyUNSLRY53S5QKTjLh730VhUZnpYdMeUPgqtDrI
         RgHyWH0M/t5qBK2+I8dJ6n8dGV0Sv4wG0OvX1w/8+KN4lMiKA8K02Ykk3lExaZcgqujm
         fWzyXQZVNHxF7jI5+pN1mLZTnHMOB/bfqd2vsCqhI9oqv5kAanHDzwFLVHYc1OrWa6xW
         9j2QTUkOlPLdNlo4gORYdc1GPy/jaRtvVS7Lsm1q2cTd3++M/Or4mPoAvU1TO50pNppj
         eTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V94iLiMyPP8tk7f4N1vvciBO9eqw97ZdzT7GjIusVXM=;
        b=kvtfukJKQypv8wHsM1rG8AFYijNbYWNafkaQNrVKzb/vMe38yDyBoIzpLZDWxk+8yF
         mtC2VRz2GynfEEOIJIKNjchvaD/9NqWayI0RM9u+slz8Kxm+JZVYSisSjcuIqLPSUCQS
         moAexyfUpdE0jTG1bfOszjjsCR4tK4y4ye09WGDu0GtTF9O+Uy5nyTRaY6K+Un4oQzBz
         j6aZakFy8cLbwLIn92925IPJtDOJipN2ayMA+M0/4FhLFQe5yb2nCHt4X2xLI3JKJU/x
         tNCw0pUz95QBFly3mD2CyxsghoBKbTwLqMqdtDbJWYl839M+FE3RHne43g5Dl2Oo2lwf
         BlIg==
X-Gm-Message-State: AA+aEWZVYrSZ7YbjKqpx6yopuEmn1+IhJiADOTmNQ4uBIg4w6tm+UUGR
        o+veghxFDQSS/sfScpaoxw0=
X-Google-Smtp-Source: AFSGD/VnLTa1ToF4anSREdI5eZDgs076doPqnafu7a6EhBpnfau4qvIb91YFaZEUxhNbuUhX9y93EA==
X-Received: by 2002:a17:906:1915:: with SMTP id a21-v6mr20510953eje.101.1545326906039;
        Thu, 20 Dec 2018 09:28:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f20sm6162715edf.19.2018.12.20.09.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:28:25 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:28:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] pwm: imx: add ipg clock operation
Message-ID: <20181220172824.GC9408@ulmo>
References: <1545196822-31361-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <1545196822-31361-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 05:24:58AM +0000, Anson Huang wrote:
> i.MX PWM module's ipg_clk_s is for PWM register access, on
> most of i.MX SoCs, this ipg_clk_s is from system ipg clock
> or perclk which is always enabled, but on i.MX7D, the ipg_clk_s
> is from PWM1_CLK_ROOT which is controlled by CCGR132, that means
> the CCGR132 MUST be enabled first before accessing PWM registers
> on i.MX7D. This patch adds ipg clock operation to make sure
> register access successfully on i.MX7D and it fixes Linux kernel
> boot up hang during PWM driver probe.
>=20
> Fixes: 4a23e6ee9f69 ("ARM: dts: imx7d-sdb: Restore pwm backlight support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 48 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb0TgACgkQ3SOs138+
s6H/Hg//S4FCYBXLRTVQxiESbgu5bCtnp85AyRfd5uuzFnMEi+svvTmXxZ107yGU
EDa5ldrdBFFq7a1Gq9iTIKL1Z4goaUVteV07Vz0YrOCfla6tntMZgMQCBCibkjPa
Cw8gWq9y+4RLQEwMBqSZj9IDIqTb3zEI3rAknZsCBhOZWGz+ipkk30b8+ECc/o0P
NfBTw4Ir8e9r3jNI6K0MXVYNt/x0/nNTAM6TMeV3MBRI3U0N8fPKkl6TTcIAmTip
SB0IKsbunpMsjy8eN1Ck8/ZOyDF4h0FXS6O0vhaPkP4tErF3bZW3wwTclX7koTWP
G7XDi+QotaArO7gVOe9ehrfUgD9dRTMLoHSnauBP7idxq4JKARZ2JoC6QKOlr6uO
jjJohnQNUoIJtPNLg33LxWQrtyAMWXd4LDE2oKaWy+rZA6jt7nN0DdV4zBGXy6Vd
j1hdAQG139lEcBYUmO+0svAWL38zhNZ+s/fhfpHITJrUsJqVdnNb5bn0m8tu3chF
8EReQxi7vQoQQEX5bqiHjXJIt6i+D/ubfW26CpHjv3UIQM8iexXyoMh/KrnGNmVe
z+5Vw08BwlPEKLTs8Zv8q5ETmV/zgIdz6n4RlTfRtaMq7bcIBekpG2jHp8zrRecc
v0YMfBVvnBjspWnwSVIyosiRzRMGaVthK+3NNLEpATfvgfmULYU=
=m8aT
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
