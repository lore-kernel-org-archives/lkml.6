Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6962082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6962082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJKClb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:41:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13296 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbeJKClb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:41:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9AJ9JVT026312;
        Wed, 10 Oct 2018 21:17:54 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n0se6rrm5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Oct 2018 21:17:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C70531;
        Wed, 10 Oct 2018 19:17:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB195A664;
        Wed, 10 Oct 2018 19:17:52 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Oct
 2018 21:17:52 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 10 Oct 2018 21:17:52 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH v4 13/17] remoteproc: create vdev subdevice with specific
 dma memory pool
Thread-Topic: [PATCH v4 13/17] remoteproc: create vdev subdevice with specific
 dma memory pool
Thread-Index: AQHUJavkF36KvkhroUKheT26RJQNr6UYT6KAgAD+0pA=
Date:   Wed, 10 Oct 2018 19:17:52 +0000
Message-ID: <54cd805121f34c15a64e283bf93e5737@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-14-git-send-email-loic.pallardy@st.com>
 <20181010055823.GB20016@builder>
In-Reply-To: <20181010055823.GB20016@builder>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
> Sent: mercredi 10 octobre 2018 07:58
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org; s-anna@ti.com
> Subject: Re: [PATCH v4 13/17] remoteproc: create vdev subdevice with
> specific dma memory pool
> 
> On Fri 27 Jul 06:14 PDT 2018, Loic Pallardy wrote:
> 
> > This patch creates a dedicated vdev subdevice for each vdev declared
> > in firmware resource table and associates carveout named "vdev%dbuffer"
> > (with %d vdev index in resource table) if any as dma coherent memory
> pool.
> >
> > Then vdev subdevice is used as parent for virtio device.
> >
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 35
> +++++++++++++++++++++++---
> >  drivers/remoteproc/remoteproc_internal.h |  1 +
> >  drivers/remoteproc/remoteproc_virtio.c   | 42
> +++++++++++++++++++++++++++++++-
> >  include/linux/remoteproc.h               |  1 +
> >  4 files changed, 75 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 4edc6f0..adcc66e 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/elf.h>
> >  #include <linux/crc32.h>
> > +#include <linux/of_reserved_mem.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_ring.h>
> >  #include <asm/byteorder.h>
> > @@ -145,7 +146,7 @@ static void rproc_disable_iommu(struct rproc
> *rproc)
> >  	iommu_domain_free(domain);
> >  }
> >
> > -static phys_addr_t rproc_va_to_pa(void *cpu_addr)
> > +phys_addr_t rproc_va_to_pa(void *cpu_addr)
> >  {
> >  	/*
> >  	 * Return physical address according to virtual address location
> > @@ -160,6 +161,7 @@ static phys_addr_t rproc_va_to_pa(void
> *cpu_addr)
> >  	WARN_ON(!virt_addr_valid(cpu_addr));
> >  	return virt_to_phys(cpu_addr);
> >  }
> > +EXPORT_SYMBOL(rproc_va_to_pa);
> >
> >  /**
> >   * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc
> address
> > @@ -423,6 +425,20 @@ static void rproc_vdev_do_stop(struct
> rproc_subdev *subdev, bool crashed)
> >  }
> >
> >  /**
> > + * rproc_rvdev_release() - release the existence of a rvdev
> > + *
> > + * @dev: the subdevice's dev
> > + */
> > +static void rproc_rvdev_release(struct device *dev)
> > +{
> > +	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev,
> dev);
> > +
> > +	of_reserved_mem_device_release(dev);
> > +
> > +	kfree(rvdev);
> > +}
> > +
> > +/**
> >   * rproc_handle_vdev() - handle a vdev fw resource
> >   * @rproc: the remote processor
> >   * @rsc: the vring resource descriptor
> > @@ -455,6 +471,7 @@ static int rproc_handle_vdev(struct rproc *rproc,
> struct fw_rsc_vdev *rsc,
> >  	struct device *dev = &rproc->dev;
> >  	struct rproc_vdev *rvdev;
> >  	int i, ret;
> > +	char name[16];
> >
> >  	/* make sure resource isn't truncated */
> >  	if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct
> fw_rsc_vdev_vring)
> > @@ -488,6 +505,18 @@ static int rproc_handle_vdev(struct rproc *rproc,
> struct fw_rsc_vdev *rsc,
> >  	rvdev->rproc = rproc;
> >  	rvdev->index = rproc->nb_vdev++;
> >
> > +	/* Initialise vdev subdevice */
> > +	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> > +	rvdev->dev.parent = rproc->dev.parent;
> > +	rvdev->dev.release = rproc_rvdev_release;
> > +	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev-
> >dev.parent), name);
> > +	dev_set_drvdata(&rvdev->dev, rvdev);
> > +	dma_set_coherent_mask(&rvdev->dev, DMA_BIT_MASK(32));
> > +
> > +	ret = device_register(&rvdev->dev);
> > +	if (ret)
> > +		goto free_rvdev;
> > +
> >  	/* parse the vrings */
> >  	for (i = 0; i < rsc->num_of_vrings; i++) {
> >  		ret = rproc_parse_vring(rvdev, rsc, i);
> > @@ -518,7 +547,7 @@ static int rproc_handle_vdev(struct rproc *rproc,
> struct fw_rsc_vdev *rsc,
> >  	for (i--; i >= 0; i--)
> >  		rproc_free_vring(&rvdev->vring[i]);
> >  free_rvdev:
> > -	kfree(rvdev);
> > +	device_unregister(&rvdev->dev);
> >  	return ret;
> >  }
> >
> > @@ -536,7 +565,7 @@ void rproc_vdev_release(struct kref *ref)
> >
> >  	rproc_remove_subdev(rproc, &rvdev->subdev);
> >  	list_del(&rvdev->node);
> > -	kfree(rvdev);
> > +	device_unregister(&rvdev->dev);
> >  }
> >
> >  /**
> > diff --git a/drivers/remoteproc/remoteproc_internal.h
> b/drivers/remoteproc/remoteproc_internal.h
> > index f6cad24..bfeacfd 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -52,6 +52,7 @@ struct dentry *rproc_create_trace_file(const char
> *name, struct rproc *rproc,
> >  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> >
> >  void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
> > +phys_addr_t rproc_va_to_pa(void *cpu_addr);
> >  int rproc_trigger_recovery(struct rproc *rproc);
> >
> >  int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> b/drivers/remoteproc/remoteproc_virtio.c
> > index de21f62..9ee63c0 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -17,7 +17,9 @@
> >   * GNU General Public License for more details.
> >   */
> >
> > +#include <linux/dma-mapping.h>
> >  #include <linux/export.h>
> > +#include <linux/of_reserved_mem.h>
> >  #include <linux/remoteproc.h>
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_config.h>
> > @@ -315,10 +317,48 @@ static void rproc_virtio_dev_release(struct device
> *dev)
> >  int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> >  {
> >  	struct rproc *rproc = rvdev->rproc;
> > -	struct device *dev = &rproc->dev;
> > +	struct device *dev = &rvdev->dev;
> >  	struct virtio_device *vdev = &rvdev->vdev;
> > +	struct rproc_mem_entry *mem;
> >  	int ret;
> >
> > +	/* Try to find dedicated vdev buffer carveout */
> > +	mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer",
> rvdev->index);
> > +	if (mem) {
> > +		phys_addr_t pa;
> > +
> > +		if (mem->of_resm_idx != -1) {
> > +			struct device_node *np = rproc->dev.parent-
> >of_node;
> > +
> > +			/* Associate reserved memory to vdev device */
> > +			ret = of_reserved_mem_device_init_by_idx(dev, np,
> > +								 mem-
> >of_resm_idx);
> > +			if (ret) {
> > +				dev_err(dev, "Can't associate reserved
> memory\n");
> > +				goto out;
> > +			}
> > +		} else {
> > +			if (mem->va) {
> > +				dev_warn(dev, "vdev %d buffer already
> mapped\n",
> > +					 rvdev->index);
> > +				pa = rproc_va_to_pa(mem->va);
> > +			} else {
> > +				/* Use dma address as carveout no
> memmapped yet */
> > +				pa = (phys_addr_t)mem->dma;
> > +			}
> > +
> > +			/* Associate vdev buffer memory pool to vdev
> subdev */
> > +			ret = dmam_declare_coherent_memory(dev, pa,
> > +							   mem->da,
> > +							   mem->len,
> > +
> DMA_MEMORY_EXCLUSIVE);
> 
> Is it not possible to associate the dma_mem with vdev->dev directly,
> instead of injecting yet another device in-between the remoteproc
> platform device and the virtio device?

Thank you for the review.
I'll check how to use virtio device. An additional ops for memory registration may be needed at virtio level. 

> 
> That way the resulting allocation in e.g. virtio_rpmsg would be on the
> virtio device itself, not its parent.
Yes agree, it will simplify allocation/inheritance...

Regards,
Loic
> 
> Regards,
> Bjorn
> 
> > +			if (ret < 0) {
> > +				dev_err(dev, "Failed to associate buffer\n");
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +
> >  	vdev->id.device	= id,
> >  	vdev->config = &rproc_virtio_config_ops,
> >  	vdev->dev.parent = dev;
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 6b3a234..2921dd2 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -547,6 +547,7 @@ struct rproc_vdev {
> >  	struct kref refcount;
> >
> >  	struct rproc_subdev subdev;
> > +	struct device dev;
> >
> >  	unsigned int id;
> >  	struct list_head node;
> > --
> > 1.9.1
> >
