Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B45D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlKk3krr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B45D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeIXQIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:08:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40904 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbeIXQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:08:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so2807136wmh.5;
        Mon, 24 Sep 2018 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O/f1cdohAweW8JJV/Qu9oMTndsAH56yclPGjOOEwzc4=;
        b=QlKk3krrMxxPDKXSOao1bfnBBdq4c221v7rm6QauHwgh0qB9beYuwbu53/NKiAy1QO
         +JozLZz7mKjBkj00/M0Unx8ETftuehR3PhohuSk3Fl5GtFQ8nbtLUoja7/z58lgFQ2hJ
         E/gb0TY+2X6Pr5bnqoQpvhd34PQjxi9TB/rdhX/TE8VeITMrlwJIdZkDOxjRZmqgr8xK
         ZF0suLwmWP/cXlKbF0+WBzAdMvpRXTC8IXnvZy8MqXiz61BvxKYwhOVWrZ99ri1e9V1O
         xnynX6T1oZlOKiLeBZrVhYN+M/iRrPwhXUElQfAI2YwCfphcL17g3NxRhTlocpCNORzr
         NQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O/f1cdohAweW8JJV/Qu9oMTndsAH56yclPGjOOEwzc4=;
        b=TYxWrKnLHWFAkZAtre/0UE6PAJhVZ/szbHc2HrkZGhRly4ofO5bA1rAyIVKT0kEKlM
         +N11Z64Dl+kH1Y59kPjalErLNSyGBuKafMAA/PBJogwifoslrK5HBdFw7g1lyCgke5yg
         4j0ve8XMKsonQzWHLkj+EebR9o59hSGT9E2v/k3PgnyA6A7+R1r0JTeTklBTkfhIPOUX
         LMUtFOB5lxwh0c+YjTDXG6Q59jN5c/DVSgiAWS4OWtqzfB9QZ55PnoUhhMiAKYCcQPo0
         qYwV+xUE2bWcrrhXm3ZkUUVGb8BFijAz9dG3EYlnuSIQMkL0GyhZ3dYgfeSsXamB5RGD
         6DGg==
X-Gm-Message-State: APzg51BzxzXK7gXB7Hwmn5FauCbCKlyGvsmLNLDjt69ywe5AUbpRU5bz
        e/GKDvEwqMddcQNGgBlLaVZ3jtGf
X-Google-Smtp-Source: ANB0VdYcOu9JP0rH8OpX4YVD6/177e6OOTxWuGw4iSdSQjSWfQ3DwdqUE122A9p8JpbSWU2H3IrOPQ==
X-Received: by 2002:a1c:398b:: with SMTP id g133-v6mr7100231wma.5.1537783643658;
        Mon, 24 Sep 2018 03:07:23 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id a126-v6sm14705042wmh.1.2018.09.24.03.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:07:23 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:07:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/20] iommu/tegra: gart: Optimize mapping / unmapping
 performance
Message-ID: <20180924100722.GG21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-6-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:38AM +0300, Dmitry Osipenko wrote:
> Currently GART writes one page entry at a time. More optimal would be to
> aggregate the writes and flush BUS buffer in the end, this gives map/unmap
> 10-40% performance boost (depending on size of mapping) in comparison to
> flushing after each page entry update.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

10-40% sounds really nice, great stuff:

Acked-by: Thierry Reding <treding@nvidia.com>

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluot1kACgkQ3SOs138+
s6GV3RAAp1rhOAm6sQZ32r7t5gQnDun3nb584/yANQ1Tkk/+d6uI4aQOwy09ittA
NYLbF6UPJLyVA/U2JpOSPu7ZK1trJ3+8gWWdq+33KQv4mb/2xI1wGSEq2OpIs+3D
hnj5iMP6AHB+EafsNUccvebGmkN1LvAVvK2oPSTDKVtH//0fFdMQqqlWMWKqxtlD
WtTYKGeMnBwdezhtfS63+83og03QnTb4HLLh8RHZNyJZT7/HpUY5llOQnYy1bae0
Q/L1jN/NQxekxbe2GtW5pmg6eZa0tW0nnzW2o7yfbB459cxyk8CYta+5JCfd0EEj
6hBz3akItwNZDQwmLqumDBuaz02LlKDMgan/HWz0ZRxRa2kYqJCKdw10ReU15JWy
AEWkzzqBVJzVvb1lIXfwl2hpNA2Z+ipkCZ5Atl+ND7C1wPfQQV8ddNblLwgfDYkv
weopJzt8UwTWhO6TJ7t0HjSNEYpH0mxp7eWh0sYQ2UJaWY+Q25whHJU6tWQu4XWT
LDHP83dFmjiJ4qkPZvkAjEJUMq7HlEfkDoAzNKM5ps8gjOYrvfaAW7dUy4bPDf6X
N74+6M9DkgEwSp4yA4+J4/8ZOATDmkPu0MMlJDJe26rFTKLLOcsjr9M7yYrXIeu/
13FfhXSNXC2V823XNJhLVoP8nQNM1ZRWjlmRqrV4Ka7er+kYwSs=
=bqRd
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
