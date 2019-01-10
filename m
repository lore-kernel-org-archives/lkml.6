Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618F020660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdZX21WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfAJOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:47:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfAJOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:47:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so11751664wrr.0;
        Thu, 10 Jan 2019 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e2Dml50Y9NfSaOBjudpkrIV8gYb7wcVFcnpmjW88Mzs=;
        b=CdZX21WPRZdUU90FQyTyWEQNsf3q6iBA0nsP+/LmEM6LZqdwrW31ISh3xzRTD+AS1l
         s9bANVy8iKnJBCJ1dABXaKyNeKELNIPtXU+srKrcHpPBeU02HCnRU7wTJN1qaqX2fLyb
         w8YmbQQVzm7Zh8cI0+380fxo+kgRdBxGfM2Ik9BZsm+/f0OyTEapbuFw+U+WSXcQ/v6l
         jjac5lgWv5WrTS9vpfYfIp9uYcCaY9ZO9KHxTbuiIycOaJCpRoQkAP5Rs5m7MhuftEsd
         UZvRAlvsv3RyWEfvPkNKV/uHosFL3pNmEpHpPe39YPsLSty2YGWSwdepSDuK0y1CExPv
         5TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e2Dml50Y9NfSaOBjudpkrIV8gYb7wcVFcnpmjW88Mzs=;
        b=ZXPoqeOOg/cgPQBDnwRXzQof1Nm1ZSr/vBjegl3t+4fcd/psmcjcbM2cqP0ZOiU+8z
         gGiKuaHTu17WCej0zXlA12m6kaNnS2HgOgaO4YBqMfDk79ETzoOsH2cyhNL1kcJyUENt
         HwUbqMaKi0KdWvCEuYF6Yl45BcJN76T+nxUQAKAEt61mMX7Fpp4vOkGeMH7mS0Bp2457
         xe0XQWT4GvJRvC2AzcCOgSt2d8Aw2NtE5hN9NfkAfX0fN87UmgYd6aYTbSA7GXy8Me2C
         SpSCACkbHLFJhb4bcXIlHg1zZ1jKc0qOznyFFpXknJhFYi753+p+FPi9eUBcJNn71wCm
         W7iQ==
X-Gm-Message-State: AJcUukf81hviG8tXzAW1qfk7GhUq4eEi9Q3AE7h2NR/ddtUKeC2OG4Oq
        Nv04kWJhw6zsLiHf7oNfmCg=
X-Google-Smtp-Source: ALg8bN769yArrIFaqlVv6FSDKTyAUM8tsa+vgORdlHgFqlBbhLA4nHX4Ul7y7V+s5SHy9CKljowWcw==
X-Received: by 2002:adf:f052:: with SMTP id t18mr10057758wro.112.1547131655081;
        Thu, 10 Jan 2019 06:47:35 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h184sm6005528wmf.0.2019.01.10.06.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:47:32 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:47:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V7 1/2] arm64: dtsi: Fix SDMMC address range
Message-ID: <20190110144731.GA25353@ulmo>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <1546457808-18270-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 11:36:47AM -0800, Sowjanya Komatineni wrote:
> This patch fixes the SDMMC Controllers address space to be exact
> defined register address range as per the design.
>=20
> SDMMC Controller supporting Command Queue has CQHCI registers at
> offset 0xF000.
>=20
> This fix helps to identify the Tegra SDMMC Controllers supporting
> Command Queue based on the size of address space.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 +++---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

After applying these patches I'm having second thoughts about the DT
aspect of this. I know you and Timo had originally argued to advertise
the capability via an extra property in DT instead of updating the reg
property. In retrospect, I think that's the right thing to do, after
all.

The problem I'm running into is that if I apply patch 2/2 without the
first patch, then both Jetson TX2 and Jetson AGX Xavier crash on boot
because they try to access these registers (the I/O memory size is
0x10000 for all controllers). So we're effectively breaking ABI with
existing device trees.

I don't know of a way to work around that other than the separate
property. Would you mind changing the series to contain:

	1) a patch updating the device tree bindings with the new
	   optional property that would mark SDMMC4 as CQE capable
	   (make sure to Cc devicetree@vger.kernel.org on that patch)

	2) replace this patch by one which only adds the new
	   "supports-cqe" property

	3) update the second patch to make the decision based on the
	   flag rather than the I/O memory size

Sorry for the back and forth on this. I evidently hadn't thought this
through.

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3WwAACgkQ3SOs138+
s6Er5hAAjcqLKJlSzT0ipK8NA2g937YzOBD4HRe/jMLXTbDcpjYTzndQVNGCttsY
Zjw4SPTxjZRBEOZsb3DKmYWCbriqVJpi3Ym2JiG6afv/BVw0UlYmOhp9uBOlzp+Z
MSXtkkwA5QKMUT+BYwhnTR50SzA0EBD/LCrCJKRX9Gr7d7XrZjgaGVMo/yIp9isj
xYVZbg3+iKdf+U3bEQOYKWw53mg8+Zb91voWX/M+yEfRwjTPOH4Wu4B8geHQxCgo
TX6uMZrJQvJX0N3puGaxZp/SzE8qficNnJXXPRSXQjXqRm5P73BN3D/1GZxJUlcb
sIx0hte4/B9R/9N9OvpSsQAYPZzTXwG1khOcpU3lIzfozsttDCOvWoJCSXegaWFv
BaKcwYj76luUxtiP39Fboe/aYROA+c1m5wl7uMz2/Gh921LbAuVCundN5f7VzH7g
fiHcDX5DRtIF9qBHA5pXOueM6DXZS2Fh2StJBoqcVv9efFF5bogOoP/GgCJmjk7Z
fvZu/KJkqitcNUAg3HuQ+JndDSz3s79ddU5zN7E7EAcHQxXX2HICPx5fhK4RDXei
WK8WMU5kZmCN6xHBtAKYJgdZhjv3ySc1XNnJTSzcrcfZdE8KrwwNorMCALNfy3hU
bam38+6lFyHNxrnSG+7CF0ySc6nZ07P/8XCFl+ZIP+YGDiD0ILQ=
=JW8s
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
