Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F4C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC3721EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYMGI5Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3721EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeHIRRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:17:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40149 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIRRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:17:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so5398944wrs.7;
        Thu, 09 Aug 2018 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XLW2vKuc2chnpTM8c/b7eG9vjWV7PoDFfftW9RxBRyg=;
        b=FYMGI5OruisN3wumM3dgtDcpPL2iSe92Gy7rW0pCzcF+rZaBreOrHa2WRKmN1sLD4V
         MaPl4OHV8D8iuWZxl/5zuicR8FkYS7mqS/CWsc+bAUB+TSkZHDlzstTwuH/vWC4+QswP
         mwqRx0wQeYBC0yHX3ayypKDqPZqic4KZbOfQ3luN679f2NnW/5/Zrx0FHw8mDhQ+ZLMk
         d8i8o8zzInpYAZCz6tosvqkGGEBLD98LydTLcFhsLPZLlA11AaJ5u6cdO/Q/qwOtSdvg
         kgCH4+wVWOrbsTZK1Bb7+ElsgfnitiIADPttRJ343m3XTXNbnoD75/pvlwMUQwbjX0vB
         RbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLW2vKuc2chnpTM8c/b7eG9vjWV7PoDFfftW9RxBRyg=;
        b=iUzENruJ1rf/hHQMClpAZ9P/GHd6TM4LdX6cev8Xau8bwKhrQo2+ypAtTrciGgCS86
         FnkUBBMnujeL5eql8xtALwvzRdO2NQ09H1IAy/VJNTKsFgtinA1jYjDEC9uyLNQHjser
         Rqj82q8HdYDeIPRF8QOsPWTICxtohyriryJ0yZUvVMMZDUGBRHW4dMtfE5GmqHbTJVrp
         rYD0TTfmqy07+pqhhGGHtZFHPoKVn9NeN13v6aC3HlWh0wKQWggXIOrhpS3Ayn3vqP62
         P2+R+vT+uXAaUnhGYphCBS0FNQabowSXBh1QIW9ib+4eVPSC8Xot7EPARONlcZon0rKn
         9Fgg==
X-Gm-Message-State: AOUpUlHhBw6AUj+Q7dkrF+qTAj/votOcn99R6ffggOQ9AnIP3TBzZlbR
        q435/CgtPAGZRK3glE5KsVGlcq+d
X-Google-Smtp-Source: AA+uWPypFuAkx/MzrhVZM/Ftoznn5ONZXLT157aKVuwrtoZA9hr1H/nod5Mgcz1GYDozZWpTZ+1Ifw==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr1599152wrj.3.1533826328313;
        Thu, 09 Aug 2018 07:52:08 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id x23-v6sm4371129wmh.26.2018.08.09.07.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 07:52:07 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:52:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory
 Controller driver
Message-ID: <20180809145206.GA26588@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com>
 <16855111.9YhuyP46zb@dimapc>
 <20180809135924.GG21639@ulmo>
 <40363808.PZSQB5qk50@dimapc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <40363808.PZSQB5qk50@dimapc>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 05:22:59PM +0300, Dmitry Osipenko wrote:
> On Thursday, 9 August 2018 16:59:24 MSK Thierry Reding wrote:
> > On Thu, Aug 09, 2018 at 02:39:03PM +0300, Dmitry Osipenko wrote:
> > > On Thursday, 9 August 2018 14:17:46 MSK Thierry Reding wrote:
> > > > On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> > > > > GART contain registers needed by the Memory Controller driver, pr=
ovide
> > > > > access to the MC driver by utilizing its GART-integration facilit=
y.
> > > > >=20
> > > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > ---
> > > > >=20
> > > > >  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gar=
t.c
> > > > > index a004f6da35f2..f8b653e25914 100644
> > > > > --- a/drivers/iommu/tegra-gart.c
> > > > > +++ b/drivers/iommu/tegra-gart.c
> > > > > @@ -31,6 +31,8 @@
> > > > >=20
> > > > >  #include <linux/iommu.h>
> > > > >  #include <linux/of.h>
> > > > >=20
> > > > > +#include <soc/tegra/mc.h>
> > > > > +
> > > > >=20
> > > > >  #include <asm/cacheflush.h>
> > > > > =20
> > > > >  /* bitmap of the page sizes currently supported */
> > > > >=20
> > > > > @@ -41,6 +43,8 @@
> > > > >=20
> > > > >  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
> > > > >  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> > > > >  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> > > > >=20
> > > > > +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> > > > > +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> > > > >=20
> > > > >  #define GART_PAGE_SHIFT		12
> > > > >  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> > > > >=20
> > > > > @@ -63,6 +67,8 @@ struct gart_device {
> > > > >=20
> > > > >  	struct device		*dev;
> > > > >  =09
> > > > >  	struct iommu_device	iommu;		/* IOMMU Core handle */
> > > > >=20
> > > > > +
> > > > > +	struct tegra_mc_gart_handle mc_gart_handle;
> > > > >=20
> > > > >  };
> > > > > =20
> > > > >  struct gart_domain {
> > > > >=20
> > > > > @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *=
dev)
> > > > >=20
> > > > >  	return 0;
> > > > > =20
> > > > >  }
> > > > >=20
> > > > > +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *ha=
ndle)
> > > > > +{
> > > > > +	struct gart_device *gart =3D container_of(handle, struct=20
> gart_device,
> > > > > +						mc_gart_handle);
> > > > > +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> > > > > +}
> > > > > +
> > > > > +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *han=
dle)
> > > > > +{
> > > > > +	struct gart_device *gart =3D container_of(handle, struct=20
> gart_device,
> > > > > +						mc_gart_handle);
> > > > > +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> > > > > +}
> > > > > +
> > > > >=20
> > > > >  static int tegra_gart_probe(struct platform_device *pdev)
> > > > >  {
> > > > > =20
> > > > >  	struct gart_device *gart;
> > > > >=20
> > > > > @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_d=
evice
> > > > > *pdev)>
> > > > >=20
> > > > >  	gart->regs =3D gart_regs;
> > > > >  	gart->iovmm_base =3D (dma_addr_t)res_remap->start;
> > > > >  	gart->page_count =3D (resource_size(res_remap) >> GART_PAGE_SHI=
FT);
> > > > >=20
> > > > > +	gart->mc_gart_handle.error_addr =3D tegra_gart_error_addr;
> > > > > +	gart->mc_gart_handle.error_req =3D tegra_gart_error_req;
> > > > >=20
> > > > >  	gart->savedata =3D vmalloc(array_size(sizeof(u32), gart->page_c=
ount));
> > > > >  	if (!gart->savedata) {
> > > > >=20
> > > > > @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_d=
evice
> > > > > *pdev)>
> > > > >=20
> > > > >  	do_gart_setup(gart, NULL);
> > > > >  =09
> > > > >  	gart_handle =3D gart;
> > > > >=20
> > > > > +	tegra_mc_register_gart(&gart->mc_gart_handle);
> > > > >=20
> > > > >  	return 0;
> > > > > =20
> > > > >  }
> > > >=20
> > > > I see now why you've did it this way. We have separate devices unli=
ke
> > > > with SMMU where it is properly modeled as part of the memory contro=
ller.
> > > > I think we should consider breaking ABI at this point and properly =
merge
> > > > both the memory controller and GART nodes. There's really no reason=
 why
> > > > they should be separate and we're jumping through multiple hoops to=
 do
> > > > what we need to do just because a few years back we made a mistake.
> > > >=20
> > > > I know we're technically not supposed to break the DT ABI, but I th=
ink
> > > > in this particular case we can make a good case for it. The current=
 DT
> > > > bindings are plainly broken, and obviously so. Also, we don't curre=
ntly
> > > > use the GART upstream for anything, so we can't break any existing
> > > > systems either.
> > >=20
> > > IIUC, that will require to break the stable DT ABI of the tegra20-mc,
> > > which is working fine and does its job. I'm personally not seeing the
> > > slight lameness of the current DT as a good excuse to break the ABI.
> > > Let's then break DT ABI on all Tegra's and convert them all to genpd =
and
> > > other goodies like assigned clock parents and clock rate.
> >=20
> > genpd and assigned clocks are complementary, they can be switched to
> > without breaking ABI.
> >=20
> > And that's also different from the memory controller on Tegra20 where we
> > just made the mistake of describing what is effectively one device as
> > two separate devices. From what I can tell, the only reason this was
> > done was because it mapped better to the Linux driver model where there
> > is a framework to represent an IOMMU and a misunderstanding of how to
> > work with the driver model and device tree.
> >=20
> > As such, I would describe it as more of a bug in the DT that should be
> > fixed rather than breaking the ABI.
> >=20
> > And, like I said, we are in the somewhat fortunate situation that we
> > don't actively use the GART, at least in upstream, yet. So even if we
> > break ABI, nobody will notice anyway. Those are about as good pre-
> > conditions as you're going to get for fixing ABI.
>=20
> Please tell exactly what you're suggesting.
>=20
> Current DT:
>=20
> 	mc: memory-controller@7000f000 {
> 		compatible =3D "nvidia,tegra20-mc";
> 		reg =3D <0x7000f000 0x024
> 		       0x7000f03c 0x3c4>;
> 		interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> 		#reset-cells =3D <1>;
> 	};
>=20
> 	gart: iommu@7000f024 {
> 		compatible =3D "nvidia,tegra20-gart";
> 		reg =3D <0x7000f024 0x00000018	/* controller registers */
> 		       0x58000000 0x02000000>;	/* GART aperture */
> 		#iommu-cells =3D <0>;
> 	};
>=20
>=20
>=20
> Variant 1 (break MC ABI):
>=20
> 	mc: memory-controller@7000f000 {
> 		compatible =3D "nvidia,tegra20-mc";
> 		reg =3D <0x7000f000 0x400	/* controller registers */
> 		       0x58000000 0x02000000>;	/* GART aperture */
> 		interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> 		#reset-cells =3D <1>;
> 		#iommu-cells =3D <0>;
> 	};

This is the variant that I would prefer.

Thierry

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsVRMACgkQ3SOs138+
s6G9PQ//Y3E5j85+oFHvSXIFjwetn4hi+96fAJmEYhvdRpS5nklKbo3goOXB0793
4iIiQTi4a08YNDJoRPSw5hbbrg9YE7i0G7Gwm2XcUt9RmFSihJjtQI1+luisVZFl
MxuvI0cE82TRIOg5VQSlR7hmZ2g4ds7L8Qx2bL07Bvh/tYzZiThCIOHkFydZsNMY
iPiHT7V8iqr91q2q0gW+7BlnI25yqZg9CPQXIyYjmDk9Z41Ah1L0Yuw9kVi/lL1M
+yz6qVoFFXDsnBaLGWfLxlQrw8NKqpANUQZt/29f3j/HKnfG4UzCMNZ2ZNDXwWCf
BbF0gM97CajceEE9tm9ux+dAiJ/YaygSHUS6QJCuGLp8jF4Tjl+NlGmXWGzx/+6W
ZHyBBRmKdPb98Qu/ntSnR7WriQd0mXyog3sqEB8nnA/9ue1R7nb74jso1i/3nJit
bM/FLGZLkeYpej155/v5pEbs1SHvtNaNFTeOEgskMALWxrBpx+8o7SZ4at5Pvl8O
kTvV/0q3PjqCIjuxGdKkQ9Q3mMylAwl9auO4Tcf8BLGntp/RxVBAN9A1G0W23J1r
fTdkwLfkmO5Qm5orhUR4UM9MgF5lz/xptDk1YXoLHAQjQsk88xEJcJYqeeEf6Al7
HSBdfHUgYAcZR2t1qQPSY57iU1MQOIaQYQMOMsxu0AmhafQ6hNk=
=Qbpf
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
