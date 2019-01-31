Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D0FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515F1218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAogQ5Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfAaLbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:31:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:31:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so2890451wrp.3;
        Thu, 31 Jan 2019 03:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/TInfMJ1c+Vkl4pc6Eub1nfEIvn/kZHoKGvZ+84+Aw=;
        b=fAogQ5XgdRhDjLpxdVJZmPz25FOufHN3ag6F3WOkSq4Y9vLmXT/vyj2XSr1RaM4Dyd
         S/o40vShBtrV+TWZk6ZlX5aSIiR1U6GgVpgctuar/YCMWxR3LHoSmQfJw0HbB5xTsDSP
         m5aWpuWp6/krRcdJCOyL/A5jhq/e0NyAFXcCyEihgxC3GiL81BMTGbXx6RZETmvnq0TF
         T57ikuHMxZzzbqk+KOJRWqZ9LmwTIOVyN7xOXDYbG7GXduzvBWhjv8ABlB5f0uXeb3j4
         87dy607XLIYGhlyk/xOz9La6uGWYme6JgwF8yYrgrnLRcB8RMBuyepnKJWIISwFwA0lX
         bVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/TInfMJ1c+Vkl4pc6Eub1nfEIvn/kZHoKGvZ+84+Aw=;
        b=jeLpeR/GkqW6kTr37MOGnpKL3O5EEgfzQ1onjq5XwS2jVKQZj2t8C3nD1Pm6/KIZHn
         nGZi9De4cZ/PK2zSyNJ7MwEN03zaaUDGga+59USf1NlXlGSBnzE7oH5SxRvn/ATdO3aV
         vi0N77At9gVNE8ENuissULOkShrKtWqV+8ocft6IomMV1ht2VqSOr3VtOvJaJfUydh09
         hXSJq6SBkf4lwwEWqwDX7bX8ijTeqTbqpch6oe26OsI/9giVn+v94HYEqyxs7eaArDBC
         i3vhL+jR3axYn1OyVaDLsK7yESCWEH3hJN+LD2dQR0tUiXHFfv7a+00GS1nADiOemCwz
         eKnA==
X-Gm-Message-State: AJcUukfARZj/3gyfwlE/lwhr2btkyHWVqTPUrdphGRzuDvvvvXphiO3K
        +uqTZS5ofXNq8ilFJun4sPpdn8MOt3Y=
X-Google-Smtp-Source: ALg8bN6F1UEk6gWgH8Ag1BE+7S9L0a1Yw2LMHPx/INRZch6XuKV0jn0gGcHhKxCOzXHjc2euZ+k8yA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr33286134wrs.281.1548934300320;
        Thu, 31 Jan 2019 03:31:40 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 198sm8800077wmt.36.2019.01.31.03.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 03:31:39 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:31:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V7 2/5] i2c: tegra: Add Bus Clear Master Support
Message-ID: <20190131113138.GE23438@ulmo>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <1548864096-20974-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 08:01:33AM -0800, Sowjanya Komatineni wrote:
> Bus clear feature of tegra i2c controller helps to recover from
> bus hang when i2c master loses the bus arbitration due to the
> slave device holding SDA LOW continuously for some unknown reasons.
>=20
> Per I2C specification, the device that held the bus LOW should
> release it within 9 clock pulses.
>=20
> During bus clear operation, Tegra I2C controller sends 9 clock
> pulses and terminates the transaction with STOP condition.
> Upon successful bus clear operation, bus goes to idle state and
> driver retries the transaction.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V5/V6/V7]: Same as V4
>  [V4]: Added I2C Bus Clear support patch to this version of series.
>=20
>  drivers/i2c/busses/i2c-tegra.c | 71 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 71 insertions(+)

Almost perfect, just a minor nit:

Please be more consistent with the spelling. You've got all of "Tegra",
"tegra", "I2C" and "i2c" in the commit message. "Tegra" and "I2C" are
the correct ones.

And to clarify, it's fine to keep the lower-case spellings in the
subject because that serves as a sort of tag. In prose, always use the
correct spelling.

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS3JoACgkQ3SOs138+
s6EB6g/+IjKYSnpCAhoigIKxi1yW7e07mlWu62zZXBLdQkEsxQoMFGkr5+0d9FgF
wGR0Uox9v+bPHt3A/A7svqD1o+5b7TFM8jCVAlNepMU81pk12qhU5D6BveZjdTTw
7MT4PIF46AkI0lLbs5wZ8nnkw0Nx1QKoWpUPqnot2AgJGEwQjPHBmRRs+UtgSRam
EugV4SmDXbzkMEBuCI28H0r1JegmVl8HZ/3gKqHPN1EvBUov3F/u5xB3rN8U55Jr
8ZDCbUWMU2nzZzRW/KPmEhQXNH/g6eN2L774gPhddd1RlqZheXxVgk3G+u3OWpVA
XKCeRDH+Sr5vzIN/5nvqKaUiFjdg1gvbF40gmoeWC6HoJ2wxv3ru42xntMC9oph0
eMvSHkk7dfr6U5UntMulBOn5U05ap/b482Ht/NXkqo8rgBznAg9z4Asq+3aaENoK
1nop/WrDuWLmBvmyoJq9E6MCyFXo2mCERUqacYR3rGW6Scjf+UakRzS+YC5ypObP
6yr/aJOjbKc7/21h+lOAiSJXfTh+tpv3iYg6tIndXZaSLarXF1Jk1P2MICC35WCw
NZBvMQCp6d9EtfBCP7g8yJ9zfHVAfBLQpwFDVQ3YRaHIEP5ZOTkuXxWYClOcv/iK
DFEEq6Nl77z3/gMnej+RgNqxdhyjY32cW/aM/bcuuyHiti6qfDI=
=x02l
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
