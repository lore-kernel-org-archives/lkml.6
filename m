Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeCIIxl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:53:41 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:36813 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeCIIxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:53:35 -0500
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RFC] rcu: Prevent expedite reporting within RCU read-side
 section
From: Byungchul Park <byungchul.park@lge.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
References: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
 <20180306134205.lwmn3cgisnwkngcf@tardis>
 <908c33f9-c8ed-5d4e-91cb-a123de5dbbc7@lge.com>
 <a2e0a9c5-4246-d3b9-2eb7-9bdd87aef636@lge.com>
 <20180307150343.GD3918@linux.vnet.ibm.com> <20180308100825.GA32165@X58A-UD3R>
 <20180308180156.GQ3918@linux.vnet.ibm.com> <20180309084154.GA24031@X58A-UD3R>
Message-ID: <78ee5416-5485-662e-c0a2-0091e30f65e9@lge.com>
Date: Fri, 9 Mar 2018 17:53:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309084154.GA24031@X58A-UD3R>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2018 5:41 PM, Byungchul Park wrote:
> On Thu, Mar 08, 2018 at 10:01:56AM -0800, Paul E. McKenney wrote:
>> On Thu, Mar 08, 2018 at 07:08:25PM +0900, Byungchul Park wrote:
> 
> [...]
> 
>>>     2. Clear its bit of ->expmask *only* when it's out of RCU read
>>>        sections and keep others unchanged. So it will be cleared at the
>>>        end of the RCU read section in that case.
>>>
>>>        This option would also work because we anyway check both
>>>        ->exp_tasks and ->expmask to finish the expedite-gp.
>>
>> This could be made to work, but one shortcoming is that the grace
>> period would end up waiting on later read-side critical sections
>> that it does not really need to wait on.  Also, eventually all the
> 
> I don't think it waits on any later ones since ->expmask would be
> cleared at the end of the previous RCU read section.

Now having simplified my patch, with the simplified version, I can
see what you were saying. Right, the expedite-gp might be extended
as you said. That optimization cannot be achieved this way without
reggression.

You're awesome. Thank you for explaning the reason why not.

-- 
Thanks,
Byungchul
