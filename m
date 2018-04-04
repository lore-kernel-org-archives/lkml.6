Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDDPzQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:55:16 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35005 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752030AbeDDPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:55:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T-fnNOH_1522857303;
Subject: Re: [RFC] prctl: Deprecate non PR_SET_MM_MAP operations
To: Michal Hocko <mhocko@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20180403223722.GA15783@uranus.lan>
 <48bcd917-4eb8-9da6-ec4b-e76a654695c4@linux.alibaba.com>
 <20180404053541.GA6312@dhcp22.suse.cz>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <40dde421-5300-b11f-860a-cf19aea00ec9@linux.alibaba.com>
Date: Wed, 4 Apr 2018 08:54:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404053541.GA6312@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/18 10:35 PM, Michal Hocko wrote:
> On Tue 03-04-18 16:15:20, Yang Shi wrote:
>>
>> On 4/3/18 3:37 PM, Cyrill Gorcunov wrote:
>>> An ability to manipulate mm_struct fields was introduced in
>>> sake of CRIU in first place. Later we provide more suitable
>>> and safe operation PR_SET_MM_MAP where all fields to be modifed
>>> are passed in one structure which allows us to make more detailed
>>> verification.
>>>
>>> Still old interface remains present for compatibility reason
>>> though CRIU itself already switched to PR_SET_MM_MAP on its
>>> own long ago.
>>>
>>> Googling didn't reveal some other users of this operation
>>> so I think it should be safe to issue deprecation warning
>>> first time and get rid of this interface after a couple
>>> of releases.
>>>
>>> CC: Andrey Vagin <avagin@openvz.org>
>>> CC: Andrew Morton <akpm@linuxfoundation.org>
>>> CC: Pavel Emelyanov <xemul@virtuozzo.com>
>>> CC: Michael Kerrisk <mtk.manpages@gmail.com>
>>> CC: Yang Shi <yang.shi@linux.alibaba.com>
>>> CC: Michal Hocko <mhocko@kernel.org>
>>> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
>>> ---
>>> Or we can simply drop it off because PR_SET_MM_MAP covers all needs,
>>> and I would rather prefer to do that asap.
>> Thanks for making it deprecated. I'd prefer just drop it off if nobody
>> objects. The change will get soaked in linux-next for a while , we will know
>> if it breaks compatibility (it sounds very unlikely).
> Yeah, let's just drop it and have the patch in linux-next (via mmotm)
> for 2 release cycles and see whether somebody complains.

BTW, I will do my v3 on top of the patch (drop off prctl_set_mm).

Yang

>
> You can add
> Acked-by: Michal Hocko <mhocko@suse.com>
> for such a patch.
