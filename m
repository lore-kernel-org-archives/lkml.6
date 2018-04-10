Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeDJH0B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:26:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751490AbeDJH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:26:00 -0400
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, alex.williamson@redhat.com, ddutile@redhat.com,
        alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com,
        jianfeng.tan@intel.com, xiao.w.wang@intel.com
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
Date: Tue, 10 Apr 2018 15:25:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410045723.rftsb7l4l3ip2ioi@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月10日 12:57, Tiwei Bie wrote:
> On Tue, Apr 10, 2018 at 10:52:52AM +0800, Jason Wang wrote:
>> On 2018年04月02日 23:23, Tiwei Bie wrote:
>>> This patch introduces a mdev (mediated device) based hardware
>>> vhost backend. This backend is an abstraction of the various
>>> hardware vhost accelerators (potentially any device that uses
>>> virtio ring can be used as a vhost accelerator). Some generic
>>> mdev parent ops are provided for accelerator drivers to support
>>> generating mdev instances.
>>>
>>> What's this
>>> ===========
>>>
>>> The idea is that we can setup a virtio ring compatible device
>>> with the messages available at the vhost-backend. Originally,
>>> these messages are used to implement a software vhost backend,
>>> but now we will use these messages to setup a virtio ring
>>> compatible hardware device. Then the hardware device will be
>>> able to work with the guest virtio driver in the VM just like
>>> what the software backend does. That is to say, we can implement
>>> a hardware based vhost backend in QEMU, and any virtio ring
>>> compatible devices potentially can be used with this backend.
>>> (We also call it vDPA -- vhost Data Path Acceleration).
>>>
>>> One problem is that, different virtio ring compatible devices
>>> may have different device interfaces. That is to say, we will
>>> need different drivers in QEMU. It could be troublesome. And
>>> that's what this patch trying to fix. The idea behind this
>>> patch is very simple: mdev is a standard way to emulate device
>>> in kernel.
>> So you just move the abstraction layer from qemu to kernel, and you still
>> need different drivers in kernel for different device interfaces of
>> accelerators. This looks even more complex than leaving it in qemu. As you
>> said, another idea is to implement userspace vhost backend for accelerators
>> which seems easier and could co-work with other parts of qemu without
>> inventing new type of messages.
> I'm not quite sure. Do you think it's acceptable to
> add various vendor specific hardware drivers in QEMU?
>

I don't object but we need to figure out the advantages of doing it in 
qemu too.

Thanks
