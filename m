Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966591AbeBNCng (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:43:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966382AbeBNCne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:43:34 -0500
Subject: Re: [PATCH RFC 0/2] Packed ring for vhost
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1c200171-5d72-f410-7637-1ade5f41b550@redhat.com>
Date: Wed, 14 Feb 2018 10:43:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月14日 10:37, Jason Wang wrote:
> Hi all:
>
> This RFC implement a subset of packed ring which was described at
> https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd07.pdf
> . The code were tested with pmd implement by Jens at
> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor
> change was needed for pmd codes to kick virtqueue since it assumes a
> busy polling backend.
>
> Test were done between localhost and guest. Testpmd (rxonly) in guest
> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.
>
> It's not a complete implemention, here's what were missed:
>
> - Device Area
> - Driver Area
> - Descriptor indirection
> - Zerocopy may not be functional
> - Migration path is not tested
> - Vhost devices except for net
> - vIOMMU can not work (mainly because the metadata prefetch is not
>    implemented).
> - See FIXME/TODO in the codes for more details
> - No batching or other optimizations were implemented
>
> For a quick prototype, this series open code the tracking of warp
> counter and descriptor index at net device. This will be addressed in
> the future by:
>
> - Move get_rx_bufs() from net.c to vhost.c
> - Let vhost_get_vq_desc() returns vring_used_elem instad of head id
>
> With the above, we can hide the internal (at least part of) vring
> layout from specific device.
>
> Please review.
>
> Thanks

It's near spring festival in China, will probably reply after the holiday.

Thanks
