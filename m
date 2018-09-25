Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF217C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893FF21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbNLssag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893FF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeIYQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:16:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44439 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIYQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:16:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so22695215wro.11;
        Tue, 25 Sep 2018 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KyZVbbNBwWhQAqZ0KtbHQC9RZxK3dSUHs6uk95Bl9SE=;
        b=GbNLssagqYADxRZ85mNhklWhOvKFwSKBgeL0wd5DrhNkTv0167HU5yNSI7Itf0FWFy
         fS33Hi2nsgELCqoq5FQH64LYCquXjSLksCVo8s5oVM89XQYRpPEA9bxF2Gy9uVpxPM1f
         5W4Ffcylaget0TA0dX23kCB0IqUC1cAOwYk02z5e+ffba+/c9R8ZzOSp2nM6KLURtTYw
         gIPEpwS8sTO1NGrz5iacOd3xaNSAfUYFRl7y89lyjH5k/2S/xWorqKYT+k40gr/WlqjW
         csCwmQrVlS7IsbCspeOfjCR4AVKbcxjYirGBX/T38GBGDkUMmB39BGt8QhCviwMD7eu+
         SJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KyZVbbNBwWhQAqZ0KtbHQC9RZxK3dSUHs6uk95Bl9SE=;
        b=IWsxreFuYA7euJcprgUkerjIQNAQRPNurhslmOT+ReqZXiFa47ujwUvlAy3oBAle4T
         l0wi/Gfuss0VODxf9ME0RjTcVdrrF8L3oVj3od0BTZmLa5mYzRh1xhLyYpYE2tK3h9hh
         NczXdHWyY5789kXczFHdIfNH7+qwcOqjCwN2Yg/DrmDvd2/tnXkF0xr/+nnr9pIUVh4I
         0tYQznusyRRLRSvvpjOLa9mFC/q5/l7WYGoCXBKrQP8gdGEV71Gtbg4gXdzQii0Ts5EM
         6sKgyrzBXovw7880CMT9wjNoddou1zpWZ72YCnszZvOyhMq+CVDzOFEVsWV8YLV61TEl
         /1mw==
X-Gm-Message-State: ABuFfojC+ZEoOtlkYnDCYC3OoCUq1CYSqx1HejMmZNoeUUyRQpACSGfP
        HA9yyXtDNKMNhdeIKDWOLBw=
X-Google-Smtp-Source: ACcGV61fe+I7h1p+CaZKdAU448dlO9p5KDQFWQ+jNEKvDezRuEURorunhpk5epCYkh31MqrlFWyioQ==
X-Received: by 2002:adf:91a4:: with SMTP id 33-v6mr263570wri.37.1537870150832;
        Tue, 25 Sep 2018 03:09:10 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id o12-v6sm1605189wrj.58.2018.09.25.03.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:09:10 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:09:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/20] iommu/tegra: gart: Simplify clients-tracking
 code
Message-ID: <20180925100909.GH7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-20-digetx@gmail.com>
 <20180924111047.GP21032@ulmo>
 <aefb6b78-4923-0259-0f3a-2ce3b95ca456@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <aefb6b78-4923-0259-0f3a-2ce3b95ca456@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 08:50:35PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 2:10 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:52AM +0300, Dmitry Osipenko wrote:
> >> GART is a simple IOMMU provider that has single address space. There is
> >> no need to setup global clients list and manage it for tracking of the
> >> active domain, hence lot's of code could be safely removed and replaced
> >> with a simpler alternative.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
> >>  1 file changed, 39 insertions(+), 118 deletions(-)
> >>
> >> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> >> index 306e9644a676..7182445c3b76 100644
> >> --- a/drivers/iommu/tegra-gart.c
> >> +++ b/drivers/iommu/tegra-gart.c
> >> @@ -19,7 +19,6 @@
> >> =20
> >>  #include <linux/io.h>
> >>  #include <linux/iommu.h>
> >> -#include <linux/list.h>
> >>  #include <linux/module.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/slab.h>
> >> @@ -42,30 +41,20 @@
> >>  #define GART_PAGE_MASK						\
> >>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
> >> =20
> >> -struct gart_client {
> >> -	struct device		*dev;
> >> -	struct list_head	list;
> >> -};
> >> -
> >>  struct gart_device {
> >>  	void __iomem		*regs;
> >>  	u32			*savedata;
> >>  	u32			page_count;	/* total remappable size */
> >>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
> >>  	spinlock_t		pte_lock;	/* for pagetable */
> >> -	struct list_head	client;
> >> -	spinlock_t		client_lock;	/* for client list */
> >> +	spinlock_t		dom_lock;	/* for active domain */
> >> +	unsigned int		active_devices;	/* number of active devices */
> >>  	struct iommu_domain	*active_domain;	/* current active domain */
> >>  	struct device		*dev;
> >> =20
> >>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> >>  };
> >> =20
> >> -struct gart_domain {
> >> -	struct iommu_domain domain;		/* generic domain handle */
> >> -	struct gart_device *gart;		/* link to gart device   */
> >> -};
> >> -
> >>  static struct gart_device *gart_handle; /* unique for a system */
> >> =20
> >>  static bool gart_debug;
> >> @@ -73,11 +62,6 @@ static bool gart_debug;
> >>  #define GART_PTE(_pfn)						\
> >>  	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
> >> =20
> >> -static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
> >> -{
> >> -	return container_of(dom, struct gart_domain, domain);
> >> -}
> >> -
> >>  /*
> >>   * Any interaction between any block on PPSB and a block on APB or AHB
> >>   * must have these read-back to ensure the APB/AHB bus transaction is
> >> @@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct=
 gart_device *gart,
> >>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
> >>  				 struct device *dev)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >>  	struct gart_device *gart =3D gart_handle;
> >> -	struct gart_client *client, *c;
> >> -	int err =3D 0;
> >> -
> >> -	client =3D kzalloc(sizeof(*c), GFP_KERNEL);
> >> -	if (!client)
> >> -		return -ENOMEM;
> >> -	client->dev =3D dev;
> >> -
> >> -	spin_lock(&gart->client_lock);
> >> -	list_for_each_entry(c, &gart->client, list) {
> >> -		if (c->dev =3D=3D dev) {
> >> -			dev_err(gart->dev, "GART: %s is already attached\n",
> >> -				dev_name(dev));
> >> -			err =3D -EINVAL;
> >> -			goto fail;
> >> -		}
> >> -	}
> >> -	if (gart->active_domain && gart->active_domain !=3D domain) {
> >> -		dev_err(gart->dev,
> >> -			"GART: Only one domain can be active at a time\n");
> >> -		err =3D -EINVAL;
> >> -		goto fail;
> >> -	}
> >> -	gart->active_domain =3D domain;
> >> -	gart_domain->gart =3D gart;
> >> -	list_add(&client->list, &gart->client);
> >> -	spin_unlock(&gart->client_lock);
> >> -	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
> >> -	return 0;
> >> +	int ret =3D 0;
> >> =20
> >> -fail:
> >> -	kfree(client);
> >> -	spin_unlock(&gart->client_lock);
> >> -	return err;
> >> -}
> >> +	spin_lock(&gart->dom_lock);
> >> =20
> >> -static void __gart_iommu_detach_dev(struct iommu_domain *domain,
> >> -				    struct device *dev)
> >> -{
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> -	struct gart_client *c;
> >> -
> >> -	list_for_each_entry(c, &gart->client, list) {
> >> -		if (c->dev =3D=3D dev) {
> >> -			list_del(&c->list);
> >> -			kfree(c);
> >> -			if (list_empty(&gart->client)) {
> >> -				gart->active_domain =3D NULL;
> >> -				gart_domain->gart =3D NULL;
> >> -			}
> >> -			dev_dbg(gart->dev, "GART: Detached %s\n",
> >> -				dev_name(dev));
> >> -			return;
> >> -		}
> >> +	if (gart->active_domain && gart->active_domain !=3D domain) {
> >> +		ret =3D -EBUSY;
> >=20
> > This omits the error message and returns -EBUSY instead of -EINVAL. Was
> > this intended? For what it's worth, I do agree with the changes, it's
> > just that I think you could've made those in the earlier patch that
> > introduced them.
>=20
> The message isn't really needed and EBUSY seems fit better than EINVAL he=
re.
>=20
> > But this is all one series and the end result looks fine, so no need to
> > be that picky.
>=20
> Good, thanks.
>=20
> >> +	} else if (dev->archdata.iommu !=3D domain) {
> >> +		dev->archdata.iommu =3D domain;
> >> +		gart->active_domain =3D domain;
> >> +		gart->active_devices++;
> >>  	}
> >> =20
> >> -	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
> >> -		dev_name(dev));
> >> +	spin_unlock(&gart->dom_lock);
> >> +
> >> +	return ret;
> >>  }
> >> =20
> >>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
> >>  				  struct device *dev)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> +	struct gart_device *gart =3D gart_handle;
> >> +
> >> +	spin_lock(&gart->dom_lock);
> >> =20
> >> -	spin_lock(&gart->client_lock);
> >> -	__gart_iommu_detach_dev(domain, dev);
> >> -	spin_unlock(&gart->client_lock);
> >> +	if (dev->archdata.iommu =3D=3D domain) {
> >> +		dev->archdata.iommu =3D NULL;
> >> +
> >> +		if (--gart->active_devices =3D=3D 0)
> >> +			gart->active_domain =3D NULL;
> >> +	}
> >> +
> >> +	spin_unlock(&gart->dom_lock);
> >>  }
> >> =20
> >>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
> >>  {
> >> -	struct gart_domain *gart_domain;
> >> -	struct gart_device *gart;
> >> +	struct gart_device *gart =3D gart_handle;
> >> +	struct iommu_domain *domain;
> >> =20
> >>  	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
> >>  		return NULL;
> >> =20
> >> -	gart =3D gart_handle;
> >> -	if (!gart)
> >> -		return NULL;
> >> -
> >> -	gart_domain =3D kzalloc(sizeof(*gart_domain), GFP_KERNEL);
> >> -	if (!gart_domain)
> >> -		return NULL;
> >> -
> >> -	gart_domain->domain.geometry.aperture_start =3D gart->iovmm_base;
> >> -	gart_domain->domain.geometry.aperture_end =3D gart->iovmm_base +
> >> +	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> >> +	if (domain) {
> >> +		domain->geometry.aperture_start =3D gart->iovmm_base;
> >> +		domain->geometry.aperture_end =3D gart->iovmm_base +
> >>  					gart->page_count * GART_PAGE_SIZE - 1;
> >> -	gart_domain->domain.geometry.force_aperture =3D true;
> >> +		domain->geometry.force_aperture =3D true;
> >> +	}
> >> =20
> >> -	return &gart_domain->domain;
> >> +	return domain;
> >>  }
> >> =20
> >>  static void gart_iommu_domain_free(struct iommu_domain *domain)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> -
> >> -	if (gart) {
> >> -		spin_lock(&gart->client_lock);
> >> -		if (!list_empty(&gart->client)) {
> >> -			struct gart_client *c, *tmp;
> >> -
> >> -			list_for_each_entry_safe(c, tmp, &gart->client, list)
> >> -				__gart_iommu_detach_dev(domain, c->dev);
> >> -		}
> >> -		spin_unlock(&gart->client_lock);
> >> -	}
> >> -
> >> -	kfree(gart_domain);
> >> +	kfree(domain);
> >>  }
> >=20
> > Doesn't this now make it possible to free a potentially active domain?
>=20
> Yes, don't do it. I can add a WARN_ON() here, though I think IOMMU core
> should be the one taking care about that.

Yeah, might be good to have the WARN_ON() either here or in the IOMMU
core. Force-detaching is probably a good idea, too, otherwise the users
of the freed domain are just going to crash anyway, right? Maybe
something to discuss more generally with Joerg.

I think in the meantime just having the WARN_ON() here is probably good
enough. It should point out the cases where we do free the domain with
devices still attached, which hopefully don't exist, and we can fix
them.

> >>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long =
iova,
> >>  			  phys_addr_t pa, size_t bytes, int prot)
> >>  {
> >> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> >> -	struct gart_device *gart =3D gart_domain->gart;
> >> +	struct gart_device *gart =3D gart_handle;
> >=20
> > Hmm... this now introduces more uses of the gart_handle that I hoped we
> > could get rid of. I think we could still keep around struct gart_domain
> > and just make sure it is unique. The small amounts of casting here seem
> > mostly harmless to me, especially since they will be nops, so we end up
> > with just one dereference to get at the struct gart_device. I think the
> > benefits of not having this global variable around are worth the one
> > dereference here.
>=20
> What are the benefits? I don't see anything other than the pedantic oddit=
y.
>=20
> I've removed gart_domain in the end because it is an extra code (and
> consumed resources) without any benefit. Let's keep that part as it is
> now. I'll be happy to change that code if you'll explain why it is worth
> it.

I thought I did explain. Anyway, it's always been like this, so no need
to change it as part of this series.

Thierry

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqCUUACgkQ3SOs138+
s6G/UQ/8Cq+keTTSr0rMlqLC763bG/Sn3T0KZZueywks0/aoZfeYxGRPirjdFr6S
E9FzVgtboWpm9x4PxcOdzItx+Q6GNgWLVTLacFBAEYbOTejEyMZZDrh0J3lo6qch
yCsNoyhoATwPoQEqZiusngtccszUGzfMwBaoax+NI9l54Cec7OXL8VDo/O01LYf+
S9ej8RAdN29XF88RhMK8QTFU8AM0ykG5CoQw1scVBF9h3KgS5dMUttQAbznvK3xH
TbVDSLbGhS6NNiB8YbrTkvq0fi2l1ftvJZikir46nFv6dYhKSSQ4PLAptIPASqNB
JiojoF5p0wqOQqEHHlNvXNC/pqIn6G+5nFAS1lMg9RyBhIG15QgGPzEPccGuLwEE
S2kk60e45V3MnkcRsdzVY2EMZ/knMXHs8Q1bcJmBDLkRhAnIFQsBiNKVOR5eeg28
YDO5i4PGLwZQjUTB8OUhyeaXURol6QQJ152NdJUD66YiSpKfWAFLHAml/LdOHPmv
V6qtQhECrJBRWtbJEPwnKyI77OyM80NU/z5lvrazInz0B90pSbS8FHBJYu37rC/3
r4FaREzk6tmY4tdo3H7hj30yoM+vrKBBreNr1iaBvKN4n70kq4yUps5LUAIRmFmS
dwLT5wkgjiUxStwzDp3IfQyIIH7hRx6NkYeEcPuHKXlMX8flqLQ=
=1iE+
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
