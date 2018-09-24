Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92EFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E7821480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofJxrlIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E7821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeIXQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:58:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44927 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeIXQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:58:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so19189567wro.11;
        Mon, 24 Sep 2018 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtG+ecx3kSb+BXI5IJn+a4PvPYfZl+2G9B8LVftYLmE=;
        b=ofJxrlILklk4wVZN/nxL47LGTJ0UA5dWBlfhP89nfwN5v2Nw1RlJzUYUclJlGVedWh
         nAfVn6tU8VrAb2UBEqFVr6msy81SlpkOmvmZ9lKd2K+Ll7P6fPPjpUnhcciKRTepaoGI
         i8GJa3B6h1C1Us78wLN/08wttEXQlLvLpKkpHUZagN/sAm2xJYKzJSmlqg9aq7XdYFnl
         mtX187I2P8GaqZ7ERyBIQ5+yb3I1bV6q5IOJhFj1SJhte3/q1MBjuM1hD3ty4N9VDYCM
         2gunumj1Eh2GZ8jRSfutCtbEUN60zJOrNIYqmtlqQ5QPzr9txF2mERaeVFcu6Aq7HRtx
         g2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtG+ecx3kSb+BXI5IJn+a4PvPYfZl+2G9B8LVftYLmE=;
        b=l+wdEcFAZglHshx6eajRyNtjFlp77I8M/O3leGgzEbuvkMZNh2waRKTyyIlk/svfBL
         DERNGbW1PAT1pSlq1stpHnR49zY7GtDhKkLO4XcL2dq8b7u+YmXw9Ga+TejEB4KvUvbl
         XcCkfNPjx8ZPbUTleDNeKnwRvSU82Ih4+vZDD9t+p6jZUuBZHhAKmeufsr+31fZY+gBL
         6ooYDEyNCpgFD6iabKmPkLbfid8jxIWwfyMFnRtEzR714M5vRTZALdtaODPMX/15OZrE
         pFAj1f8hm1DzhbkxscEMOuM7bQPtNtMKwkl4Tees1xrcbrhFLm4ms3kRCOTKkUU4sAUa
         BO+A==
X-Gm-Message-State: ABuFfohoLjDOUMxkopyVD/7UjbZ14c5txADsPHvBJ5sJ1X2z/TdAD24h
        k/WPuTAwAe8r1c0GEtv+Iz4=
X-Google-Smtp-Source: ACcGV61FSsobOdiSaJU3VH1/yfuOKxZpP1wgSRblIf79aO0mSoxtn/SjLzQxoCvDm2jX79kwqwjPRg==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr1425817wrm.127.1537786636069;
        Mon, 24 Sep 2018 03:57:16 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id i12-v6sm659526wmg.39.2018.09.24.03.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:57:15 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:57:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/20] iommu/tegra: gart: Prepend error/debug messages
 with "GART:"
Message-ID: <20180924105714.GN21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-18-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-18-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:50AM +0300, Dmitry Osipenko wrote:
> GART became a part of Memory Controller, hence now the drivers device
> is Memory Controller and not GART. As a result all printed messages are
> prepended with the "tegra-mc 7000f000.memory-controller:", so let's
> prepend GART's messages with "GART:" in order to differentiate them
> from the MC.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

There's a macro called dev_fmt (similar to pr_fmt) to do this for dev_*
printers. Also I think this would be more readable if the prefix was
"gart: " rather than "GART: ". At least from my personal experience I
get easily distracted by all-caps words in logs, because they usually
indicate something that requires immediate attention. I think it's
better to leave that up to higher level mechanisms, such as the color
keying of messages based on level by tools like dmesg.

Thierry

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowwoACgkQ3SOs138+
s6F4Ww/+OYHsX2jWHpA4boVmo7Hho/Wg6+os+ELy0AU2+wUZFLqOPJxotod6Xa47
/j4fX9/3klWk/r1K3pgnfzgVxROcR3uYFTbt7gQL14GY0Q7URN/w4ne1hfMSFuQW
ycVuApcIJa75YmHPdWx/CfWla16Yg+Fv1024IWMyEVDMYpQMqShecWEdRkQpqXP3
UigSgEhpMZIinud0IiwsA4vcyJySUV4WSuJ9YjAlJnc0DsH0rZvmCM3oPh0rFpvO
MAqiNW+A3TxCM/LOwZ73YdCp6rYdypVLiljU4BCc03eLaoXbB1KdM5Z0itOSEQOp
F8ldbtgrvqoJf7YGXGn7WanKepRqJvoph09x2D2FScxjl90Wh/Ej7msnt6eDpzt9
pEPSHHcoxlemS2b3+j+PwSPLw4/3hervHNaobnxbu5cceqBPhkiZsUaVvJtJ+1BC
3a9VOO6wp07tNMbTANyo9WIfxfGflX+h1pH24c05XieGi/3ywHqnimxiHPk0/LNQ
6bTgHS3Jlvvd9ZnzsB2u7i9IY1mSkWOlucKf0Zdoemr/q5WpdyYCi0MXRPxtuQ66
6Af5jRTZbyiU0pf0RggWJPIN0XQCzu5HCG62NKvcvXu5e/vpPULLJ95D8pm8wI7j
4S9wcbXCczVhYCvq5JLNLSaSpgyG/xSdXeRzXw3RDRxiLtM2ie0=
=tygZ
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
