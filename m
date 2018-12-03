Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DD720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yd+hbmMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DD720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLCKYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:24:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54661 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:24:17 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so8366975ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UmrYYrcVEUMHJZpCsWazmOrYV9XEY5TV2nNkfIM6gOc=;
        b=yd+hbmMMaG7RMKwrL6s0sKwFugqB72Gue1slI2zd6kTImha4wPnkSR23X5WIpoCiwr
         81ER70O5/5MKjoewFGh/7vAL8xT/Kb14RZ0SnDoD0e4MHQxyQpz9JxlYUx6KrQ6XMxHZ
         6Sd2ysG54i2NmZ5TlXUD4rvBm900XCLCWGIrimq2IVjcl21xu0F2m3c55MLPsCjNPLME
         tIFqIT+Nur+H5QPDMVZF0Hyx6+agJamh4QfaNNAeoDodoJfvw0kcbSqv7HYlYZXYlhm7
         ykA8XzJRnqLWE5u7vWV/M0+CMICBAHevosjjwSk8SOMzIZd6ccXwsbmBi1HthnX1uzEt
         QuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UmrYYrcVEUMHJZpCsWazmOrYV9XEY5TV2nNkfIM6gOc=;
        b=VlWpOVEAysA3y9EiX82Bz1Bji8NyVAzXcrggiao08KlGbCPdHBMJdeVtjZara0wVRM
         x+utBznWVS2SkQTFRa76q7WQTkg1Eu1uQQtMQRr8krUj0BpKx+6dAYcoOjYnYWzTwKNx
         FnBeSLthGDr6Nzk6vteNrIWrP9HjmCY5XVFeIsnDvtu3Oh0YYHzAAROfsYq5xRIOZqT/
         vTY+60/Y82naSBiofQwiZYkoEvAURY5ppdWs0L62sgivsVzZCmLzSUnMnNA9mQ0HMXng
         ER8RhEnS9/7wMHTbm1jvsim120Ezwjfcs2IKOeL7NBmvHf51gqlskCeeV8dZPNM8t4FY
         xCpg==
X-Gm-Message-State: AA+aEWbOVhS14OjMQqV2g5OWHPSB0tgdm3Ml6xnpjgLCupKaFiMLvFd8
        UDOvBfd0e0Zn5w5Dbt+AL2lULdhIgbMDQ2PFUfHbaQ==
X-Google-Smtp-Source: AFSGD/W5sy4muEWm/4bUrilv12431R76AUN/ruMqhdvhddupexmnxl0kmK3p4skyZvfHwSkzQYnThwg4FBlyHhtXz/A=
X-Received: by 2002:a24:7284:: with SMTP id x126mr7822259itc.96.1543832631030;
 Mon, 03 Dec 2018 02:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de> <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
In-Reply-To: <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Dec 2018 11:23:38 +0100
Message-ID: <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 2 gru 2018 o 23:20 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
>
> niedz., 2 gru 2018 o 22:56 Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> >
> > Hello,
> >
> > On Thu, Nov 29, 2018 at 07:14:45PM +0100, Bartosz Golaszewski wrote:
> > > We're getting too much into details of how to handle simulated
> > > interrupts and we can continue discussing it, but meanwhile I'd like
> > > to address a different thing:
> > >
> > > Thomas, Linus: after commit fa38869b0161 ("gpiolib: Don't support irq
> > > sharing for userspace") some libgpiod tests are failing because we ca=
n
> > > no longer depend on reading the value of a dummy GPIO after detecting
> > > an interrupt to know the edge of the interrupt. While these interrupt=
s
> > > are triggered from debugfs and debugfs is not required to maintain
> > > compatibility, I thing having a working test suite for the GPIO
> > > subsystem and uAPI is worth applying these two patches and also the
> > > previous one[1].
> > >
> > > Can we have them applied for 4.20 or are there any objections?
> >
> > Just for the record: I objected the patch, Bartosz agrees to discuss
> > further and but because this is too much detail the patch should now be
> > applied anyhow to fix the test suite of an external project. This seems
> > wrong to me.
> >
>
> Just to look at it from a different perspective: we have a project
> whose tests rely on a behavior that was changed by Uwe's patch. While
> the patch is fine, we need to find a correct way of testing the GPIO
> user API. This may take a long time. In order to not break the tests
> of an external project in 4.20 I propose to patch the interrupt
> simulator (a component only used for testing) for now and to revisit
> it later without time pressure.
>
> Best regards,
> Bartosz

In fact after re-reading this conversation I'm still not sure what
your objection is exactly. You're proposing a solution that may well
be nicely engineered but it's specific to your gpio-simulator.
Meanwhile I'm trying to provide a more generalized API for more
testing modules to use.

Why exactly would you not merge this fix?

Bart
