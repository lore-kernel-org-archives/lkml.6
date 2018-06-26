Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9A321A05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIBhQIW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9A321A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeFZSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:41:39 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:47063 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeFZSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:41:38 -0400
Received: by mail-ua0-f195.google.com with SMTP id r18-v6so5573033ual.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rZMe/zZG/lhVIRB2o5nVF2Y4yi/wdkftqNYBNdg3OKY=;
        b=nIBhQIW2bsrO8+cygRo8i2lcP9b7UfPlguzyb7JEKDHn6TB9VMH0uk/Kr4FQuDevtb
         jbq/Hns2+5+3ah1iwIQzBK2MjZcuTZ/+xsmfnSb9vMtwQWXPwXr+whAODGlsncKKxkCP
         EkN3fykReUnTED5PcMtHNwoL3vY7DVRdhS0lj1TTY5yYkqf2naKmxHL8YObgVx/bpw1A
         2K80N+vP2AhFEmUjIPnRifrjxXBp0ldRk0rdwxivzWnMzsETFtyMpAmH961IN9LBZdjU
         tqAtLfO7i0OiZERf9PeLSdbY+ZM3L9d44p520wo7NHVK6KY58gRvuDlAFQjJhCzvP/do
         zE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rZMe/zZG/lhVIRB2o5nVF2Y4yi/wdkftqNYBNdg3OKY=;
        b=HjYxDUN87jst9wGsHrgV7jxLF2f0IrWCWpvJiaDX4Enq+xLgujPzgUBCcr6Rs+n6iO
         2F2vzNQum9Shcnb1038kgnLE2rohJmuk0T2+tVYTVWE18jzKpplL2oZqe5KLv+h20Gxc
         wK74xj0MhpHvTSIJKPhlH7AA8C5Y7ZVtvD7bZ3rR/pnEBqe1ReX3F+5Kzv+XJJ3Qbuqm
         KJ7RulaZfkX8xnhrr3JK0guTOHXy2hiPH6qU5guSmeOBwSb8z+SU6lvHMYl02+VHOxp+
         4DAAP6HBuqgmaHplIADdDYkgpbPel5t2wSfMvQYDFezw0wzBN6hrUsW8Zgc15GCTL1VR
         lJbw==
X-Gm-Message-State: APt69E0GzPdjzmIOh/Q2bgORFvNhirN6ZJBgK7mJkPCO+adUQtf/dQhJ
        z4CbONFFT/m1R8H+174QTH1CHwOAuCspGxxa+Oc=
X-Google-Smtp-Source: AAOMgpeCFC/D/GTu041yQ0uPXntuZ4GY/3d073bmFa/PhgAXCvCQQFJWUC3pSyRtrn4/deu6M3jatsbp39xUbEYHHBk=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr1754030uai.122.1530038497514;
 Tue, 26 Jun 2018 11:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 11:41:36
 -0700 (PDT)
In-Reply-To: <1530035183.3205.6.camel@arista.com>
References: <20180626162438.16306-1-dima@arista.com> <CAHp75VchWpr+76rBCmXctpYi5a06pr-MT==FrNDy03g=boxfog@mail.gmail.com>
 <1530035183.3205.6.camel@arista.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 21:41:36 +0300
Message-ID: <CAHp75VfxajbTK3azfRWVBY6+f91JjGZwzHKrhQcHXDw9xeO_HA@mail.gmail.com>
Subject: Re: [PATCHv2] lib/ratelimit: Lockless ratelimiting
To:     Dmitry Safonov <dima@arista.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:46 PM, Dmitry Safonov <dima@arista.com> wrote:
> On Tue, 2018-06-26 at 20:04 +0300, Andy Shevchenko wrote

>> >  #define RATELIMIT_STATE_INIT(name, interval_init, burst_init)
>> > {                \
>> > -               .lock           =
>> > __RAW_SPIN_LOCK_UNLOCKED(name.lock),  \
>>
>> name is now redundant, isn't it?
>
> It is. Worth to split on the second patch or keep callers changes in
> this patch?

For me sounds like a part of this change, though weakly tighten to the
main purpose.
Otherwise in the middle of the series you introduce some bogus stuff
(not sure if compiler or some static analyzers would warn about it).

>> > @@ -42,9 +41,10 @@ static inline void ratelimit_state_init(struct
>> > ratelimit_state *rs,
>> >  {
>> >         memset(rs, 0, sizeof(*rs));
>> >
>> > -       raw_spin_lock_init(&rs->lock);
>> >         rs->interval    = interval;
>> >         rs->burst       = burst;
>> > +       atomic_set(&rs->printed, 0);
>> > +       atomic_set(&rs->missed, 0);
>>
>> Can it be
>>
>> *rs = RATELIMIT_STATE_INIT(interval, burst);
>>
>> ?
>>
>> (Yes, the '(struct ratelimit_state)' has to be added to macro to
>> allow this)
>
> Sure.

This part, by the way, potentially can be split into preparatory
patch. Please, double check if it possible to do this way.

>> > -       if (rs->missed) {
>> > +       if ((missed = atomic_xchg(&rs->missed, 0)))
>>
>> Perhaps
>>
>> missed = ...
>> if (missed)
>>
>> ?
>
> Ok, will change - checkpatch has warned me, but I thought it's just a
> preference than a rule.

In general, yes and no. In this case it would increase readability and
assignment inside conditionals is not the best practice.

>> Instead of casting, perhaps
>>
>> int missed = ...
>>
>> I think you already has a guard against going it below zero. Or I
>> missed something?
>
> No, I do:
> atomic_add_unless(&rs->missed, 1, -1);
>
> So, it's guard against overflow, but not against negative.
> That's why I do print it as unsigned.

Hmm...
If you increment the variable, it would become 2^n, then 2^n + 1, ...
which in unsigned form quite far from -1.

So, this check is against revolving the value.
Otherwise you are using atomic_t as unsigned type indeed.

But in case of use you assign signed to unsigned which would not
overflow, so, the casting is superfluous.

(and I would rather go with unsigned int type instead of unsigned if
it fits style of the module)

-- 
With Best Regards,
Andy Shevchenko
