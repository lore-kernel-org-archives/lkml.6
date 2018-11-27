Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EA4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F29208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4OWCfft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F29208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeK0T6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:58:49 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:42055 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbeK0T6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:58:49 -0500
Received: by mail-io1-f46.google.com with SMTP id x6so16357443ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17OMeXdA+cn8HDvQagvMUiDn7pfkIoSy4U5d6D8C3Nw=;
        b=C4OWCfftDFbmkfQ8BcCdth7LFlC4eQ629TA5KpmSfJmm8024F4wI/AB+2OUGjUvkKF
         1apaZAGyaMVF9MMAA+q+IRyfjs9EqIW1KPzs6Amvwd2CfKlADy0xclNn2Na99GYdU4js
         3zIn0kEMPrUsEZ/PfpkXEXgtU69vxeKtEEpTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17OMeXdA+cn8HDvQagvMUiDn7pfkIoSy4U5d6D8C3Nw=;
        b=cWZ/PGqMBaK4120Jii682v2ST5J4+R2einaQRmLx7fuLNO9npvegxUybNVOIxZFL+d
         1ctkVwzzgkd3+/KQszNrW9nS6jXsIPoJGOGHT9lAM/DIHG21HKXHxbVPt+RUsZOUr+y8
         5Iz8TEpjqdFv7wKHxvY0M6tkizqA94WxbWsKxuAYt4IuCbiTXvJly1ovrgoYkusL8Vti
         c1emX6kUq/fHezeV4akchbsXfiRhPRo9Tyh8uggm9gxfN0JRBFvVgNbQckmH0VSSdW0X
         C7O/8Le/04AYq7i/334K17kIksgmCKphPFnt9gYIBscq0EtRyV6bkReW4GAejQhpc0AY
         /lrg==
X-Gm-Message-State: AA+aEWbC4uVqVUA45JgVtTYdwm50GypzjtkUfpWjA9EoYb141QJGB8uR
        pQDyxIIq9PosbRXgAPoYEje+V3ubvb0H9KoJ/4hE/g==
X-Google-Smtp-Source: AFSGD/VKS+9L2vn+M9FcyUC2DmJGZkDa5RyvlNSPavwBiht8nSxMlo7qQ9lxpkrj2BbIVUrCAFiamjx4nJkTRmRoUS4=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr22690561iof.183.1543309295825;
 Tue, 27 Nov 2018 01:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20181121223453.GA4016@andrea> <20181126093051.GV2131@hirez.programming.kicks-ass.net>
 <CAKfTPtDm49JS7thuUn0--ocqpn2Du4qi8qsUeeHzGrAG_F2epw@mail.gmail.com> <20181126204414.GA4643@andrea>
In-Reply-To: <20181126204414.GA4643@andrea>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Nov 2018 10:01:24 +0100
Message-ID: <CAKfTPtBjA-oCBRkO6__npQwL3+HLjzk7riCcPU1R7YdO-EpuZg@mail.gmail.com>
Subject: Re: [Question] atomic_fetch_andnot() in nohz_idle_balance()
To:     andrea.parri@amarulasolutions.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 21:44, Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> On Mon, Nov 26, 2018 at 12:37:00PM +0100, Vincent Guittot wrote:
> > On Mon, 26 Nov 2018 at 10:30, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Nov 21, 2018 at 11:34:53PM +0100, Andrea Parri wrote:
> > > > Hi,
> > > >
> > > > The comment for the atomic_fetch_andnot() in nohz_idle_balance() says:
> > > >
> > > >   "barrier, pairs with nohz_balance_enter_idle(), ensures ..."
> > > >
> > > > which, well, does sound a note of warning... ;-)
> > > >
> > > > I see that nohz_balance_enter_idle() has an smp_mb__after_atomic() but
> > > > the comment for the latter suggests that this barrier is pairing with
> > > > the smp_mb() in _nohz_idle_balance().
> > > >
> > > > So, what is the intended pairing barrier for the atomic_fetch_andnot()?
> > > > what (which memory accesses) do you want "to order" here?
> > >
> > > I can't seem to make sense of that comment either; the best I can come
> > > up with is that it would order the prior NOHZ_KICK_MASK load vs us then
> > > changing it.
> > >
> > > But that would order against kick_ilb(), not enter_idle.
> > >
> > > Vincent?
> >
> > I can't come with a good explanation.
> > After looking into my email archive, the only explanation that i have
> > is that the comments remains from a previous iteration of the feature
> > that was based on a nohz.stats_state mechanism
>
> I'm afraid I still can't help your comment...  put in other terms, would
> you feel "unconfortable" with _relax()ing the andnot()?  (and if so ...)

so I think that the comment is useless and can be removed because it
was referring to a line code above the comment that was present in a
previous iteration of the patchset. This line disappeared in final
version but the comment has stayed.

If your question is: can we use atomic_fetch_andnot_relaxed() instead
of atomic_fetch_andnot() in nohz_idle_balance() ?
I think that it's possible

>
>   Andrea
