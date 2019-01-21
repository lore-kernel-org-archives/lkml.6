Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981AC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A929520663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI93w7LU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAUKoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:44:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37186 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfAUKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:44:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so10223850wmd.2;
        Mon, 21 Jan 2019 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZ2nfzaXTQg2/YaeEm8B1mA7KuZc99ueFVrb0O9D7A4=;
        b=CI93w7LUajbajOfNeo2M8amS7S7TzsEXloz1cUjHSpnAdDr2XtMGa4cle4ejYPNHVO
         m+FlN8vg+FwTaKSUmKbSYV3dVX1HNCr4BYPT1RBtF/cApZSwph7FdOh1GXTp/FDtZYU2
         7Rej25BvlmeWZDG5YKPEBMXjObwNS7BIHTEi5xq2rPPw7dXjp57dQN9X+A+yErZRERvB
         EW6eAxsWxnP++qjfveml0Ah7RtlH/6FikERpfN0DNU8UBeC9Z7K1/r4hsC8HdMQzE6zU
         ddQdWPb5h8BuqTKBQ++OtXAmKPnrqXdlNl9ITURNLj+cg+ttxiHaEtH18xl4DnOzDoOC
         l99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZ2nfzaXTQg2/YaeEm8B1mA7KuZc99ueFVrb0O9D7A4=;
        b=meg6ip8EnWm38rwAe/pxkGUkZBBsV1uSHBaV5uQq9rkgRdBUOykNGpL0sgUmMjExkS
         ZxGQbUutZCgpqoCplwSHpJ1p6cbxLHplPJTN85MuBVE7ynS2WPzKYMj3VFpbrkwZma58
         AwoG5hvtMVeRabaBc8b0PxXd6y5LpG0IHFaTGkF6Jj6IQ5M8bSprgrsLC6uvu34W3ck+
         8YN+nn/to8vVgMgWJg/1oNPQxWIJJvBM83iJUuVUOZOVxCJ1qospkrtAUwz8JZBZEGWz
         k6s++0LurvU51qkqGpCukm2D/YOcGwP+PFqv7MhUPF2G1lJoGq9zbmZ0N/Q8DxL1Dcl3
         qg1g==
X-Gm-Message-State: AJcUukexO7jvgfBvACFVv2M4ENvdnF5PTOKEfH0ZkiL9gZroov6sPNNL
        NPe71aF4nniHNWez29DVdJA=
X-Google-Smtp-Source: ALg8bN6aL/nr/pExjVT7BOZHjPySfzEETOHCxpYkLrHOtTvm4M4On4TX5nysm3kTGe1KwafUYaLS+A==
X-Received: by 2002:a1c:d082:: with SMTP id h124mr22772765wmg.21.1548067474293;
        Mon, 21 Jan 2019 02:44:34 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r77sm64300179wmd.22.2019.01.21.02.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 02:44:33 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:44:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V9 3/3] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Message-ID: <20190121104432.GE16756@ulmo>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
 <1547579032-18314-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <1547579032-18314-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:03:52AM -0800, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++=
++++--
>  drivers/mmc/host/sdhci.c       |   9 +++-
>  drivers/mmc/host/sdhci.h       |   2 +
>  4 files changed, 124 insertions(+), 5 deletions(-)

Looks good to me. It might be worth splitting off the SDHCI core changes
into a separate patch, but that's for Adrian and Ulf to decide. From a
Tegra point of view:

Acked-by: Thierry Reding <treding@nvidia.com>

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFopAACgkQ3SOs138+
s6Hxlg/9HITuwlKXqMJqQliyTbhELbKNJkPdJdBo4IDdYP3JLJIP4MmJfWsmEem2
vAvMWal7V7J+IOq9sTrwcGXhglYiqnIoD51RPZdfO252/8jF4yxd/M+GNLKkaxAF
EDQD6Jes6D7PQO2ff20Tu9Prhjy/YTfvEo2RhtGlhn59bSgYoD3RWyFgMv6bjZWX
Zs6zoTcXisWfqb4iHvLgFWptqi++EpCv09TouNxQpb1BSjJye5EztlPbqp0aWc3a
NfAog1bce3JeEfwgzrMVrjS7UHYtaxJxuW1ttSFvOkMy9I/Uf8oUcMpVaf6lYHNe
/dGpgJkqAzXtnvskDJOxYdV6BizdTI8EdEg73E2CZEHjqUz9VjZUn6Fy8t0KUgqH
+1VpMAnqNGvkrNFfBnbnjVDasT7V8dobsOpEZBvzfK4tUubpnyRhPV4+lW6YsS+x
IlSWMH/c1UaieE7tVAIQsDWP4KcSJzgBilRkqH/vFU+IF5w+EbNM0jfx2DtMASnh
EINeheFHdNtEivfOq1ohKUQNo7gT1XOfZCQvIGKZzVia41DIQKoOUnOdI/Iwi0JO
LvDwSE66C4gRYx4gwP7bKUJ3V8x8cS+dxJL2BEcBNszWkrt0mx6ojc47OXf+kRRU
ndD4n3+C15ewPbiwHfWA9mUFJwnPEI3RbzyB0SRYue0izYIQihU=
=vgaz
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
