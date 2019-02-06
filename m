Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF3EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD140218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CA4V+avY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfBFKt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:49:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33702 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfBFKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:49:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so5031856lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1LMen8wTwY4yhWXGiMwywfKz0XY14FbbWinez9Hg6fg=;
        b=CA4V+avY2jaK5sTlGVIXKUl5CEV7OEsua2RvFxjm0TscZDYkE8mMXeEBhpZPM7Ue19
         QE4gNtVix+Qd0188wwomyPJp/gozn3WQB/HBYeYkoo6iTYZL26AOfwJbSMBlTtUjP3ya
         0MxeixPzH9k/+zTQeIp8Ok1doKU1zvlgGcTTgFVXBp7NmPmXtq/Wjb3L2vpt0jyeLXpT
         aP9UrfuuE2T3VklU75jY7QcxZVaq40lASZQ5pgXjl9XD6so52/BcS3S+M3bmyjwWFOyX
         Gb935135VQ/gkykiGWblTM5oushEQsAIWKIl0OIPt6TCe9lKbNCT8mEA6jdyQPxTSkQm
         IWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1LMen8wTwY4yhWXGiMwywfKz0XY14FbbWinez9Hg6fg=;
        b=LnPTElZIrXPHiTYUz3TTIxGZDQbKtgkmRypBAtly+2diCFMgqHx8T9SHQ5+2X5xefo
         8YoMwAw6Y+EkshuppB2g0XxQdNRutlPP6//wWjO1G0O+ABIVD2NnWcp74g8F7dIA0gL3
         z3A5H1NbImsv9piIIE9im5p0JRnhb27AzQACeK42/PAjlweRzEguqWPiq2jeQnmNpxKW
         7JpBObtuES6sF2wj7s6f11rR0cpioTWwOQxSAOrzjKJmqFE9CLFg1sxfsSZRG7I7CZdb
         dW8qoJOuQuDNIKGSHbmUFSXT/gF8KnJOB7bvdSJtZppK+WAniP65jF55yn9+H37jGoc7
         F7EQ==
X-Gm-Message-State: AHQUAuaZ5MSGHkqIqnu1CJJsf54koN0+GerQovnmYtk6HStNxkzmQrgV
        SPuFbVC6BvHLMIjiGvmdKPveCxNWUxlMuVcF4Rz1Uxgxyk0=
X-Google-Smtp-Source: AHgI3IY3PEh/QNdiO+YB9WoO86tBF4SVaF7MbPvjb2iV8iivqhd7AoPIGoqRdsUvuwcHTYXC415JIoyAUpm7fFPXC/A=
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr6033720lfl.115.1549450163444;
 Wed, 06 Feb 2019 02:49:23 -0800 (PST)
MIME-Version: 1.0
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com> <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
In-Reply-To: <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Wed, 6 Feb 2019 16:18:47 +0530
Message-ID: <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++=
++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..8dcb40d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,33 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently=
 only
> > +supports one period for all channels in the PWM. This is set globally =
in DTS.
>
> You can simply drop this if the first user can set this using the usual
> interface. Don't you like this suggestion that I already made a few
> times now?
>
> Did you consider to make the driver support only a single output with a
> more flexible period setting?

We cannot consider supporting only single output since we have boards that
use the additional PWM channels to control individual LED brightness
of a tri-color LED.
If we go down to one channel, then we can't control the brightness of
the individual LEDs.
It will break the use case.

I am considering the below approach, let me know if it's fine by you.

- Drop the global period property and allow the only first user to change p=
eriod
using the usual interface.
- A note in the binding that all PWMs need to run at the same
period. If the driver already refuses to apply incompatible periods,
the users are going to notice that they've got the DT wrong.
- In driver code, count the users using the .request and .free callbacks.
Based on this, allow changes to period iff the user count is one.

>
> > +The period also has significant restrictions on the values it can achi=
eve,
> > +which the driver rounds to the nearest achievable frequency.
>
> Rounding a period to a frequency sounds wrong.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
