Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFB7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119432087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T68gMe4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119432087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeH1OfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:35:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54792 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeH1OfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:35:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so1406010wmb.4;
        Tue, 28 Aug 2018 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kxiBoAgNGILYNmZjP5dgkIMYEdWujfo9VV/ZUtBhHL4=;
        b=T68gMe4rrLNxjl77jCwfSYtmD+gD+ualDEOO7+IZnYO+/fDzP1wGZLgpUr9GFXaeHK
         Ya/78LqZ9SSNDK3DUGMremEcnAiqQd7XopKDI2gp+Nfw87Xywop3OzRERMcWXli6butJ
         /OOD9ItwW4wei09yczRyzu5F2jXCvJ6monTwoYd+k7a4k+bTjpscVVPieyrvL/F+kwCW
         /8MqX+beRGLAnKojtHGJg+BejLQ+iGB8NBUrzpkm8k3dERKfrpEAPttk3uhf7YYLZt4A
         flnwWLTB6AvXlexg/polCe16Upcp5vvCD+zzYMxOrTHrutF83u6SqWgZj/DOU5H9PoRm
         8nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kxiBoAgNGILYNmZjP5dgkIMYEdWujfo9VV/ZUtBhHL4=;
        b=KslziKLO1d8BhNKX7TM7yF44UzcnE1LDBHJUEeyw937J5+5XYIg5ywGZ6bX9IhrLk2
         2AAer7hjZE/p8U+zs0GuQNphB0YSfCTt2G5hYqN2mJnV/wBU2t5/mhWx5TBFcBPeAmIZ
         hGN9CGtw/OlHYiURM+EagnnPUlslHij1TphJcnwxS3PkNqpnf9J2yBhLmNrTRw3+rJ67
         k8oOMFcIu+c0Ru06hzTE2/F5CBCb4klHG74Hc1QPcQGQ/LH2Kzo1HwMeaCKo7ybdjqcW
         GvQCgK4w7yuWeWf6cmGNdyJY5kBFXLwush6kypgMWTY21T8yQuazItoPM45xBV8/Kx6p
         OMjA==
X-Gm-Message-State: APzg51Cug/mVkBiPPcxUM7I70J1pjFpPo0YO4lskcyI0KjhLwf+KbdD7
        TCSZx/yiDjWYK6DAvYbtZSFlL8kB
X-Google-Smtp-Source: ANB0Vdb2io9lS25H/DaH/wtEPoTQtT/XZ7Qo7jwLM1drCRbpFU2Z/mlTXuba2mU2uKOo6lJ/iG7+VQ==
X-Received: by 2002:a1c:230f:: with SMTP id j15-v6mr989033wmj.124.1535453046952;
        Tue, 28 Aug 2018 03:44:06 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id 144-v6sm1520486wma.45.2018.08.28.03.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 03:44:05 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:44:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Message-ID: <20180828104405.GB9386@ulmo>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 08:52:44PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/dove/pmu.c            |  8 +++---
>  drivers/soc/fsl/qe/qe_tdm.c       |  4 +--
>  drivers/soc/qcom/apr.c            |  2 +-
>  drivers/soc/rockchip/pm_domains.c | 44 +++++++++++++++----------------
>  drivers/soc/tegra/pmc.c           | 12 ++++-----
>  drivers/soc/ti/knav_dma.c         |  8 +++---
>  drivers/soc/ti/knav_qmss_queue.c  |  8 +++---
>  7 files changed, 43 insertions(+), 43 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluFJ3UACgkQ3SOs138+
s6GD5xAAwk8wk3MMJcqmINxPuZwkmqEhM9UEvObejj4eWhcJyTTaZVxWDSImevoN
qlqEesIdQPZ/zqjTf9b0SHsIfRIEy+kUSjEajNaVPTy9WAuPl8H/34yO/e/nUU3U
jnwt58kIpeoU1kMvVzTCloBRJE2JNRV6IdzhMp8Dr7XFZdKUxgFylx7KQRM3HcCH
O07fktTO4MDKlhceR29zG70cnVVudfZ+IOrUFVKwwyh6G3RSBPsJIU70fWpUoyvN
DHsLpfGPVHPy+uHerLL9BTCrq4cwpZydHUs5f7ehWda8h8pexx2DsSxzsStxzuW/
2JhiCvQlZC9cMtTYYVQV/ewAA/AyR0Qk5GE8hkSUmmFqGVrEPqG+UWSQEJwi+NyG
n+v8zJauq1LFYvvIcm/SMKmw9lhVfPtWVeaPF5WXdegWAHcmG6smtXcB6ObxCvEk
kA0Y38kezs/DQzSrqyJzkU6L36Vl6UiBU5PKeL3CpKQ2XhOerw8d23Yk2FnGxCCf
p/DyDWFLlb+ocQ/YSyheBKZ9xKFPFvNwMs6KOEjV4DrWI0AUNflRS9/0R022y1tH
rPR9pGJ66CatN3iz207Q/w7XBpkVPqtVl5oBWlxsqRtcBsFV82Xcq5TiIGFLSWMR
/EP9dvrfcBZ+62YR2ByJv09XoYgMBcFcdX5JqWVqlTwYGdM0qM0=
=WnQr
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
