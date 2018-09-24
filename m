Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998AC2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXY0Jcra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998AC2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeIXQYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:24:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43964 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeIXQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:24:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id z14-v6so1590831wrs.10;
        Mon, 24 Sep 2018 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiiBGVzqFnlU80bax9OYHWebaw8NjVB7TaaVJNMqFlE=;
        b=CXY0Jcra9DwzznTnJqMnCdydJ2Bbi46bGiXITHhej0AQjALM9w866Nn0dCVJpm+fce
         etK8ewirZgc7clSANKJ47p37UZ9pz0CtVSWJl6FUkq7vMuUEIEI1Lk04S38i1SxqUvU2
         3ofVSXlU4WpqrmJgJgLXVlnlUWzx4rcWs0LBWsYycbRtD7Vkk3iLBgSBYa6aQSiiY9fg
         5B+jy3aeNcKagH4fO5KLXJvZ8zV6xfgZ/xVzmup6xaPJr8jK48ZCKLB8Q5n4/6GZLb39
         6EoTbgSqTOUSg9vyq4pMfVvvvztYUBP5KmstGfMaQ8k8JRO+hN598VREeEwa6tyZpLft
         nOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiiBGVzqFnlU80bax9OYHWebaw8NjVB7TaaVJNMqFlE=;
        b=ZUfe+g67Gg21UYOcWBMDvIeT/XzyZOYOU3eBeugHrDBcwyxshb6FS15fN1dPBy5N+n
         LwH2vwphf47DI1ETFkh247C1rViflxNVNNiYLBCAqU2p/D1njwIS9M2MLdV06zi4Euv3
         xX6lsjm5NLgOFOYtmfoQN6HJFWJaXgsBkK8/biDahwU1gztbWxMo5py+/Z3U7oixVXDE
         4lkI9l07WxaeqIKcsgrGX5ECQwKEQfS5jUiv/JQcjYdpAhgi/kT5bE1Z1GQnnEKh42Wc
         gAgqs52Dnbry6St0lXgPA1otYWHrKwBxCM0YP4+cRJ1xtT+6qwA5C48OMzJC79kSzg/H
         LTlQ==
X-Gm-Message-State: ABuFfojG9xrEVKm3/BH3OdFtwW9jxonT19V6ekrUmgb/+98d9iVr7Jk8
        yYq0gjGV9BNCT4YRHrlBZhPnq0ad
X-Google-Smtp-Source: ACcGV61CFGQB/aCcE0V09L4VPZa96rAAxYNa1gpW9UxVlP/1iL2QMaWLNHfTdcrxPZ3XAUgDK/c6tw==
X-Received: by 2002:a5d:4e44:: with SMTP id r4-v6mr1599762wrt.27.1537784604313;
        Mon, 24 Sep 2018 03:23:24 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id 144-v6sm28685341wma.45.2018.09.24.03.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:23:23 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:23:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory
 Controller driver
Message-ID: <20180924102322.GI21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-13-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:45AM +0300, Dmitry Osipenko wrote:
> The device-tree binding has been changed. There is no separate GART device
> anymore, it is squashed into the Memory Controller. Integrate GART module
> with the MC in a way it is done for the SMMU of Tegra30+.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/Kconfig      |  1 +
>  drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
>  include/soc/tegra/mc.h     | 27 +++++++++++
>  4 files changed, 93 insertions(+), 74 deletions(-)

I think this could technically have been two patches, but since they'd
have a compile-time dependency either way they need to be applied in the
correct order, so some coordination between IOMMU and Tegra trees is
going to have to happen anyway and might as well just stick this into a
single patch.

Thierry

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluouxoACgkQ3SOs138+
s6FIqRAAv1YXOG+5wSjtW+2I5DBn924yW8YAZ9x/j72Pf+1bNLaZ+o/zLBl82aHC
PVVQMLjOCNSoozNRra27knqbUB/bogRvRQQAyjk01LeQzigTtJx3Gp5I1M+kKrzo
jvDKUm3roJdHvJrAZewWwM5tEe7ODQhZ6dHW3gk9jBDcen8Qc4gacm4wKlb1z4PS
LctjQf5QiYvhx6iPgW1pWRQG79TpHuG6SS1jHfVaw5fSGUDbco6asxqTLwdj6ZBc
fI/k0faAW652NxxoQe7aq11yE41bZu+6oYwWGhT7F/ABwJKdDCBH14Bgwz5Fk5pq
6onUtt42xw1wR9OwjtGv6zlVcZQcsQ7Fn/X2TQ3M/Fu/aY74u/DsLNeeqEZI0xsL
I1+F4R8WCTmAqAOgdq7TeCJGUJRg43IykYYeJ9U6nXFyUhhpafza9uZXx/1f9OpF
ntrM6S+nhRCyccytdYxFq6CKES8O6sPd7ER21a8DqkuIwQoe3/KwovTRoQU5fQrh
0+XTaGTdo6PbWTxkkl7qJNZO+xcqn/ZickKtCZbbIZ334qxd94g7/R1N9VSIGul7
IGmgngRQzQcEhCzK6JWClfWMBKnvuuflY6S60j+0o3WJiC6yJzo4pgpVDWqxRsc7
iAyiVGx0VSzjhciA7VsPT5mwntGloKaUjD4kfO0UzuEeyhjgAt0=
=wIFq
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--
