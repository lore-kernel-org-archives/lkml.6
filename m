Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF09ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05B22087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltU6vDpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05B22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeIXQHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:07:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34435 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeIXQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:07:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so11129522wrx.1;
        Mon, 24 Sep 2018 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qgjouWBGTkziOpUXeosLNM5Ys1sWyrnxWjJRnmH8i6A=;
        b=ltU6vDpxrb7GIDciVcy3+iff7fidvlIVaMvVp73ebLVBNA1w0Mwnm+0mC39vqsMrxr
         JNqdpB0uiGTegADDOMaYpY0zSjps+M0GeuOF3hDkuW5UIEgNNkM1naQ/TRLeHAsVkGrB
         /6SfvbU0X0iM+zS2BAvEQqYdTLjT/7kx7VLW6Irdvr0fLEZDq+yhMN5J3pFBZCUGu8Nz
         Am2ct81kI2GM/Ap8BYGm5WNEI5xTejHUKvRQsJLwuosg0YODVFdPFQe9pQ/2DTScRaat
         RCN+irnGZ3pvr8yzgPCSVCOzU5q30TisdtDFKpd19eVKioCo6TfSF+wgJuOpfDQUYmVz
         GQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qgjouWBGTkziOpUXeosLNM5Ys1sWyrnxWjJRnmH8i6A=;
        b=oNKu94cZI4vZhj5lCIoGw15+/vzZ5DQbtkPKtrBceb81NdRoEK4CDTsHAWtP5Tuv2C
         UafzlEzY1AVtbXwpgqdm/ElFFkDwMwY2y6tbnucTlU9XhIlF7yI0YJ4dPggoQz3zIDP0
         btbXBNbuzslwImTGg3lYmGrBbbrFM3y5B6iCt/s3vRDgfnkKmOLSG+kwvYa7dZ7GfaAF
         LwtNqQ6w5PYnI1RcinVs+LFGRXLZHIOKHiDsjy+psHfhrJvjNtnB3mQ95Lmd2+9gcEy5
         R1w+bQnH7xpfbfc5LkdV/Yjor6jJktkYDKCKlz7rK0FXgNNaA32OacpJOVglU71nscV1
         XxTw==
X-Gm-Message-State: ABuFfojHVpCLNA7BHdrl22ax8XMYcrRtK3U1UxWrdOGLnhlomVHYGuw5
        +IfJGagHElT2u1Xzc6RTon8=
X-Google-Smtp-Source: ACcGV63Qh6irEEE6ClufAyhhgGxmxjh6m1YolnnXmTBXcT3HVPzuvRUwxDSuqY77QRFIHusUpS6T+A==
X-Received: by 2002:adf:bf11:: with SMTP id p17-v6mr3797572wrh.235.1537783589750;
        Mon, 24 Sep 2018 03:06:29 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id f15-v6sm10143971wrs.36.2018.09.24.03.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:06:29 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:06:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/20] iommu: Introduce iotlb_sync_map callback
Message-ID: <20180924100628.GF21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:37AM +0300, Dmitry Osipenko wrote:
> Introduce iotlb_sync_map() callback that is invoked in the end of
> iommu_map(). This new callback allows IOMMU drivers to avoid syncing
> after mapping of each contiguous chunk and sync only when the whole
> mapping is completed, optimizing performance of the mapping operation.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++++--
>  include/linux/iommu.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotyQACgkQ3SOs138+
s6Hu5Q/9Fao/qs6ZsPgCpKGQ5rCOFkk1DdOsQluo4ar889JUxblUq/sDiCIny3Cp
RVoi8a9nZldE1uXIhUkJ8LMer8qZYNNfqTVs2VkB6NSBLJBuxnt1eZTK3mmSXPnj
pWvuL5tBIVQmYQyp3qkeYdHkSFAoG7d1vq+7IgSduEBfCvo0Zw6b+5eyuAgQxVKc
ibR+KRfWRK+YGrt28NkjfXrmEy5nCbqvxa3exs/LnGohehpRbl+7fPLSkEGMC/lW
GuESgYxfBG67Zo1MDDFPiCp2JL5pqfgXE5dI4vstx68oPEULfdlaxfzHTTck+OBx
uTRt5kImF4d9a7oD0XUplbo01bP7KEnBdDeEw2vNHXGjvbmqYxYqvaAb7I7iKbWV
V5dXp3H8yG/o+5e8m9fh8NrLUmAMfu+LOGMGksZirtWLnLh6JfjqmM+zWgW/nHUv
LjfEJCYH7GzH31BPPmI8e3PUmQByo1RZx+hUWaPyLdAmXsVCdlqI8BGeO8a82Td4
4D1M6Gm2qguonHPQiJbYVzTff7PC4Axonb7JtYeDZlSjcQKjWZjAvUrQ4OQvxJa7
k1Al+5C2Wau4UwsKoQECtYolEdEhCcSUFTNnhonUd8epAPB34z7RuIyo6jof6Bxm
Sgh49Of1Rimye14XhJ7wFhjMLFgVFOElRM/5mbVoNbXitp6H8Wc=
=Y+NX
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
