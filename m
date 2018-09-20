Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F51C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B910F21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B910F21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeITREc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730984AbeITREc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:04:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F367F356F6;
        Thu, 20 Sep 2018 11:21:31 +0000 (UTC)
Received: from [10.36.117.43] (ovpn-117-43.ams2.redhat.com [10.36.117.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92EF6100034A;
        Thu, 20 Sep 2018 11:21:19 +0000 (UTC)
Subject: Re: [PATCH] qemu: Add virtio pmem device
To:     Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        linux-nvdimm@ml01.01.org
Cc:     jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, nilal@redhat.com, kwolf@redhat.com,
        pbonzini@redhat.com, ross.zwisler@intel.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        imammedo@redhat.com, eblake@redhat.com
References: <20180831133019.27579-1-pagupta@redhat.com>
 <20180831133019.27579-5-pagupta@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <2721c3ee-88d1-a8e9-1f1e-ffc3eef1d1ca@redhat.com>
Date:   Thu, 20 Sep 2018 13:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180831133019.27579-5-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Sep 2018 11:21:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -0,0 +1,241 @@
> +/*
> + * Virtio pmem device
> + *
> + * Copyright (C) 2018 Red Hat, Inc.
> + * Copyright (C) 2018 Pankaj Gupta <pagupta@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "hw/virtio/virtio-access.h"
> +#include "hw/virtio/virtio-pmem.h"
> +#include "hw/mem/memory-device.h"
> +#include "block/aio.h"
> +#include "block/thread-pool.h"
> +
> +typedef struct VirtIOPMEMresp {
> +    int ret;
> +} VirtIOPMEMResp;
> +
> +typedef struct VirtIODeviceRequest {
> +    VirtQueueElement elem;
> +    int fd;
> +    VirtIOPMEM *pmem;
> +    VirtIOPMEMResp resp;
> +} VirtIODeviceRequest;

Both, response and request have to go to a linux header (and a header
sync patch).

Also, you are using the same request for host<->guest handling and
internal purposes. The fd or pmem pointer definitely don't belong here.
Use a separate struct for internal handling purposes. (passing to worker_cb)

> +
> +static int worker_cb(void *opaque)
> +{
> +    VirtIODeviceRequest *req = opaque;
> +    int err = 0;
> +
> +    /* flush raw backing image */
> +    err = fsync(req->fd);
> +    if (err != 0) {
> +        err = EIO;
> +    }
> +    req->resp.ret = err;
> +
> +    return 0;
> +}
> +
> +static void done_cb(void *opaque, int ret)
> +{
> +    VirtIODeviceRequest *req = opaque;
> +    int len = iov_from_buf(req->elem.in_sg, req->elem.in_num, 0,
> +                              &req->resp, sizeof(VirtIOPMEMResp));
> +
> +    /* Callbacks are serialized, so no need to use atomic ops.  */
> +    virtqueue_push(req->pmem->rq_vq, &req->elem, len);
> +    virtio_notify((VirtIODevice *)req->pmem, req->pmem->rq_vq);
> +    g_free(req);
> +}
> +
> +static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIODeviceRequest *req;
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> +    HostMemoryBackend *backend = MEMORY_BACKEND(pmem->memdev);
> +    ThreadPool *pool = aio_get_thread_pool(qemu_get_aio_context());
> +
> +    req = virtqueue_pop(vq, sizeof(VirtIODeviceRequest));
> +    if (!req) {
> +        virtio_error(vdev, "virtio-pmem missing request data");
> +        return;
> +    }
> +
> +    if (req->elem.out_num < 1 || req->elem.in_num < 1) {
> +        virtio_error(vdev, "virtio-pmem request not proper");
> +        g_free(req);
> +        return;
> +    }
> +    req->fd = memory_region_get_fd(&backend->mr);
> +    req->pmem = pmem;
> +    thread_pool_submit_aio(pool, worker_cb, req, done_cb, req);
> +}
> +
> +static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> +    struct virtio_pmem_config *pmemcfg = (struct virtio_pmem_config *) config;
> +
> +    virtio_stq_p(vdev, &pmemcfg->start, pmem->start);
> +    virtio_stq_p(vdev, &pmemcfg->size, pmem->size);
> +}
> +
> +static uint64_t virtio_pmem_get_features(VirtIODevice *vdev, uint64_t features,
> +                                        Error **errp)
> +{
> +    return features;
> +}
> +
> +static void virtio_pmem_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice   *vdev   = VIRTIO_DEVICE(dev);
> +    VirtIOPMEM     *pmem   = VIRTIO_PMEM(dev);
> +    MachineState   *ms     = MACHINE(qdev_get_machine());
> +    uint64_t align;
> +    Error *local_err = NULL;
> +    MemoryRegion *mr;
> +
> +    if (!pmem->memdev) {
> +        error_setg(errp, "virtio-pmem memdev not set");
> +        return;
> +    }
> +
> +    mr  = host_memory_backend_get_memory(pmem->memdev);
> +    align = memory_region_get_alignment(mr);
> +    pmem->size = QEMU_ALIGN_DOWN(memory_region_size(mr), align);
> +    pmem->start = memory_device_get_free_addr(ms, NULL, align, pmem->size,
> +                                                               &local_err);
> +    if (local_err) {
> +        error_setg(errp, "Can't get free address in mem device");
> +        return;
> +    }
> +    memory_region_init_alias(&pmem->mr, OBJECT(pmem),
> +                             "virtio_pmem-memory", mr, 0, pmem->size);
> +    memory_device_plug_region(ms, &pmem->mr, pmem->start);
> +
> +    host_memory_backend_set_mapped(pmem->memdev, true);
> +    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
> +                                          sizeof(struct virtio_pmem_config));
> +    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
> +}
> +
> +static void virtio_mem_check_memdev(Object *obj, const char *name, Object *val,
> +                                    Error **errp)
> +{
> +    if (host_memory_backend_is_mapped(MEMORY_BACKEND(val))) {
> +        char *path = object_get_canonical_path_component(val);
> +        error_setg(errp, "Can't use already busy memdev: %s", path);
> +        g_free(path);
> +        return;
> +    }
> +
> +    qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
> +}
> +
> +static const char *virtio_pmem_get_device_id(VirtIOPMEM *vm)
> +{
> +    Object *obj = OBJECT(vm);
> +    DeviceState *parent_dev;
> +
> +    /* always use the ID of the proxy device */
> +    if (obj->parent && object_dynamic_cast(obj->parent, TYPE_DEVICE)) {
> +        parent_dev = DEVICE(obj->parent);
> +        return parent_dev->id;
> +    }
> +    return NULL;
> +}
> +
> +static void virtio_pmem_md_fill_device_info(const MemoryDeviceState *md,
> +                                           MemoryDeviceInfo *info)
> +{
> +    VirtioPMemDeviceInfo *vi = g_new0(VirtioPMemDeviceInfo, 1);
> +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> +    const char *id = virtio_pmem_get_device_id(vm);
> +
> +    if (id) {
> +        vi->has_id = true;
> +        vi->id = g_strdup(id);
> +    }
> +
> +    vi->start = vm->start;
> +    vi->size = vm->size;
> +    vi->memdev = object_get_canonical_path(OBJECT(vm->memdev));
> +
> +    info->u.virtio_pmem.data = vi;
> +    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
> +}
> +
> +static uint64_t virtio_pmem_md_get_addr(const MemoryDeviceState *md)
> +{
> +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> +
> +    return vm->start;
> +}
> +
> +static uint64_t virtio_pmem_md_get_plugged_size(const MemoryDeviceState *md)
> +{
> +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> +
> +    return vm->size;
> +}
> +
> +static uint64_t virtio_pmem_md_get_region_size(const MemoryDeviceState *md)
> +{
> +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> +
> +    return vm->size;
> +}
> +
> +static void virtio_pmem_instance_init(Object *obj)
> +{
> +    VirtIOPMEM *vm = VIRTIO_PMEM(obj);
> +    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
> +                                (Object **)&vm->memdev,
> +                                (void *) virtio_mem_check_memdev,
> +                                OBJ_PROP_LINK_STRONG,
> +                                &error_abort);
> +}
> +
> +
> +static void virtio_pmem_class_init(ObjectClass *klass, void *data)
> +{
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
> +
> +    vdc->realize      =  virtio_pmem_realize;
> +    vdc->get_config   =  virtio_pmem_get_config;
> +    vdc->get_features =  virtio_pmem_get_features;
> +
> +    mdc->get_addr         = virtio_pmem_md_get_addr;
> +    mdc->get_plugged_size = virtio_pmem_md_get_plugged_size;
> +    mdc->get_region_size  = virtio_pmem_md_get_region_size;
> +    mdc->fill_device_info = virtio_pmem_md_fill_device_info;
> +}
> +
> +static TypeInfo virtio_pmem_info = {
> +    .name          = TYPE_VIRTIO_PMEM,
> +    .parent        = TYPE_VIRTIO_DEVICE,
> +    .class_init    = virtio_pmem_class_init,
> +    .instance_size = sizeof(VirtIOPMEM),
> +    .instance_init = virtio_pmem_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_MEMORY_DEVICE },
> +        { }
> +  },
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_pmem_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 990d6fcbde..28829b6437 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -85,6 +85,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> +#define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
>  
>  #define PCI_VENDOR_ID_REDHAT             0x1b36
>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
> new file mode 100644
> index 0000000000..fda3ee691c
> --- /dev/null
> +++ b/include/hw/virtio/virtio-pmem.h
> @@ -0,0 +1,42 @@
> +/*
> + * Virtio pmem Device
> + *
> + * Copyright Red Hat, Inc. 2018
> + * Copyright Pankaj Gupta <pagupta@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#ifndef QEMU_VIRTIO_PMEM_H
> +#define QEMU_VIRTIO_PMEM_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "exec/memory.h"
> +#include "sysemu/hostmem.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "hw/boards.h"
> +#include "hw/i386/pc.h"
> +
> +#define TYPE_VIRTIO_PMEM "virtio-pmem"
> +
> +#define VIRTIO_PMEM(obj) \
> +        OBJECT_CHECK(VirtIOPMEM, (obj), TYPE_VIRTIO_PMEM)
> +
> +/* VirtIOPMEM device structure */
> +typedef struct VirtIOPMEM {
> +    VirtIODevice parent_obj;
> +
> +    VirtQueue *rq_vq;
> +    uint64_t start;
> +    uint64_t size;
> +    MemoryRegion mr;
> +    HostMemoryBackend *memdev;
> +} VirtIOPMEM;
> +
> +struct virtio_pmem_config {
> +    uint64_t start;
> +    uint64_t size;
> +};
> +#endif
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 6d5c3b2d4f..346389565a 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_PMEM         25 /* virtio pmem */

This should be moved to a linux header sync patch.




-- 

Thanks,

David / dhildenb
