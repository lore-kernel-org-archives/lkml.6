Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931EFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F97206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJuiUtPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F97206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeIYQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:08:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52391 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeIYQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:08:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id l7-v6so7905558wme.2;
        Tue, 25 Sep 2018 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2tuSnbLxdvWCwfiqOyf1kgZXtZiPdJV444WHdSKYjhI=;
        b=tJuiUtPTDQJ9zXPBnKP5P3SwQyToSUzx15QjugQWfUiQIMfL7rUoGRDTIVM5uplRYy
         II+86Zf16GXrysswKMXuyHBQJCY5+tv8yuC4Ac+p7MK2vkClLoiivraaZQ0EsUw3IJLF
         rw64lgainBGiiRAkbnO+nbKwGZsINtH15PJdOvXeaG9HvfyKQQ7KsG0fRnu/ClsOJD4V
         qCrZKPx9fvwiMCF6RiIgW2KfgwCT4SEhVLUDvjR+0rZBrOQk8m1xEcM5VeoNd1pH4xe0
         wzhSHL42UXfWhv7nYySkuodSw3WoMySragfKv906w3lECT/tTPRzQAN30QdIEl+nThNJ
         JTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tuSnbLxdvWCwfiqOyf1kgZXtZiPdJV444WHdSKYjhI=;
        b=klL7vJeRtBfFaswoJvcDx81ypjSh7EJeOSsQMCjTEunVqAR9HNkPgChIwRp3N/NZh3
         78yysDemtetY4uMGwHahz2sZXEoYATz2P8EzpY1xoOBZFfvrlTNbaZ95i+3mL8mXg2RM
         xPEVMnefXPVdps0AVtdTCTDh2O1xJFc0v8qWHIcyvDkSXQeT1919xVKy8SfcqYWE8FF3
         yIP5FG1Jst02X7y8Zw3+Yu1lPCysPkTx7q9bL93SXnyDBkgKTfAn/G4QOhO/FU4u2J8D
         FKbpP18lmoSPJ9eZ2MQuy0mTFT3kqNbEyvGOg/Ba9KZyIQb4HnKB6xpinbmlzpPoHgtW
         Nrmg==
X-Gm-Message-State: ABuFfojuUJU1uXYvS7JzxBE487Axy4VAjJ1xgykRB3gsFDEB2oITI3hS
        O0BK8S9b7LoEZJ3t67mxths=
X-Google-Smtp-Source: ACcGV60PMYJebjDIr2Puw4buSBboeRZIkzuSVSncxTRTJ/w6yShFO7XdrV1cKvg1BkKBJ0QF6cmlKg==
X-Received: by 2002:a1c:8085:: with SMTP id b127-v6mr21109wmd.146.1537869723690;
        Tue, 25 Sep 2018 03:02:03 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id j27-v6sm2014208wmc.17.2018.09.25.03.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:02:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:02:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory
 Controller driver
Message-ID: <20180925100202.GE7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-13-digetx@gmail.com>
 <20180924102322.GI21032@ulmo>
 <b2d283fc-ff52-3166-cd70-42f9cba93948@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <b2d283fc-ff52-3166-cd70-42f9cba93948@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:22:59PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 1:23 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:45AM +0300, Dmitry Osipenko wrote:
> >> The device-tree binding has been changed. There is no separate GART de=
vice
> >> anymore, it is squashed into the Memory Controller. Integrate GART mod=
ule
> >> with the MC in a way it is done for the SMMU of Tegra30+.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/iommu/Kconfig      |  1 +
> >>  drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
> >>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
> >>  include/soc/tegra/mc.h     | 27 +++++++++++
> >>  4 files changed, 93 insertions(+), 74 deletions(-)
> >=20
> > I think this could technically have been two patches, but since they'd
> > have a compile-time dependency either way they need to be applied in the
> > correct order, so some coordination between IOMMU and Tegra trees is
> > going to have to happen anyway and might as well just stick this into a
> > single patch.
>=20
> I assume that Joerg will take the whole series once it's ready (no?),
> hence your ACK will be needed here and in other patches.

Yeah, either Joerg takes them all with my Acked-by's or provides his for
the IOMMU bits and I take the batch through the Tegra tree. I don't have
a strong preference.

Thierry

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqB5oACgkQ3SOs138+
s6Hkvw/5AWXy5G71xh8Re4QOcew+EqSH3Hh/AZ0z0t6SS3rJX6kjk6fiy39FHeb4
ZHMqZf2bpJLTPea6QiiWJ7VUAYVgnyb1plfuvHGttu0CGpmoSWROMclkm4KNArNW
XV7EDxbGbXpkfqm/uYMRQVMvYXn2malwgpXXVKgH8ABOaERTchxNJMoacuB7Y++b
E2LBcoLQbjfZZumyYjqCRQbbEa1BHhGD0sBOW4klTGJZMHRnS3VPs5rsyxN8YdJY
4+wz+00B4+JjNI5y13TynWL4ARLtGlwgAYZ6V1U09i+qQjUWsvFImrXGnxlt7aO9
2kxS18zkV9Ak2uD2oUFR3Tng9u+VDXOGh/1syuQ8lVoi1CT2N0/Au5AjuDvzM6gq
PrTHdrUtNQyU3chmLYBOfdfHuiaTgoTXgiw43AncaPWQyoLcjxwAYTnh+B1yuKqX
01JABU6g/HMQjksEDJXb/mY7zQ2IRuJn0eOL5wx5GF1p8+pEiC2i6wQKnZ16Flnd
k2xnwANk8i8vl+R4If9rJvMrc7FYOVSJbkkAopEozhvszsdn9sVbl708IiPesIi1
mhtCOaEwDe7fgrvhB9h74IbPiS6eg3POIZf4mL2JNbdd7+dWjOrkFGy0lx6Gc5S6
9YEjsHgopAg3zyB0eCBqAPXJo8lPGPPbT4NVbz9/9l8I839VyhQ=
=NkBG
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
