Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF23C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313992086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owsKsasU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313992086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLLKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:05:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45894 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:05:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so15008625edb.12;
        Wed, 12 Dec 2018 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G75IVEXe2/IXXypwbyOJG0kqGgd28jeGIZVMmjLxnmk=;
        b=owsKsasUMQv6OwZLkx8frKDAw23URe4JhCxF7KIkEosSqpqCzn62siC/24mguOtlAo
         hVvOaVreFrB14VdluDoMPIingsOvmHzexh7klueCL2/YlDP67pBpGfMNH2A9NYPv1sz4
         90c2DC0p3JJFbYKW+Bl8gTLtfo0JnlfSDQBCOkiuvmPPwvgD689P6n5Q2CyqZ2GD9AEi
         bEWkXoNJDDldRtxC/AmKK37ynlpXVPssukZ4TWDg0A2rZ1Eb1qSHHIJO+IYbICD6cXz4
         nXVNPjz08KBJ2TN9pILjCTWPP2jw/VSPvXOyZeGHoc9lNc+6+WKLMYKfwkdWQdglYO/j
         I9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G75IVEXe2/IXXypwbyOJG0kqGgd28jeGIZVMmjLxnmk=;
        b=cJO6+bGAB3Nu8NUZOUbLzrCVNZusIe0/0FxVkRNvPwhh7X3riOmihkH1D7V6Ai1ikT
         wKULWlv41R58Iycw/1nrlE728tYt5I2l3tgDtN+S9dlfIPLMksZh2kRFV+s3yU4mKlBv
         PPxmF/ee1z9az7WDaexngAOBhbhGuRvaL//Qyn+sT6ZApPLzZAWKFr81Ws4A2w5qNtzD
         OqnFIVGWdZAigfdPIrsfVZWrok0Mr+h0e8uDtkFpOo8he/gtnMP0cKdQWaiJmKMw4pVg
         uB8rVD/TO3eDTDsPYuFsZxZmHj4962yuN1H3hALtsfe3dInMvzBYAxRxoWwW1rWG55CH
         6K4w==
X-Gm-Message-State: AA+aEWYhWE1enXhhK+f19FSZfW/OuUARttrFGWkKFcRRdGTPkInE6Ulr
        S1ipj/tmVWWD5yF4HvhrcCo=
X-Google-Smtp-Source: AFSGD/VsL5ybAQ0g+OWPoi6TBnyW0XLNgVStEIqi3hLq2mghbchCWgvbyv8IB+cQ+AgjV4PdkdLIYg==
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr18648145edg.121.1544609125487;
        Wed, 12 Dec 2018 02:05:25 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2562606ejc.10.2018.12.12.02.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:05:24 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:05:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/21] memory: tegra: Read client ID on GART page fault
Message-ID: <20181212100523.GG15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-11-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:39PM +0300, Dmitry Osipenko wrote:
> With the device tree binding changes, now Memory Controller has access to
> GART registers. Hence it is now possible to read client ID on GART page
> fault to get information about what memory client causes the fault.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3WMACgkQ3SOs138+
s6GZHg//RNajyeYT9wZ8n9fuo/qqiKODESwNpf2kYIYOSdXA2RwRouhml2L/q06D
A0cBf3VZcT45q+OPpEChx6NQ+z6YjTdaJlMABgXrZTqXu7mv3DJ2EzskcApa7gvu
IZAQPlOV9qTD8U94QeIaay362knEHbRP+cWOezOdQSaH7BTR64dufPoFyPDlHEEi
O/Ums8Q9vBnRWqzJxY6D0l0h00UZV2PfjSqg8qNB3EhwBrclRomhd5BFx0zUKEHW
PyctKwGmL4tGyaJwbKQDxVYeKnHx3OMFqv515KuWeXKzvFPbmrdabbA/yL4bRxQ3
yfKPDnERvlKdEmw63zcw7xN6DNloXyXtYn4mvYea2qdWi/LxZdyNc8MF8yxNv+8F
7iRkjP1+iBOineBJriwMK7HVlhimnuJJvTD1kb2MjglMgn0artOrHS/kyoQ8R3Js
tyDF1FEnNLKzvmG2SUSZLD52KWgwwLr9WQ5wDGC6akY86DnBiO3tBu8W7zCLw8h3
JFvbYhcjrSDQ58/jkaNThIJVk4eOwevMlfypG6TIH89owVMDnVL+xNvB2XExosrc
QU9VnjWn2tlz5IRoqUEkzDaQUs9xGO5+XUqA/ZkpG47hZsp9Bkv5tlKyUgh3x6+K
EgdwJUSrY4oXRoaAkidCcz7iwz84WXqzFSq+Tz3R4U5Wrmoadxc=
=6nNA
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
