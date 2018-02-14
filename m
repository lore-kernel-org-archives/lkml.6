Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966774AbeBNDsZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:48:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966671AbeBNDsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:48:24 -0500
Subject: Re: [PATCH RFC 0/2] Packed ring for vhost
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, tiwei.bie@intel.com
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
 <20180214044634-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <97e20ab7-a73c-e911-f5ae-38359f68d4f4@redhat.com>
Date: Wed, 14 Feb 2018 11:48:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214044634-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月14日 10:47, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2018 at 10:37:07AM +0800, Jason Wang wrote:
>> Hi all:
>>
>> This RFC implement a subset of packed ring which was described at
>> https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd07.pdf
>> . The code were tested with pmd implement by Jens at
>> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor
>> change was needed for pmd codes to kick virtqueue since it assumes a
>> busy polling backend.
>>
>> Test were done between localhost and guest. Testpmd (rxonly) in guest
>> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.
> How does this compare with the split ring design?

No obvious difference (+-5%). I believe we reach the bottleneck of vhost.

>
>> It's not a complete implemention, here's what were missed:
>>
>> - Device Area
>> - Driver Area
>> - Descriptor indirection
>> - Zerocopy may not be functional
>> - Migration path is not tested
>> - Vhost devices except for net
>> - vIOMMU can not work (mainly because the metadata prefetch is not
>>    implemented).
>> - See FIXME/TODO in the codes for more details
>> - No batching or other optimizations were implemented
> ioeventfd for PIO/mmio/s390.
>

Probably, but this is not the stuffs of packed ring I think.

Thanks
