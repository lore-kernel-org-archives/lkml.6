Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65EDC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D97321E22
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+GCVjoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D97321E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeHIQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:24:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51230 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbeHIQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:24:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so321753wma.1;
        Thu, 09 Aug 2018 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57oEn7KMrVxRFnb3pB0G+gQz6PDSflcxMJKcq7T+gm8=;
        b=X+GCVjoE6hLabnSAY8HHwSc8DVal1TebeYQpacr7r5BA7u1Lp6YYfusGBKeCukfJLZ
         mnq5lqmppMqZCSIbYyPj/0UDIP4zuSYp1Jidtp/zTroxpJO2GVyOqIsNnWUGWmjFm0jt
         nofRKyqrSyfd+V7LwoNQJmVvNT9/QxGpkklNSnn0J5wyiWtiELHXTATG2s5/BY/GXHma
         RjMIcExFMi1Ex96i0fUPUlpc54TXWnZqsDXTU/ku4eHA0usmjsp8keIW4t0pHWo8xJQO
         0HwSLbRjJdQpmpo+fw/MS7Uz+Bd69IgXs+umxnCvFy0x3/0JcSxZ4NYdqYTfZLc9Hw0+
         q2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57oEn7KMrVxRFnb3pB0G+gQz6PDSflcxMJKcq7T+gm8=;
        b=hokn3EHlai34CWGAZA673v/EBWtpXSy2FiAw2zkAMXKfSXhAxDZYuBt5vdpnyGkwfr
         2Hs5+Jqe943M+5OXHAvt45sJIf4/ZVPaxF2uwVyn+Kr2/3c6KzAD5LDdDIDuEN7XWaT6
         60iaIa2WgrUQY1gXvDz4rqK60KVRpKT5+1PzyKgzp4ilj0TCPaQwfEZiUQ9Ig1h+GH7K
         ERlle1ntxGFPlVnb4HXZu6DQ0dJsY2jLh7oV6SfeuBc+Rg13Hz3/CgXoLQbKxwurUR1P
         C22/DMG/3yHyqknmSSHkZ8SUrzagJo+B1MWU+QyWDnsE0Ca4JfHPeJ+/QGPRE8Srp2Th
         xezA==
X-Gm-Message-State: AOUpUlENP62l7k/ckhxxHJEaOLwuMEZ6yNO/NGA6SMq+mwQoI/4gUSc8
        Qgb0+zhpCEOIdwNR8EYa08g=
X-Google-Smtp-Source: AA+uWPxHGovmrnoX3X0U1KROCwSBSBwEhhHPbnTRu3aOjgrVWyiAk89Jyk/O3unUWGPXEmJnUT/HUg==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr1840915wmf.8.1533823167235;
        Thu, 09 Aug 2018 06:59:27 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id b10-v6sm5175742wrr.88.2018.08.09.06.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 06:59:26 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:59:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory
 Controller driver
Message-ID: <20180809135924.GG21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com>
 <20180804143003.15817-3-digetx@gmail.com>
 <20180809111746.GG21639@ulmo>
 <16855111.9YhuyP46zb@dimapc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FBBJgEOSAOerUJIT"
Content-Disposition: inline
In-Reply-To: <16855111.9YhuyP46zb@dimapc>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FBBJgEOSAOerUJIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 02:39:03PM +0300, Dmitry Osipenko wrote:
> On Thursday, 9 August 2018 14:17:46 MSK Thierry Reding wrote:
> > On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> > > GART contain registers needed by the Memory Controller driver, provide
> > > access to the MC driver by utilizing its GART-integration facility.
> > >=20
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >=20
> > >  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >=20
> > > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> > > index a004f6da35f2..f8b653e25914 100644
> > > --- a/drivers/iommu/tegra-gart.c
> > > +++ b/drivers/iommu/tegra-gart.c
> > > @@ -31,6 +31,8 @@
> > >=20
> > >  #include <linux/iommu.h>
> > >  #include <linux/of.h>
> > >=20
> > > +#include <soc/tegra/mc.h>
> > > +
> > >=20
> > >  #include <asm/cacheflush.h>
> > > =20
> > >  /* bitmap of the page sizes currently supported */
> > >=20
> > > @@ -41,6 +43,8 @@
> > >=20
> > >  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
> > >  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> > >  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> > >=20
> > > +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> > > +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> > >=20
> > >  #define GART_PAGE_SHIFT		12
> > >  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> > >=20
> > > @@ -63,6 +67,8 @@ struct gart_device {
> > >=20
> > >  	struct device		*dev;
> > >  =09
> > >  	struct iommu_device	iommu;		/* IOMMU Core handle */
> > >=20
> > > +
> > > +	struct tegra_mc_gart_handle mc_gart_handle;
> > >=20
> > >  };
> > > =20
> > >  struct gart_domain {
> > >=20
> > > @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
> > >=20
> > >  	return 0;
> > > =20
> > >  }
> > >=20
> > > +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> > > +{
> > > +	struct gart_device *gart =3D container_of(handle, struct gart_devic=
e,
> > > +						mc_gart_handle);
> > > +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> > > +}
> > > +
> > > +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> > > +{
> > > +	struct gart_device *gart =3D container_of(handle, struct gart_devic=
e,
> > > +						mc_gart_handle);
> > > +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> > > +}
> > > +
> > >=20
> > >  static int tegra_gart_probe(struct platform_device *pdev)
> > >  {
> > > =20
> > >  	struct gart_device *gart;
> > >=20
> > > @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device
> > > *pdev)>=20
> > >  	gart->regs =3D gart_regs;
> > >  	gart->iovmm_base =3D (dma_addr_t)res_remap->start;
> > >  	gart->page_count =3D (resource_size(res_remap) >> GART_PAGE_SHIFT);
> > >=20
> > > +	gart->mc_gart_handle.error_addr =3D tegra_gart_error_addr;
> > > +	gart->mc_gart_handle.error_req =3D tegra_gart_error_req;
> > >=20
> > >  	gart->savedata =3D vmalloc(array_size(sizeof(u32), gart->page_count=
));
> > >  	if (!gart->savedata) {
> > >=20
> > > @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device
> > > *pdev)>=20
> > >  	do_gart_setup(gart, NULL);
> > >  =09
> > >  	gart_handle =3D gart;
> > >=20
> > > +	tegra_mc_register_gart(&gart->mc_gart_handle);
> > >=20
> > >  	return 0;
> > > =20
> > >  }
> >=20
> > I see now why you've did it this way. We have separate devices unlike
> > with SMMU where it is properly modeled as part of the memory controller.
> > I think we should consider breaking ABI at this point and properly merge
> > both the memory controller and GART nodes. There's really no reason why
> > they should be separate and we're jumping through multiple hoops to do
> > what we need to do just because a few years back we made a mistake.
> >=20
> > I know we're technically not supposed to break the DT ABI, but I think
> > in this particular case we can make a good case for it. The current DT
> > bindings are plainly broken, and obviously so. Also, we don't currently
> > use the GART upstream for anything, so we can't break any existing
> > systems either.
>=20
> IIUC, that will require to break the stable DT ABI of the tegra20-mc, whi=
ch is=20
> working fine and does its job. I'm personally not seeing the slight lamen=
ess=20
> of the current DT as a good excuse to break the ABI. Let's then break DT =
ABI=20
> on all Tegra's and convert them all to genpd and other goodies like assig=
ned=20
> clock parents and clock rate.

genpd and assigned clocks are complementary, they can be switched to
without breaking ABI.

And that's also different from the memory controller on Tegra20 where we
just made the mistake of describing what is effectively one device as
two separate devices. From what I can tell, the only reason this was
done was because it mapped better to the Linux driver model where there
is a framework to represent an IOMMU and a misunderstanding of how to
work with the driver model and device tree.

As such, I would describe it as more of a bug in the DT that should be
fixed rather than breaking the ABI.

And, like I said, we are in the somewhat fortunate situation that we
don't actively use the GART, at least in upstream, yet. So even if we
break ABI, nobody will notice anyway. Those are about as good pre-
conditions as you're going to get for fixing ABI.

Thierry

--FBBJgEOSAOerUJIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsSLwACgkQ3SOs138+
s6EBkg/+ItgkU95kpNhbkVG8JkfdRyQbLS8pyeTJe5HPuqcYg5Kx0uzCi7/VOV9K
MFC7ziLMZUKGcnVdELJFiQOiOcH6WXfWTtULf9MDOeQNw2Qu1co/3GE2eyOt0Zh+
DsgLZWsHkRoVGE3BA5u9Vd9M2Zv/5Z9uNuFzv/4ELYcnlJOktK5zpRAbwwvzFK3q
3vCboh4o+zos1mzBAFcPsm4cuKoQvEaOvf5U28UgrToVSsYq5niau/7AQlYh+HGC
WgVW7RXO0SNT+h0OfXCJhh8My41EmeTd3FUMyNvRa5Ur3e6P6Wtfy1LtWxLKYc7g
8w3uPHaGzu//y6Yam/oMO+d/hRdrMpvUJQCi/s+2EkJ3qwQApQl6zmynzyM/Tkes
eu0bBIhjoGLUGt/4J75hKWtLhVw6r2PSDikxir6wvzUOIhHPfrkPLNdFE5wcD3Og
Xjb+pGGE439LVcVkWe79f64YSV403VR+4xHjEToegOuXYyjL7TYCBYwsLN/TVece
MbuigLG8SQMEafCuTtvyvs3gf1Rp5AezvNgGbatQ0bgflhcAqX+ug0SJ9h3n7J4h
zpri3YMd2RwIkDi40ihiGz4JWT6SnoY8NfsaLTCoie3FzVDBfsBtDoZZ3GY81zl1
ip5R1lND1+lCGXxQcF+7R6otT9difNAkGD0AbZ/KbEWSCvrdHsE=
=odYV
-----END PGP SIGNATURE-----

--FBBJgEOSAOerUJIT--
