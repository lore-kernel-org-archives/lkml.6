Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CA1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6F120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jpkmU5Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6F120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeKIUtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:49:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45442 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:49:25 -0500
Received: by mail-io1-f67.google.com with SMTP id p83-v6so956107iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u5SB2aJ4f10n49Y7xNBr0227p9qWnWZerYTKA7No80k=;
        b=jpkmU5GrqiOA/GQOnqRttQEGWsxlznv8xJRnzgzsNqX/IEQztPCGaHf30lQ1lRKszb
         MJF6dXvUeNCdyxIL9vU9w/6D7HKIzJyXzhEbe77ilkVq7wvO4tG9BZCaavxSbRssrWY/
         PQ0Zazdn6DkMPdkUejoqITyUg2eVAnos0RhLpoaV0UbZzGebp4ieWE26CXMNes9QAGTp
         6nT0TGD0sGKuTA6OnobRLylc1cshUu5Zz1bIvz5iPUzEKLtqsQlxpBYp5Mg0FWJT6xCj
         +RDB/qdrVfULiOCO8omLoineNmaAD5Ijx3G643Eud6bnzsJC8Jg/T8/9nFjSGRaYvVUC
         82aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u5SB2aJ4f10n49Y7xNBr0227p9qWnWZerYTKA7No80k=;
        b=Pj5w2CxYAnn0h8pABqSOyIK1XT2B9pLua459ekUg0vDnKzyuOVBJtT8RuP9UY2qr07
         uvGvfU7DtZ/4ER5gAibtl0AvECoPPMxpxM77kgFc90mo9aHVc11D6Wtm1V2pXzrtVUTk
         wb4ljtAUpyeqFnmfLkTnNzgNV8ECZCFBWwN1nWtRdUGklTrntgfR5YfA8QgqvVpTACRn
         cx8xY+luzbT0e2gz0G/1BuQ11LVdPakNzctOpV0L0AdoJW5nY2btIJpCQn1NpnObmr67
         yNkmOFb2dppI/R59mZDxTXFZQpWdMi3MG6cgcjIr0ppHOm0vrdndyU3Nrz7JlBhM+vzJ
         Dobw==
X-Gm-Message-State: AGRZ1gIGLgWx2FKSLmGesavFGOdAZ+hZyWPbi99EeBLQ+gImrXLFfCwi
        X6rBqVl0virY4w2H1qf2y4W74/UZOJfl8w4vHEhEsQ==
X-Google-Smtp-Source: AJdET5dVww47Yasgv45C06kAvKS3NxVjud+JfEFZD/CxEBEdBNTq6zwEdIgOvwpH1kthwOtAUZjSiosxG97raqAcH40=
X-Received: by 2002:a5e:aa13:: with SMTP id s19-v6mr6669571ioe.187.1541761757137;
 Fri, 09 Nov 2018 03:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20181108164748.31222-1-brgl@bgdev.pl> <20181108194116.tjkku7hdqf67awuq@pengutronix.de>
 <alpine.DEB.2.21.1811091108001.1519@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811091108001.1519@nanos.tec.linutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 12:09:06 +0100
Message-ID: <CAMRc=Md39C_7R39c5N9-ZUEZcT5bnE=uwx3gL=CNxPnxyytUUQ@mail.gmail.com>
Subject: Re: [PATCH] irq/irq_sim: add locking
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 9 lis 2018 o 11:19 Thomas Gleixner <tglx@linutronix.de> napisa=C5=82(a=
):
>
> On Thu, 8 Nov 2018, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Nov 08, 2018 at 05:47:48PM +0100, Bartosz Golaszewski wrote:
> > > @@ -74,6 +74,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int =
num_irqs)
> > >     }
> > >
> > >     init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
> > > +   mutex_init(&sim->lock);
> > >     sim->irq_count =3D num_irqs;
> > >
> > >     return sim->irq_base;
> > > @@ -142,10 +143,14 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> > >   */
> > >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > >  {
> > > +   mutex_lock(&sim->lock);
> > > +
> > >     if (sim->irqs[offset].enabled) {
> > >             sim->work_ctx.irq =3D irq_sim_irqnum(sim, offset);
> > >             irq_work_queue(&sim->work_ctx.work);
> > >     }
> > > +
> > > +   mutex_unlock(&sim->lock);
> >
> > This doesn't fix the issue I think. irq_work_queue() only schedules the
> > work function. If after irq_sim_fire() returned but before the worker
> > runs another irq_sim_fire() is issued the value is still overwritten.
>
> Right. So the obvious solution is to avoid the irq number store and use a
> bitfield instead.
>
> struct irq_sim_work_ctx {
>        ...
>        unsigned long    pending;
> };
>
> fire(sim, offset)
> {
>         if (!sim->irqs[offset].enabled)
>                 return;
>
>         set_bit(offset, &sim->work_ctx.pending);
>         ....
>
> and in the work handler do:
>
> handle(work)
> {
>         struct irq_sim_work_ctx *ctx =3D container_of(work,....);
>
>         while (ctx->pending) {
>                 offs =3D ffs(ctx->pending);
>                 clr_bit(offs, &ctx->pending);
>                 handle_simple_irq(offs);
>         }
> }
>
> Or something like that.
>
> Thanks,
>
>         tglx

Actually on ARM and x86 with smp the handler is called between the
mutex lock and unlock alright but this solution looks much better.
I'll resend a v2.

Thanks!
Bartosz
