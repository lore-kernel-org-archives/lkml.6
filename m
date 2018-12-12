Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66443C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2012084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2PQ7Z2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2012084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeLLKUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:20:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38773 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeLLKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:20:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so15085638ede.5;
        Wed, 12 Dec 2018 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PRwRVFgeE6PMaMzMRkMm7IQrunQ4PYYUZ+pQDQoO7Sg=;
        b=V2PQ7Z2qtZ5METOtU+SWM/M1RX5oHKD0uEeNVbgKa4tH5FOvzoEyAU3n7ESe1kVEWN
         E7feFoyNneAbVgCEyKx+po4DpFnS5iouUCZzWqr4Y817OKILIQD8pQu4eyVpzK5W7LX0
         wQJxtLVG/Ert9MrL7++LCN/bbjxBCnzvAq6PSHvzDGGtCH7a+9rWsr/t2QkqNwDiTJ/J
         z7zqwmdSvalIswlOcjprdI89IjuT/9IosEFghwNvxq6bZKDlyWhvoReTC2AjjJZCLfK2
         HH+SOC9V+DEBCexa/my//hx6cQGXMsD+8uo/WZ097Q2fg5sQzGXbjrSTPRZtKKijP8Fp
         W9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PRwRVFgeE6PMaMzMRkMm7IQrunQ4PYYUZ+pQDQoO7Sg=;
        b=sdvqD47vHB4hoDAKSHXLRz2oyClarnRJLTfLIxwR84xVNQtp1qE0fPYhLMTmAwPvZ1
         P2eZD1NqIBjIvPiGv1duFVeRaKazCLbyLaTl9v1a/9JTGquIW697mto/yaRGx/5ueGAH
         9bAx0TOF9HGjlXByiIr+E1q4IfbiYq6Oj9aPYG4NI32aU2/T9SZldtzZYSRVoc2k98IQ
         onGBDw1U9Kh+bLL8PJRdsNiIPdLEuVIjdnfPON4LQOantE1IPhDAaR7zPvQuOl9xJ99+
         vH2PRabgEtUc6gh4vVyml8WghQ9RH+58s9zbAU3gpwFQQX53A9+Cnu5j6tNJq4UdZjHZ
         q+qQ==
X-Gm-Message-State: AA+aEWataEqqP+sBfE/CAi23vtxaDc+L4c6gf1Almjl7pI1tWVeIjNFE
        OdJXpu3ypMB3ZrHbuMV+P4g=
X-Google-Smtp-Source: AFSGD/VTo04/JPHA00B5XqI4R5bC5oOgwCCPblr6pY/KL73QF9kUOpM0hBVOPKCL1Vjruy3neSdz4Q==
X-Received: by 2002:a50:ade7:: with SMTP id b36mr17589458edd.215.1544610028864;
        Wed, 12 Dec 2018 02:20:28 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s27-v6sm2541788ejm.14.2018.12.12.02.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:20:28 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:20:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/21] iommu/tegra: gart: Perform code refactoring
Message-ID: <20181212102027.GK15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-22-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-22-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:50PM +0300, Dmitry Osipenko wrote:
> Removed redundant safety-checks in the code and some debug code that
> isn't actually very useful for debugging, like enormous pagetable dump
> on each fault. The majority of the changes are code reshuffling,
> variables/whitespaces clean up and removal of debug messages that
> duplicate messages of the IOMMU-core.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 244 +++++++++++++++----------------------
>  1 file changed, 96 insertions(+), 148 deletions(-)

This is a little over the top in some places, but there are enough good
changes to gloss that over:

Acked-by: Thierry Reding <treding@nvidia.com>

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4OsACgkQ3SOs138+
s6EGoQ/+OhpqPKQ5u8xJGxhe0MrI4exbUAh+zAC1y5Tmq+PbSTKpsf33/E0jao7Z
3e3oVbeN0Fi7o5c5boHynwaXTea+C4KC4uwLhtBZ/FjWyQp68sJTSM88NaBJK7mq
rQVUQ2ayUT5/pOGVT2V71WOwodL1g3SukQaM5owcgUwq2SVCfUe5QvzH1x2Gztor
q/iM50vHYU8wtezVeSCB6Fm4951TAN8uHaRYeGiMyQ/OB5VDpD3kYzPzCt03kC/f
yocv/dKZu56IFBnWQPJtVR0KzjL41ZyJxqm2/sa0pp1aYUVrmsXReyHsv1gBCMIs
JAY5IoSe231YT4/98HH10NH4iqm/SE10aNpJSbuc00WIt8LvZSWVrqpm8LMYboLV
odPOy/yPsdOEUISQYdBZpMrBWNc9bkLAwsMlbNlcB+4dItKU8tG2b2kpj4H/66D8
5AfIAJbd9715R/iP3ff3YdBakLpVvDENvkI2v3t/TcThUoEyDjWVRUNU1TjNoScS
xM5FkjRqvWZBQ1wgfuYyl97RHL3mkJDRpiw9gtGVlev4F7lq9z6RSsyhhnq27gzL
kwZESih+tDiCfwoQq0ZC6eMz3Uz6AXvNrzd/OL9epicyFtnBPTzxI0I661BF4v4b
2+qUFq2j597+RhSfvNsU3vhYvQcXqitqT8+rfGA85Ihsfe3n6Sc=
=T0tQ
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--
