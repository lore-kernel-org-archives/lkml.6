Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0010EC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA9420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgoDMk60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA9420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbeFTRPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:15:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37408 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754059AbeFTRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:15:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so444352lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dPmNaPzhp65HlzELLdqo7kzurA1fq8VrfyzeIAXWSi0=;
        b=QgoDMk600GjubEi+mZKdt4KP9c49WWTMMjjzfYvQGDaJa94U1BVCu0MqQGeMW2ZAj0
         iWVrlytC2t7KVy2tiSVlJazTKtfU0g09H0cjWXdXORncmTy5Jd5cifVyu0pZXRSPTULA
         l0EyfPktNgl3rI8+uwoKsu3elil7j/FSqaBT5QbM03bhAeYnF9gZusdZXou5D4eCOWXF
         vApDgcH2cWQWHR4HOLgxk7Y8myUgP5LOsPcH0QY+g3Pn/UAHQyGe/ULYA6pKc1F2bPjo
         YSwTDhi+BdggDQZA7mujanOZ0x74sYAhIqnaRazCaCofWt0zMZ8SnhOAGfu/TpEdIZJT
         dJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dPmNaPzhp65HlzELLdqo7kzurA1fq8VrfyzeIAXWSi0=;
        b=pQl7d+f0HmrVzxVCjDHMqtv+JVfA76JQs0shxiLzDhJhp4O52aeMxFQ9pfRLg8Kgzj
         fY/5g6zRRhkjNlfUkoFKR4JhKe0Uqp12iWje/DsGZ6YJJh6hFaBiNtzYrZIBY8EeZwBc
         DX4pGoUgZ7NHttP444932KHxrSTLsnjj5RJGY51lTxxPMRou2FRndK3Z4a9fuLT3IL8Q
         lo5oDDSamHLTjszUzWZMn84sokL2ebTVTLIEsl3+9ppUqXdgK0wRueLWdWNA9ULgjoiQ
         kR47aIo+iNrn+ZlvVdEsHAc/W/23368q+CdVygTlkX5dsDx7XNSzmE1mrg4VL71W/O5O
         pbmg==
X-Gm-Message-State: APt69E0MdY9ZdQJcZJ8+28HDOccCsOnIzEWJiNdUzkcRfYsEvz3+5AkS
        EK1f2IHvR7CmAxZyBkwk2RzHigPSWt9ETcKAX5I=
X-Google-Smtp-Source: ADUXVKJVcZuJoNiarWeiddXlhW+bn5qPwWxN1VK0MgE8ITYmhC++eLJGnsmnUdENPJoLfHDTRNHuvcKlh0yyQNHSOS4=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr15985846lja.25.1529514907912;
 Wed, 20 Jun 2018 10:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:44ec:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 10:15:07
 -0700 (PDT)
In-Reply-To: <20180620164902.GW3593@linux.vnet.ibm.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com> <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 21 Jun 2018 02:15:07 +0900
Message-ID: <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
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

On Thu, Jun 21, 2018 at 1:49 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

[...]

> Perhaps the fact that there are architectures that can enter interrupt
> handlers and never leave them when the CPU is non-idle.  One example of
> this is the usermode upcalls in the comment that you removed.
>
> Or have all the architectures been modified so that each and every call to
> rcu_irq_enter() and to rcu_irq_exit() are now properly paired and nested?
>
> Proper nesting and pairing was -not- present in the past, hence the
> special updates (AKA "crowbar") to the counters when transitioning to
> and from idle.

Thank you very much for explaining it in detail.

> If proper nesting and pairing of rcu_irq_enter() and rcu_irq_exit()
> is now fully in force across all architectures and configurations, the
> commit log needs to say this, preferably pointing to the corresponding
> commits that made this change.

Right.

> There is a call to rcu_irq_enter() without a corresponding call to
> rcu_irq_exit(), so that the ->dynticks_nesting counter never goes back to
> zero so that the next time this CPU goes idle, RCU thinks that the CPU
> is still non-idle.  This can result in excessively long grace periods
> and needless IPIs to idle CPUs.

No doubt.

> But only if calls to rcu_irq_enter() and rcu_irq_exit() are now always
> properly paired and nested, which was definitely -not- the case last
> I looked.

I missed it. Right. It's worth only in the case that calls to rcu_irq_enter()
and rcu_irq_exit() are always properly paired and nested.

> OK, so I can further consider this pair of patches only if
> all architectures now properly pair and nest rcu_irq_enter() and
> rcu_irq_exit().  It would be very good if they did, but actually testing
> back in the day showed that they did not.  If that has changed, that
> would be a very good thing, but if not, this patch injects bugs.

Totally agree with you. Sorry bothering you.

-- 
Thanks,
Byungchul
