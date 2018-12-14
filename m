Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622CA20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1AuyHnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbeLNOTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:19:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34162 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:19:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so16352066wmd.1;
        Fri, 14 Dec 2018 06:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kb2rCQkeWSatxBrLpllpmJVxH8OTFMhwYHBAbyWfxjo=;
        b=j1AuyHnSWyRCPT5J3fzYGeCidvYxmNQB0ib8apdBvBk+aEvNZGLOOVuEWZHc0q01ou
         jcCrTMPtI2AHFpUNMT+UYqOsk5WitEfyS3O4xBSV0iqpsbCaYPYmoG+xbn6iyhxyWrLt
         OvV24ucFQ6vSsjZOzCGIQy1vGOAAlEdHfYQwwH3HrsydoA+ZjF4pmWhEn9GnMZGBqBFa
         shdC0rCOx/1AzfemLkwidtipQl0kQJQNh0T6TaUdgtH48Gg43MEnn+FYQ3RKDM9tpMKG
         OY4NnG75+wz5Khk3+OTnpsqLPcv0g3LwWOWe566IcLZi09cHLopca98gn+97+aE++ugC
         d1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kb2rCQkeWSatxBrLpllpmJVxH8OTFMhwYHBAbyWfxjo=;
        b=MsruLKF+ANO/PdRdZ0fmTPhWyNiuCMZmVKM2WZZAvF8OzAcyfQsAT0Lrc4HwXVArER
         7w4mpgt1RHLmqGpP5e1JKRszIhDpvXEKa1TeTfccOazrgzsq52ULSlFstyEPQdm21G3x
         Z5yU1jCHJj3E+K0jrzgm9wgZTZYamUiWgy40+NbY3kVOwyiaKoDFxIOQhyfz3KWw+sRk
         JgBYS/7fKYZ7IgjxKm13L03ssLIeze+MUD2z+8z7nvmeb27yFXZjY36sGW6by47WJr4D
         yikiRny++d+Rdq3ixa3NF2ZVEFXtlNEsn6UZoZgCrMJF84sE0SwvPqZNxvxjRF23Oah4
         em0g==
X-Gm-Message-State: AA+aEWZHO+PMFwC/m/QLlrtYTxk4iu1UAh6pOT0KzR5K1oSLtQuSRxbl
        z5B7kkDhH9CYcNo+7KLisEJjjkLC
X-Google-Smtp-Source: AFSGD/WULva3dIpMS254yCHpIgtM3Glq31cZRfOfPBGwLlcAZtt0cOM1HJWS4j8RXqb+704jjrbaAQ==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr3543472wmb.139.1544797158615;
        Fri, 14 Dec 2018 06:19:18 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q3sm4193735wrn.84.2018.12.14.06.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 06:19:17 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:19:17 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] thermal: tegra: parse sensor id before sensor
 register
Message-ID: <20181214141917.GD23379@ulmo>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-4-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <1544780993-20744-4-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 05:49:52PM +0800, Wei Ni wrote:
> Since different platforms may not support all 4
> sensors, so the sensor registration may be failed.
> Add codes to parse dt to find sensor id which
> need to be registered. So that the registration
> can be successful on all platform.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 45 ++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTu+QACgkQ3SOs138+
s6GQ2g/9H5U7iEqhcsBZjiDTsgCdVZQSZ3qaCmsCrX5pZCoGkMWiPpEs+xMhznPo
QgFAjvBMMRLhqUw28EAM+bk48lR4ZIxiBrFa0MYjFj7CcQZID0AAy7kI72Ot+lGd
Fs5l/ifEiZhPodNFdraWxe8QVVeZY6OXgpaoGp8MoMHUHaTG9TaIbA71YgQExCTO
rBXADQcrIcRsj7zgoROnWrsR97IqufVzOItO54rDBZnb38mQrlLYllQ2pH/r9itf
b974c0NFKutOgjsy+vqGpEkhygz/O0+MRY+C6YTjPTKwP+Mh0bwhdXRSoDO6vcd5
KDE26XGT9tAdYaNYxoi4Y0OyewKN22bJqYk7obpE+QjvF0TYmnU/YzTljmUPf9ps
GFisy+/5NWh0TnD+nQ/QbymKjc9fiTniqoaks4MN6DUjUsS4UdeAiHR0c+9IolN5
gPJPoXqFVQ8c1zqL7731OwgWK2RBsdfypL64XngoGqekoHw1dew7ovWy5AR1ZTqW
14K07cc9aXNrYeyRIWLL4fJAVOJxwNld7AeR0VzLIgc7x2K9PehRQMkcIsPuO7t/
FAW9RekprXEdpz9v8xia1ASRszF7RlvdBz/AyulyX3Jwh6lNLdKeszPbKc+KyAV5
mr8eiym+nRkBWvvlZutxcsMKTap/SWxEHOPgQe3IzkFI+A/4yoY=
=vvyd
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
