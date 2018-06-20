Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D6C1B0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4A3208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t23+/T5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4A3208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeFTQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:05:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36629 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753952AbeFTQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:05:24 -0400
Received: by mail-lf0-f65.google.com with SMTP id n24-v6so136350lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WU2XYXXJxV//OHzRw/AAcpe5VZPTYYjDEgySWfj/zQI=;
        b=t23+/T5VtnQQQuDS0Fwww5wBXra4OjEGYPE68/fRBgOMowZWsK79TeEH9v9nKEBNjk
         y6XG/kabcTX01MbwDkJg6sW/Qqo/lelRXLjNyoGpoj+23VuAqtOe3m523McEV8LJ0NYS
         DOCS1qfbnaFDXQ9o76lXiT27+LzdmnMXC5IclT/G3bDWUX38kRIfo0boY5WnnwD4Eny/
         BIAyV5kh1K3gNq5PfYIpScj6NpYGw0lHKQ15aD2Y1lwxOfnKuqrm8DIm3gX1P1AI9auR
         rutF3ju8HhNfgmEkkva6ATCNFDVk4g6QijDzRziF8kaOPQBGUUTaQbiNzrPzWCFvTmZB
         mmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WU2XYXXJxV//OHzRw/AAcpe5VZPTYYjDEgySWfj/zQI=;
        b=gm6gstZ3VZrzz1EPudzx+d/3GC0/SlFfsNci255RBZfXYlDwY5Siofd2jzb6aB2VyI
         ylNLDbFjJ97oZfF5b1WD5YkOlvLCPZnOnO4wqZ8UWvbXIVHN7N05C43VBF4d1l2RjCeb
         pEYRVlPTJtcfG+TCuk/oPEA1O1J/9ht0WEWqqKKVFgEXBI7zUrb/DBnBSrRpyoEXvmGH
         Z1k4Yn37N/l7oSpcrgDDgM2OzlvelH/Tr8coAdMiAvUVy2gfMtG/3Yj6aydoHynAN2pu
         ZmIXYKOw1oGsflKT8VxyM9n+sCER9S1awylCWEyCiRR+bgf/YIARSBOp8vqDKTGBD/s/
         rEOQ==
X-Gm-Message-State: APt69E1GLqiHFLdpSZsGqYKd247iT+sW7OqG1XqIhIjXacd5ZmDkSs/S
        Qjx9N8tAAG/ficFYtx/j+5pS5kmvTtOJE9XbIz0=
X-Google-Smtp-Source: ADUXVKLN3yYFGQCP705D+drPmOq4CQiJMnzVBJQElfcKx5h74ViIzQ5455ZFTqfTOQ62XVaK1pmGkeRA+/k7JBHlxV4=
X-Received: by 2002:a2e:1188:: with SMTP id 8-v6mr15548348ljr.38.1529510722932;
 Wed, 20 Jun 2018 09:05:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:44ec:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:05:22
 -0700 (PDT)
In-Reply-To: <20180620145814.GQ3593@linux.vnet.ibm.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com> <20180620145814.GQ3593@linux.vnet.ibm.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 21 Jun 2018 01:05:22 +0900
Message-ID: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:58 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Wed, Jun 20, 2018 at 05:47:20PM +0900, Byungchul Park wrote:
>> Hello folks,
>>
>> I'm careful in saying that ->dynticks_nmi_nesting can be removed but I
>> think it's possible since the only thing we are interested in with
>> regard to ->dynticks_nesting or ->dynticks_nmi_nesting is whether rcu is
>> idle or not.
>
> Please keep in mind that NMIs cannot be masked, which means that the
> rcu_nmi_enter() and rcu_nmi_exit() pair can be invoked at any point in
> the process, between any consecutive pair of instructions.  The saving

I believe I understand what NMI is and why you introduced
->dynticks_nmi_nesting. Or am I missing something?

> grace is that these two functions restore state, but you cannot make them.
> After all, NMI does stand for non-maskable interrupt.

Excuse me, but I think I've considered that all. Could you show me
what problem can happen with this?

These two functions, rcu_nmi_enter() and rcu_nmi_exit(), would still
save and restore the state with ->dynticks_nesting.

Even though I made ->dynticks_nesting shared between NMI and
other contexts entering or exiting eqs, I believe it's not a problem
because anyway the variable would be updated and finally restored
in a *nested* manner.

> At first glance, the code below does -not- take this into account.

Excuse me, but could explain it more? I don't understand your point :(

> What am I missing that would make this change safe?  (You would need to
> convince both me and Andy Lutomirski, who I have added on CC.)

Thanks for doing that.

>> And I'm also afraid if the assumption is correct for every archs which I
>> based on, that is, an assignment operation on a single aligned word is
>> atomic in terms of instruction.
>
> The key point is that both ->dynticks_nesting and ->dynticks_nmi_nesting
> are accessed only by the corresponding CPU (other than debug prints).
> Load and store tearing should therefore not be a problem.  Are there

Right. But I thought it can be a problem between NMI and other contexts
because I made ->dynticks_nesting shared between NMI and others.

> other reasons to promote to READ_ONCE() and WRITE_ONCE()?  If there are,
> a separate patch doing that promotion would be good.

But the promotion is meaningless without making ->dynticks_nesting
shared as you said. I'm afraid it's too dependent on this patch to
separate it.

I'm sorry I don't understand your point. It would be very appreciated if
you explain it more about what I'm missing or your point :(

>                                                         Thanx, Paul
>
>> Thoughs?
>>
>> ----->8-----
>> >From 84970b33eb06c3bb1bebbb1754db405c0fc50fbe Mon Sep 17 00:00:00 2001
>> From: Byungchul Park <byungchul.park@lge.com>
>> Date: Wed, 20 Jun 2018 16:01:20 +0900
>> Subject: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
>>
>> The only thing we are interested in with regard to ->dynticks_nesting or
>> ->dynticks_nmi_nesting is whether rcu is idle or not, which can be
>> handled only using ->dynticks_nesting though. ->dynticks_nmi_nesting is
>> unnecessary but to make the code more complicated.
>>
>> This patch makes both rcu_eqs_{enter,exit}() and rcu_nmi_{enter,exit}()
>> count up and down a single variable, ->dynticks_nesting to keep how many
>> rcu non-idle sections have been nested.
>>
>> As a result, no matter who made the variable be non-zero, it's anyway
>> non-idle, and it can be considered as just having been idle once the
>> variable is equal to zero. So tricky code can be removed.
>>
>> In addition, it was assumed that an assignment operation on a single
>> aligned word is atomic so that ->dynticks_nesting can be safely assigned
>> within both nmi context and others concurrently.
>>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> ---
>>  kernel/rcu/tree.c        | 76 ++++++++++++++++++++----------------------------
>>  kernel/rcu/tree.h        |  4 +--
>>  kernel/rcu/tree_plugin.h |  4 +--
>>  3 files changed, 35 insertions(+), 49 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 59ae94e..61f203a 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -260,7 +260,6 @@ void rcu_bh_qs(void)
>>
>>  static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
>>       .dynticks_nesting = 1,
>> -     .dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
>>       .dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
>>  };
>>
>> @@ -694,10 +693,6 @@ static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
>>  /*
>>   * Enter an RCU extended quiescent state, which can be either the
>>   * idle loop or adaptive-tickless usermode execution.
>> - *
>> - * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
>> - * the possibility of usermode upcalls having messed up our count
>> - * of interrupt nesting level during the prior busy period.
>>   */
>>  static void rcu_eqs_enter(bool user)
>>  {
>> @@ -706,11 +701,11 @@ static void rcu_eqs_enter(bool user)
>>       struct rcu_dynticks *rdtp;
>>
>>       rdtp = this_cpu_ptr(&rcu_dynticks);
>> -     WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
>>       WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>>                    rdtp->dynticks_nesting == 0);
>>       if (rdtp->dynticks_nesting != 1) {
>> -             rdtp->dynticks_nesting--;
>> +             WRITE_ONCE(rdtp->dynticks_nesting, /* No store tearing. */
>> +                        rdtp->dynticks_nesting - 1);
>>               return;
>>       }
>>
>> @@ -767,7 +762,7 @@ void rcu_user_enter(void)
>>   * rcu_nmi_exit - inform RCU of exit from NMI context
>>   *
>>   * If we are returning from the outermost NMI handler that interrupted an
>> - * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
>> + * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nesting
>>   * to let the RCU grace-period handling know that the CPU is back to
>>   * being RCU-idle.
>>   *
>> @@ -779,21 +774,21 @@ void rcu_nmi_exit(void)
>>       struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>>
>>       /*
>> -      * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
>> +      * Check for ->dynticks_nesting underflow and bad ->dynticks.
>>        * (We are exiting an NMI handler, so RCU better be paying attention
>>        * to us!)
>>        */
>> -     WARN_ON_ONCE(rdtp->dynticks_nmi_nesting <= 0);
>> +     WARN_ON_ONCE(rdtp->dynticks_nesting <= 0);
>>       WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
>>
>>       /*
>>        * If the nesting level is not 1, the CPU wasn't RCU-idle, so
>>        * leave it in non-RCU-idle state.
>>        */
>> -     if (rdtp->dynticks_nmi_nesting != 1) {
>> -             trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nmi_nesting, rdtp->dynticks_nmi_nesting - 2, rdtp->dynticks);
>> -             WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* No store tearing. */
>> -                        rdtp->dynticks_nmi_nesting - 2);
>> +     if (rdtp->dynticks_nesting != 1) {
>> +             trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nesting, rdtp->dynticks_nesting - 1, rdtp->dynticks);
>> +             WRITE_ONCE(rdtp->dynticks_nesting, /* No store tearing. */
>> +                        rdtp->dynticks_nesting - 1);
>>               return;
>>       }
>>
>> @@ -803,8 +798,8 @@ void rcu_nmi_exit(void)
>>       }
>>
>>       /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>> -     trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
>> -     WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>> +     trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nesting, 0, rdtp->dynticks);
>> +     WRITE_ONCE(rdtp->dynticks_nesting, 0); /* Avoid store tearing. */
>>       rcu_dynticks_eqs_enter();
>>  }
>>
>> @@ -851,10 +846,6 @@ void rcu_irq_exit_irqson(void)
>>  /*
>>   * Exit an RCU extended quiescent state, which can be either the
>>   * idle loop or adaptive-tickless usermode execution.
>> - *
>> - * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
>> - * allow for the possibility of usermode upcalls messing up our count of
>> - * interrupt nesting level during the busy period that is just now starting.
>>   */
>>  static void rcu_eqs_exit(bool user)
>>  {
>> @@ -866,7 +857,8 @@ static void rcu_eqs_exit(bool user)
>>       oldval = rdtp->dynticks_nesting;
>>       WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
>>       if (oldval) {
>> -             rdtp->dynticks_nesting++;
>> +             WRITE_ONCE(rdtp->dynticks_nesting, /* No store tearing. */
>> +                        rdtp->dynticks_nesting + 1);
>>               return;
>>       }
>>       rcu_dynticks_task_exit();
>> @@ -875,7 +867,6 @@ static void rcu_eqs_exit(bool user)
>>       trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
>>       WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>>       WRITE_ONCE(rdtp->dynticks_nesting, 1);
>> -     WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
>>  }
>>
>>  /**
>> @@ -915,11 +906,11 @@ void rcu_user_exit(void)
>>  /**
>>   * rcu_nmi_enter - inform RCU of entry to NMI context
>>   *
>> - * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
>> - * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
>> - * that the CPU is active.  This implementation permits nested NMIs, as
>> - * long as the nesting level does not overflow an int.  (You will probably
>> - * run out of stack space first.)
>> + * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks. And
>> + * then update rdtp->dynticks_nesting to let the RCU grace-period handling
>> + * know that the CPU is active.  This implementation permits nested NMIs,
>> + * as long as the nesting level does not overflow an int.  (You will
>> + * probably run out of stack space first.)
>>   *
>>   * If you add or remove a call to rcu_nmi_enter(), be sure to test
>>   * with CONFIG_RCU_EQS_DEBUG=y.
>> @@ -927,33 +918,29 @@ void rcu_user_exit(void)
>>  void rcu_nmi_enter(void)
>>  {
>>       struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>> -     long incby = 2;
>>
>>       /* Complain about underflow. */
>> -     WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
>> +     WARN_ON_ONCE(rdtp->dynticks_nesting < 0);
>>
>> -     /*
>> -      * If idle from RCU viewpoint, atomically increment ->dynticks
>> -      * to mark non-idle and increment ->dynticks_nmi_nesting by one.
>> -      * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
>> -      * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
>> -      * to be in the outermost NMI handler that interrupted an RCU-idle
>> -      * period (observation due to Andy Lutomirski).
>> -      */
>>       if (rcu_dynticks_curr_cpu_in_eqs()) {
>>               rcu_dynticks_eqs_exit();
>> -             incby = 1;
>>
>>               if (!in_nmi()) {
>>                       rcu_dynticks_task_exit();
>>                       rcu_cleanup_after_idle();
>>               }
>>       }
>> -     trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>> -                       rdtp->dynticks_nmi_nesting,
>> -                       rdtp->dynticks_nmi_nesting + incby, rdtp->dynticks);
>> -     WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* Prevent store tearing. */
>> -                rdtp->dynticks_nmi_nesting + incby);
>> +
>> +     trace_rcu_dyntick(rdtp->dynticks_nesting ? TPS("++=") : TPS("Endirq"),
>> +                       rdtp->dynticks_nesting,
>> +                       rdtp->dynticks_nesting + 1, rdtp->dynticks);
>> +     /*
>> +      * If ->dynticks_nesting is equal to one on rcu_nmi_exit(), we are
>> +      * guaranteed to be in the outermost NMI handler that interrupted
>> +      * an RCU-idle period (observation due to Andy Lutomirski).
>> +      */
>> +     WRITE_ONCE(rdtp->dynticks_nesting, /* Prevent store tearing. */
>> +                rdtp->dynticks_nesting + 1);
>>       barrier();
>>  }
>>
>> @@ -1089,8 +1076,7 @@ bool rcu_lockdep_current_cpu_online(void)
>>   */
>>  static int rcu_is_cpu_rrupt_from_idle(void)
>>  {
>> -     return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 0 &&
>> -            __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
>> +     return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 1;
>>  }
>>
>>  /*
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index 4e74df7..071afe4 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -38,8 +38,8 @@
>>   * Dynticks per-CPU state.
>>   */
>>  struct rcu_dynticks {
>> -     long dynticks_nesting;      /* Track process nesting level. */
>> -     long dynticks_nmi_nesting;  /* Track irq/NMI nesting level. */
>> +     long dynticks_nesting __attribute__((aligned(sizeof(long))));
>> +                                 /* Track process nesting level. */
>>       atomic_t dynticks;          /* Even value for idle, else odd. */
>>       bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
>>       unsigned long rcu_qs_ctr;   /* Light universal quiescent state ctr. */
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index c1b17f5..0c57e50 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -1801,7 +1801,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
>>       }
>>       print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
>>       delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
>> -     pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
>> +     pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld softirq=%u/%u fqs=%ld %s\n",
>>              cpu,
>>              "O."[!!cpu_online(cpu)],
>>              "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
>> @@ -1811,7 +1811,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
>>                               "!."[!delta],
>>              ticks_value, ticks_title,
>>              rcu_dynticks_snap(rdtp) & 0xfff,
>> -            rdtp->dynticks_nesting, rdtp->dynticks_nmi_nesting,
>> +            rdtp->dynticks_nesting,
>>              rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>>              READ_ONCE(rsp->n_force_qs) - rsp->n_force_qs_gpstart,
>>              fast_no_hz);
>> --
>> 1.9.1
>>
>



-- 
Thanks,
Byungchul
