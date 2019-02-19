Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A120851
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T/fpKpno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfBSPeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:34:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35961 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:34:02 -0500
Received: by mail-it1-f193.google.com with SMTP id h6so7174181itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 07:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EbmrV/1MFDQ47AXNjnxMZ05YdkPikn5k2ueCP5B2Xvo=;
        b=T/fpKpnooiN+LyxrsPJB+LUb2RpN3XsP8ZvmcQ/1voF12Y9X/4T2+DRXAetvTY7q7x
         Z8GXdOISMjCCH8ps3cEIxmSkKbcesf7BE93qcELw8VfHJC0lLfV7T/Wg+G9LcxovuPv+
         3fsJ2ZkbtajCAk/VUS1lrSsIZ+tLhvi6B+joJcJ5wNb6aN6dmXJDkwLg8Q+Up3tW3Xlq
         R+fKklaJzSzOMO/YG5p9RPMSj+1/Mi/U2M+A84aeEbSaUWDc7NPPWFqAQIEPtTSzm1eH
         EokZFC/RQYNi+52Kj3pUxKluQrsHMTQgz4ijIB74oqS0WniaOteJgoHwzuzS5sf281ZQ
         ia2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EbmrV/1MFDQ47AXNjnxMZ05YdkPikn5k2ueCP5B2Xvo=;
        b=pj8urPNHayfW1C3YX6bp5cT7D31Gt5ELAeQIu3KrRkozHM20UtsZ0tj15dPPKEBQbV
         u6M90jMYqfaMHeqGCty0I1DuBX0J5xFlctd5Rbj5ug/A/5YJV1T6lMIU3C8xSHDhz0+7
         yoK6LGPd63CSY0x+c1hVjM/JMJa5Z4O5QNZ94Z6SnmZuq701Rld+g4dxm2ahq772g7A7
         icTjKM6/Cp+ulA+uq1zf/tJ/WVVEuKPYOMx0a6ap3WBcWMWSe5SbhtSfVp0LLluh7ACi
         fLNNjbX+FG6sMSKLaTvA/0vPVwhHW7f5h55lvIyJDPBmd5izOITWtem2wyuCcp0itRta
         zrBw==
X-Gm-Message-State: AHQUAubkFYpbB8OA6LptNQo5iYgyPGSH61G43kI/MRvtbglplSL8TA+j
        +OM0X2sryCdVE/ZqRbbdzWGaAaqSaNloKrNe/JqZUA==
X-Google-Smtp-Source: AHgI3IarznmGLWqQVaArjZb3PscNyi3chxPUbtO7qpkBFNOtMRI578u+axcMu+Mr77ThS5Zvmtk1ZCWSc9La1s87L5c=
X-Received: by 2002:a24:2b8c:: with SMTP id h134mr2847780ita.53.1550590441102;
 Tue, 19 Feb 2019 07:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20190218164138.24921-1-brgl@bgdev.pl> <20190218164138.24921-2-brgl@bgdev.pl>
 <20190219122524.2e2b01db@why.wild-wind.fr.eu.org> <CAMRc=McPh3ox-eLGdS=VdmJOsxHeYwRTTjHfay9oEAr4QfjV1g@mail.gmail.com>
 <20190219134033.23a53fc1@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219134033.23a53fc1@why.wild-wind.fr.eu.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Feb 2019 16:33:49 +0100
Message-ID: <CAMRc=Mc8USe8TxsK1F4_hE9ONZy_Xpthd=u5vwgiiJWJVn96tg@mail.gmail.com>
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

wt., 19 lut 2019 o 14:40 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(a=
):
>
> On Tue, 19 Feb 2019 14:20:03 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > wt., 19 lut 2019 o 13:25 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=
=82(a):
> > >
> > > On Mon, 18 Feb 2019 17:41:32 +0100
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Implement the irq_set_type() callback and call irqd_set_trigger_typ=
e()
> > > > internally so that users interested in the configured trigger type =
can
> > > > later retrieve it using irqd_get_trigger_type().
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  kernel/irq/irq_sim.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > > > index 98a20e1594ce..83ecc65d8be2 100644
> > > > --- a/kernel/irq/irq_sim.c
> > > > +++ b/kernel/irq/irq_sim.c
> > > > @@ -25,10 +25,18 @@ static void irq_sim_irqunmask(struct irq_data *=
data)
> > > >       irq_ctx->enabled =3D true;
> > > >  }
> > > >
> > > > +static int irq_sim_set_type(struct irq_data *data, unsigned int ty=
pe)
> > > > +{
> > > > +     irqd_set_trigger_type(data, type);
> > > > +
> > > > +     return 0;
> > >
> > > You keep ignoring the requirement for sanitization of the trigger typ=
e.
> > > Frankly, I'm getting tired of fighting over 3 lines of incorrect code=
.
> > >
> >
> > It used to be there in previous versions, but I removed it on purpose
> > in v5. I understand why we needed that earlier, but if we now moved
> > *all* the logic behind the trigger type to the users of this API and
> > we're now simply storing any config we get, then why would we impose
> > any limits on it here? We don't do this now and this patch doesn't
> > change the current behavior. I really don't understand how not
> > rejecting certain trigger types makes this patch incorrect.
>
> You expose a new set_type callback. Only a set of valid values can be
> handled by the users of this interface. At least your mockup gpio only
> handles a narrow set of configuration. Not rejecting erroneous values
> is a bug. This isn't a new requirement; this is how the irqchip API
> works, as drivers do expect such a failure if requiring an invalid
> type.
>
> > > I guess that despite all the noise, you don't really want this code i=
n
> > > after all.
> > >
> >
> > I do want and need this, but I really can't figure out from your
> > reviews how you imagine the correct solution. You said previously that
> > the irq_set_type callback should push the configuration to wherever
> > it's needed.
>
> Yes. But it doesn't mean it should accept something that cannot be
> handled by the irqchip. If you push it to the code that does the
> handling, it still has to return an error if the backing code decides
> that this is not a supported configuration.
>
> At the end of the day, where you store it is irrelevant for the problem
> at hand. There is an API, and you need to implement it correctly.
>
> > I believe the above patch does this. Should we then limit
> > the supported trigger types? That would mean that irq_sim would need
> > to know what users support. It seems inverted to me, but if you think
> > it's right, then my question is: will accepting only IRQ_TYPE_NONE,
> > IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING in the above function
> > be enough for you to accept it? Is the rest fine?
>
> IRQ_TYPE_NONE doesn't mean anything, apart from "whatever defaults were
> there because I have no clue". In your case, I really don't see the
> point. The EDGE settings are what you handle, and are the only values
> that should be accepted.
>

Right, irq_set_type() isn't even called if there's no trigger set.

> As for the rest of the patches, I haven't looked at them, and probably
> won't (if only because I'm on holiday and would like to do something
> else...). All I'm asking from you is to give me a correct patch #1.
> Once I see that, I'll gladly ack it.
>

Thanks,
Bartosz
