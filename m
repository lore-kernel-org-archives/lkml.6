Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669BC214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn1cSSm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669BC214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeIXQDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:03:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55586 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeIXQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:03:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so1106036wmb.5;
        Mon, 24 Sep 2018 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WjalxdWabknwfzaCg8bV6Lnm15v/7K5bb7xRiyu+R6o=;
        b=Nn1cSSm0UAAiydm1GFF0Cax7IkoKtNfemjm7HGj9xz+hwxXaNeuiIgmJ9Tw6IyuTJz
         m2Do5DsdSdryP4MUj6hYYzcoq1OIhSs4SDBZHf0DMHq06HnpE9aGoExq8pvkk/kOStpI
         xpMRgzeoIAOqfpqFN1TXTvQ6z2skrNCPq+gkcjGO6eJUbDpf/6DYN14rIV6dg+iAywFn
         5FArtgKbiELTqTIKB0QqPv98TpL2PTkX8/ull+6UDNfWSHuiHw8Mn/iswKLcDqRM6asR
         PrznNuE6fqt/BQijjkK0w/97nMlEOkCiMi/Gm+8TBoxxOvi75wvDq0Cb4sHYc516I9uQ
         +3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjalxdWabknwfzaCg8bV6Lnm15v/7K5bb7xRiyu+R6o=;
        b=jDXDQkONegF7AdtF9RCkw9NcPGDvwrIB0zmS/TcQhqgCoemUaBK0TGuOrgffknoI6t
         otSnPatHJqUAmNM7pXpGYBg7GACyki2aCQL3yd6XAKLbFgmQQARfOFiRxehRBag/yaXx
         1dmUJui8VvQpE4FcFHUHSwXedmMK9Zjrp2//cadwH24wrry1NpTctb9/T+kO5Z2t8wye
         iBR+rQWq+M5q5i1hr93ASgMqKkQj3/XKWXAl02Ans3eJLXJUo7IOjDWy7RddJh3wNgQ5
         e1+02Tp5k236ouBOnTfEVkQ9k9U28Y2W/GinALXjeXJYr2Vq0xgaGlxjLU7wWQKQ6QR7
         Zg9A==
X-Gm-Message-State: APzg51AgposDI524zWfPUIr3QMrqpDSzysDSTx4CR8fTOeePd78W9mOw
        naqPNOsxlLwiJqbpujJxGVg=
X-Google-Smtp-Source: ANB0VdapqLxmkQEvsKlwtqSTv6HKRGOarCoP6RHQqy4VFbu+6Po6KI/yaOg+4hJXVfNvI0HYVg9hlQ==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr6320727wmd.92.1537783327319;
        Mon, 24 Sep 2018 03:02:07 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id b74-v6sm22293113wma.8.2018.09.24.03.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:02:06 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:02:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/20] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
Message-ID: <20180924100205.GB21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-10-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:42AM +0300, Dmitry Osipenko wrote:
> The tegra20-mc device-tree binding has been changed, GART has been
> squashed into Memory Controller and now the clock property is mandatory
> for Tegra20, the DT compatible has been changed as well. Adapt driver to
> the DT changes.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 21 ++++++++-------------
>  drivers/memory/tegra/mc.h |  6 ------
>  include/soc/tegra/mc.h    |  2 +-
>  3 files changed, 9 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index e56862495f36..1b4ceefd82f9 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -51,7 +51,7 @@
> =20
>  static const struct of_device_id tegra_mc_of_match[] =3D {
>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
> -	{ .compatible =3D "nvidia,tegra20-mc", .data =3D &tegra20_mc_soc },
> +	{ .compatible =3D "nvidia,tegra20-mc-gart", .data =3D &tegra20_mc_soc },

Technically we now regress because we no longer support the older device
tree bindings. I know that it doesn't really matter because this driver
doesn't really do much interesting yet other than reporting memory
access violations, but if that's enough to warrant a change of the
compatible string, then I think we also need to preserve compatibility
in the code.

That said, I think compatibility would be easier to preserve if we stuck
with the old compatible string and used a "reg-names" property to
specify which version of the binding we're referring to.

For example, we could have:

	memory-controller@7000f000 {
		compatible =3D "nvidia,tegra20-mc";
		reg =3D <0x7000f000 0x024
		       0x7000f03c 0x3c4>;
		...
	};

for the old binding and:

	memory-controller@7000f000 {
		compatible =3D "nvidia,tegra20-mc";
		reg =3D <0x7000f000 0x00000400>,
		      <0x58000000 0x02000000>;
		reg-names =3D "mc", "gart";
		...
	};

for the new binding. The driver can then easily check for the existence
of the reg-names property and take the legacy or new code paths.

Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluoth0ACgkQ3SOs138+
s6FNNA//dbYek11QhDjPony5xuLxPAcxmAJxl9zWStnLA4kW4ZqBhelXXhMNPqjc
wAQLVVXtXXghdg66hGIHvqj/Ug+1e2tnlTm+avZPC+Dx55ISdEf6kiAURFbmsvHu
U37RtpfKaCicRlR1iJPmgAEnngxzcZscmf7TodrgHnMeTUj4I3aV+bbxnVMcDZ53
yNG2fgpThvF27FKhW96lA2iA6sJAF5uCJi+kgqrCA+JBB2nPf4eH7RrF1p2etb8i
YtCZ4zmZClXnA7E3X1uKkx/zl1TIL1luPE8L3WC6kah48R68KdPwCW4svEETcV8G
5WDLfyUi6hzeEkSp+sv7S2VF9ld/UYvMcO5ZDdAcNrxPy7HBjmptCeA9+COdvlBj
PsngAZBLbaqQInS4evmMrJPnYGcp3tP8Okmx6Ca9MuQJjh1d+lPv9C3QCylrR9Xy
RPcT6szOFiPbmGmExTEYmIvfoNq+s8vhnmR9LVpBlQ8pgN+PWNGr8qzBHaseRWWO
LCCNzuT/bZuHc7gDKDacytquDejpRf6nvay/0wpkQ20Km/Etjp2EL4IGO+XfYcBJ
hpdIyN5sNIqGP8Jlb0mnWJtuL4wQjbsOAjpYQdVZBulmtN2+1xzaqoCSfcc5uoHq
1dVZ8bL//k3mWYlmTXIRigflHeMokvx6MSxtioTramG3rQVPUmM=
=1ysw
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
