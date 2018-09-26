Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE30C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E20214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIhPVhkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E20214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeIZVVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:21:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35615 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIZVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:21:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so2768189wmc.0;
        Wed, 26 Sep 2018 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quwuIEjTEe9k7mWzQHLTN5X2kI1nceXlFAmHyVctN4o=;
        b=mIhPVhkCUqR0yRtrAytDqPRmwh1sezZypgAA4fsgdCEhGOwCWtc8/sL8p537N5E68o
         5yyx2b+IZOw6BQrqRJ9OMyKULQa67lTk3MqtxVYA36GcPq/o+Q7lm8P9UL4rMil0jwUD
         lJAInfb/VJk5RYGBVlhHxDZJlW+apaA6CCd/Onu1gHbbMkL/m26xJUBuZ049LENZtz8c
         moXWb8UMmBpYFfwpmNCh+l6p8bsQSLM+3Lp7Z+i3ikpXogKGFMnUcC6HdPXaqieWi065
         uTE2J9vzfvdKqC4BU5dca9oc8lBGTW9us5ADBsEywEqchbAoNPNwk74suStKxFAnGWuS
         klQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quwuIEjTEe9k7mWzQHLTN5X2kI1nceXlFAmHyVctN4o=;
        b=o0KmCBml4gLM7Ujvwxo20abaE3DCdb5VKdxrhar7SLmNUG00gKegN1ytyvLljd94a1
         M9icCipbELb8dW5mmvW9bLpBiptsFuZ4dGJB1nyGUhB9L7O8D7x578bM9PbluBF5dVUH
         fESplOkFC3S0aiaPQJy5sfVgeGBFzI1X8mSED8rqyZvx9xespK5Zj0pJZXytlU9zY7KQ
         wvFH29Z5IafyBfF5uC5o9UAiVgQ85N3pR+B4iIb6bfQBkMd7vckhoCAOl/YzEuRLMMpK
         LrZBKuE8Brg5b00+YLvGhYYW6vm6rZpzBWurEy/PWr+HxsMoBS2DrU4A4Jk2lkhsYxsq
         vTAw==
X-Gm-Message-State: ABuFfojifd2eKe4AUVorIC90dDhXVY1gU4SZvz9HaMI27SbNfnUA9NUw
        yNE3eIrFMpC1R8QWw0izBSTlSDPd
X-Google-Smtp-Source: ACcGV62mCLlTpWfx0w7WRxm1YG/6LamuFH/xJQ9bpcwHbKTbZtwmRElliTCQ5PnvJHJwhY46wFixIw==
X-Received: by 2002:a1c:c145:: with SMTP id r66-v6mr4705909wmf.131.1537974510302;
        Wed, 26 Sep 2018 08:08:30 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id v6-v6sm3869191wmc.43.2018.09.26.08.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:08:29 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:08:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v2] ARM: tegra: tegra20: Fix mixed tabs-spaces indentation
Message-ID: <20180926150828.GI12980@ulmo>
References: <20180830172153.20653-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <20180830172153.20653-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 07:21:53PM +0200, Krzysztof Kozlowski wrote:
> Fix indentation and alignment when spaces were used instead of tabs.
> This fixes checkpatch errors like:
>=20
>     ERROR: code indent should use tabs where possible
>     #306: FILE: arch/arm/boot/dts/tegra20-paz00.dts:306:
>     +^I^I         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;$
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
> Changes since v1:
> 1. Add Marcel's ack.
> ---
>  arch/arm/boot/dts/tegra20-colibri.dtsi | 2 +-
>  arch/arm/boot/dts/tegra20-paz00.dts    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluroOwACgkQ3SOs138+
s6H7ZRAAs/BNgDpG8YDi1HtViiLhc7rFDXqg0c8zCwStL+3kmp1jLlcaL6w+6ce0
g/+CnvXt+VeNBxgoMGMip4GIDH7usOqKkpzbdl8H2xPzDKIQTX2cwbu+LhP0N6zK
I1D9rdDANwWVwdoGbT0Be7mlSqQQ+wNggCOH0Yq1zr0CrJAu98R97uMHAE2gbtGd
20OkTLhgNHXWjfBoPrO/PYOqu+AiAcDDsqf5LSnPPET+4/pvSWSdXbjvKSvePdh7
jBxDma9trLzUG0Mm9d4AFe9bv0ycYrYMKekyqViHj3uEpoFcFCnH4CR/e0jfBPBR
r5Voo5lZI7knwwLhpRCWGojJAqC8+iqwNutzNYBZaboM+oI75v7iGZYuMls1v2FG
5DpNGnW8kg4qGx8Ri4d5jM75kguZWnYa/Bkl/Y9s8zobxQuUhGfi1pWMYS+P+JDp
19F0QhOZPQEqxP9IhSP7G+Tp4B6cBs4zOzHpN/5o4ebmGwI8GeiSskib/Wd6BaA3
iNQ62JcmIFU+Rz2kltWc8fP54N8J1cp1wkqgPDo6bJQBLQLgW9Hb3AGLsQQvsaGW
ISBgIsMgJFJ7hp9vdl9R4SuqnXYYbsiitnj2TwUH2Ia8hJuH+YBme/49koaU/Msh
Bx5RXTX66Hzd1ZlEfTrEAHWgHgT1W4ysuAS49b61HHJRtKG3SzU=
=gOMv
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
