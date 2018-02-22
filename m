Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeBVFFZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:05:25 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:36021 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:05:24 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [QUESTION] srcu: Remove the SCAN2 state
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
References: <1519257447-4232-1-git-send-email-byungchul.park@lge.com>
 <20180222021147.GA2855@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <fb00133e-776b-50c7-1a46-b56c3339622b@lge.com>
Date: Thu, 22 Feb 2018 14:05:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222021147.GA2855@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2018 11:11 AM, Paul E. McKenney wrote:
> On Thu, Feb 22, 2018 at 08:57:27AM +0900, Byungchul Park wrote:
>> Hello,
>>
>> I'm sorry for bothering you, and I seem to be obviously missing
>> something, but I'm really wondering why we check try_check_zero()
>> again in the state, SCAN1, for the previous srcu_idx.
>>
>> I mean, since we've already checked try_check_zero() in the previous
>> grace period and gotten 'true' as a return value, all readers who see
>> the flipped idx via srcu_flip() won't update the src_{lock,unlock}_count
>> for the previous idx until it gets flipped back again.
>>
>> Is there any reasons we check try_check_zero() again in the state, SCAN1?
>> Is there any problems if the following patch's applied?
> 
> Indeed there are!  Removing the second scan exposes us to a nasty race
> condition where a reader is preempted (or interrupted or whatever) just

Indeed! I missed the cases. It should be as it is.

Thanks a lot for pointing it out.

> after fetching its counter.  A detailed explanation for an essentially

-- 
Thanks,
Byungchul
