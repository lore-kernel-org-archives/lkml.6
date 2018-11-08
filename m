Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF14ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8392F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fggXpbK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8392F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKIGc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:32:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38977 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:32:28 -0500
Received: by mail-io1-f68.google.com with SMTP id n11-v6so15693417iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GBwDPqrXmTdV+VCS99LIdiSRsIAovy+WziXWWlAiO2Y=;
        b=fggXpbK2mrE/cE3mwZ5yzx/vVM4oi6ReqvCHFyGI9DAqviApQZgEF84jOojE1gXFVD
         JOr71vSLHifcCwqX/s1uHVOYSrC2nIEENwOaZ+5UANgMMElmoeKU/HdlWTjFszMTlrcH
         k9u0ME8lINX9C7iN2hFl8CLYNzDJoTDU0Rno8yTmZSRjN+i01aUGVXd+55mYbQUm7WiS
         3B0JkB2YqJJVY9d4ZozOgqLOniq1I4F3STLEHdsgFvCCoO9axqBH1P+wWVbjFeh+pz7G
         RxvGTOo9o53OLuw7/b0XJToNHYr5Q0VQh+l34fWwYfEk52ED3fTOEshP2wjsUJN7tS6m
         QXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GBwDPqrXmTdV+VCS99LIdiSRsIAovy+WziXWWlAiO2Y=;
        b=dH4aNKvtc7SPAh3ay5RKC5wECvCFIx2FLZGhAhv3+Nr8cTrPPuq6dqfGcSYjHdONBR
         tFi3/TlE2YsLzxVVRcfsGifsp1sDc0ge6BGn0SKj8hSWrf6ioueXWOAwJIUS4KqbfAp/
         x4cULE6+oTyqi5Smo6kdRh/uQpj+K4RoQji/QOMM9p3C+tQkhUogiscspfeXZqymHsW3
         ffU/qM9fqjj3CbKAIIfGwhQVON70/KksibiHj7rzDbG0iUfxWA366vTWWaSIMKLCVOVX
         t1Mi5AEI4Em8iYcu0SpIxSDjL3RIBg9Gj8QeJ1DHPpLSVQFfIZM3GMSfnrdSmK14mKZE
         SQYA==
X-Gm-Message-State: AGRZ1gIzA765gdwGr/KDAOaSX7bnPw5bVZxkXLfNVvqyFYK726/DMW0w
        FyLFXtl/WZGGfKl5F2UeDH4m3dmLhkaFKXJoowqAvg==
X-Google-Smtp-Source: AJdET5dFJZ9H2rt6xebTM3LcJGnq7X1Lbcp7MNlzNkMaiSbho1tr7EoYY/BON4uRQAF0AoZ/RTHlswkfOSucKBSC/9s=
X-Received: by 2002:a5e:8d19:: with SMTP id m25-v6mr5025776ioj.258.1541710513780;
 Thu, 08 Nov 2018 12:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20181108164748.31222-1-brgl@bgdev.pl> <20181108194116.tjkku7hdqf67awuq@pengutronix.de>
In-Reply-To: <20181108194116.tjkku7hdqf67awuq@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 8 Nov 2018 21:55:02 +0100
Message-ID: <CAMRc=McmKVcCHiZv2Vy0b6J2hUmXsR_Rs3+V81KvihHtzF4MFA@mail.gmail.com>
Subject: Re: [PATCH] irq/irq_sim: add locking
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 8 lis 2018 o 20:41 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Thu, Nov 08, 2018 at 05:47:48PM +0100, Bartosz Golaszewski wrote:
> > Two threads can try to fire the irq_sim with different offsets and will
> > end up fighting for the irq_work asignment. To fix it: add a mutex and
> > lock it before firing.
> >
> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > ---
> >  include/linux/irq_sim.h | 1 +
> >  kernel/irq/irq_sim.c    | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> > index 630a57e55db6..676bfa0c12b9 100644
> > --- a/include/linux/irq_sim.h
> > +++ b/include/linux/irq_sim.h
> > @@ -29,6 +29,7 @@ struct irq_sim {
> >       int                     irq_base;
> >       unsigned int            irq_count;
> >       struct irq_sim_irq_ctx  *irqs;
> > +     struct mutex            lock;
> >  };
> >
> >  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index dd20d0d528d4..2f06c24b51a0 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -74,6 +74,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int nu=
m_irqs)
> >       }
> >
> >       init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
> > +     mutex_init(&sim->lock);
> >       sim->irq_count =3D num_irqs;
> >
> >       return sim->irq_base;
> > @@ -142,10 +143,14 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> >   */
> >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> >  {
> > +     mutex_lock(&sim->lock);
> > +
> >       if (sim->irqs[offset].enabled) {
> >               sim->work_ctx.irq =3D irq_sim_irqnum(sim, offset);
> >               irq_work_queue(&sim->work_ctx.work);
> >       }
> > +
> > +     mutex_unlock(&sim->lock);
>
> This doesn't fix the issue I think. irq_work_queue() only schedules the
> work function. If after irq_sim_fire() returned but before the worker
> runs another irq_sim_fire() is issued the value is still overwritten.
>

Looking at irq_work_queue(): while there may be some arch-specific
details deeper down the stack, it seems that unless the work is
IRQ_WORK_LAZY, the handler should be executed immediately. I'll verify
tomorrow though.

Bart
