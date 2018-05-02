Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbeEBI0Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:26:25 -0400
Received: from foss.arm.com ([217.140.101.70]:54824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeEBI0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:26:21 -0400
Subject: Re: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
To: Kim Phillips <kim.phillips@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        sudeep.holla@arm.com, frowand.list@gmail.com, robh@kernel.org,
        john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
 <20180501225503.a55fb963795afb40163f3763@arm.com>
From: Robert Walker <robert.walker@arm.com>
Message-ID: <019a4703-f51a-b402-7e92-c5045a17361a@arm.com>
Date: Wed, 2 May 2018 09:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180501225503.a55fb963795afb40163f3763@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/18 04:55, Kim Phillips wrote:
> On Tue, 1 May 2018 10:10:51 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>> Convert component enable/disable messages from dev_info to dev_dbg.
>> This is required to prevent LOCKDEP splats when operating in perf
>> mode where we could be called with locks held to enable a coresight
> Can we see the splats?  Doesn't lockdep turn itself off if it starts
> triggering too many splats?
>
>> path. If someone wants to really see the messages, they can always
>> enable it at runtime via dynamic_debug.
> Won't the splats still occur when the messages are enabled with
> dynamic_debug?
>
> So in effect this patch only tries to mitigate the splats, all the
> while making things harder for regular users that now have to recompile
> their kernels, in exchange for a very small convenience for kernel
> developers that happen to see a splat or two with DEBUG_LOCKDEP set?
>
> Not the greatest choice...How about moving the dev_infos outside of the
> locks instead?
>
> Thanks,
>
> Kim
The other reason for making these dev_dbg is performance - a message is 
output each time a source / link / sink is enabled or disabled, so we 
can get 20+ messages on each process switch when tracing with perf.  
This has a significant effect on the runtime of the application being 
traced.

Regards

Rob
