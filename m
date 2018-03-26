Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeCZOmC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:42:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbeCZOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:42:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Mar 2018 22:41:59 +0800
From: yuankuiz@codeaurora.org
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        cgroups-owner@vger.kernel.org
Subject: Re: [PATCH]cgroup: __cpuset_node_allowed return bool
In-Reply-To: <ea271bc26e293c232c6ea7772607c7fc@codeaurora.org>
References: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
 <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
 <20180326141212.GI2149215@devbig577.frc2.facebook.com>
 <3540bc7869927f54c409b697c743938a@codeaurora.org>
 <20180326142527.GJ2149215@devbig577.frc2.facebook.com>
 <ea271bc26e293c232c6ea7772607c7fc@codeaurora.org>
Message-ID: <a8a2a62242ffa3f41b52a1b58f4bf9ee@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

     Additionally,

On 2018-03-26 10:37 PM, yuankuiz@codeaurora.org wrote:
> Hi Tejun,
> 
>     inline.
> 
> On 2018-03-26 10:25 PM, Tejun Heo wrote:
>> On Mon, Mar 26, 2018 at 10:20:43PM +0800, yuankuiz@codeaurora.org 
>> wrote:
>>>  1) return int type variable in bool function:
>>>  bool enabled()
>>>  {
>>>  	int ret = 1;
>>>  	return ret;
>>>  }
>> ...
>>>  2)
>>>  bool enabled()
>>>  {
>>>  	bool ret = 1;
>>>  	return ret;
>>>  }
>> ...
>>>  so the #1) style function can generate significant instructions
>>> than the #2).
>> 
>> That is a problem for the compiler, not the code.
[ZJ] Actually, it should be bool but not int. Without any optimization 
by compiler, it is the best if it is the same as returned.

>> 
>>>  While, this is happened only when "-On" is not used with *-gcc
>>> together. Though, it is oftern there, it is best to provide this
>>> with decoupling of which option is used for optimization.
>> 
>> We don't want to dictate minute coding styles to avoid things which
>> are trivially optimized by compilers.
> [ZJ] Optimized by compiler is observed only. Such as it is not so big
> difference in x86-arch.
> 
>> 
>> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe cgroups" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

     Thanks,
BR//Zhao
