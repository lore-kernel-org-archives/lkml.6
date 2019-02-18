Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B436C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548AB21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCDjMOzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfBROnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:43:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39959 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbfBROnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:43:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15so9256858wmi.5;
        Mon, 18 Feb 2019 06:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aeur/q/3yWzC3nkpi8nxeHc+K6TQc9JCz1dt6FZUrek=;
        b=UCDjMOzfW5AIIYjmVupvfJW12cJU3lIQXbJnOsJM5ZlTpQ++dKScqq8ko80ZBQBEwZ
         XLXbB/y1Q58WzAADmQeztpbGvVH4d/+5Bw7/PUaq9HDExwjQqtgoRrgissKpOzOBVylz
         wklWwa/YQzbQtRW8xK3PHDra4DI/7sqQ9GXMsBy4rx0Kt2XpUHFSEYTwZulU1nOInabd
         GcfndqbFIm8K1Jwvk8Iwxl1bD9/Jztw0nvlrVZDamzkWtTw8Pr+5qdHdonkyyAyVoeza
         T57qxi6/ET0pgp90uIzw0AMrVvExmp//nMUb/Qi8ViWilw8VNtMf0se0SuhuoUX0N2P3
         JuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aeur/q/3yWzC3nkpi8nxeHc+K6TQc9JCz1dt6FZUrek=;
        b=E18r5D8/lNjsRtl8APuPO19BA441Xdk8iBvirlqbRnrg/e7ry8uotTNypj0PZnzweK
         GieiggAhHUONjfFxhPa4kAOkC3Qh3cyWlAXZL7nuJpnNy70Cp27dXZ5xdQTdaURAp6XK
         ZaL/Mv7BjuYPK20rY62LNOZqOMx8HyWmWPres7XS9hIags0tnfQSGzjW7RbhpuRIbJ3I
         h2XxMN7muzPXqvbybI2jMCkDyX4IkiSgD0r+Qxdg0ES1d/ST2cWfJXaSppyaIgONYk4D
         lHbHc3ESKS+BpxtIncfetmDQq2gMC3Jn3yikeRh88dGg0Olu+EjVMyU/Pdo5OYAADSpq
         gyjA==
X-Gm-Message-State: AHQUAuZIkX3P0EN8TRTGbjskcSUsfcUiXX30omwqJ/kMatGsvioAeQKU
        Y/HmS6P1B+9Y9RagKxPXhRXMbiyb
X-Google-Smtp-Source: AHgI3Ia1pKS7FgVeeJkhSzEw5jWEjA1WD+t/cRpB/vglsM8ItC1NfOMk49SmIBMJvj6r2OD5KEehZA==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr15391171wmh.141.1550501018870;
        Mon, 18 Feb 2019 06:43:38 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a8sm16839482wmh.26.2019.02.18.06.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 06:43:38 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:43:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: vic: fix implicit function declaration warning
Message-ID: <20190218144337.GB19190@ulmo>
References: <20190218110050.10589-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190218110050.10589-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 12:00:50PM +0100, Anders Roxell wrote:
> When CONFIG_IOMMU_API isn't set the following warnings pops up:
>=20
> drivers/gpu/drm/tegra/vic.c: In function =E2=80=98vic_boot=E2=80=99:
> drivers/gpu/drm/tegra/vic.c:110:31: error: implicit declaration of functi=
on =E2=80=98dev_iommu_fwspec_get=E2=80=99; did you mean =E2=80=98iommu_fwsp=
ec_free=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    struct iommu_fwspec *spec =3D dev_iommu_fwspec_get(vic->dev);
>                                ^~~~~~~~~~~~~~~~~~~~
>                                iommu_fwspec_free
> drivers/gpu/drm/tegra/vic.c:110:31: warning: initialization of =E2=80=98s=
truct iommu_fwspec *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from=
 integer without a cast [-Wint-conversion]
> drivers/gpu/drm/tegra/vic.c:117:19: error: =E2=80=98struct iommu_fwspec=
=E2=80=99 has no member named =E2=80=98num_ids=E2=80=99
>    if (spec && spec->num_ids > 0) {
>                    ^~
> drivers/gpu/drm/tegra/vic.c:118:16: error: =E2=80=98struct iommu_fwspec=
=E2=80=99 has no member named =E2=80=98ids=E2=80=99
>     value =3D spec->ids[0] & 0xffff;
>                 ^~
>=20
> Rework so that its inside a '#ifdef CONFIG_IOMMU_API' block.
>=20
> Fixes: f3779cb190a5 ("drm/tegra: vic: Support stream ID register programm=
ing")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/gpu/drm/tegra/vic.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxqxJgACgkQ3SOs138+
s6FdzxAAqMQwVpAXY7534MRScbODw+x2lR1SKl9F6NuD2JXGRtMUFBPehoy/2Z/P
pWmBhDczB9oqD7kbLPeyjcmg1UH76F7ozMFpbmuL8+G/UFBBkv5tFnzWGWGremPC
DdmOUVwb79F10AUFmhb2lzvYD7IqV0FVWcQ9TmTpXnEr41jvXtGrmwbhOvS0Ihfa
l1fx07dybPZ3M/qmMHxT7Jf8iXPvxOv5KUjSpbIo89JXOguMirXNt1W5PfUkA2j+
D5ek4bHO2Y83kSUi2lQ99qZ7Yfm2XLkutGrGS1aWaWPkPusz9eAoBPOQhNs28Jjq
NC7VcuztkJDVMZYa2MR+vtMoGD371/OdHST7lI+4KfM+u5oE/rWx/CzK8gUc6Nlm
3QyIsLsf2/NAoK77FSffAtrTq2TBUviZFEPKxZ2RcZkAji22DkQtQfv1UgPAGbPK
RFju4jRiez2QPEj6HzIZllrZSkkD0GTaN6vc2BsJ1ZCkLutB2GyQMJPFJtWlxlvp
Q4+UumjC3COO5XHZhh5WLfMqYfvI1A0hLk/2C1aILC83xh36ZJUjdNAejtpAPa/6
O1BLgZRphcNtXfRzr2Kojd7yL2oHchazE7vqEO5qQeHe4V7fkHFp0m/7gn28RuXn
KkKV2p56dYWnXfDU9mvN2d3kvzqT3wIkM+tx/qDP3pmRgmYYdGA=
=6gu4
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
