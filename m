Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E28C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E426B2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6fL9ES3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfBEW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:29:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfBEW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:29:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so5471712wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 14:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dL/dFHMc4krS8cywN3wVuxwHJWpSq1L+esmXWPyRHWc=;
        b=G6fL9ES3u8A6rGQe72aABpI2yS1FkuUU6FXjdN09bG5hCPODCKdx+5xxnpAq+zsVcE
         fNTVrL4udrd3kzFvJdGFJs+o0T4O3UxJl86E6iI3yhgrkEus8iuNcMDDoO0oZCrVnqSq
         GuwC3tIbyykJKLq7aqitXTTIXwaZRVyJDfqyWXdiWnZGr55mUriFs4a9oY92pdh8c/Xv
         a11lIyZEYeOAGzEGFcRDcey74wOdMHHdfxHDSH4OLCw1EaCCHUIAtjCakqWHhA6C3tQ+
         6YKZz9z0/nfH1o1Vh1XCSaklRVVYzfc8IjJ6FbcJ1JfNu8P4/NVaNUEULukJxRygjF9w
         MHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dL/dFHMc4krS8cywN3wVuxwHJWpSq1L+esmXWPyRHWc=;
        b=mZi5eF7nEMNYoE85mhzJKPmntw0G1fS3LA4CfRbvEMYlBjP1iGnMUekLYjumlXU9jf
         zNHxwVr1Y8YJ2MJS5A9dusfC3tIFwf6+SBUxHG5GAzom8J3RKgnAWyA0Ukf7LeGnfHVI
         PuRwugCPij0jkBPSgken7QooQayNsFnSu5SqkllUnDnq/HlfVExhPX+X0SF2n0xWw6NM
         zmJ2GtYcJ3zotU29PfqwYEoK+IoyTsHlrJIcXApVSmA83cQKAHF0RiTwnu2ZiF+t4A5Z
         U1T7KuxAzS7kGrKTUAWKSXkR2hKeZR4SelpmY004UB0t7klfIEBljMDmw439qcoC/gWp
         Dhpw==
X-Gm-Message-State: AHQUAuZXUoCUZontFzrJkMEzsMN3f1Z6+t0ABropRiZMCI568CDVgcvr
        ivdlT/O3kGkIi+O99GdMNaQDJ1Nbawc=
X-Google-Smtp-Source: AHgI3IYZ+DW9/2AKBvmNtcuGxr0up/6SbaNonvQeFaEi63pdtInHWRH/PSYkPhB0mQiumWIZhwhhtw==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr5151047wrt.209.1549405754005;
        Tue, 05 Feb 2019 14:29:14 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id x22sm5698210wmj.40.2019.02.05.14.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 14:29:13 -0800 (PST)
Date:   Tue, 5 Feb 2019 23:29:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Message-ID: <20190205222912.GC1372@mithrandir>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
 <20190205161036.GA782@lst.de>
 <20190205162057.GA29974@ulmo>
 <20190205163837.GA1222@lst.de>
 <20190205175611.GA7052@ulmo>
 <20190205180218.GB2882@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <20190205180218.GB2882@lst.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 07:02:18PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 06:56:11PM +0100, Thierry Reding wrote:
> > Sure, here you go:
> >=20
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tr=
ee/drivers/gpu/host1x/cdma.c#n106
>=20
> Yes, I think we I can come up with a nicer helper for that.

One thing I could also try is to remove direct IOMMU API usage at least
=66rom the host1x driver. I think this might work nowadays.

For Tegra DRM we still need direct IOMMU API usage because we need to be
able to map into an IOMMU domain without knowing the struct device *
that we're mapping for (it could be needed by any of up to four display
controllers). For host1x we always only have one struct device *, so the
DMA mapping API should be good enough.

Thierry

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxaDjcACgkQ3SOs138+
s6Gcwg//WRhXjFu9BSLtgrWzoBPopvxCVRqepUzKFiRnTnkFrU/g59V6Pr1ZByZv
z/urtOpVjpYTLc/RHUuTvY1eojJRv40hE/WYNrqN6u9/WLdbSZQVktNkt0HD1het
f29Of53/q3CDCagCP/BcePZllaNrf0aMSicRVAJFLhL9x5ZtV0TII4yCTGSdmnYj
7zWkd4NEp5BqoPi76MtxlfsrPpUPCeDa5ZBiCffDebDQyVMvfNtWp1FYvYop4hLt
z2y+QYqUlyMpxeMEi5P6vTFtoDsZuATEbMF9+Y9DPVZXseKgbMcTnFIzR6rPcQM0
k/d4sMXl/GPMPQtCyQlXKaflHuL5uvrk+3WDAP3pjnG/IO8MZj0L8u3rfWa03wuF
3J2LF7khOs60EFPZYYgIlO4ocvVrAygjWiEu39oK8OuIFTuvRujrzi2lCqsgqoT5
HI1J5GxKFpCjejRSAy2CtDthx+SwKkewLiUy2ZKz7TLwAS1NMx0cwh+6t5p35Q/l
/NjU6hg1bWk/Tb3Q5aVqO5wPi+xs70BMXGTS7ZEIt+qEtwe5IEWpDWU9zHDtCjA/
XFmcPow2PZNRrXsHWdeba2JZrhcVCSZamoXubt/ZAhf97N5SKi/sj/h8PEzBGQCn
vFjAOaZurOKJsSL+Anx+XX07K/K/Drq4uqWiwTkW8FMwAei7K7w=
=igOb
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
