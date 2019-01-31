Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BCB2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Nj2DEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbfAaMuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:50:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39751 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbfAaMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:50:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so3147611wra.6;
        Thu, 31 Jan 2019 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqvRd+1MXgh0u7EWUBxrzOJ2hnDqyZ/opb03skn96SM=;
        b=k1Nj2DEUxNZV28esEq5ZbqNniSDsRXyn8gqBkMs0XGtR1FXhbbPQIZ82qSMpu/ZyW9
         3Tzv3ULkDlQADss9trh27NPdEqUn37Z9jtFIXGdbp2QYrKbdT7fMsL9CgWFXOmEiXg6Q
         zzLZC0gPBQeXCCT6jgIJUIYPo5iSnLaYeNjO3ygwk2aIsPdxEHIobA64j8ygwrcBEz3j
         NLqKhPgGy+cS4s9ztVytRF/PYVjZtyqt+fJKyIpJFjGmmOANLN0h/O7JaF1mEluaEZq0
         FmdWlqwgnpUMZyRMWeMz5202610yWCr2CpyJ3Ds/zM2dCCETr7L05vdNZN/tSnR+Mvvi
         9wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqvRd+1MXgh0u7EWUBxrzOJ2hnDqyZ/opb03skn96SM=;
        b=aM2nObmeU9XTwyxKZrGObEzeTzJRXcwP4l6SKt+29tBB9pFetEF8hCVzrr2qNWgtx9
         M0jV85JVSLOgwWMMWc7lZADotxGvIR8fKikQm5wq7VIWeXtLfpuepAOrX1NB3+QvPZFu
         0TTJo1p3IGfCjTMlpUu2RYBfiOQMdu8se89yqr60B5Uv4wW8DLxT2JNzcY9U0pMLeHzP
         R3C5Sc8A5yVc0PdpyYJ1IPrxQ/2kd3CTrgktXFVuNcIUbGi6CtfALMYirrnd0m1nGqrK
         SqieFTjDRcErHmyDHsvit1mnY+GcbmNd/yhTEFoEd3xm86mCh7fefVmwmlm3IV+WfDBv
         JmAA==
X-Gm-Message-State: AJcUukd215FCcDkww73w+nNVoPHIbOx1qt8D9kJcVxdbXAtyYj0vFZqe
        mtM/qmZaNQv3n+G1eNSRf81oIKRSAW0=
X-Google-Smtp-Source: ALg8bN7wXI0dc5ygrUVsL18dRczq11QsA8lTBeGExH9v0aORpb/xz3YtRrzC0JOjJqp3jsJ/BKSwTQ==
X-Received: by 2002:adf:f605:: with SMTP id t5mr32090340wrp.229.1548939016655;
        Thu, 31 Jan 2019 04:50:16 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b7sm2975144wrs.47.2019.01.31.04.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:50:16 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:50:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V8 5/5] i2c: tegra: Add I2C interface timing support
Message-ID: <20190131125015.GK23438@ulmo>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Content-Disposition: inline
In-Reply-To: <1548915387-28826-5-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:16:27PM -0800, Sowjanya Komatineni wrote:
> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the i2c spec
> setup and hold times based on the tuning performed on Tegra210,
> Tegra186 and Tegra194 platforms.
>=20
> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
> and Tegra I2C controller design uses them as a part of internal
> clock divisor.
>=20
> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
> for start and stop conditions.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V8] : Updated to handle timing implementation within tegra_i2c_init dir=
ectly
>  [V7] : Minor updates to timing implementation
>  [V5/V6] : Added this Interface timing patch in V5 of the patch series.
>=20
>  drivers/i2c/busses/i2c-tegra.c | 187 ++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 158 insertions(+), 29 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS7wcACgkQ3SOs138+
s6EuAg//R7O3xNYPKqmFBL6WnIleMs2ii8nXNh4msfa3KTIS2p86SUSE36a2zpL2
2UoflWAc39ZMNpomvrI0NwZrUBoUWFYczEiWHtda6N3CLHzzqvLCOWUJ9Moo43Vq
LiCsMJUYLonikftcCrr9ADY+9cxdAmSs4+DV4ADtZFEVAeUU+E0cd5Y8aFOUONwc
yVEflqm11tID7jgwZMgszxMCAgAM5FPStc+/TdZxvUpCd2wCqzsOYYSC8HiHEbX6
/oxJ+BUTF5qeQaRIgfw0LAL3dleeIkqNIDWBk6/Pi6giNhCaDKxPfUJG/9OC34/j
Fxwb0qnHSIMKDKH8i0GMPU2G00Wmcva+TgpuGfuyLoA4xEKb3ffPtRgtDQsc/xz+
kVrNrG1i/6BJKV2TJ8Pv/lmijCjSGPbK0AuPRa5J2remVRwyzkOG2jDD9LW+GZjp
T5IHTl2zFXGjz+PVQK7BjA6dEbZiZpai7+MI1W0um/SHMfjqWilMkciV2P2uD3xY
LQdvvZutNMnXwuYjFfM7Get4ozjzuBU/ds+FgK28Lhg4nPrtpnsQq+hKe87ACTm1
ogq/Dtg+uWgZLbDQHp4IpqbnKfjabj07fqOSKdUIXhRoR7sF2YPT7B3PmwECeS9P
u/pEWi3YNIrqgqgArG5P8wCzhru7dTsI1Bw5H1FPacLp5I/91CM=
=fS/Z
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--
