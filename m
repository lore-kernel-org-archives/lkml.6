Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBXWr3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:47:29 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37729 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeBXWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:47:28 -0500
X-Google-Smtp-Source: AH8x224owZl9ZMhThlB/sidsgYFDKRN8a2jrBakt2c4BCCLeHtyiOMiUJEiUwY2/GXEii2StlIDdEQ==
Subject: Re: [PATCH] tools/memory-model: update: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20180224143658.GA3556@andrea>
 <Pine.LNX.4.44L0.1802241149090.14116-100000@netrider.rowland.org>
 <20180224180814.GV2855@linux.vnet.ibm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <b01f23b8-058c-a968-2b09-37f315e76681@gmail.com>
Date: Sun, 25 Feb 2018 07:47:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224180814.GV2855@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/02/24 10:08:14 -0800, Paul E. McKenney wrote:
> On Sat, Feb 24, 2018 at 11:49:20AM -0500, Alan Stern wrote:
>> On Sat, 24 Feb 2018, Andrea Parri wrote:
>>
>>> On Fri, Feb 23, 2018 at 07:30:13PM -0800, Paul E. McKenney wrote:
>>>> On Sat, Feb 24, 2018 at 12:22:24PM +0900, Akira Yokosawa wrote:
>>>>> On 2018/02/22 07:29:02 +0900, Akira Yokosawa wrote:
>>>>>> On 2018/02/22 2:15, Alan Stern wrote:
>>>
>>> [...]
>>>
>>>>>>>
>>>>>>> Akira pointed out some typos in the original patch, and he noted that
>>>>>>> cheatsheet.txt should be updated to indicate how unsuccessful RMW
>>>>>>> operations relate to address dependencies.
>>>>>>
>>>>>> My point was to separate unannotated loads from READ_ONCE(), if the
>>>>>> cheatsheet should concern such accesses as well.
>>>>>> Unsuccessful RMW operations were brought up by Andrea.
>>>>>>
>>>>>
>>>>> Paul, can you amend above paragraph in the change log to something like:
>>>>>
>>>>>     Akira pointed out some typos in the original patch, and he noted that
>>>>>     cheatsheet.txt should be updated to indicate READ_ONCE() implies
>>>>>     address dependency, which invited Andrea's observation that it should
>>>>>     also be updated to indicate how unsuccessful RMW operations relate to
>>>>>     address dependencies.
>>>>>
>>>>> , if Alan and Andrea are OK with the amendment.
>>>>>
>>>>> Also, please append my Acked-by.
>>>>>
>>>>> Acked-by: Akira Yokosawa <akiyks@gmail.com>
>>>>
>>>> I can still amend this, and have added your Acked-by.  If Alan and Andrea
>>>> OK with your change, I will apply that also.
>>>
>>> LGTM. Thanks,
>>
>> Me too.
> 
> Very good, how about this for the new version?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 21ede43970e50b7397420f17ed08bb02c187e2eb
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Feb 21 12:15:56 2018 -0500
> 
>     tools/memory-model: Update: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference
>     
>     Commit bf28ae562744 ("tools/memory-model: Remove rb-dep,
>     smp_read_barrier_depends, and lockless_dereference") was accidentally
>     merged too early, while it was still in RFC form.  This patch adds in
>     the missing pieces.
>     
>     Akira pointed out some typos in the original patch, and he noted that
>     cheatsheet.txt should indicate that READ_ONCE() now implies an address
>     dependency.  Andrea suggested documenting the relationship betwwen
>     unsuccessful RMW operations and address dependencies.

Looks good. But I've found a remaining typo in the patch. See below.

>     >     Andrea pointed out that the macro for rcu_dereference() in linux.def
>     should now use the "once" annotation instead of "deref".  He also
>     suggested that the comments should mention commit 5a8897cc7631
>     ("locking/atomics/alpha: Add smp_read_barrier_depends() to
>     _release()/_relaxed() atomics") as an important precursor, and he
>     contributed commit cb13b424e986 ("locking/xchg/alpha: Add
>     unconditional memory barrier to cmpxchg()"), another prerequisite.
>     
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Suggested-by: Akira Yokosawa <akiyks@gmail.com>
>     Suggested-by: Andrea Parri <parri.andrea@gmail.com>
>     Fixes: bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")
>     Acked-by: Andrea Parri <parri.andrea@gmail.com>
>     Acked-by: Akira Yokosawa <akiyks@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> index 04e458acd6d4..956b1ae4aafb 100644
> --- a/tools/memory-model/Documentation/cheatsheet.txt
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -1,11 +1,11 @@
>                                    Prior Operation     Subsequent Operation
>                                    ---------------  ---------------------------
>                                 C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
> -                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
> +                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
>  
>  Store, e.g., WRITE_ONCE()            Y                                       Y
> -Load, e.g., READ_ONCE()              Y                              Y        Y
> -Unsuccessful RMW operation           Y                              Y        Y
> +Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> +Unsuccessful RMW operation           Y                          Y   Y        Y
>  rcu_dereference()                    Y                          Y   Y        Y
>  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
>  Successful *_release()         C        Y  Y    Y     W                      Y
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index dae8b8cb2ad3..889fabef7d83 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -826,7 +826,7 @@ A-cumulative; they only affect the propagation of stores that are
>  executed on C before the fence (i.e., those which precede the fence in
>  program order).
>  
> -read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
> +read_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have

   rcu_read_lock()

Don't ask why I missed this in the first place...

Paul, can you fix this directly?

        Thanks, Akira
        
>  other properties which we discuss later.
>  
>  
> @@ -1138,7 +1138,7 @@ final effect is that even though the two loads really are executed in
>  program order, it appears that they aren't.
>  
>  This could not have happened if the local cache had processed the
> -incoming stores in FIFO order.  In constrast, other architectures
> +incoming stores in FIFO order.  By contrast, other architectures
>  maintain at least the appearance of FIFO order.
>  
>  In practice, this difficulty is solved by inserting a special fence
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index 5dfb9c7f3462..397e4e67e8c8 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -13,7 +13,7 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
>  smp_store_release(X,V) { __store{release}(*X,V); }
>  smp_load_acquire(X) __load{acquire}(*X)
>  rcu_assign_pointer(X,V) { __store{release}(X,V); }
> -rcu_dereference(X) __load{deref}(X)
> +rcu_dereference(X) __load{once}(X)
>  
>  // Fences
>  smp_mb() { __fence{mb} ; }
> 
