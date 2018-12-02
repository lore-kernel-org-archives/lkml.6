Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2585C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899C02081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IVUOOiZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899C02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBRAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:00:36 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42988 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLBRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:00:36 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so8484412ioa.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oisxvrn8vwMyiwpK5R9JK86kA7nCnXCgxvtMALgRayo=;
        b=IVUOOiZMsqKBhkdeKRpuWF9XfJtF9U43/ou7tPPYEhF3r13D72lyjHyiyOicvBQb52
         ZcHvPiaT2/TMHZJidhbWdCge8WRfBb75tL0slbNL8m80qnrCqgsYmZ0mJsnVKx+lhoz0
         sdF28+zyY6dpGS25EJU++8r/gzVOtdtk384Q5Y01kVDCI5UWK7dvE5Ni55QHWlMKcAfP
         74GiwqEsUg2P/NdhKRThdF25QF3cE0+775T1kSuSsc+Idg9JH+grGfq0yUUyx22KndhF
         Os14sc5CvTbTzZfs2y7QFACvIqtd9atugHEaMsqaZLdDm4Ym69Ndk/hKxNikv657UAOU
         eAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oisxvrn8vwMyiwpK5R9JK86kA7nCnXCgxvtMALgRayo=;
        b=ju3NIbAD79/l/GMMuyN357OZB7wN+/y+8Y14CbPUFuP4NOFBlh4pgt0w2MEncxZGut
         MmxK9BR9xzbDCSWasudx1G0pl+QD71feQcehs3qsvjqObYGWK9eUNSj3M6YHwa9zbc+Y
         0/IG+F1Z0ftorVrZNxzeCP+ERzYlem8euRGa7I9NG2Wzw97us8O8yf7CTE/rCNYlXUbn
         jAwFY/SotWNiG2XnCbC150BwwCGrqhxXocbsBBv+8dljAguIefKxfNY2NF45d+n4iTeX
         FgSs1s055J7/FI88sTLREo/rZP1oW9cy1uV21UqtBU+0V8HeN+9fuFScfrnHD2UYKnC9
         71Vw==
X-Gm-Message-State: AA+aEWa54ItCCBeRM+oQoGqYkF1GoTp7wZFkAh62GaJA2FO8IvGSQcQj
        MCbNmjRvDTArr0uEENjdA3nrXIbLNfkOokdofYtAUA==
X-Google-Smtp-Source: AFSGD/U99JXA7FVJ/6/yK/spGjS0zK3aY6++9Zc7XYD1AyZnz9bfNz6wWeamUjKs4RxxsT59LDkrp5bLxXoT5oGdkIQ=
X-Received: by 2002:a5e:aa06:: with SMTP id s6mr11385852ioe.187.1543770033491;
 Sun, 02 Dec 2018 09:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de> <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <CACRpkdY9-umyz=T8v0ZmfOx8tFapvDguS3B=BYAVkY73BrkxqQ@mail.gmail.com> <20181202122900.79922c91@why.wild-wind.fr.eu.org>
In-Reply-To: <20181202122900.79922c91@why.wild-wind.fr.eu.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 2 Dec 2018 18:00:22 +0100
Message-ID: <CAMRc=MczHf3Q+826QDMMNAFU3WMKHR3L-Tj=Da4ydVRDcZThCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 2 gru 2018 o 13:29 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82=
(a):
>
> On Fri, 30 Nov 2018 23:26:25 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > On Thu, Nov 29, 2018 at 7:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> >
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
> > I'm fine with applying them if I can just get an ACK from one of the IR=
Q
> > maintainers (Thomas, Marc).
>
> I'm fine with that patch, with the provision that (nitpick) the edge
> field is turned into a bool instead of an int.
>
> With that,
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>

I wanted to reuse the already existing IRQ_TYPE_EDGE_RISING/FALLING
defines which I think makes more sense here than a boolean.

Bart
