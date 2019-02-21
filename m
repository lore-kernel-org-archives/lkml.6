Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B4CC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706912081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfBUTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:54:57 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55000 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfBUTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:54:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TKsBKHK_1550778890;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TKsBKHK_1550778890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Feb 2019 03:54:52 +0800
Subject: Re: [PATCH] doc: cgroup: correct the wrong information about measure
 of memory pressure
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1550278564-81540-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190218210504.GT50184@devbig004.ftw2.facebook.com>
 <CAHCio2g-S6snHsh84r0Wp1RQW1CR3t_eyUUjcdDaxnUHWTcdFw@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3edd7008-d568-f9b1-a991-bd0ee88f6c52@linux.alibaba.com>
Date:   Thu, 21 Feb 2019 11:54:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHCio2g-S6snHsh84r0Wp1RQW1CR3t_eyUUjcdDaxnUHWTcdFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/19 2:45 AM, 禹舟键 wrote:
> Hi TeJun
> I've built the 5.0.0-rc6 kernel with psi option, but I cannot find any
> cgroup.controllers when I mounted cgroup2.
>
> [root@bogon /]# uname -r
> [root@bogon /]# 5.0.0-rc6+
> [root@bogon /]# mount -t cgroup2 none cgroup2/
> [root@bogon /]# cat cgroup2/cgroup.controllers
> [root@bogon /]
> [root@bogon /]# cat cgroup2/cgroup.subtree_control
> [root@bogon /]#
>
> What's wrong with this kernel? Or maybe I lost some mount option?

I'm not sure what you did before you mounted cgroup2, but if you have 
legacy controllers mounted, you have to unmount them, otherwise 
cgroup.controllers would show up as empty. Or you can pass 
"cgroup_no_v1=" in your kernel parameter.

Yang

>
> Thanks
> Yuzhoujian
>
> Tejun Heo <tj@kernel.org> 于2019年2月19日周二 上午10:32写道：
>> On Sat, Feb 16, 2019 at 08:56:04AM +0800, Yang Shi wrote:
>>> Since PSI has implemented some kind of measure of memory pressure, the
>>> statement about lack of such measure is not true anymore.
>>>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> ---
>>>   Documentation/admin-guide/cgroup-v2.rst | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>> index 7bf3f12..9a92013 100644
>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>> @@ -1310,8 +1310,7 @@ network to a file can use all available memory but can also operate as
>>>   performant with a small amount of memory.  A measure of memory
>>>   pressure - how much the workload is being impacted due to lack of
>>>   memory - is necessary to determine whether a workload needs more
>>> -memory; unfortunately, memory pressure monitoring mechanism isn't
>>> -implemented yet.
>>> +memory.
>> Maybe refer to PSI?
>>
>> Thanks.
>>
>> --
>> tejun

