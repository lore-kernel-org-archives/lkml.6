Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CBB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NuLMciBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfBSNUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:20:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34916 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfBSNUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:20:16 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so6072859itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g0ZSwhM8SsMrZ+Y7p39jUuzmskpUHbIHPc2CYj3PXLk=;
        b=NuLMciBEL3kI5jf0rFGl4elQpErU9L8hkF5iRa5dq0qrOYJSYyvhMzEi5ek/LMfYwP
         vTjlqnEvqaFZy3D/ljDufZCCAO56yTlLO9Is8uz+luTdwrwpxWX9gZTsDH6arWjZzDmf
         QRCA3ggr8AOOfC1SW/AtvcNLfegVOk/ioi8NAf1EbUOIyklpv0iBsVK85iZ7C5EkCaRl
         tsVl6XVvGA6ZCsVfhqSwg/j1RwfBzJM1S4bepAWycZl9zBYWsiR16xl80C8HQGVVTAHy
         +PMiUxIE2dfCwV7GDT8RkNja+K3q4Azg/lYdkyp2kn0PVz5Zk1iQDA3a3OyCE6OS16Uw
         8v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g0ZSwhM8SsMrZ+Y7p39jUuzmskpUHbIHPc2CYj3PXLk=;
        b=NXy+d0vVP8oO7xziS0yXBkAnC66hKmJQdnhLIUvvQhD3FwLqntnqUPb0hXMM4dOLyx
         9kcIi1c+gjpjgZyGoSejIP4nsFeQAJNdIkkFBp2MG4suRDiET/E4jrT0ml8r6e2Fk2qt
         v7UKh+WzWXp8y3n7VU0X4UtE7xRu6VXs+Yz1AWuzyNy5EjcEN/0/EH7gf2pfHWMW5a9n
         pHtcIcACd9YupT/FdxOhqKsqYeO+M+aR24QsEOnH+znLuT5cbzg5hMCWPelZZ5ocxgzb
         2BabhKs+a5SP0ZXxgb863JK3DDMLygc0EJtYQ90fpl7mrzCScfT1RKRosWmyt80adMH8
         uNow==
X-Gm-Message-State: AHQUAuZ0tVQU7YQ5CF6/iT+3M+NxKCoriLqVSz9yc1TPd0vfp6rrvMLG
        /FqimwGTrhrlBGNRf78rwfEq7S374aIa2x1+m2aviw==
X-Google-Smtp-Source: AHgI3IYjBRXxWP+idxe+yyfsezofE9SAAmgHW2xrJbrRJyFkmyStvs1eOGYUhMf73WtVy6sSE1X6IpkPa1z/3+gCBEU=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr16550310ior.258.1550582414917;
 Tue, 19 Feb 2019 05:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20190218164138.24921-1-brgl@bgdev.pl> <20190218164138.24921-2-brgl@bgdev.pl>
 <20190219122524.2e2b01db@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219122524.2e2b01db@why.wild-wind.fr.eu.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Feb 2019 14:20:03 +0100
Message-ID: <CAMRc=McPh3ox-eLGdS=VdmJOsxHeYwRTTjHfay9oEAr4QfjV1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] irq/irq_sim: add irq_set_type() callback
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 19 lut 2019 o 13:25 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(a=
):
>
> On Mon, 18 Feb 2019 17:41:32 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the irq_set_type() callback and call irqd_set_trigger_type()
> > internally so that users interested in the configured trigger type can
> > later retrieve it using irqd_get_trigger_type().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  kernel/irq/irq_sim.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index 98a20e1594ce..83ecc65d8be2 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -25,10 +25,18 @@ static void irq_sim_irqunmask(struct irq_data *data=
)
> >       irq_ctx->enabled =3D true;
> >  }
> >
> > +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
> > +{
> > +     irqd_set_trigger_type(data, type);
> > +
> > +     return 0;
>
> You keep ignoring the requirement for sanitization of the trigger type.
> Frankly, I'm getting tired of fighting over 3 lines of incorrect code.
>

It used to be there in previous versions, but I removed it on purpose
in v5. I understand why we needed that earlier, but if we now moved
*all* the logic behind the trigger type to the users of this API and
we're now simply storing any config we get, then why would we impose
any limits on it here? We don't do this now and this patch doesn't
change the current behavior. I really don't understand how not
rejecting certain trigger types makes this patch incorrect.

> I guess that despite all the noise, you don't really want this code in
> after all.
>

I do want and need this, but I really can't figure out from your
reviews how you imagine the correct solution. You said previously that
the irq_set_type callback should push the configuration to wherever
it's needed. I believe the above patch does this. Should we then limit
the supported trigger types? That would mean that irq_sim would need
to know what users support. It seems inverted to me, but if you think
it's right, then my question is: will accepting only IRQ_TYPE_NONE,
IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING in the above function
be enough for you to accept it? Is the rest fine?

Thanks,
Bartosz
