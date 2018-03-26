Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCZDol (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:44:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750960AbeCZDoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:44:39 -0400
Subject: Re: [RFC PATCH V2 0/8] Packed ring for vhost
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
        Jens Freimann <jfreimann@redhat.com>, Wei Xu <wexu@redhat.com>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1529f62d-dc16-d279-2ebf-85a6d2029ebe@redhat.com>
Date: Mon, 26 Mar 2018 11:44:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Jens, Tiwei and Wei

Thanks


On 2018年03月26日 11:38, Jason Wang wrote:
> Hi all:
>
> This RFC implement packed ring layout. The code were tested with pmd
> implement by Jens at
> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor change
> was needed for pmd codes to kick virtqueue since it assumes a busy
> polling backend.
>
> Test were done between localhost and guest. Testpmd (rxonly) in guest
> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.
>
> Notes: The event suppression /indirect descriptor support is complied
>         test only because of lacked driver support.
>
> Changes from V1:
>
> - Refactor vhost used elem code to avoid open coding on used elem
> - Event suppression support (compile test only).
> - Indirect descriptor support (compile test only).
> - Zerocopy support.
> - vIOMMU support.
> - SCSI/VSOCK support (compile test only).
> - Fix several bugs
>
> For simplicity, I don't implement batching or other optimizations.
>
> Please review.
>
> Thanks
>
> Jason Wang (8):
>    vhost: move get_rx_bufs to vhost.c
>    vhost: hide used ring layout from device
>    vhost: do not use vring_used_elem
>    vhost_net: do not explicitly manipulate vhost_used_elem
>    vhost: vhost_put_user() can accept metadata type
>    virtio: introduce packed ring defines
>    vhost: packed ring support
>    vhost: event suppression for packed ring
>
>   drivers/vhost/net.c                | 138 ++-----
>   drivers/vhost/scsi.c               |  62 +--
>   drivers/vhost/vhost.c              | 818 ++++++++++++++++++++++++++++++++++---
>   drivers/vhost/vhost.h              |  46 ++-
>   drivers/vhost/vsock.c              |  42 +-
>   include/uapi/linux/virtio_config.h |   9 +
>   include/uapi/linux/virtio_ring.h   |  32 ++
>   7 files changed, 921 insertions(+), 226 deletions(-)
>
