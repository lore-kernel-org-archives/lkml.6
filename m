Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9291ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7506220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7506220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGSOlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:41:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731110AbeGSOlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A99F40201CA;
        Thu, 19 Jul 2018 13:58:25 +0000 (UTC)
Received: from [10.36.117.75] (ovpn-117-75.ams2.redhat.com [10.36.117.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A168E2026D6B;
        Thu, 19 Jul 2018 13:58:21 +0000 (UTC)
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>
Cc:     Luiz Capitulino <lcapitulino@redhat.com>, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org,
        ross zwisler <ross.zwisler@intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        hch@infradead.org, imammedo@redhat.com, mst@redhat.com,
        niteshnarayanlal@hotmail.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, nilal@redhat.com
References: <20180713075232.9575-1-pagupta@redhat.com>
 <20180713075232.9575-4-pagupta@redhat.com> <20180718085529.133a0a22@doriath>
 <367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com>
 <20180719121635.GA28107@stefanha-x1.localdomain>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <b6ef19f3-7f16-5427-bfed-f352a76e48b7@redhat.com>
Date:   Thu, 19 Jul 2018 15:58:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719121635.GA28107@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 13:58:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 13:58:25 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2018 14:16, Stefan Hajnoczi wrote:
> On Thu, Jul 19, 2018 at 01:48:13AM -0400, Pankaj Gupta wrote:
>>
>>>
>>>>  This patch adds virtio-pmem Qemu device.
>>>>
>>>>  This device presents memory address range information to guest
>>>>  which is backed by file backend type. It acts like persistent
>>>>  memory device for KVM guest. Guest can perform read and persistent
>>>>  write operations on this memory range with the help of DAX capable
>>>>  filesystem.
>>>>
>>>>  Persistent guest writes are assured with the help of virtio based
>>>>  flushing interface. When guest userspace space performs fsync on
>>>>  file fd on pmem device, a flush command is send to Qemu over VIRTIO
>>>>  and host side flush/sync is done on backing image file.
>>>>
>>>> Changes from RFC v2:
>>>> - Use aio_worker() to avoid Qemu from hanging with blocking fsync
>>>>   call - Stefan
>>>> - Use virtio_st*_p() for endianess - Stefan
>>>> - Correct indentation in qapi/misc.json - Eric
>>>>
>>>> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>>>> ---
>>>>  hw/virtio/Makefile.objs                     |   3 +
>>>>  hw/virtio/virtio-pci.c                      |  44 +++++
>>>>  hw/virtio/virtio-pci.h                      |  14 ++
>>>>  hw/virtio/virtio-pmem.c                     | 241
>>>>  ++++++++++++++++++++++++++++
>>>>  include/hw/pci/pci.h                        |   1 +
>>>>  include/hw/virtio/virtio-pmem.h             |  42 +++++
>>>>  include/standard-headers/linux/virtio_ids.h |   1 +
>>>>  qapi/misc.json                              |  26 ++-
>>>>  8 files changed, 371 insertions(+), 1 deletion(-)
>>>>  create mode 100644 hw/virtio/virtio-pmem.c
>>>>  create mode 100644 include/hw/virtio/virtio-pmem.h
>>>>
>>>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>>>> index 1b2799cfd8..7f914d45d0 100644
>>>> --- a/hw/virtio/Makefile.objs
>>>> +++ b/hw/virtio/Makefile.objs
>>>> @@ -10,6 +10,9 @@ obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
>>>>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=
>>>>  virtio-crypto-pci.o
>>>>  
>>>>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>>>> +ifeq ($(CONFIG_MEM_HOTPLUG),y)
>>>> +obj-$(CONFIG_LINUX) += virtio-pmem.o
>>>> +endif
>>>>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>>>>  endif
>>>>  
>>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>>>> index 3a01fe90f0..93d3fc05c7 100644
>>>> --- a/hw/virtio/virtio-pci.c
>>>> +++ b/hw/virtio/virtio-pci.c
>>>> @@ -2521,6 +2521,49 @@ static const TypeInfo virtio_rng_pci_info = {
>>>>      .class_init    = virtio_rng_pci_class_init,
>>>>  };
>>>>  
>>>> +/* virtio-pmem-pci */
>>>> +
>>>> +static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error
>>>> **errp)
>>>> +{
>>>> +    VirtIOPMEMPCI *vpmem = VIRTIO_PMEM_PCI(vpci_dev);
>>>> +    DeviceState *vdev = DEVICE(&vpmem->vdev);
>>>> +
>>>> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>>>> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>>>> +}
>>>> +
>>>> +static void virtio_pmem_pci_class_init(ObjectClass *klass, void *data)
>>>> +{
>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>>>> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>>>> +    k->realize = virtio_pmem_pci_realize;
>>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>>> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>>>> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_PMEM;
>>>> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
>>>> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
>>>> +}
>>>> +
>>>> +static void virtio_pmem_pci_instance_init(Object *obj)
>>>> +{
>>>> +    VirtIOPMEMPCI *dev = VIRTIO_PMEM_PCI(obj);
>>>> +
>>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>>>> +                                TYPE_VIRTIO_PMEM);
>>>> +    object_property_add_alias(obj, "memdev", OBJECT(&dev->vdev), "memdev",
>>>> +                              &error_abort);
>>>> +}
>>>> +
>>>> +static const TypeInfo virtio_pmem_pci_info = {
>>>> +    .name          = TYPE_VIRTIO_PMEM_PCI,
>>>> +    .parent        = TYPE_VIRTIO_PCI,
>>>> +    .instance_size = sizeof(VirtIOPMEMPCI),
>>>> +    .instance_init = virtio_pmem_pci_instance_init,
>>>> +    .class_init    = virtio_pmem_pci_class_init,
>>>> +};
>>>> +
>>>> +
>>>>  /* virtio-input-pci */
>>>>  
>>>>  static Property virtio_input_pci_properties[] = {
>>>> @@ -2714,6 +2757,7 @@ static void virtio_pci_register_types(void)
>>>>      type_register_static(&virtio_balloon_pci_info);
>>>>      type_register_static(&virtio_serial_pci_info);
>>>>      type_register_static(&virtio_net_pci_info);
>>>> +    type_register_static(&virtio_pmem_pci_info);
>>>>  #ifdef CONFIG_VHOST_SCSI
>>>>      type_register_static(&vhost_scsi_pci_info);
>>>>  #endif
>>>> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
>>>> index 813082b0d7..fe74fcad3f 100644
>>>> --- a/hw/virtio/virtio-pci.h
>>>> +++ b/hw/virtio/virtio-pci.h
>>>> @@ -19,6 +19,7 @@
>>>>  #include "hw/virtio/virtio-blk.h"
>>>>  #include "hw/virtio/virtio-net.h"
>>>>  #include "hw/virtio/virtio-rng.h"
>>>> +#include "hw/virtio/virtio-pmem.h"
>>>>  #include "hw/virtio/virtio-serial.h"
>>>>  #include "hw/virtio/virtio-scsi.h"
>>>>  #include "hw/virtio/virtio-balloon.h"
>>>> @@ -57,6 +58,7 @@ typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>>>>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
>>>>  typedef struct VHostVSockPCI VHostVSockPCI;
>>>>  typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
>>>> +typedef struct VirtIOPMEMPCI VirtIOPMEMPCI;
>>>>  
>>>>  /* virtio-pci-bus */
>>>>  
>>>> @@ -274,6 +276,18 @@ struct VirtIOBlkPCI {
>>>>      VirtIOBlock vdev;
>>>>  };
>>>>  
>>>> +/*
>>>> + * virtio-pmem-pci: This extends VirtioPCIProxy.
>>>> + */
>>>> +#define TYPE_VIRTIO_PMEM_PCI "virtio-pmem-pci"
>>>> +#define VIRTIO_PMEM_PCI(obj) \
>>>> +        OBJECT_CHECK(VirtIOPMEMPCI, (obj), TYPE_VIRTIO_PMEM_PCI)
>>>> +
>>>> +struct VirtIOPMEMPCI {
>>>> +    VirtIOPCIProxy parent_obj;
>>>> +    VirtIOPMEM vdev;
>>>> +};
>>>> +
>>>>  /*
>>>>   * virtio-balloon-pci: This extends VirtioPCIProxy.
>>>>   */
>>>> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
>>>> new file mode 100644
>>>> index 0000000000..08c96d7e80
>>>> --- /dev/null
>>>> +++ b/hw/virtio/virtio-pmem.c
>>>> @@ -0,0 +1,241 @@
>>>> +/*
>>>> + * Virtio pmem device
>>>> + *
>>>> + * Copyright (C) 2018 Red Hat, Inc.
>>>> + * Copyright (C) 2018 Pankaj Gupta <pagupta@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2.
>>>> + * See the COPYING file in the top-level directory.
>>>> + *
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qapi/error.h"
>>>> +#include "qemu-common.h"
>>>> +#include "qemu/error-report.h"
>>>> +#include "hw/virtio/virtio-access.h"
>>>> +#include "hw/virtio/virtio-pmem.h"
>>>> +#include "hw/mem/memory-device.h"
>>>> +#include "block/aio.h"
>>>> +#include "block/thread-pool.h"
>>>> +
>>>> +typedef struct VirtIOPMEMresp {
>>>> +    int ret;
>>>> +} VirtIOPMEMResp;
>>>> +
>>>> +typedef struct VirtIODeviceRequest {
>>>> +    VirtQueueElement elem;
>>>> +    int fd;
>>>> +    VirtIOPMEM *pmem;
>>>> +    VirtIOPMEMResp resp;
>>>> +} VirtIODeviceRequest;
>>>> +
>>>> +static int worker_cb(void *opaque)
>>>> +{
>>>> +    VirtIODeviceRequest *req = opaque;
>>>> +    int err = 0;
>>>> +
>>>> +    /* flush raw backing image */
>>>> +    err = fsync(req->fd);
>>>> +    if (err != 0) {
>>>> +        err = errno;
>>>> +    }
>>>> +    req->resp.ret = err;
>>>
>>> Host question: are you returning the guest errno code to the host?
>>
>> No. I am returning error code from the host in-case of host fsync
>> failure, otherwise returning zero.
> 
> I think that's what Luiz meant.  errno constants are not portable
> between operating systems and architectures.  Therefore they cannot be
> used in external interfaces in software that expects to communicate with
> other systems.
> 
> It will be necessary to define specific constants for virtio-pmem
> instead of passing errno from the host to guest.
> 

In general, I wonder if we should report errors at all or rather *kill*
the guest. That might sound harsh, but think about the following scenario:

fsync() fails due to some block that cannot e.g. be written (e.g.
network connection failed). What happens if our guest tries to
read/write that mmaped block? (e.g. network connection failed).

I assume we'll get a signal an get killed? So we are trying to optimize
one special case (fsync()) although every read/write is prone to kill
the guest. And as soon as the guest will try to access the block that
made fsync fail, we will crash the guest either way.

I assume the main problem is that we are trying to take a file (with all
the errors that can happen during read/write/fsync) and make it look
like memory (dax). On ordinary block access, we can forward errors, but
not if it's memory (maybe using MCE, but it's complicated and
architecture specific).

So I wonder if we should rather assume that our backend file is placed
on some stable storage that cannot easily fail.

(we might have the same problem with NVDIMM right now, at least the
memory reading/writing part)

It's complicated and I am not a block level expert :)

> Stefan
> 


-- 

Thanks,

David / dhildenb
