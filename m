Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeA3TRe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:17:34 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39969 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeA3TRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:17:33 -0500
X-Google-Smtp-Source: AH8x224RorlfIBCRK1FPWncsK3YxjumHP+JAdOzz03XZGGN9afKehD7ZUpGb2XJTWC9Y35pcXyft/cvEncBRKK0It8M=
MIME-Version: 1.0
In-Reply-To: <20180130053708.GA3741@linux.vnet.ibm.com>
References: <20180129182309.3869-1-devix84@gmail.com> <20180130053708.GA3741@linux.vnet.ibm.com>
From: Ildar Ismagilov <devix84@gmail.com>
Date: Tue, 30 Jan 2018 22:17:32 +0300
Message-ID: <CADCZxWcTSaWGFi67Ruwyof_=PtZNO-ph7JQF2ZbAbnLpdudE8w@mail.gmail.com>
Subject: Re: [PATCH] srcu: fix misprint in srcu_funnel_exp_start
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't check the performance, because this misprint has been found
accidentally, during studying of a RCU/SRCU code.

2018-01-30 8:37 GMT+03:00 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> On Mon, Jan 29, 2018 at 09:23:09PM +0300, Ildar Ismagilov wrote:
>> Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
>
> The original does look backwards, now that you mention it, thank you
> for sending it.
>
> Did you see any performance differences from this patch?
>
>                                                         Thanx, Paul
>
>> ---
>>  kernel/rcu/srcutree.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 6d5880089ff6..1798d1aa60fa 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -599,7 +599,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
>>               raw_spin_unlock_irqrestore_rcu_node(snp, flags);
>>       }
>>       raw_spin_lock_irqsave_rcu_node(sp, flags);
>> -     if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
>> +     if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
>>               sp->srcu_gp_seq_needed_exp = s;
>>       raw_spin_unlock_irqrestore_rcu_node(sp, flags);
>>  }
>> --
>> 2.11.0
>>
>



-- 
Best regards
Ildar
