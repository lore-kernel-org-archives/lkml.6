Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BBFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31FD206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1Ekh2Hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31FD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIYQKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:10:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54441 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeIYQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:10:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id c14-v6so12695014wmb.4;
        Tue, 25 Sep 2018 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZ4S3YnwjKcnQYUyH4MRhINubrDTlbVMfmN5/hecrtA=;
        b=I1Ekh2Hvs5r9CKLYOcncAMAW2rLKmaINmTmwbNXwfo/RzdHKDLkNMQw70EvmloTsyK
         PFt3ggs643w0g5inp3CiTjy07fN1Vzqb+Ip2pYp20BQeqJdgobiJUydslA0mO6MG1JGf
         Cip1xu04lE2dbP+Srhm58uVl32W5vNGNuQYbUwZwlYQIABIvcr6vw5tgd6skJh3iZP5u
         dadGiaUSGj2dVbtOiJbufpUBwaqYa4B712OnA0PA+n4ck+4JrFeZ6aWkCMaQ4JVyVaaa
         G7GUQYss1LAtKgaAGKW0MRS/9tD1TL7yMRN9PJg+3NdvoKPjUektuUPlaLWcXV3/VMSs
         HGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZ4S3YnwjKcnQYUyH4MRhINubrDTlbVMfmN5/hecrtA=;
        b=FitgPSZBRrc35J8h3FnY/uf5kxsaDqp8Z/Rd4clTMQNIDUoOLyQtNMqz2HqVVFkjLv
         9pITf0zQRzoLvCx/dUX5c94BBPr0TZ9RzpQstXB4C6wMC3zsfVFVTQXxHHcopKy54zME
         vDtBXT0N4j8MicpvT364wmYBEB+0bcZ5OSxUUfQVNDG6jiaCUYT7azYQR6clotgdjkZk
         vuQUMswL09I2jtwiudwF9KEOwb4yIHk9q+3/cjTtLBuBXf0pK9q4zieployb4+/ap976
         P7xyVg6I/jIb2kM0cLBoHG6GynDL1NTjEx/kTIaxdQeCIi/jsl+05OWBY7DPS9/853Me
         YXxQ==
X-Gm-Message-State: ABuFfoim1icV9vhjyM/9fz48h/BbgToqFuNLQSOCgOzRLcE8ixT7ZoMh
        eZotuySO0yLvqsH9xX7L8DE=
X-Google-Smtp-Source: ACcGV61rfLJKahucQzgOIp7Ipidx+fP0OJK7rMM9BHUt62q2m8XXqDwyDBNK9CA5m2/lNh5JoBEgmw==
X-Received: by 2002:a1c:be14:: with SMTP id o20-v6mr16001wmf.73.1537869812381;
        Tue, 25 Sep 2018 03:03:32 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id z4-v6sm1471700wrt.89.2018.09.25.03.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:03:31 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:03:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Message-ID: <20180925100330.GF7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-17-digetx@gmail.com>
 <20180924105246.GM21032@ulmo>
 <a9e2943b-1139-8838-5440-bd6cf55e9a55@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <a9e2943b-1139-8838-5440-bd6cf55e9a55@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:57:10PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 1:52 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
> >> GART is a part of the Memory Controller driver that is always built-in,
> >> hence there is no benefit from the use of managed resources.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/iommu/tegra-gart.c | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > One benefit would be cleanup on probe error. Also, we may eventually
> > want to make even the memory controller driver buildable as a module.
>=20
> Please, let's keep that patch as is and re-introduce devm once it will
> become really relevant.

Alright, fine with me.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqB/IACgkQ3SOs138+
s6HNoA/8CFbeEPyFp1VE67Jzl/fEMLQ6zRfF+06HOGCAeFnQ0qqvVGle6Il1QH1i
N9HYw6xE11x2NZHngX+kYMw+b7B0cF4nT3CXLDa0GXTf4ZzqWkmDOwGPKaPMUl8e
MCC2TEf6TIJl0SJy6X66Zoxc4wFof3WIUT2XzxlRR7vPwiRJj4NLyVqH2PEkxyQz
eLhRE9ZNTQeA5GGUtizPZ2mePDMmK9r6wFRwfitoz1no0JuRVJtsVfdCcCa6zbhR
dni5cyjGWiUDCxTS4OaUesNkTN8uYlVVZYGiglVDrgiz7ztA26Wp6JSZp9oaPDz2
9LmA30NgzE3ja6tjd+vlBFc+k0LBwWpmphjG8kQWMaos+PoJypoaFu560aS7oF+r
kTcBh7RLJo1JRu+jLx8P/iYEWth4/ZLkCTPqi7foJPwJb+qu7J0gUuFW+29UnX/U
bDE2z/pRwggUCGpfKlqXz+EdqZ2+tgYwRaeLgrPmKs7HSHsqnzlV0jlkfaKABoP+
Od2ftt1kkAobq0vUTwGLKKpWVJcQSxCX6HMkFvC7TTL1ntMZVSK1SqomA9geFo2k
0YbywVOL6LBlyElwpWZ+oyemLb9IH5POnHnl+gCxYAqy3oIJg87+UTuMjnbHI3a9
xRxdJhFy0jOLmtSlQTq9Q0HmKC+VfD+4kDOOPUFwV8lFDFCr3a4=
=fmqX
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
