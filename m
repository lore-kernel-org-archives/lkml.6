Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09F2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF202086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN48NepM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbfAaMpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:45:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35405 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbfAaMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:45:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so2451854wmt.0;
        Thu, 31 Jan 2019 04:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Tt6r24OQ8PuG6E7W8UuPqdb2Zx2hYeQYc1/wcgB0T8=;
        b=gN48NepMg+20DJB9E4m8WEP8Sw3q097eWywDPot8IxzCZezOEi2rrVuMgDiqvnhkDF
         mrpZKElCdq6PqezpDw7DvZU51OH4LO77BJ64rUrxA3hmwj1mFOloENdMuD1udVAz3mJV
         Bhc+3Ik9Y/OP3rymhSuH1jv3OO5HMbrMZ79ein+M8Oakv4LR5Shp+MjsXUeXvgY0Ko15
         vAWnpqSuNPLCp3I2oF07OUA6VBlwdSTPYfN4SRgb+2aIjH4z+ksZJkkZs1X00zzbqY8r
         Uk0Kz3keP6sw1Oiw6w71oC/itT11akjKMiluFUNcQS1uUZN8cjJGYTOG8qe7/MM8v7EJ
         c3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Tt6r24OQ8PuG6E7W8UuPqdb2Zx2hYeQYc1/wcgB0T8=;
        b=EKuEn+BIAIBP2jMwric4ZKSnE5chPbxOgtLkutuZQjqt/A0/Rd12+nlrg1jXlWMzgT
         UMzVYkEuICULgdG6WaQnxOwc/4VuIR0yrxiBHOpi5QtDVO2NNfWfObB9MHXI7wGvhwJV
         udeDlKh6irsRv1vPw/Zjew7ovEPRYQuZQO9t1LnUKFAF8lTPLs9IpcGazhRVpCg6+VP7
         dXhWeNg4Rbgx2DBQpFzVkRdyPqttsNOCkhzbIhuT1sH8n/E0x9zoHSBAwebBXKp8G4QM
         Fln7fBb56O2N5PxL5xoGuM5HzZ0RUpcjg8BuS6otNaysIB88My9MyEAALLfp8GYcLF58
         AtOw==
X-Gm-Message-State: AJcUukeQXk+usiAR8oSIs1Zp4LAkM4y3IioJ6TLsYkky6utYGmlOnLNS
        VpCg88wh0zR2dp56IPhWb2GwrpvGOVM=
X-Google-Smtp-Source: ALg8bN7RX8fin/BwotPm4XYddEoQXkOpVju3xHmtQu5KQz19xUvZWaHf7unFdLy2E0vPdqh7Jpin+w==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr28785557wmb.153.1548938698648;
        Thu, 31 Jan 2019 04:44:58 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h17sm3737955wrt.59.2019.01.31.04.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:44:58 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:44:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V8 2/5] i2c: tegra: Add Bus Clear Master Support
Message-ID: <20190131124457.GH23438@ulmo>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <1548915387-28826-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:16:24PM -0800, Sowjanya Komatineni wrote:
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
>  [V5/V6/V7/V8]: Same as V4
>  [V4]: Added I2C Bus Clear support patch to this version of series.
>=20
>  drivers/i2c/busses/i2c-tegra.c | 71 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 71 insertions(+)

See my comments on v7, with that:

Acked-by: Thierry Reding <treding@nvidia.com>

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS7ckACgkQ3SOs138+
s6GY5Q/9Hq082Qy6L09+W1CmZvGOnDiqAUC+sz/Ci7EcoUiDRfRXS86q1CLZWxGj
UT5fzk90sZDHSvx0pJLWjvnBy7laB21dYzUd4UowIf14/GmnqljluZ5AgA62Hg5z
go6JPXNB2/igk/5Px6PTOqO8LuJjYjk2uPcooahvYay+JuCRO9IBEMI0KrHKgwIA
8U2r1DjH6OKl6y9tJgg041Zt1m0sw/CL9bRVrfA/1w+WbNKOCQFpizFF9llaHa0x
KZ6DJw3EudNqdKyTs3RZ/vsmswPcPHeT2eqRgtUjKlCbwXdGs9TUXGAizNEKLp9W
wmEvI1J5kll/dW9s15ibyGPBm0MLaqw5xc3KAz2jz8WHLHpmfA3bC8tZ4uYhi9wV
SHrnAZXvjuPtVidf7tmMQ5FPvsNluJ3HbeD9WCxl1psNjBnnLn5tK1mGjCYd7L/2
H8q1jacZTsAf0CBw2k2XZDAoikNlrYCIWD2GbVRemwQJHZfJecGxygrI9AIc3729
K4ht8/wHoTTGm2cIl3GquCLMvzaAEf1I9jzFVgForE9WXHn/aB3OPCNPFHXWZ9P2
m7WYKOyvHn8nV/IndxdC+zqv3WWUsXfJgK9702qXdMoBrC5/0idmBC/BLd8x/XNF
QlIqgAE5JT/IkW2o770e4dj7KaYoCYn8BfthVX5kYbKxOxEiQ64=
=909g
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
