Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeFDMkl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752066AbeFDMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:40:38 -0400
Subject: Re: [PATCH V4] mlx4_core: allocate ICM memory in page size chunks
To: Michal Hocko <mhocko@kernel.org>, Qing Huang <qing.huang@oracle.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, tariqt@mellanox.com,
        haakon.bugge@oracle.com, yanjun.zhu@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        gi-oh.kim@profitbricks.com,
        "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
References: <7a353b65-6b7f-1aee-1c48-e83c8e02f693@gmail.com>
 <0e11e0fc-6ccf-aa93-9c4f-b9eae1b90643@gmail.com>
 <cdf0d1a9-378a-8b09-544e-a4918acb57fe@gmail.com>
 <20180531065405.GH15278@dhcp22.suse.cz>
 <ae114f01-4b09-bb1c-fb92-6152486a896f@gmail.com>
 <20180531085532.GK15278@dhcp22.suse.cz>
 <20180531091022.GL15278@dhcp22.suse.cz>
 <7d8f52e1-aa16-d20c-a9a8-35ad88c0b1ab@oracle.com>
 <20180601073137.GV15278@dhcp22.suse.cz>
 <f0bfa913-1837-6c5d-6e77-2a188fd094e1@oracle.com>
 <20180604062737.GA19202@dhcp22.suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 A3XDrKOXTZil3g8D
Message-ID: <c67934a5-8858-0de7-a7b5-532d14b5c881@suse.cz>
Date: Mon, 4 Jun 2018 14:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604062737.GA19202@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 08:27 AM, Michal Hocko wrote:
> On Fri 01-06-18 15:05:26, Qing Huang wrote:
>>
>>
>> On 6/1/2018 12:31 AM, Michal Hocko wrote:
>>> On Thu 31-05-18 19:04:46, Qing Huang wrote:
>>>>
>>>> On 5/31/2018 2:10 AM, Michal Hocko wrote:
>>>>> On Thu 31-05-18 10:55:32, Michal Hocko wrote:
>>>>>> On Thu 31-05-18 04:35:31, Eric Dumazet wrote:
>>>>> [...]
>>>>>>> I merely copied/pasted from alloc_skb_with_frags() :/
>>>>>> I will have a look at it. Thanks!
>>>>> OK, so this is an example of an incremental development ;).
>>>>>
>>>>> __GFP_NORETRY was added by ed98df3361f0 ("net: use __GFP_NORETRY for
>>>>> high order allocations") to prevent from OOM killer. Yet this was
>>>>> not enough because fb05e7a89f50 ("net: don't wait for order-3 page
>>>>> allocation") didn't want an excessive reclaim for non-costly orders
>>>>> so it made it completely NOWAIT while it preserved __GFP_NORETRY in
>>>>> place which is now redundant. Should I send a patch?
>>>>>
>>>> Just curious, how about GFP_ATOMIC flag? Would it work in a similar fashion?
>>>> We experimented
>>>> with it a bit in the past but it seemed to cause other issue in our tests.
>>>> :-)
>>> GFP_ATOMIC is a non-sleeping (aka no reclaim) context with an access to
>>> memory reserves. So the risk is that you deplete those reserves and
>>> cause issues to other subsystems which need them as well.
>>>
>>>> By the way, we didn't encounter any OOM killer events. It seemed that the
>>>> mlx4_alloc_icm() triggered slowpath.
>>>> We still had about 2GB free memory while it was highly fragmented.
>>> The compaction was able to make a reasonable forward progress for you.
>>> But considering mlx4_alloc_icm is called with GFP_KERNEL resp. GFP_HIGHUSER
>>> then the OOM killer is clearly possible as long as the order is lower
>>> than 4.
>>
>> The allocation was 256KB so the order was much higher than 4. The compaction
>> seemed to be the root
>> cause for our problem. It took too long to finish its work while putting
>> mlx4_alloc_icm to sleep in a heavily
>> fragmented memory situation . Will NORETRY flag avoid the compaction ops and
>> fail the 256KB allocation
>> immediately so mlx4_alloc_icm can enter adjustable lower order allocation
>> code path quickly?
> 
> Costly orders should only perform a light compaction attempt unless
> __GFP_RETRY_MAY_FAIL is used IIRC. CCing Vlastimil. So __GFP_NORETRY
> shouldn't make any difference.

It's a bit more complicated. Costly allocations will try the light
compaction attempt first, even before reclaim. This is followed by
reclaim and a more costly compaction attempt. With __GFP_NORETRY, the
second compaction attempt is also only the light one, so the flag does
make a difference here.
