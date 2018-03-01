Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966934AbeCAJZA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:25:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965026AbeCAJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:24:46 -0500
Subject: Re: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small
 buffer
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <1519874345-10235-3-git-send-email-jasowang@redhat.com>
 <20180301090206.04e13a71@redhat.com>
 <dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
 <20180301101553.55c4c6bd@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c20a958-55c6-5a5f-c0e9-dc6f7c0e4db5@redhat.com>
Date: Thu, 1 Mar 2018 17:24:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301101553.55c4c6bd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月01日 17:15, Jesper Dangaard Brouer wrote:
> On Thu, 1 Mar 2018 16:49:24 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>>> 2. This can easily cause out-of-order packets.
>> I may miss something, but it looks to me packets were still delivered
>> in order? Or you mean the packets that was dropped by cpumap?
> No. Packets can now travel two code paths to the egress device. (1) XDP
> native via ndp_xdp_xmit via direct delivery into a lockfree/dedicated
> TX queue, (2) via normal network stack which can involve being queue in
> a qdisc.  Do you see the possibility of the reorder now?
>

I see, thanks. But consider this could only happen for first few 
packets, not sure it was worth to worry about it.

Thanks
