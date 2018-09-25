Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D7FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DD32145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nienBosL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DD32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIYQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:11:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33093 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:11:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10-v6so1660077wrs.0;
        Tue, 25 Sep 2018 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmFwJxWPbPLEGoSqi37mzTAr6BsmiaPCdo59W52iqNc=;
        b=nienBosLpSroDiSYMtWROA0FQJGa0y08kzwOTBflDzs12TrgBUo8+yeTu+SWCDsnRO
         UVSyxxb7/tNJgx9Wnq8rnUyLqpLW+PNxfkNrJLv5Y6STF0MltYXxNPKxMOGCj2xb3OCR
         Lp74CKo8u/zNJXtsNwQfoUgh/7oFYP64E3lPIk+DMVaoc6xZeFcTwFP/ouxesA9K+xXc
         RmIkUaBoBZa1Mm9cfgkKhGAaFov6gW3T3weuWv/KAy2eWN9pVGzdQbW+6QsMl8wF5y9/
         u7yzux4Se1+/X03KADzOJQSd6tifA+fHlST7tjaEZEG2RKddx7qRPOjBASdYlvOo2NSZ
         otqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmFwJxWPbPLEGoSqi37mzTAr6BsmiaPCdo59W52iqNc=;
        b=e5EMqwKP0gbYcI/WYj5jRkctC+kLFnl8nfxM0ZaXI7Nc4JW/dx+C7Rj787QVoweK5L
         gNL+mprTzBhD1Sfjkhairtx7L7N092lzLsveO1G5SMn+V+6NE/XM0fkmk1wUv3JlbrdE
         6ftamh8vkaTAE4zHfnRMOVIjI8bzVj86V4pofhJ2WAN5z231G5vH1eWodLfecC0aBXog
         IcoPh6W5EfKlAF35rXlNKdwhXwqGiDtB3UECft3NWvQrc3YhnpV67/RuWaqS2l5innTN
         W0Lnnx46FWFhiawTm42ciXo8Ev10AuWfuJtHtBGs6qQUUp+2agOUZEIkct0oVXAe+hvG
         KWzQ==
X-Gm-Message-State: ABuFfogLcAlXDjiIbAhyF90voYIbHahMtLXYvJ2AUXybrN7RLRBrZM66
        fzuqMXWLIh9CGlHDuYKwN1c=
X-Google-Smtp-Source: ACcGV62KE14HAK2ZBRUK5ulfnNQF0mLEsJFwRKuuhJ+MoAu3iNodUy5uUZGJesHvKrTWmwFGVQR+Aw==
X-Received: by 2002:adf:84e6:: with SMTP id 93-v6mr33891wrg.144.1537869865382;
        Tue, 25 Sep 2018 03:04:25 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id t70-v6sm1564105wmt.30.2018.09.25.03.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:04:24 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:04:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
 inactive domains
Message-ID: <20180925100424.GG7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-19-digetx@gmail.com>
 <20180924110047.GO21032@ulmo>
 <8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:05:48PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 2:00 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
> >> There could be unlimited number of allocated domains, but only one dom=
ain
> >> can be active at a time. Hence devices must be detached only from the
> >> active domain.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/iommu/tegra-gart.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > Do we have a mechanism of switching out different domains? I don't think
> > we do, so I'm wondering if perhaps a better solution to this would be to
> > just refuse to create more than one domain in the first place. That
> > would also allow us to get rid of the global variable gart_handle.
>=20
> That's what was done in v1, Robin Murphy suggested that it will be
> better not to restrict allocation of unpopulated domains. It is
> mentioned in the changelog, see comment to v2 changes.

Okay, fine.

Thierry

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqCCcACgkQ3SOs138+
s6EcWRAAi1a6EdXZRPBtfZIPPFrJWw0mFbyhRhoBMtgV6Un7CUmgM6G8GBHgMfUk
1ZOEZeXCAQPBL7UonpE3DgOqE27JmX8UuevI7ZiyEQH/7ZHaNN3F35GGbN5R8oSZ
vIFFKGrdx6gWWCfGzDy9vsJ4BasUt28weT6/dHDKLiW7Og8RWICssRmo71oUMyJb
cwA09L4Yf99YbwYcB+YhsYLmcdolfWWoeh7fZO/6xsBnZg6n1YlKsXLKPqzOCl4u
GJ68y6RrwdqRoi7EjxQQvN7RALttAJTEQFctlWijqYlZw73lymgQeDBgWoLJmrzn
tabDCEw5Ut7HsF33lfsPuONHYLUdHy4OnGfjvXrVfHEsRdmUxYtlx/tMAgyr+/N1
hLTk0lVEFr70qXLLXHKy1CvzDj7SwHKnbVjFdIGtW0+2VddBfPT5KCeDyctnQoW9
osyz22j64i+QQDfXRRLqk+ov8S1meF+cFZi6X5RUuJAsC3Ix9HVQKc2A0ep1NPlN
8CMU5xysmcg6a0QHFDPP95G25bYOTTNOSi4bZNjLmqnt5xbtQCqfiwvocJ0f2pyV
kiI+IPyJb3kb+fl4/7RU0MEZho/rS+uPXVkNJkWNHe+Px37dJe4PhSOG8DEZCwKO
vq4tEQsrwuDw8BMQLjczDykDmNL/M0xbhXe7Jvn8FOpD9iZkSAo=
=ph6I
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
