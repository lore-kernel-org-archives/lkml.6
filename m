Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A972081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s24PFElW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A972081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeLDVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:24:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44425 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeLDVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:24:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so7932083pgr.11;
        Tue, 04 Dec 2018 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BH+ws94NsWyacZhH6lo5REKr5MIOA8g7//6Dg8BbDjQ=;
        b=s24PFElWdWufbjvyPXmQ+9j3IND2RpiLLfjTLwOfrA0IHSs5qqkkO4oi10uSxorvQL
         OaHU+PpX/cAgQ6C+MLGiK3/xke7Fsxnd3j4dvO3nHzCaNKn+XCaINAmBy51XLXo+Anft
         55YziGhlj9e1L4uQcaGXAq8fn8cCWDUl5O+nZL0iuDOppN980d0jYKZkqFC8o4wK5PWm
         Ohere07P/sKo9tnU1LOQMbPhd1jiYZ5Bh+p1F5Yr+mLaNO0vgr/uBrVpvIDEY4NcICqM
         FYYnCBcnW4Nxr5xYvuVKpgD1cAD3zlGAliP+kvXODMqDJ6SuoMEt3XC0XBgqLFURn13Q
         m2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BH+ws94NsWyacZhH6lo5REKr5MIOA8g7//6Dg8BbDjQ=;
        b=Pe2f6/GSyT4yipsYkIGBQg151xh4/LeZepps2Gr6FvHHads0tow5KKlz7hjtAnP0aC
         DXuwTIvioQNdo03KsVGFOvqptzwW+digpoJxu8Bp5trnfaJBLREmSpzQjHHoghgkz1H9
         MVRktJUyms1bUSE5oweY5x2cTsi+gl/K52J0DxchHgPLdcMWZTkIaIYhr4Dri/J38XxX
         CgHTqH0ukGYz1oY98RzGsAtIwzHzC82gENQ6aS51rm22flpmKO4gAPKCIMig+rwi0he8
         KjJYYBqra74aVh1Lw3ET8L7Lve+CgmwSky5hxXvxDpkrXKcEcZWFCJJnDiR3Grp6cW3I
         fXFQ==
X-Gm-Message-State: AA+aEWZi+Dci3/0ERT36oF3CnZrXWzPD0LV1kUsPtynx1cT3txgQIruC
        7/QgQi4U3skLFw89RQCKpphNkI4wVsk9XopSNxs=
X-Google-Smtp-Source: AFSGD/VQrdT0hF27CHsurcPeXNvCR3D0UFuU2yLK9Q+ADiIbOA0ngbCP8ZEZnKds6S31WfFvcLx74D/sUq7dWINsvt8=
X-Received: by 2002:a63:9a09:: with SMTP id o9mr17446014pge.94.1543958687338;
 Tue, 04 Dec 2018 13:24:47 -0800 (PST)
MIME-Version: 1.0
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-13-git-send-email-loic.pallardy@st.com> <59fad1e3-11a2-939e-c47e-4351fb636e2d@ti.com>
 <c21433c8034a438d8d7c5044c181c2e0@SFHDAG7NODE2.st.com> <edff6a62-5b4c-433b-d824-51143b83ad93@ti.com>
 <CAA07jV8vmVF0rwYHK86dxe3=8fSEsm5wEcZZeC7ws=JdqW1VWg@mail.gmail.com>
 <b9f5941cd4014e3e82832b4b302ee422@SFHDAG7NODE2.st.com> <CAA07jV8StedBEStNURsRTNwk4jRS2LanV1tz-xXuf-5qVtuXwA@mail.gmail.com>
 <a984be5d411d4808a30551e420e84e2e@SFHDAG7NODE2.st.com>
In-Reply-To: <a984be5d411d4808a30551e420e84e2e@SFHDAG7NODE2.st.com>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Tue, 4 Dec 2018 13:24:36 -0800
Message-ID: <CAA07jV9EU3PO9Qgp8tSQ8d4EhZ8wFqbSSMWhzmqF2Es8mApP+w@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
 centralized carveout allocator
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnaud pouliquen <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:57 AM Loic PALLARDY <loic.pallardy@st.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Wendy Liang <sunnyliangjy@gmail.com>
> > Sent: mardi 4 d=C3=A9cembre 2018 19:58
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: Suman Anna <s-anna@ti.com>; Bjorn Andersson
> > <bjorn.andersson@linaro.org>; Ohad Ben-Cohen <ohad@wizery.com>;
> > linux-remoteproc@vger.kernel.org; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> > Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to re=
ly on
> > centralized carveout allocator
> >
> > On Tue, Dec 4, 2018 at 10:04 AM Loic PALLARDY <loic.pallardy@st.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wendy Liang <sunnyliangjy@gmail.com>
> > > > Sent: mardi 4 d=C3=A9cembre 2018 18:57
> > > > To: Suman Anna <s-anna@ti.com>
> > > > Cc: Loic PALLARDY <loic.pallardy@st.com>; Bjorn Andersson
> > > > <bjorn.andersson@linaro.org>; Ohad Ben-Cohen <ohad@wizery.com>;
> > > > linux-remoteproc@vger.kernel.org; Linux Kernel Mailing List <linux-
> > > > kernel@vger.kernel.org>; Arnaud POULIQUEN
> > <arnaud.pouliquen@st.com>;
> > > > Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > > Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation t=
o rely
> > on
> > > > centralized carveout allocator
> > > >
> > > > On Mon, Oct 29, 2018 at 1:19 PM Suman Anna <s-anna@ti.com> wrote:
> > > > >
> > > > > Hi Loic,
> > > > >
> > > > > On 10/24/18 10:14 AM, Loic PALLARDY wrote:
> > > > > > Hi Suman,
> > > > > >
> > > > > >> -----Original Message-----
> > > > > >> From: Suman Anna <s-anna@ti.com>
> > > > > >> Sent: mercredi 24 octobre 2018 02:14
> > > > > >> To: Loic PALLARDY <loic.pallardy@st.com>;
> > bjorn.andersson@linaro.org;
> > > > > >> ohad@wizery.com
> > > > > >> Cc: linux-remoteproc@vger.kernel.org; linux-
> > kernel@vger.kernel.org;
> > > > > >> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> > > > > >> benjamin.gaignard@linaro.org
> > > > > >> Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocat=
ion to
> > > > rely on
> > > > > >> centralized carveout allocator
> > > > > >>
> > > > > >> On 7/27/18 8:14 AM, Loic Pallardy wrote:
> > > > > >>> Current version of rproc_alloc_vring function supports only
> > dynamic
> > > > vring
> > > > > >>> allocation.
> > > > > >>>
> > > > > >>> This patch allows to allocate vrings based on memory region
> > > > declatation.
> > > > > >>> Vrings are now manage like memory carveouts, to communize
> > > > memory
> > > > > >> management
> > > > > >>> code in rproc_alloc_registered_carveouts().
> > > > > >>>
> > > > > >>> Allocated buffer is retrieved in rp_find_vq() thanks to
> > > > > >>> rproc_find_carveout_by_name() functions for.
> > > > > >>>
> > > > > >>> This patch sets vrings names to vdev"x"vring"y" with x vdev i=
ndex
> > in
> > > > > >>> resource table and y vring index in vdev. This will be update=
d when
> > > > > >>> name will be associated to vdev in firmware resource table.
> > > > > >>>
> > > > > >>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > > > > >>> ---
> > > > > >>>  drivers/remoteproc/remoteproc_core.c     | 61
> > +++++++++++++++++-
> > > > -----
> > > > > >> ---------
> > > > > >>>  drivers/remoteproc/remoteproc_internal.h |  2 ++
> > > > > >>>  drivers/remoteproc/remoteproc_virtio.c   | 14 +++++++-
> > > > > >>>  include/linux/remoteproc.h               |  6 ++--
> > > > > >>>  4 files changed, 51 insertions(+), 32 deletions(-)
> > > > > >>>
> > > > > >>> diff --git a/drivers/remoteproc/remoteproc_core.c
> > > > > >> b/drivers/remoteproc/remoteproc_core.c
> > > > > >>> index c543d04..4edc6f0 100644
> > > > > >>> --- a/drivers/remoteproc/remoteproc_core.c
> > > > > >>> +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > >>> @@ -53,6 +53,11 @@ typedef int
> > (*rproc_handle_resources_t)(struct
> > > > > >> rproc *rproc,
> > > > > >>>  typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
> > > > > >>>                              void *, int offset, int avail);
> > > > > >>>
> > > > > >>> +static int rproc_alloc_carveout(struct rproc *rproc,
> > > > > >>> +                           struct rproc_mem_entry *mem);
> > > > > >>> +static int rproc_release_carveout(struct rproc *rproc,
> > > > > >>> +                             struct rproc_mem_entry *mem);
> > > > > >>> +
> > > > > >>>  /* Unique indices for remoteproc devices */
> > > > > >>>  static DEFINE_IDA(rproc_dev_index);
> > > > > >>>
> > > > > >>> @@ -312,21 +317,33 @@ int rproc_alloc_vring(struct rproc_vdev
> > > > *rvdev,
> > > > > >> int i)
> > > > > >>>     struct device *dev =3D &rproc->dev;
> > > > > >>>     struct rproc_vring *rvring =3D &rvdev->vring[i];
> > > > > >>>     struct fw_rsc_vdev *rsc;
> > > > > >>> -   dma_addr_t dma;
> > > > > >>> -   void *va;
> > > > > >>>     int ret, size, notifyid;
> > > > > >>> +   struct rproc_mem_entry *mem;
> > > > > >>>
> > > > > >>>     /* actual size of vring (in bytes) */
> > > > > >>>     size =3D PAGE_ALIGN(vring_size(rvring->len, rvring->align=
));
> > > > > >>>
> > > > > >>> -   /*
> > > > > >>> -    * Allocate non-cacheable memory for the vring. In the fu=
ture
> > > > > >>> -    * this call will also configure the IOMMU for us
> > > > > >>> -    */
> > > > > >>> -   va =3D dma_alloc_coherent(dev->parent, size, &dma,
> > GFP_KERNEL);
> > > > > >>> -   if (!va) {
> > > > > >>> -           dev_err(dev->parent, "dma_alloc_coherent failed\n=
");
> > > > > >>> -           return -EINVAL;
> > > > > >>> +   rsc =3D (void *)rproc->table_ptr + rvdev->rsc_offset;
> > > > > >>> +
> > > > > >>> +   /* Search for pre-registered carveout */
> > > > > >>> +   mem =3D rproc_find_carveout_by_name(rproc,
> > "vdev%dvring%d",
> > > > > >> rvdev->index,
> > > > > >>> +                                     i);
> > > > > >>> +   if (mem) {
> > > > > >>> +           if (rproc_check_carveout_da(rproc, mem, rsc->vrin=
g[i].da,
> > > > > >> size))
> > > > > >>> +                   return -ENOMEM;
> > > > > >>> +   } else {
> > > > > >>> +           /* Register carveout in in list */
> > > > > >>> +           mem =3D rproc_mem_entry_init(dev, 0, 0, size, rsc=
-
> > > > > >>> vring[i].da,
> > > > > >>> +                                      rproc_alloc_carveout,
> > > > > >>> +                                      rproc_release_carveout=
,
> > > > > >>> +                                      "vdev%dvring%d",
> > > > > >>> +                                      rvdev->index, i);
> > > > > >>> +           if (!mem) {
> > > > > >>> +                   dev_err(dev, "Can't allocate memory entry
> > > > > >> structure\n");
> > > > > >>> +                   return -ENOMEM;
> > > > > >>> +           }
> > > > > >>> +
> > > > > >>> +           rproc_add_carveout(rproc, mem);
> > > > > >>>     }
> > > > > >>>
> > > > > >>>     /*
> > > > > >>> @@ -337,7 +354,6 @@ int rproc_alloc_vring(struct rproc_vdev
> > *rvdev,
> > > > int i)
> > > > > >>>     ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KE=
RNEL);
> > > > > >>>     if (ret < 0) {
> > > > > >>>             dev_err(dev, "idr_alloc failed: %d\n", ret);
> > > > > >>> -           dma_free_coherent(dev->parent, size, va, dma);
> > > > > >>>             return ret;
> > > > > >>>     }
> > > > > >>>     notifyid =3D ret;
> > > > > >>> @@ -346,21 +362,9 @@ int rproc_alloc_vring(struct rproc_vdev
> > > > *rvdev, int
> > > > > >> i)
> > > > > >>>     if (notifyid > rproc->max_notifyid)
> > > > > >>>             rproc->max_notifyid =3D notifyid;
> > > > > >>>
> > > > > >>> -   dev_dbg(dev, "vring%d: va %pK dma %pad size 0x%x idr %d\n=
",
> > > > > >>> -           i, va, &dma, size, notifyid);
> > > > > >>> -
> > > > > >>> -   rvring->va =3D va;
> > > > > >>> -   rvring->dma =3D dma;
> > > > > >>>     rvring->notifyid =3D notifyid;
> > > > > >>>
> > > > > >>> -   /*
> > > > > >>> -    * Let the rproc know the notifyid and da of this vring.
> > > > > >>> -    * Not all platforms use dma_alloc_coherent to automatica=
lly
> > > > > >>> -    * set up the iommu. In this case the device address (da)=
 will
> > > > > >>> -    * hold the physical address and not the device address.
> > > > > >>> -    */
> > > > > >>> -   rsc =3D (void *)rproc->table_ptr + rvdev->rsc_offset;
> > > > > >>> -   rsc->vring[i].da =3D dma;
> > > > > >>> +   /* Let the rproc know the notifyid of this vring.*/
> > > > > >>>     rsc->vring[i].notifyid =3D notifyid;
> > > > > >>>     return 0;
> > > > > >>>  }
> > > > > >>> @@ -392,12 +396,10 @@ int rproc_alloc_vring(struct rproc_vdev
> > > > *rvdev,
> > > > > >> int i)
> > > > > >>>
> > > > > >>>  void rproc_free_vring(struct rproc_vring *rvring)
> > > > > >>>  {
> > > > > >>> -   int size =3D PAGE_ALIGN(vring_size(rvring->len, rvring->a=
lign));
> > > > > >>>     struct rproc *rproc =3D rvring->rvdev->rproc;
> > > > > >>>     int idx =3D rvring->rvdev->vring - rvring;
> > > > > >>>     struct fw_rsc_vdev *rsc;
> > > > > >>>
> > > > > >>> -   dma_free_coherent(rproc->dev.parent, size, rvring->va, rv=
ring-
> > > > > >>> dma);
> > > > > >>>     idr_remove(&rproc->notifyids, rvring->notifyid);
> > > > > >>
> > > > > >> Also, I am not sure if FW_RSC_ADDR_ANY semantics were enforced
> > > > > >> previously on the vring da. It was simply overwritten irrespec=
tive of
> > > > > >> the value. Now, I am running again into the "bad carveout rsc
> > > > > >> configuration value" due to the iommu_domain_check if
> > > > > >> !FW_RSC_ADDR_ANY.
> > > > > >
> > > > >
> > > > > Just realized that I missed responding on this thread last week.
> > > > >
> > > > > > When are you running into the "bad carveout rsc configuration v=
alue"
> > ?
> > > > > > This patch is creating one carveout per vring to rely on generi=
c
> > carveout
> > > > allocator.
> > > > > > Then carveout is retrieved from carveout  list and vring resour=
ce table
> > > > information updated.
> > > > > >
> > > > > > If the da of the carveout was fixed in the resource table, it i=
s normal
> > you
> > > > have this error.
> > > > >
> > > > > Yes, and if the vring da value is FW_RSC_ADDR_ANY, then I don't r=
un
> > into
> > > > > this particular error. It's just that the semantics of vring da i=
s open
> > > > > previously, and my above comment being 0 was being used as a rese=
t
> > value
> > > > > as well.
> > > > >
> > > > > > To solve that ST driver is registering one fixed carveout per v=
ring (with
> > the
> > > > right name today)
> > > > >
> > > > > Yeah, we still expect to allocate these dynamically, so there won=
't be
> > > > > any registration needed.
> > > > >
> > > > > > It is the same discussion as with Patch 1.
> > > > >
> > > > > Right, except that we have a da from RSC_CARVEOUT and a da from
> > vring,
> > > > > and the previous code had some slight differences between the two=
.
> > The
> > > > > vring da semantics were never set before (value was always being
> > > > > overwritten, also it didn't have a pa field), whereas the remotep=
roc.h
> > > > > documentation did mention about FW_RSC_ADDR_ANY (without any
> > > > backing
> > > > > implementation previously) for the RSC_CARVEOUT da, with the entr=
y
> > also
> > > > > having a field for pa.
> > > > >
> > > > > If we consider we can't change fixed coprocessor address requests=
,
> > rproc
> > > > > core should stop its execution.
> > > > > > It is the responsibility of platform driver to register the rig=
ht memory
> > > > regions.
> > > > > > That's what we discussed with you and Bill in OpenAMP forum.
> > > > > > TI usecase was to have the same DSP firmware with the same
> > resource
> > > > table being able to run on any DSP.
> > > > >
> > > > > Yeah, it only covers one of the usecases/platforms (Keystone 2 DS=
P
> > > > > platforms). And this only worked on these platforms so far becaus=
e we
> > > > > only were using internal memories - so there were no RSC_CARVEOUT
> > > > > entries with valid da. Our Davinci DSP is a single instance and w=
e do
> > > > > have a RSC_CARVEOUT there, which fails due to the same Patch 1 lo=
gic
> > > > > here as well.
> > > > >
> > > > > > In that case each DSP platform driver has to provide the right =
memory
> > > > region configuration with the correct pa to da.
> > > > > >
> > > > > >>
> > > > > >> FWIW, the rproc_free_vring was actually using the value 0 when
> > > > resetting.
> > > > > >
> > > > > > It is no more needed as the carveout list is cleared at each st=
op and
> > > > recreated at each start.
> > > > > > Moreover resource table (and firmware) is reloaded at each
> > coprocessor
> > > > start.
> > > > >
> > > > > Yes, agreed. This is about the semantics of vring da from before =
(no
> > > > > enforcement to strict enforcement of FW_RSC_ADDR_ANY). The
> > > > overwriting
> > > > > on da field on vrings with the dma address is actually a mistake,=
 which
> > > > > we are trying to proliferate more now. It all comes down to the f=
act of
> > > > > treating da as dma address when it is not going to be the case on=
 all
> > > > > remoteprocs.
> > > > [Wendy] Are we assuming that the vring da is always predefined.
> > > > But in the Linux kernel side, without IOMMU case, we use
> > > > dma_alloc_coherent() to
> > > > allocate for vring address. In this case, there is no gurantee the
> > > > allocated vrings
> > > > address matches the predefined value.
> > > > Or we assume that only vdev devices of the remoteproc can use
> > > > dma_alloc_coherent()
> > > > but not subdevices?
> > > > Or we can still store the rsc table da pointer. And instead of alwa=
ys
> > > > set da with dma address
> > > > we can pass the dma address to remoteproc and let remoteproc to do
> > the
> > > > pa to da conversion if
> > > > required.
> > >
> > > Hi Wendy,
> > > I pushed a correction patch which check dma address with requested da
> > from resource table.
> > > If no match, a warning is display, but the sequence is not stopped as
> > requested by Suman.
> > > I have a next patch which is adding a rproc_pa_to_da() platform
> > dependent function to concert a pa in da understandable by rproc firmwa=
re.
> > > The goal is to answer Suman request, that some rproc can configure an
> > offset in HW to access part of the DRR or an memory.
> > > On another side, I'm looking how to do the same with the carveout
> > registration functions...
> > HI Loic,
> >
> > I agreed that carveout registration functions should allow ANY_ADDRESS
> > for no IOMMU case.
> > In my case, the openamp remoteproc virtio assumes that when the app is
> > running, it assumes the da are all set by master, but the latest
> > upstream delayed the vring da setting
> > when it tries to create the vq, it looks, it looks like the remote
> > should not even start to checking vdev configs until the master set
> > the status to DRIVER_OK.
>
> Yes that's an old discussion I had with Bjorn, when he introduced sub dev=
. Rpmsg buffer are allocated after rproc start.
> But we agree on the fact master and slave initialization can be fixed and=
 slave should use synchronization flags like
> virtio kick or vdev status before accessing configuration. New implementa=
tion is respecting same rule.
> About this issue, I know Arnaud has done a development on OpenAMP side to=
 wait vdev status OK before reading vring da.
Maybe that's virtio without remoteproc implementation, the remoteproc
virtio implementation in OpenAMP assumes
the vring da is already set by master when the application starts.
I am changing the remoteproc virtio backend in OpenAMP not to get the
vring da until status is OK.

Best Regards,
Wendy

>
> Regards,
> Loic
> >
> > Best Regards,
> > Wendy
> > >
> > > Regards,
> > > Loic
> > >
> > >
> > > >
> > > > Thanks,
> > > > Wendy
> > > > >
> > > > > regards
> > > > > Suman
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Loic
> > > > > >>
> > > > > >> regards
> > > > > >> Suman
> > > > > >>
> > > > > >>>
> > > > > >>>     /* reset resource entry info */
> > > > > >>> @@ -484,6 +486,7 @@ static int rproc_handle_vdev(struct rproc
> > > > *rproc,
> > > > > >> struct fw_rsc_vdev *rsc,
> > > > > >>>
> > > > > >>>     rvdev->id =3D rsc->id;
> > > > > >>>     rvdev->rproc =3D rproc;
> > > > > >>> +   rvdev->index =3D rproc->nb_vdev++;
> > > > > >>>
> > > > > >>>     /* parse the vrings */
> > > > > >>>     for (i =3D 0; i < rsc->num_of_vrings; i++) {
> > > > > >>> @@ -528,9 +531,6 @@ void rproc_vdev_release(struct kref *ref)
> > > > > >>>
> > > > > >>>     for (id =3D 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> > > > > >>>             rvring =3D &rvdev->vring[id];
> > > > > >>> -           if (!rvring->va)
> > > > > >>> -                   continue;
> > > > > >>> -
> > > > > >>>             rproc_free_vring(rvring);
> > > > > >>>     }
> > > > > >>>
> > > > > >>> @@ -1322,6 +1322,9 @@ static int rproc_fw_boot(struct rproc
> > *rproc,
> > > > > >> const struct firmware *fw)
> > > > > >>>     /* reset max_notifyid */
> > > > > >>>     rproc->max_notifyid =3D -1;
> > > > > >>>
> > > > > >>> +   /* reset handled vdev */
> > > > > >>> +   rproc->nb_vdev =3D 0;
> > > > > >>> +
> > > > > >>>     /* handle fw resources which are required to boot rproc *=
/
> > > > > >>>     ret =3D rproc_handle_resources(rproc, rproc_loading_handl=
ers);
> > > > > >>>     if (ret) {
> > > > > >>> diff --git a/drivers/remoteproc/remoteproc_internal.h
> > > > > >> b/drivers/remoteproc/remoteproc_internal.h
> > > > > >>> index 7570beb..f6cad24 100644
> > > > > >>> --- a/drivers/remoteproc/remoteproc_internal.h
> > > > > >>> +++ b/drivers/remoteproc/remoteproc_internal.h
> > > > > >>> @@ -60,6 +60,8 @@ struct dentry *rproc_create_trace_file(cons=
t
> > char
> > > > > >> *name, struct rproc *rproc,
> > > > > >>>  int rproc_elf_load_rsc_table(struct rproc *rproc, const stru=
ct
> > firmware
> > > > > >> *fw);
> > > > > >>>  struct resource_table *rproc_elf_find_loaded_rsc_table(struc=
t
> > rproc
> > > > > >> *rproc,
> > > > > >>>                                                    const stru=
ct firmware
> > > > > >> *fw);
> > > > > >>> +struct rproc_mem_entry *
> > > > > >>> +rproc_find_carveout_by_name(struct rproc *rproc, const char
> > > > *name,
> > > > > >> ...);
> > > > > >>>
> > > > > >>>  static inline
> > > > > >>>  int rproc_fw_sanity_check(struct rproc *rproc, const struct
> > firmware
> > > > *fw)
> > > > > >>> diff --git a/drivers/remoteproc/remoteproc_virtio.c
> > > > > >> b/drivers/remoteproc/remoteproc_virtio.c
> > > > > >>> index bbecd44..de21f62 100644
> > > > > >>> --- a/drivers/remoteproc/remoteproc_virtio.c
> > > > > >>> +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > > > >>> @@ -76,7 +76,9 @@ static struct virtqueue *rp_find_vq(struct
> > > > > >> virtio_device *vdev,
> > > > > >>>     struct rproc_vdev *rvdev =3D vdev_to_rvdev(vdev);
> > > > > >>>     struct rproc *rproc =3D vdev_to_rproc(vdev);
> > > > > >>>     struct device *dev =3D &rproc->dev;
> > > > > >>> +   struct rproc_mem_entry *mem;
> > > > > >>>     struct rproc_vring *rvring;
> > > > > >>> +   struct fw_rsc_vdev *rsc;
> > > > > >>>     struct virtqueue *vq;
> > > > > >>>     void *addr;
> > > > > >>>     int len, size;
> > > > > >>> @@ -88,8 +90,14 @@ static struct virtqueue *rp_find_vq(struct
> > > > > >> virtio_device *vdev,
> > > > > >>>     if (!name)
> > > > > >>>             return NULL;
> > > > > >>>
> > > > > >>> +   /* Search allocated memory region by name */
> > > > > >>> +   mem =3D rproc_find_carveout_by_name(rproc,
> > "vdev%dvring%d",
> > > > > >> rvdev->index,
> > > > > >>> +                                     id);
> > > > > >>> +   if (!mem || !mem->va)
> > > > > >>> +           return ERR_PTR(-ENOMEM);
> > > > > >>> +
> > > > > >>>     rvring =3D &rvdev->vring[id];
> > > > > >>> -   addr =3D rvring->va;
> > > > > >>> +   addr =3D mem->va;
> > > > > >>>     len =3D rvring->len;
> > > > > >>>
> > > > > >>>     /* zero vring */
> > > > > >>> @@ -114,6 +122,10 @@ static struct virtqueue *rp_find_vq(stru=
ct
> > > > > >> virtio_device *vdev,
> > > > > >>>     rvring->vq =3D vq;
> > > > > >>>     vq->priv =3D rvring;
> > > > > >>>
> > > > > >>> +   /* Update vring in resource table */
> > > > > >>> +   rsc =3D (void *)rproc->table_ptr + rvdev->rsc_offset;
> > > > > >>> +   rsc->vring[id].da =3D mem->da;
> > > > > >>> +
> > > > > >>>     return vq;
> > > > > >>>  }
> > > > > >>>
> > > > > >>> diff --git a/include/linux/remoteproc.h
> > b/include/linux/remoteproc.h
> > > > > >>> index 4cdd0c6..6b3a234 100644
> > > > > >>> --- a/include/linux/remoteproc.h
> > > > > >>> +++ b/include/linux/remoteproc.h
> > > > > >>> @@ -453,6 +453,7 @@ struct rproc_dump_segment {
> > > > > >>>   * @table_sz: size of @cached_table
> > > > > >>>   * @has_iommu: flag to indicate if remote processor is behin=
d an
> > > > MMU
> > > > > >>>   * @dump_segments: list of segments in the firmware
> > > > > >>> + * @nb_vdev: number of vdev currently handled by rproc
> > > > > >>>   */
> > > > > >>>  struct rproc {
> > > > > >>>     struct list_head node;
> > > > > >>> @@ -485,6 +486,7 @@ struct rproc {
> > > > > >>>     bool has_iommu;
> > > > > >>>     bool auto_boot;
> > > > > >>>     struct list_head dump_segments;
> > > > > >>> +   int nb_vdev;
> > > > > >>>  };
> > > > > >>>
> > > > > >>>  /**
> > > > > >>> @@ -512,7 +514,6 @@ struct rproc_subdev {
> > > > > >>>  /**
> > > > > >>>   * struct rproc_vring - remoteproc vring state
> > > > > >>>   * @va:    virtual address
> > > > > >>> - * @dma: dma address
> > > > > >>>   * @len: length, in bytes
> > > > > >>>   * @da: device address
> > > > > >>>   * @align: vring alignment
> > > > > >>> @@ -522,7 +523,6 @@ struct rproc_subdev {
> > > > > >>>   */
> > > > > >>>  struct rproc_vring {
> > > > > >>>     void *va;
> > > > > >>> -   dma_addr_t dma;
> > > > > >>>     int len;
> > > > > >>>     u32 da;
> > > > > >>>     u32 align;
> > > > > >>> @@ -541,6 +541,7 @@ struct rproc_vring {
> > > > > >>>   * @vdev: the virio device
> > > > > >>>   * @vring: the vrings for this vdev
> > > > > >>>   * @rsc_offset: offset of the vdev's resource entry
> > > > > >>> + * @index: vdev position versus other vdev declared in resou=
rce
> > table
> > > > > >>>   */
> > > > > >>>  struct rproc_vdev {
> > > > > >>>     struct kref refcount;
> > > > > >>> @@ -553,6 +554,7 @@ struct rproc_vdev {
> > > > > >>>     struct virtio_device vdev;
> > > > > >>>     struct rproc_vring vring[RVDEV_NUM_VRINGS];
> > > > > >>>     u32 rsc_offset;
> > > > > >>> +   u32 index;
> > > > > >>>  };
> > > > > >>>
> > > > > >>>  struct rproc *rproc_get_by_phandle(phandle phandle);
> > > > > >>>
> > > > > >
> > > > >
