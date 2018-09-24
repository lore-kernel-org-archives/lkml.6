Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE673ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0772086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXtDF7Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeIXQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:52:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39582 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeIXQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:52:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so9524459wmq.4;
        Mon, 24 Sep 2018 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWnGZQn58OvqeGa0ToWAPWW8qPT/181fXPExtXppLz8=;
        b=DXtDF7PiLUXLiYBztKGlUC1rHLqp8CaM2/SwDos8aVGHOODF0zrTy2m55z9PErxQpM
         HvxMkMShHflqGElDbivf+auhxg3IGHtOOWzI+pSu5QSqnH6/uwce40LI+A8tmUW4YO5n
         q3iuJbKeOslxTgmgxsg5FaKyAlvdHeDmtvh1kuYHx9xo6xO7qulklJA4y6R/p5eMjIyS
         oqeuyDWZh+sbN/CSZQP2+ZSh/a9Gn4FJzn5MN5Hj5tx1kMcD71jBOFw8vspTlZiHT2ps
         PGLSrn8e/W83Io9cvlsRIcno8J90VqaIojmF4v3J8l/PPerjbcGTB3MYaaB+1zF5DD7p
         7anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWnGZQn58OvqeGa0ToWAPWW8qPT/181fXPExtXppLz8=;
        b=ayakHFCOoyfpVj0YSHbHPX+Xx6g+8xsmHGTfVLKCWu27gY6KOIZd4GvBg2rj9XU//P
         j4ao7j+4gsCN/lDa86QiTxOYPEDJMe3LkbV5Nl54JerTWR3KriZpVHIyNMYK/zrvmhzo
         zagGbsFfxMyF4ZgDHWLjvVeNvZA6/XbyaK8rQ9ckXM3RBdmC6UeHI4271E9bHihDwRu2
         /QXbyHRoh6csmCqKDV1CJPfzwaN7KGxccJb1z1NjQ/mL5ds8jChhNkkpkSEYC5amAZ5V
         zy7SkgrB5Sc4FV1V9pCGN1+kqYSldWfXiaH2o/SswNAMhvB+CBBUZVVnnIr4TTnDo42V
         gIsA==
X-Gm-Message-State: APzg51DjkSo26FltR/gRgqe9DdFD/gpiNeFKd9HFgilEri8xA5sMjcBV
        eWjBwcRLsbphJ50xlz/Ohxlg/BAk
X-Google-Smtp-Source: ANB0VdbB49q3kdDql4IocMWPWslucb1Wa/MSgbmgj/LKG0TtCrlgVzS+Anxega5pGK4R6Eo3R+EaOw==
X-Received: by 2002:a1c:5fc2:: with SMTP id t185-v6mr1403065wmb.12.1537786245104;
        Mon, 24 Sep 2018 03:50:45 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id v6-v6sm9912098wmc.43.2018.09.24.03.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:50:44 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:50:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/20] iommu/tegra: gart: Allow only one active domain
 at a time
Message-ID: <20180924105043.GL21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-16-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-16-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:48AM +0300, Dmitry Osipenko wrote:
> GART has a single address space that is shared by all devices, hence only
> one domain could be active at a time.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 1d45b023adea..9f7d3afb686f 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -55,6 +55,7 @@ struct gart_device {
>  	spinlock_t		pte_lock;	/* for pagetable */
>  	struct list_head	client;
>  	spinlock_t		client_lock;	/* for client list */
> +	struct iommu_domain	*active_domain;	/* current active domain */

The active_ prefix seems a little unnecessary here, but either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowYMACgkQ3SOs138+
s6EwKA//YnbjzmDTEdpchLy7vm5PcbIN2vQ15t394H/pBAqUoUWcqcziaBlJC3a9
y2Exp0e9z/8thAcITQSn6jq+K1FHCEjtiBZHqZzgOqNQozqk+QaUby4SvOVueGA3
nfwZVkFpSjcac6JxXtgIkmcaIW1MB3JIZIMMQC7sCW04BINHoKGpcxhCWLRZ5Ma4
schH+VQ6YWgmyfjDLzHcBqJcJeQGbOs41RO2GDCCBF/xTvtUjiH0fqCtNIM8yQhk
H7UMBP/xOCp+RnrpAm8wuCupFdkceKbd6EIVzxgz+4JWAdiMefAP38PB8B5ZjJe3
aDyL7ZYUjr9e8F7mpHRVPkHah8RW3TsxEuc09q3kAYAgSPGown0geAGFgqIsEjQY
vJPQhR4slYbihcac8Oun/dKDUStg/+pNurDZyemmQ97amjXi66RA2X2234LCSOyH
6CukFlaHrIYjtwctHmgceT8gsrQFGJuy4Y45fBtzC7cN1IEYAwkA1lPbb7uYU7w4
qs6dDdR3IN7xS+vUSKEQV5ch2Z/WYqnEf/v2CZHVAqVHmd9OWAMRL1akLqvkVNxd
qOtELT14EDXZdnZHo8Bs7/LYb7k2eT2+HBoUMKeuR56dfV/LaQKV60kf2D+KYnWT
P2TOOI80G2Te1oPXjVmtY3YkYqPWZ0AhcSsJc7SvaQAyJL8fK4Y=
=P3Vx
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
