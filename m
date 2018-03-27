Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeC0Ddt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:33:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751824AbeC0Ddr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:33:47 -0400
Subject: Re: [RFC PATCH V2 0/8] Packed ring for vhost
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
 <20180326190130.GE6928@char.us.oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1e5ad820-f11a-8208-d4c0-5d871adddb9e@redhat.com>
Date: Tue, 27 Mar 2018 11:33:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326190130.GE6928@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月27日 03:01, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 26, 2018 at 11:38:45AM +0800, Jason Wang wrote:
>> Hi all:
>>
>> This RFC implement packed ring layout. The code were tested with pmd
>> implement by Jens at
>> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor change
>> was needed for pmd codes to kick virtqueue since it assumes a busy
>> polling backend.
>>
>> Test were done between localhost and guest. Testpmd (rxonly) in guest
>> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.
> And how does it compare to older ring layout?
>

No obvious difference.

Vhost itself becomes a bottleneck. I plan to do more aggressive batching 
like dpdk on top.

Thanks
