Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670A9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6AA208B9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvlHFZap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6AA208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeFTPZs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:25:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35196 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbeFTPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:25:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so5609750lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h1ibE3kEoENvIaTx2f9HGNodpszw2vE575My1OoQ4e4=;
        b=SvlHFZappOP0ffGsfyD5iimSYmbAQHFPA8rVs061eOCuP3jTj+vn1yqyo/w5hx91gc
         1fR+zheb0e3rgoNBlheta7HrH9IjMrC04FCjfC32Ai/seZortzuLL2XkbmbRMNMS0xAJ
         l8cPd14D0Jq1kDuLX4zAsdQxicOfTg7rT2HpzgSjgqO4ayDpL72drY8UYfx6Q/TEJk1I
         3X/fepuRSmPOxGLmE6iMU8u651EU4CJb7nqpG4CqEiAKwUSTMRbKJ7A4CjkNbPLNEinX
         oCzKxmCQ2ZdYUF3wcHlA6kqtnrRJn3NyYAklpBkRRyDETpfllAdD1L2TASxLlscbYuGi
         S99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h1ibE3kEoENvIaTx2f9HGNodpszw2vE575My1OoQ4e4=;
        b=TrLj0Dk3hX3arFBn8Zo9Tj3sEsMR7uanBkbSzA54IAaNc8Q4S0+d5BbWLaMy4x45gf
         XmUBhgFX813sreHXqXPq+3lvyMJXpUHaXrCyZbIQ/DJ0X3xvex0HR5hlcDDRmdKX1lnL
         D6spPjVaFnkq/KM7faG2g29vo6KaUnL1JBqvgHm4nJmQAp3wficsVXT7tif0MD25NpNF
         zl6A8sMJiDh8b7BDVbly2VWK81xdy08ux2wDh2GyOi1aFH4+Vd7I816o9g1xBLzgt4m9
         zOim4CxcgJxPRbNToBrChnfy3ZX/j3ASF31q05lrO3k65GwvZQelq/1sO4gq3cPEtuAE
         RbhQ==
X-Gm-Message-State: APt69E2uo9mRI3b/5jU9BgFo2Ur+zQ8v3zDk0zNdAs6/7OvooNolokaL
        7fUW6JKNiJa40j0iJwQfyRWl+OzYADJub+7YDnDZlr0g
X-Google-Smtp-Source: ADUXVKKkI0HjwyQdTW57KLHYgf+6l8ni0/p1ZkWj+VpTDRQll2Ar81quDk1UHS1e68S7HUjHRNH/e7JCgx0pXQ/arP8=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr15699573lja.25.1529508345357;
 Wed, 20 Jun 2018 08:25:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:44ec:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 08:25:44
 -0700 (PDT)
In-Reply-To: <20180620093309.7d07715a@gandalf.local.home>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com> <20180620093309.7d07715a@gandalf.local.home>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 21 Jun 2018 00:25:44 +0900
Message-ID: <CANrsvRN0QWPK5R_e64Rk=A3F=_-Uaw5ThSQ0uPdCOkp3paug8w@mail.gmail.com>
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on in_nmi()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:33 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 20 Jun 2018 17:47:19 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
>
>> Get rid of dependency on ->dynticks_nmi_nesting.
>
> This is not a trivial change. Can you please explain the rational and
> background in the change log. Add enough context here to know why this
> change is needed.

I'm sorry I didn't. I thought I could add enough explanation after
requesting for comment and getting answer. But I should've done
that :(

The 1st patch is the 1st step for removing ->dynticks_nmi_nesting
entirely from the code, which is done mainly in the 2nd patch.

At the next spin(not RFC), I will add full explanation about what you
point out.

Thanks a lot.

> Thanks!
>
> -- Steve
>
>>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> ---
>>  kernel/rcu/tree.c | 22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index deb2508..59ae94e 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -797,6 +797,11 @@ void rcu_nmi_exit(void)
>>               return;
>>       }
>>
>> +     if (!in_nmi()) {
>> +             rcu_prepare_for_idle();
>> +             rcu_dynticks_task_enter();
>> +     }
>> +
>>       /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>>       trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
>>       WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>> @@ -824,14 +829,8 @@ void rcu_nmi_exit(void)
>>   */
>>  void rcu_irq_exit(void)
>>  {
>> -     struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>> -
>>       lockdep_assert_irqs_disabled();
>> -     if (rdtp->dynticks_nmi_nesting == 1)
>> -             rcu_prepare_for_idle();
>>       rcu_nmi_exit();
>> -     if (rdtp->dynticks_nmi_nesting == 0)
>> -             rcu_dynticks_task_enter();
>>  }
>>
>>  /*
>> @@ -944,6 +943,11 @@ void rcu_nmi_enter(void)
>>       if (rcu_dynticks_curr_cpu_in_eqs()) {
>>               rcu_dynticks_eqs_exit();
>>               incby = 1;
>> +
>> +             if (!in_nmi()) {
>> +                     rcu_dynticks_task_exit();
>> +                     rcu_cleanup_after_idle();
>> +             }
>>       }
>>       trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>>                         rdtp->dynticks_nmi_nesting,
>> @@ -977,14 +981,8 @@ void rcu_nmi_enter(void)
>>   */
>>  void rcu_irq_enter(void)
>>  {
>> -     struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
>> -
>>       lockdep_assert_irqs_disabled();
>> -     if (rdtp->dynticks_nmi_nesting == 0)
>> -             rcu_dynticks_task_exit();
>>       rcu_nmi_enter();
>> -     if (rdtp->dynticks_nmi_nesting == 1)
>> -             rcu_cleanup_after_idle();
>>  }
>>
>>  /*
>



-- 
Thanks,
Byungchul
