Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF21DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9126620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlM0qJP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeLLKYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:24:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34394 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeLLKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:24:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so15113498ede.1;
        Wed, 12 Dec 2018 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yv8KP/0Y4pYXLBTNvD1Y+bm/AIEzD4agn3Ub/Wj1gJM=;
        b=OlM0qJP+ekNi3T850IaB052h2KN6z0hWewxUGu0bHXz6gFcUYkcAmrpX8GZM8ZxS47
         dzDxAaSGcVqR6ZLxkD0d3UDNitrVqtGf3jHMlNuLiOCJW8+UkI60Ho+NAh0o/gizgQrx
         smAKRbI/RnsKW9GD5ChwH1S5hkn87c8icgxdl3Ph4vxFcqeO9U0FsgHO1JuSe1+E6wit
         StNHmx9Hl46z+LBhV5xEhyk7wj6CaR5DeIIT2BscwSLkgnqAQcgfAbO5BlCuZs/Pkrwp
         T50S38Ulhtq2LRvGJBhGf58oRQJdAEr5Vp/0/9jyF5/BndTrenyzMEH9JoL4wrnG5qKg
         gAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yv8KP/0Y4pYXLBTNvD1Y+bm/AIEzD4agn3Ub/Wj1gJM=;
        b=LhsJqKq5TVq04I90ixb4NkDDi9JYB7TvsGwJmDfV9VGyaUrnx0qlvppHGp97PduI9c
         m/UB8D9KLi0kI0J/whKpy37rFSSaEZyAGyKwMuCnbyd+0VJXjXMygd8EQi3WDPkjJZDC
         Fd64PX88fz5FLt/9G53egZHvCD8PgzA3O6znQh/IOHCaMj8FD5lpwHpxN/D9F3TINzSh
         YTj4gGxDzzHaZO3Vmac3HXC4+/WHIJR2fJTPOJcTROA7iHDeLyS0boYMRfZUGqvGRAcB
         DOsK4z3PWNsOKDE+RNd/nft6HVqckNLhZ3nVw+YP1Go6LH1lrteoRpYfc+ZRzjHIZed5
         LK9w==
X-Gm-Message-State: AA+aEWYtEzceqsFbJYphXeXRcOVp4bQZ5Slo6z6ixQcT4ipwIMz+YOqH
        caGG6vm+BcaCBsH81uy1C6A=
X-Google-Smtp-Source: AFSGD/VJlEAMx3hZWMSqJaScqpsYGRmzvqIuSdCf9GLmoEYHIncJ2am/eV9KmGUMcSrh8arUuD0MHg==
X-Received: by 2002:aa7:c352:: with SMTP id j18mr18182320edr.295.1544610256582;
        Wed, 12 Dec 2018 02:24:16 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d56sm5027568ede.76.2018.12.12.02.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:24:16 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:24:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
Message-ID: <20181212102415.GM15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181211095317.tv43aaefnsezmic7@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwB7x3tnyrZQfZJI"
Content-Disposition: inline
In-Reply-To: <20181211095317.tv43aaefnsezmic7@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwB7x3tnyrZQfZJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:53:17AM +0100, Joerg Roedel wrote:
> On Sun, Dec 09, 2018 at 11:29:29PM +0300, Dmitry Osipenko wrote:
> > Dmitry Osipenko (21):
> >   iommu/tegra: gart: Remove pr_fmt and clean up includes
> >   iommu/tegra: gart: Clean up driver probe errors handling
> >   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
> >   iommu: Introduce iotlb_sync_map callback
> >   iommu/tegra: gart: Optimize mapping / unmapping performance
> >   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
> >   ARM: dts: tegra20: Update Memory Controller node to the new binding
> >   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
> >     Tegra20
> >   memory: tegra: Adapt to Tegra20 device-tree binding changes
> >   memory: tegra: Read client ID on GART page fault
> >   memory: tegra: Use of_device_get_match_data()
> >   memory: tegra: Use relaxed versions of readl/writel
> >   iommu/tegra: gart: Integrate with Memory Controller driver
> >   iommu/tegra: gart: Fix spinlock recursion
> >   iommu/tegra: gart: Fix NULL pointer dereference
> >   iommu/tegra: gart: Allow only one active domain at a time
> >   iommu/tegra: gart: Don't use managed resources
> >   iommu/tegra: gart: Prepend error/debug messages with "gart:"
> >   iommu/tegra: gart: Don't detach devices from inactive domains
> >   iommu/tegra: gart: Simplify clients-tracking code
> >   iommu/tegra: gart: Perform code refactoring
>=20
> This is making progress, but some parts have no Ack or Review yet, I'll
> wait for Thierry before applying these patches into the iommu tree.

So appart from the one issue in the "memory controller integration"
patch this looks good and I've acked the remaining patches. Once the one
remaining issue is fixed I think this is ready to be merged.

Joerg, given the dependencies between the various parts of the series, I
think it may be better for you to merge everything through the IOMMU
tree if you don't mind.

Thierry

--uwB7x3tnyrZQfZJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4c8ACgkQ3SOs138+
s6Ek+hAAm6Xaia2wnPAyQoDzIPdb1xFkdfVusp69nfAlVotjQ8HfB0arU+On09RB
wXfGQH/vbKNgTHd1vRVcKItq4gMoF7GqMREK/thwWzoT20Bw3olIz7ZaG+3mIYIj
u9NzPSujgklgdXyanA/OwXt8F1418zqj/wTi662xqE1ylkTjJQh2N6BSfwMLv0X8
ZQWYTkYNCh8E7GzYHCS0jeE9Cqyd/eXTm5QK8Lfl7oUKH2XZVY9t/Te5nJERDNEs
UTmtSuC+JsQYbxa2K9ogUvlOFAzB01Ovuc+mEzmek7MKVcNd36sllzcXWocbPTIE
aMjSFs+eIQvQgkjNiO9oAWSQNoTha+iiPNEVEVtm9oHoVt+K/YWgn49ZySgzkG/X
DjppZOBA3XHY5muFKDPYcTEw1K4OoI5FjwuRmaKwV+dBUY2k82/h/jMyVUZRqqO0
NBO+NHk3k4zkxxN9pql/b+6UJ1yZiTb2/+djahQwiM6YK2soK6CEe3jaHKbvfsHV
5Lm+FV3NfU9fqyafaSs/FMU59WU8vxb2vBJ4BAosgxRXyM/A8wXjHu4zIra+chtw
c5a1dfFMWr829ZMaVJb9bqkekvadAkMwnJv/2rVUYOH7KrRHoL1/Rs52xfjz7tSs
FrtQTnMfZK2muHlolT4HY7bBXW1LUwMEwby+RAYGX+SoTrAMY+U=
=1/qQ
-----END PGP SIGNATURE-----

--uwB7x3tnyrZQfZJI--
