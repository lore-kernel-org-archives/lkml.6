Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE1C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF42D2156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QmeelB6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF42D2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbeIVG7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:59:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37695 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:59:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id o13-v6so14757470otl.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMWqs8bBmaiOV3/6oxoBPBBoxpaGPoq7t5XCm5GOzGQ=;
        b=QmeelB6iwP3b5G7BSnwfzkMHB8oSE9vwX/T4Y+bBAlWpF2pBpRDs/My3+m0ZOHtLmW
         hvH6MXM70IjnRv74zhyIssrpNpE1/DkxjRMdRg4NkCc8AFYwjwkTm6twS6BfUjR5nSSp
         8wIH8ECCLrskQe7amAC1w9t9JjLhUL+FG/fgBd/josa065OM1Zh9sE9Hq3bW/1fqvKtU
         5CL3kuWxLZ9c8dNUqTg+9uDUs3kPBHCpXI5Wx+7HqBIBseLv5JRkbaE2v+OuD0c1oNIl
         KYCdRhEaORVMhJu6Q6hAWiezyJTPOxfblApFyNaOJHRK/NtIFmy1T9/yLcdK+5Tqegc1
         oF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMWqs8bBmaiOV3/6oxoBPBBoxpaGPoq7t5XCm5GOzGQ=;
        b=TQRdnCP8Lmx9AudaT8EqO6mPMtN6YOUW7hg3dPZZnGXkyOguKRERX7bUnwDX0jznbQ
         u6IAf/vumN3UYqWrXJSWIO3rYs2YxbTGIXjKT9ihZe7m7t6XXZFafACw4H7kmiwHzJhi
         0FxUDOzN6sI75xxlGRKhLDINp5hgM6jylVBUVHQ8ujr9WFXReV5tJlPyItzVsHTPF77F
         ENkkc7JtkD4aHkX3srtrRtzdZsCAOU8b7FtnlCoHNKmNsifuVJ1fiJJGPznSvLfjcNNe
         fbmZpxM2ndFnqztZpJOEJS4WP3rZvQWXX0vYW8P87PYJByog+VouOlgeKoAEfBTtkPk/
         OtUw==
X-Gm-Message-State: ABuFfoizlXUxead9hLp5ViqfomKFD+kUMn2aHiqRDdEWxHvke9SiN+at
        lhrz6hiCqW0VlU9maYKl2VkzabKvovcaDIu686Sk5Q==
X-Google-Smtp-Source: ACcGV60ZYcLNnOg3DDt1Q8JAFTN1nAH//u90rqRfMy4mCAxfbxLCLTl8fFggkL2uYdGTmGCjwtc6McT0AOAfX+heZX8=
X-Received: by 2002:a9d:7353:: with SMTP id l19-v6mr174526otk.7.1537578493885;
 Fri, 21 Sep 2018 18:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180831133019.27579-1-pagupta@redhat.com> <20180831133019.27579-4-pagupta@redhat.com>
In-Reply-To: <20180831133019.27579-4-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 18:08:02 -0700
Message-ID: <CAPcyv4gy-ONZz=PnXN92xYnyRX0rhu7Oq-_jPWJekbYQjNKRiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Zwisler, Ross" <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 6:32 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds virtio-pmem driver for KVM guest.
>
> Guest reads the persistent memory range information from
> Qemu over VIRTIO and registers it on nvdimm_bus. It also
> creates a nd_region object with the persistent memory
> range information so that existing 'nvdimm/pmem' driver
> can reserve this into system memory map. This way
> 'virtio-pmem' driver uses existing functionality of pmem
> driver to register persistent memory compatible for DAX
> capable filesystems.
>
> This also provides function to perform guest flush over
> VIRTIO from 'pmem' driver when userspace performs flush
> on DAX memory range.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/virtio/Kconfig           |   9 ++
>  drivers/virtio/Makefile          |   1 +
>  drivers/virtio/virtio_pmem.c     | 255 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h  |   1 +
>  include/uapi/linux/virtio_pmem.h |  40 ++++++
>  5 files changed, 306 insertions(+)
>  create mode 100644 drivers/virtio/virtio_pmem.c
>  create mode 100644 include/uapi/linux/virtio_pmem.h
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 3589764..a331e23 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -42,6 +42,15 @@ config VIRTIO_PCI_LEGACY
>
>           If unsure, say Y.
>
> +config VIRTIO_PMEM
> +       tristate "Support for virtio pmem driver"
> +       depends on VIRTIO
> +       help
> +       This driver provides support for virtio based flushing interface
> +       for persistent memory range.
> +
> +       If unsure, say M.
> +
>  config VIRTIO_BALLOON
>         tristate "Virtio balloon driver"
>         depends on VIRTIO
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 3a2b5c5..cbe91c6 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -6,3 +6,4 @@ virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
>  virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> +obj-$(CONFIG_VIRTIO_PMEM) += virtio_pmem.o
> diff --git a/drivers/virtio/virtio_pmem.c b/drivers/virtio/virtio_pmem.c
> new file mode 100644
> index 0000000..c22cc87
> --- /dev/null
> +++ b/drivers/virtio/virtio_pmem.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtio_pmem.c: Virtio pmem Driver
> + *
> + * Discovers persistent memory range information
> + * from host and provides a virtio based flushing
> + * interface.
> + */
> +#include <linux/virtio.h>
> +#include <linux/module.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +#include <uapi/linux/virtio_pmem.h>
> +#include <linux/spinlock.h>
> +#include <linux/libnvdimm.h>
> +#include <linux/nd.h>

I think we need to split this driver into 2 files,
drivers/virtio/pmem.c would discover and register the virtual pmem
device with the libnvdimm core, and drivers/nvdimm/virtio.c would
house virtio_pmem_flush().

> +
> +struct virtio_pmem_request {
> +       /* Host return status corresponding to flush request */
> +       int ret;
> +
> +       /* command name*/
> +       char name[16];
> +
> +       /* Wait queue to process deferred work after ack from host */
> +       wait_queue_head_t host_acked;
> +       bool done;
> +
> +       /* Wait queue to process deferred work after virt queue buffer avail */
> +       wait_queue_head_t wq_buf;

Why does this need wait_queue's per request? shouldn't this be per-device?

> +       bool wq_buf_avail;
> +       struct list_head list;
> +};
> +
> +struct virtio_pmem {
> +       struct virtio_device *vdev;
> +
> +       /* Virtio pmem request queue */
> +       struct virtqueue *req_vq;
> +
> +       /* nvdimm bus registers virtio pmem device */
> +       struct nvdimm_bus *nvdimm_bus;
> +       struct nvdimm_bus_descriptor nd_desc;
> +
> +       /* List to store deferred work if virtqueue is full */
> +       struct list_head req_list;
> +
> +       /* Synchronize virtqueue data */
> +       spinlock_t pmem_lock;
> +
> +       /* Memory region information */
> +       uint64_t start;
> +       uint64_t size;
> +};
> +
> +static struct virtio_device_id id_table[] = {
> +       { VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> +       { 0 },
> +};
> +
> + /* The interrupt handler */
> +static void host_ack(struct virtqueue *vq)
> +{
> +       unsigned int len;
> +       unsigned long flags;
> +       struct virtio_pmem_request *req, *req_buf;
> +       struct virtio_pmem *vpmem = vq->vdev->priv;
> +
> +       spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +       while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
> +               req->done = true;
> +               wake_up(&req->host_acked);
> +
> +               if (!list_empty(&vpmem->req_list)) {
> +                       req_buf = list_first_entry(&vpmem->req_list,
> +                                       struct virtio_pmem_request, list);
> +                       list_del(&vpmem->req_list);
> +                       req_buf->wq_buf_avail = true;
> +                       wake_up(&req_buf->wq_buf);
> +               }
> +       }
> +       spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +}
> + /* Initialize virt queue */
> +static int init_vq(struct virtio_pmem *vpmem)
> +{
> +       struct virtqueue *vq;
> +
> +       /* single vq */
> +       vpmem->req_vq = vq = virtio_find_single_vq(vpmem->vdev,
> +                               host_ack, "flush_queue");
> +       if (IS_ERR(vq))
> +               return PTR_ERR(vq);
> +
> +       spin_lock_init(&vpmem->pmem_lock);
> +       INIT_LIST_HEAD(&vpmem->req_list);
> +
> +       return 0;
> +};
> +
> + /* The request submission function */
> +static int virtio_pmem_flush(struct nd_region *nd_region)
> +{
> +       int err;
> +       unsigned long flags;
> +       struct scatterlist *sgs[2], sg, ret;
> +       struct virtio_device *vdev =
> +               dev_to_virtio(nd_region->dev.parent->parent);

That's a long de-ref chain I would just stash the vdev in
nd_region->provider_data.

> +       struct virtio_pmem *vpmem = vdev->priv;
> +       struct virtio_pmem_request *req = kmalloc(sizeof(*req), GFP_KERNEL);
> +
> +       if (!req)
> +               return -ENOMEM;
> +
> +       req->done = req->wq_buf_avail = false;
> +       strcpy(req->name, "FLUSH");
> +       init_waitqueue_head(&req->host_acked);
> +       init_waitqueue_head(&req->wq_buf);
> +
> +       spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +       sg_init_one(&sg, req->name, strlen(req->name));
> +       sgs[0] = &sg;
> +       sg_init_one(&ret, &req->ret, sizeof(req->ret));
> +       sgs[1] = &ret;
> +       err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> +       if (err) {
> +               dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> +
> +               list_add_tail(&vpmem->req_list, &req->list);
> +               spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +               /* When host has read buffer, this completes via host_ack */
> +               wait_event(req->wq_buf, req->wq_buf_avail);
> +               spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +       }
> +       virtqueue_kick(vpmem->req_vq);
> +       spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +       /* When host has read buffer, this completes via host_ack */
> +       wait_event(req->host_acked, req->done);

Hmm, this seems awkward if this is called from pmem_make_request. If
we need to wait for completion that should be managed by the guest
block layer. I.e. make_request should just queue request and then
trigger bio_endio() when the response comes back.

However this does mean that nvdimm_flush() becomes asynchronous. So
maybe we need to pass in a 'sync' flag or the bio directly to indicate
this is an asynchronous flush request from pmem_make_request() vs a
synchronous one from nsio_rw_bytes().

> +       err = req->ret;
> +       kfree(req);
> +
> +       return err;
> +};
> +EXPORT_SYMBOL_GPL(virtio_pmem_flush);
> +
> +static int virtio_pmem_probe(struct virtio_device *vdev)
> +{
> +       int err = 0;
> +       struct resource res;
> +       struct virtio_pmem *vpmem;
> +       struct nvdimm_bus *nvdimm_bus;
> +       struct nd_region_desc ndr_desc;
> +       int nid = dev_to_node(&vdev->dev);
> +       struct nd_region *nd_region;
> +
> +       if (!vdev->config->get) {
> +               dev_err(&vdev->dev, "%s failure: config disabled\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       vdev->priv = vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem),
> +                       GFP_KERNEL);
> +       if (!vpmem) {
> +               err = -ENOMEM;
> +               goto out_err;
> +       }
> +
> +       vpmem->vdev = vdev;
> +       err = init_vq(vpmem);
> +       if (err)
> +               goto out_err;
> +
> +       virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +                       start, &vpmem->start);
> +       virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +                       size, &vpmem->size);
> +
> +       res.start = vpmem->start;
> +       res.end   = vpmem->start + vpmem->size-1;
> +       vpmem->nd_desc.provider_name = "virtio-pmem";
> +       vpmem->nd_desc.module = THIS_MODULE;
> +
> +       vpmem->nvdimm_bus = nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> +                                               &vpmem->nd_desc);
> +       if (!nvdimm_bus)
> +               goto out_vq;
> +
> +       dev_set_drvdata(&vdev->dev, nvdimm_bus);
> +       memset(&ndr_desc, 0, sizeof(ndr_desc));
> +
> +       ndr_desc.res = &res;
> +       ndr_desc.numa_node = nid;
> +       ndr_desc.flush = virtio_pmem_flush;
> +       set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +       nd_region = nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc);
> +
> +       if (!nd_region)
> +               goto out_nd;
> +
> +       //virtio_device_ready(vdev);
> +       return 0;
> +out_nd:
> +       err = -ENXIO;
> +       nvdimm_bus_unregister(nvdimm_bus);
> +out_vq:
> +       vdev->config->del_vqs(vdev);
> +out_err:
> +       dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> +       return err;
> +}
> +
> +static void virtio_pmem_remove(struct virtio_device *vdev)
> +{
> +       struct virtio_pmem *vpmem = vdev->priv;
> +       struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> +
> +       nvdimm_bus_unregister(nvdimm_bus);
> +       vdev->config->del_vqs(vdev);
> +       kfree(vpmem);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int virtio_pmem_freeze(struct virtio_device *vdev)
> +{
> +       /* todo: handle freeze function */
> +       return -EPERM;
> +}
> +
> +static int virtio_pmem_restore(struct virtio_device *vdev)
> +{
> +       /* todo: handle restore function */
> +       return -EPERM;
> +}
> +#endif

As far as I can see there's nothing to do on a power transition, I
would just omit this completely.

> +
> +
> +static struct virtio_driver virtio_pmem_driver = {
> +       .driver.name            = KBUILD_MODNAME,
> +       .driver.owner           = THIS_MODULE,
> +       .id_table               = id_table,
> +       .probe                  = virtio_pmem_probe,
> +       .remove                 = virtio_pmem_remove,
> +#ifdef CONFIG_PM_SLEEP
> +       .freeze                 = virtio_pmem_freeze,
> +       .restore                = virtio_pmem_restore,
> +#endif
> +};
> +
> +module_virtio_driver(virtio_pmem_driver);
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio pmem driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 6d5c3b2..3463895 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_PMEM         25 /* virtio pmem */
>
>  #endif /* _LINUX_VIRTIO_IDS_H */
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 0000000..c7c22a5
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
> + * anyone can use the definitions to implement compatible drivers/servers:

The SPDX identifier does not match this BSD license, and the whole
point of the SPDX identifier is to get out of the need to have these
large text blobs of license goop.

> + *
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS''
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + *
> + * Copyright (C) Red Hat, Inc., 2018-2019
> + * Copyright (C) Pankaj Gupta <pagupta@redhat.com>, 2018
> + */
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +struct virtio_pmem_config {
> +       __le64 start;
> +       __le64 size;
> +};
> +#endif

Why does this need to be in the uapi?
