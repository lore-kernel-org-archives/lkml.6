Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73421C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EFB2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/iEnQhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EFB2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbeKVCDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:03:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34963 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbeKVCDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:03:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so5229834edx.2;
        Wed, 21 Nov 2018 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kujdocbDGXmB5bgSyvjlRBo112EFLVETN+vMC/XpHA=;
        b=b/iEnQhgjww/Ly7rh3d9Oapxah7p36GFFc2qmHyQJpXJBJn4n11PgIDV2Lvf2ObzVP
         feiscUF+rv/yBukuJyJ3L0+BmxNN1R878vEpjyPg+rgdrsSdq3MUP8ynAKF+CQ4PEsit
         n7YUrswovE2vof3VDDNUKhS/+GaL9cEvoSQhqTbswJae+ZI0/Z1sKGs34Px81nHy+gdC
         yRGer+KabXq2NO2izTDDCVSREa/hX0DBu+Y61kA7QB+scvGSz2wsl1INcTBkBGPgRH6F
         Qyj4jkvf+xKRNzDdCCInqsdgZ7u36dEEQciAccSgO62RS6EPx1CAfuCuLfzN6Z731B/i
         gGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kujdocbDGXmB5bgSyvjlRBo112EFLVETN+vMC/XpHA=;
        b=qQ03N03MlYSMWQShETkPQRvsiZtl35r7P5Dav0ykS8L8Qv/bIxSIe3gafUTEX7R9A2
         rQuw42aL0PQZy2OhrKSoMpCC949SgM5lMEcHNK/MNVfed9GFsA91WTKdN4hY5ksj1tBF
         /dpQYQJPBAUGwsO7tqpDbzHvjnA2yNJeKTj8eR7hyUU2WW/tlWo5Z3XiA1hC3M/+r7tI
         gyKe7fWcFVQ3wgv0BeSEnJyFV3/dRtZq4XeFoYpgg1xsI5sj3rcUkfMmR4E4Jty/oQgw
         LEZn5CG3PT088TCb//NcCu1J/30nfbIcuueYHC450jdCM09NO2Ms5uYoKTRgABFjCdhF
         nqQQ==
X-Gm-Message-State: AGRZ1gJd1i/YCYNYlAtJcF3ciBKiZXjc6XDcVN4OgN92W8tpt/HXE0gX
        hwJgRSu5FE/EJNnf75t36f8=
X-Google-Smtp-Source: AJdET5db41hpR7Er2QYhgyb84CJO3GDW7cv0psxqJvh4843sq1rAxd9wRBlsDAwnMR2RwpTAVKfyQg==
X-Received: by 2002:a17:906:6a9b:: with SMTP id p27-v6mr5420608ejr.235.1542814129481;
        Wed, 21 Nov 2018 07:28:49 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id b49sm11202725edb.73.2018.11.21.07.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 07:28:48 -0800 (PST)
Date:   Wed, 21 Nov 2018 16:28:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
Message-ID: <20181121152847.GB7739@ulmo>
References: <20181121141204.22819-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20181121141204.22819-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 09:12:04AM -0500, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller.soc_is_tegra()
> doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
> soc_is_tegra() whcih automatically manages the reference count.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied to for-4.21/soc, thanks.

Thierry

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv1ea0ACgkQ3SOs138+
s6GJJBAAqLw9PQzOAQwOvTTDIJFN6uCAZ6UBLfOFwDT0jnqGwjh1SWQyfDwHb+EA
3CXMRu/GaPUxnmbpM6ZtQGtk4na5tbbc2Uvd1Hk2Mqb6esabqBj39nIP8F1ruxiN
BeDBlWpOBMs1MWM5aWXH1OenPs+fob7qpiQdmH8xI/cFEXpP+ZpapmRV+iJs84in
MlvGXDR1bB9XK1f6eocdKY9Lbzol6uP6X1TmeboI8PVJSzyanQmhXWJ7bEc+sGAx
MIWBCjXnzUyzSFIh/7HsKKCq8/yjnVW+aaKOn5ZN9kwHWkttj1z/n0y1C/+KEt5L
2SdwhxIEodVwmayv9EBxyy9cor6yE06IhaSTAWi0B9LM4qDDsTTp6FYqMJK5JjbM
Lp+L2hv2S61VTCgOCzlIi0MIBUZde7xvG04pOzcdu/OadXOE9td+TRVSU6FdGzVH
BxH184rEMTS6O53U7/uPi5E37nGNpfPBBcGWQW9hNAhNQfvK5fW/tS9puXhI0cH/
4Q2jaReUxjdtU457zayjzL3Rtl7WI3aTCwelmHeo/TGz+3KPmdVigrLpmkubeZHF
a/4YsUwSyYOBoGHX9MgO2ZiZ62gq1sg3jtog59DePJilx7kCv/YTScWnlsHGNvaQ
xT/XQbyKUEIx5G8sHmWaYAPR/o6qEP9Dxz6P0Woys2dTzC/aVKs=
=pOBX
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
