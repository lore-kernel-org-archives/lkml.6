Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37591C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3DD20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEBbPXfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3DD20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeLLJxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:53:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36744 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLLJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:53:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so15023428edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+BOZ+xD7l9AMhVqwkfBzq2lNZbqGjlZB2qlHG6ygmI=;
        b=MEBbPXfhiUA7i5f+AEsDyEhkntLxxJzWddG1ZuHNg43v5pHYHjflWNlqpRQlJOUA6R
         aywG6XT43XFGt6iCB88b88Ystf5q7YqcdJEtf6qJ2RFcKSmTtmARz4PzMYfFRG7pnDcg
         XPCfLU41G4lvD+QGaqq0pOEEWkTAyPlmrlZSGJ0r7IooJ/3z+6Sk75Ix2Fb5cZgyg6Aj
         IWYC61eqlsiPpAv/9nM3WnxP3kyEE/ZL2XaEkEXGXe1//2Pez5bYIJK9yW/NPLnG3Gts
         gabSqvrfkJVyzEI0yrAwI9A1XDGRuzyF0Nuj1MAEayGWy+shZenM/FPh5nWbuV3DIEyl
         4b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+BOZ+xD7l9AMhVqwkfBzq2lNZbqGjlZB2qlHG6ygmI=;
        b=Cnkf80SjJUXOOCFkJzpmI4DdWJyjJe3PKs/momm2oYubdk8J2q4l35PUyaMtFOeaWm
         3/Ai6aopfOp5CvjYy15ckp8Fot4uBAlB/Opp7+Mys5XSIl3JNatjaYpUbEwLaTHGXPeO
         gmCdDdcazREJzGgc5SSHc61VNTfKYGbDmMfTxCrpII1h7gwiIJsVs2PHKUdsPvMmFZQZ
         nX4+8IPtLmL4DECjgB6Z18mFIBumC/PGr/pVAeda1RlDia9XzsDNac8E+0Vs/e6FH7DU
         6n4XrijUj0GJiHge6SnpHzyoV8rzgMrMMu/pxidiyjo3Xx+7jq9z8lQobCbE4JNDVOmD
         gWAw==
X-Gm-Message-State: AA+aEWYTdHWiAtcEAZ2yEe57SpD7XWRfaRW1aBIiANrZOWYWaHf8N50y
        BR6cQYITuHbmPY4K//YGvIc=
X-Google-Smtp-Source: AFSGD/U53AtfE3JftiTXda1ivA8aTo4hKKFMMFzpg/AH4sDYmC7eJgEO7+Oc6q2Muo8W9XEEm04ctQ==
X-Received: by 2002:a17:906:314a:: with SMTP id e10-v6mr14723687eje.227.1544608410330;
        Wed, 12 Dec 2018 01:53:30 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p22-v6sm2533473ejb.76.2018.12.12.01.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 01:53:29 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:53:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 9/9] iommu/tegra: Use helper functions to access
 dev->iommu_fwspec
Message-ID: <20181212095328.GB15092@ulmo>
References: <20181211121910.5604-1-joro@8bytes.org>
 <20181211121910.5604-10-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20181211121910.5604-10-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 01:19:10PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>=20
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/tegra-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ2pUACgkQ3SOs138+
s6EgZA//e4+EUwlbBiONcBMcFK3Lp+OMNWMDeI5NDEdtigsIto/yEl8kKnYw84sy
5vvFhasY1oUEmxuIvctMxdcS+NHIUV4z+mV9iV1J6vMQFXcBB47JFnZfpfDxV2X2
+zFGe0UmOgLArSq78bL2BRvx9mJRlzapN5szI/GcHBjJuW/CKjySmNiZdDACIZML
2nPZe6lUloJV4xgcoiULetrVVaQbdwCzldPXaQSVbrvjl2r8IcqcvTYVjkzaJ0ah
gY5BEJsdp8hj3PdeYUNn4XCLtDWoh2CfdEpP7AjhpEUxzFoYTjk8k4XA6Lsh26hf
i6qTUaI6ISSpPx01zTA0Zd9aFPvDLbE0+7uGzVHAWzY58og5FclzVS/MT0kslEkl
XTYPcV9LlR7v67DxI/5p9yFoQJM0v3i+da8ERqZQuN2S0wprSYTN10htl1t51zNj
MHnVO0SyIH4tIpHbWQjjCTPvvVEbntFu/kxi214QHkZ7Yd28tQG0O6LY/E3QgPsB
VCOWKMCwFAgoKDdSn/lMBgEokV+ayjjhC7UYlquv/HB/lCYpnAZliYEe1ubZyD6e
UQ+jJFJDzn4KmFpH+y63BMQmH+ffy28t8SSuWSlqrbwP1F0QsQzIzlt/DPInB+01
/PfdHzsOmZlsXNYi3gAcG6CBZVe4birNpKcw8tjup/qd3MwOQEU=
=7QgA
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
