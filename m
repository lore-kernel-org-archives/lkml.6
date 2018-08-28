Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F4420878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvTpDpJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F4420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeH1OdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:33:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53764 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeH1OdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:33:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so1401972wme.3;
        Tue, 28 Aug 2018 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qV0hKK/dUbu61P4otQB5ogNK2MgyyiVAHKcJXZTG6hU=;
        b=JvTpDpJM5txROb8KO+rFKpDpFf3DN74P1R6C2JR8De2S+rNAVPfkttiWkywjL8G/eJ
         yKQZwm87m2GpUmSxoH2c0PgZx9LHyqhnUM8vZjhXDJF9FCBJiIoJ7CoQHBfmXlxQ2sIP
         98zOVzcvRbEP8U3Roj/7HRmuq+LX84V5NsZUK/sL6AyVXIbOfX7wx7mmREgxtZWsdSTn
         xpvoTLRrtEitPwdq/jnxmcGDaKq5gRe2X/6sW7wUVeZE+KAEzNdLRT8vo9ihCrtnvfbH
         LJnnmE8/CeswdbmSliZ/iC1vydqnPqXg7rXecRgxHZu8DWHD7N92J7va+U/W6ZA8Vk7M
         tVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qV0hKK/dUbu61P4otQB5ogNK2MgyyiVAHKcJXZTG6hU=;
        b=Q6p48k1fYcxv44cbMDdgGlpfFqX8z5zMrtkLb/oKprMgsn6Mu0hhysa6ahf3mrc9hr
         O7AjI8gAvR1+iB1munbFS3+hkjou9PFzzH2WkLjWD7PsFzLcf5Erac2RXT/Prz/pUsPk
         vZmjpRywAtDKA/zKTCy7abBGVXQnVqLrvAuRg/vgnlGpDJhysJktGQM13sm2Sky/4NxP
         hOSMfqA9il0IveYlaWVtrbX++WzD2gRwlEyItnbBaqTvYaGQAsP4Fv3HLfVGjg0vcx/q
         TM1DEVovnUHkzCdke1TlIrVF3mzgD+wrfNtGKJIsNiCtvTPtxVTX2z0wkHcqpCqoUj3N
         tiSQ==
X-Gm-Message-State: APzg51DqgreJ016WvwotJt5kNk1usi+lFYuVyTTyPIrOTIHQP5pM4m9H
        nCgn2SgA2El5jNS2m+sXW3o=
X-Google-Smtp-Source: ANB0VdZGtjSkC46TuB8dWjYM9HEbrEtuE4DU/BaVDqs7DoRrJEoPMOxzMe9ED06SXcuMPs6/ZsGNHQ==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr968366wmh.20.1535452933811;
        Tue, 28 Aug 2018 03:42:13 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id t9-v6sm1465104wra.91.2018.08.28.03.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 03:42:12 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:42:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180828104211.GA9386@ulmo>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-29-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 08:52:30PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c           | 18 +++++++-----------
>  drivers/memory/samsung/exynos-srom.c |  4 ++--
>  drivers/memory/tegra/mc.c            |  6 +++---
>  drivers/memory/tegra/tegra124-emc.c  | 12 ++++++------
>  4 files changed, 18 insertions(+), 22 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluFJwEACgkQ3SOs138+
s6EBJA/+LbK0Pndw2X6MqTI5f05rIP/mKjhRkiqnK05yE7yN2wp0Cnw9ojCsz3Rs
sRlxaNQp5l8FtnZm9UYmzLIidjOS9AACtrkR8uYaOQK0JyGUIhH9EssjN9tzZr7o
1akD1NR8NeGsJQxpc/vnw7rx6rVjWwmYrPNE8O5osXqrin3/RQeBm93Wk9Pi/OLK
UP7A/CUXNFMGM43jqThk4C6k3scA6f8OPVPeYosqlMyyMkuiKjGN2sgF19wjKlV7
5kXzqDPAoEMKYVuXnzYapQYBRaFzvrouvFDGbg/EOzwFyKjz0ZJM5XIs/4gj9mNO
RmysJ6nR1057ff0zL1wERQUlaV+/FXq7iU9G0Gr9o4wWDKkA36AKN0kFMCFgF+RR
NQdNhjtyayt5vmp9IQsa8KulbEYLdRGamO+fS2Q3ZB4qtmVQuxQwtBSirpE3dPUR
cgyoonqPmV/D8wjCvX0LQqlCcAsTwnzrPuPg+48UCYWgxFRXbtxugPzCfKierbUP
IXbc9uiUxAB09K8Xgqa9zRIQaoe+Q1KQWpl2GvCrz8sneyUpC/eujui0BbEDBXtV
8w9uYypfKMy0Ij2JQN5/brd/HdsNP3ssfjG6S7d2oDWxCroyYyHiygAdPFU9u7c5
bdquQEHSIOZffLL/ymOZ+87WjfKxT6NizWI57CMC0MXOR3JsQ44=
=vAak
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
