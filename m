Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21864C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35B32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T09N/Q1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35B32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeIXQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:54:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35089 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIXQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:54:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so5871858wrx.2;
        Mon, 24 Sep 2018 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezOWbB3cCQ2uA3kb7u/dVYn7d5Lp8IzqjC6STBUXH4Y=;
        b=T09N/Q1X0EDOeYI0rNc7yvKlidzmPIQpF8zVFet/WZPB1cSoh2iGizqyaNCw30NESt
         C3YMF98toh1V0h1QQVh8TcvbRy238WGPGZSPRhv2fFpROvs/OtpH7l4oBmACUGiW29+P
         3oAXHUmbn9+H/+XaGzyuejM9K9GlwQlepo8HhghIOfzrOA/e29HU9JepL9TOFk0onKtG
         b4r5vqS8Osif7UzPWpK/nPP1Zrz3TUjM90BlljOmtWTbTcKN0/UKtNS6OKmrZIZhYCAz
         5jHA+IXQyY0AHmvvdWBNSfPXVsxN8E5uRTGErgTah6Vh4OxvygY7VQigAqEa0eq/yad0
         ddTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezOWbB3cCQ2uA3kb7u/dVYn7d5Lp8IzqjC6STBUXH4Y=;
        b=ukyfPwbnnVhXxDM0u4FpY5f3mGaGwCgqN2+5wQZFg21un7/530w2ZtLvSGcpGuCwuS
         Z26xBthdQZEcizMvrOvFN1ChYmVOJ8aDDbcWG7ObD3UiU3doq5sPggnHTwSPy/CF4C4i
         nI5F/bBQzT0wBllhIMw3mkQXkQhQbFFtkN4Lj7L8qiKzXRb6dG7plg4Kg9h34VMunNlU
         qvlMMAEx6tU8CCb3U8Ux3fak9gtrOZn8+FSjbSZpo99RgKtrzR1gzj7zBSNyVGFwYVXs
         olg8FxgDApbk2QBN2vVqYjX+vsUtnylGyzwBwagSRRxdzETh3vyOatYv2LKrtcQ1WbBF
         DpbQ==
X-Gm-Message-State: ABuFfogiHpQXlcWhLy2V18MN+sGaElmiFRKKGyPSgeHdgkfljyk7+edV
        Q5YDuGlKd7gQ8aTn9kX6Fq0=
X-Google-Smtp-Source: ACcGV62TBsu/oP0vKOdruoTLTsj40diYmhlgN1eRDOBeXl40Q8HGEi6vIpflFleVWWJEHcATCC1Myw==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr8218836wrd.273.1537786367777;
        Mon, 24 Sep 2018 03:52:47 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id y203-v6sm10948440wmd.1.2018.09.24.03.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:52:47 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:52:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Message-ID: <20180924105246.GM21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-17-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-17-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
> GART is a part of the Memory Controller driver that is always built-in,
> hence there is no benefit from the use of managed resources.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

One benefit would be cleanup on probe error. Also, we may eventually
want to make even the memory controller driver buildable as a module.

Thierry

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowf4ACgkQ3SOs138+
s6Enbw//ap7tF+xS6njyozu0rJjVrmuTyjWXznxYcc5gfB2IrtvSEGciS1o81G6f
cijMcyvGZS4ChsKlSk0KUt2fSNOj9NBcqiWqAFDzvWgkSvn98to59sMow6T50SSi
qxHTkVN0iMO1IWwx5CTOyb4HY018LQR76J13MYOY6In7tOBX3/MssFsHniD7E01H
PdN4ICE5C9+pTkSpbr+7btE/4AE/yL62lJYMcd8A97U/hh2GhOc89B80PrUN3fAy
znHVjL6Cm+ZtuNtgl6aA1UUYDFomfDHpjSuYPdATUgi5VH04qml7ZVi3An6GyfQZ
310RHjE4PEKDg7OpRfCwnFB5OYLiduXuK2F6Ulv4UMSogiWEcWi+AOv2MvyUstm2
oJH7wMY5DUp0Ch4Is1TxVdHOKNhb0L45p1C16Xbmz1tQXO389D6idFk4dhIZYEFk
CCM8N/1neNSTV600r0hSgmpmlHovvHz/AONlji/GstfCCJqSey1+nXLrOTDPIe4g
OQEFRDkYtywdSgnJqmaiJ7SYdOPY0EqMJxGRQRIUObqw1uxMCGO81t11F2dXu8F1
HogWgI6YXt6LaHU1hRYkbCvAm3DZxQVFWPczxClYp7qvNrDTgne8GNMMWXtQ3dyl
qrRWft5yOX5tO7u8TBB+slvbbEcNJ5XaJMvZqg+kYZ9g7k3AFXs=
=PlGd
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--
