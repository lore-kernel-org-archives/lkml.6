Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996820839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC0lEKaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8996820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeLLKyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:54:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44665 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:54:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so15129206edd.11;
        Wed, 12 Dec 2018 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SZxjmMvV+YrJVYFxUOmIGIyp0Wf/76jlUo1vqNhl3ns=;
        b=eC0lEKaFp52yTK7pG73qH3F3f/V9TFC6bP8cUGnlzelsO+vxk9xwIGThm1tT9uskGR
         0J1zjgDFQcw3ok4KS7Atzt3t4Up1gJKE3J6zSZS80cprhOSkxrKxxTIq4DtwIT/eFnqx
         igCglKQP5GNWyjmUQe/yhNzAiKzjtCWKAc85pHfBDPCSclK2XH2J84TIn4+acKM9kN0J
         /fB5WdeTDqU22KqxEflnIcxh9vTtrD13Thq42ZftAdWy/HEStKkT2Jdoek16eaRuZC0u
         GpE3H1yKsZXyKGxSKXMTh/v/RNnjJ0aRj0D6xSv76pOUL26k0qy2xsTtRc0I/YWN0NUr
         KNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SZxjmMvV+YrJVYFxUOmIGIyp0Wf/76jlUo1vqNhl3ns=;
        b=aXn+AiCzw0BVGpI4yiUE9jBxuQNMRdwzS/g5srl6fe2bwWaeF0e3pW5NDGloTOp+YL
         DaDKXzIEoBMOHqIfysuDKpuV2NzjXKjRwPNn4ghzLiUJLChprmiFytDKSnRKMXyISMTJ
         MZu4vpeAmHYJuaRBfEryK1xJoAc4jf38jw0CjCXsvECef23rPhCSdwoKyiCZBZdCWSFk
         wn5baL50AWsS4r05KlFNr37+l0iBynDr9gr00LBVutmBGROigdZKw9GLBT6hcm01PI41
         TCMnf+WfoLXy+msV4WENOUhX1PIqN/PeckLZDB3K+73Eq0O5vzoyD++cM1mo9nEyYTI3
         sosA==
X-Gm-Message-State: AA+aEWZ2pYC5xOmJKhkc6HvAj8aWOlsYP3Bb+Y+dTn6Ymu+fFDtDB6ow
        J/Gqblual15vE9FxGjZtiS5mWq6L
X-Google-Smtp-Source: AFSGD/VxzZkWQVdIQX8lO3YNBmGRZkkXLB4jm1nWG7I9wr6HoHEgRR8fKZw0KPpvRVfOaY8WLH7PEQ==
X-Received: by 2002:a50:d759:: with SMTP id i25mr18772810edj.75.1544612074259;
        Wed, 12 Dec 2018 02:54:34 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r51sm5158944eda.64.2018.12.12.02.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:54:33 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:54:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: imx: Implement get_state() function for
 hardware readout
Message-ID: <20181212105432.GD17654@ulmo>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:19:48PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Implement the get_state() function and set the initial state to reflect
> real state of the hardware. This allows to keep the PWM running if it was
> enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
> set as output in bootloader keep the same setting in Linux unless it is
> reconfigured.
>=20
> If we find the PWM block enabled we need to prepare and enable its source
> clock otherwise the clock will be disabled late in the boot as unused.
> That will leave the PWM in enabled state but with disabled clock. That has
> a side effect that the PWM output is left at its current level at which
> the clock was disabled. It is totally non-deterministic and it may be LOW
> or HIGH.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)

Applied, thanks.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ6OgACgkQ3SOs138+
s6F0JA/+PsKKR4r3IMdSC/zZZHeWTuvGeFHiqatigpM44BbNdvtXxy75Sjb8HYCO
NRHA2+YRUBABYWu7A5lXY7V1TxKizW07UOJu7kduFn09hdjtIUjKPqSHWTX6IZAV
rXW1u8VDfH2DfPHWmpIShK9zw92WVVczYfUkcZMgF6U0LrNbwGmTzuQ4125db3l8
pjgEuQmALtBMEaZS6GzBU6cgTqcdVrTAxYEjTX3YQRKEJqDlpq0YP+wJ2w3yjRGK
aQdGYb0vpyrxHyszflHbPLWFdFj/XcvhSxl1YOUyzkYrtqSx6HOXqamB7fQFzIW5
XFGWcq2xfx3dVVfcBUy6xaqJjP8D8iXvaAY2ko+wAvnUhboR9jKt8JW8fqyOZIx7
TEYqDFgox8yeQl29AnFisYCMVJvXc13TXe6Q128UPOTGf/V9Eoy/MUwzQMIIcSYR
Dbp/mQyQR4qLLdV87IpI9lbdhWAxfuJvk1E6eu+WB8eYkrYlkgKbkg4Uxo1agOZC
LCl9cQLmVhbxkvJqiLvvwS3s1BSTLQEihMuVEyb18PLnhkQtx2BVnHPC7ooVpFF4
3QD5sz+YtcIH1Cu3BEw9Us8YiVnGjOnBpeq80Sebs0xnVrNkkd2K9hvmVnej7t+5
0UQ73gZSAFXxJOg6bO9JpiIiYQ1y9mWXXA5O4JXkAZMrgEWG90s=
=LARO
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
