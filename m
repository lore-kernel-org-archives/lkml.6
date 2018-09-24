Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA704ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ECB2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOXwBqxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ECB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeIXQue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:50:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38592 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeIXQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:50:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id z16-v6so3090307wmi.3;
        Mon, 24 Sep 2018 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rtHTtN1ipAcuUWYqywsCZO5/dStCr3fmdIN5cWhciYI=;
        b=rOXwBqxTxdP/xYsM9W7J2UIDPk+ylouf0vxnBwW5cGCz062HPmMh/IPUnUiT4lXKBS
         8Ob/R5fvWUsXg8OLUxu18/6AS2oaCQRLidnpxrTxTTcC5vDX2yfZbpIvYL9QPyUi1/RE
         IfloTOhp3cg7qpHomVHbhdmEf+442xfqQ75DeUXjCaEap0TphRaFSdYdpBsj/CQY8wkE
         /UFhUV1uPTFR83nENE0hVmZnbBxL71iJsIeiK/YRqTtLVr1lHlQD3TAddwYs4paPiycX
         1qBInGzaxCliGaM2uWQJ4m+uMBSrz0X7QD6Zby9lczKtWM7qwD1f1Aa3UrtwvSAyrFQZ
         UEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rtHTtN1ipAcuUWYqywsCZO5/dStCr3fmdIN5cWhciYI=;
        b=iMn5HJJBu4DSr3FKx99O9fybyDlF74uX5zqPwNiscaqbYMzKuWau42FoDrH7GQhcPs
         /E+yfHAhpJx/EWuf802ppAMqLaAPKfoinD9asnM3tl+//gx4nAzouBK+W9XjkLjV+fDX
         BcFaMy2bK0atrqLbS/FIHnVcl2O210dZm/VIFAiifHUeiSFf40vi4uFasPf/Nr+QQTYr
         EkjiX9h04kbW9SVng6uw92xMLFTqWr/sUeOyzIPDSFwETUc9UN93MvxlnutWsExukWNR
         yOYva0PoZfpaRQGAYjqwJOIrnd5YJTYMZGpMc4Jo26t5Y9eHnYKwkRxxMN43DxnkYsQa
         hLug==
X-Gm-Message-State: APzg51AX2vNpOGM9Mcd3AnB6Z94XkZsz/ktBLfdhvdqU5vGrupxnJwpz
        hdmlgAeiAZ/fYA1HzMaBVfWfFz03
X-Google-Smtp-Source: ACcGV63xt6NnnMMeAn3QoO5n4Q98Zx50CAuvkeZLxn7WM1fofYgoyPCc9Ayvvj6/WLhvVqRxyageGA==
X-Received: by 2002:a1c:dac9:: with SMTP id r192-v6mr7046108wmg.141.1537786143119;
        Mon, 24 Sep 2018 03:49:03 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id c15-v6sm8999663wmb.2.2018.09.24.03.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:49:02 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:49:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/20] iommu/tegra: gart: Fix spinlock recursion
Message-ID: <20180924104901.GJ21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-14-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:46AM +0300, Dmitry Osipenko wrote:
> Fix spinlock recursion bug that happens on IOMMU domain destruction if
> any of the allocated domains have devices attached to them.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowRoACgkQ3SOs138+
s6GPKQ/8DYlU8PYZ2EJ7v3T1n8v8mTLH8QRZTLiabrpqriO5H7k3vyACE09dIKf/
rOspXZQuy5mD4vFCHS2sXLfIBA7rfNSnE8btKDSVzICPsfZiU0BtW/bwQBu9Xz1M
fi45LpKnnHvDc0PAdFOKwJyp4lkB8bMmgreww5QPNukxeyUgaYCIQNK5JOuLFgsm
+wQswk5+Acr27LXYptJZsGi8cMP5PyCPcs3sVXUlVaQnYLi/zN66U0JfiqiBbEDN
Fn1srQMDZBYf51MOiPE6tjKeitRBRUKhyDOsVkeSZViJANlkaSsWWBD4jnvfA6mY
DrO4WKfDHvasqfeJyfUKRTZC24/hgcTdUW1hgB2G6mc2libuXOyHDZunArczkVNZ
B49mNE7/2D1UjfNF5zQHuLCdk+Z3pXbCPChNdjSyH7L2to2oJn8mLoPvttNK0yap
D1JxAL8ri2vo0d5neOShNlSxQYIsbALPj0G12XStVeVKr5h58FJzcGpvYDTWVFyX
wRt6jOiZjwXzPFjfp6osAgfr055BP27oXlZ0hhLO03mSPBlAUyn2/BIe4wate1WJ
kb9s9dnZjdJ89pbBRBdeq+kFPgoke66HXfDnwH+3+irsohCCBTqvThJ5VcjYb0z9
UK1qA5Ck68PKDRN2RojY49r137kZwt5eGf9XtUDPLjE/hRDyPFc=
=bICD
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
