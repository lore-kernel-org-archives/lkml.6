Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B48C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCC620811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544689292;
	bh=32YueCvqktQrU8uMAdobf3nWHw7Lcs9sxvDnl8mJoi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VOzf19Cj9XZbyooPKMVuSoW/eo4FAqgH+6il3TM1JdQOeunMLwyh4uEfv+KF8ofc4
	 buyVbCKTE93PUH6W1wka36ZjPrNv519aWtInip13rdXt7WwFii9yXiGcXQ2ujXpyI8
	 Sh2jikAE4rGlsJIZT9t9Z82xFRGninySHYvYTRE0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCC620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeLMIVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbeLMIVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:21:31 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9126C20880;
        Thu, 13 Dec 2018 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544689289;
        bh=32YueCvqktQrU8uMAdobf3nWHw7Lcs9sxvDnl8mJoi0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BuyRE/V1nwtvaACO0FOiFYmEA5VYItlE5amRIcfnAad9JlQnP5yCvyn6atd/vJQQ+
         0FVC62kgLwCI//5aMueYpcE/TAvXx/JbEeBuuw2YkC1Quv7Zdxlj1xfXtFg3im2/ZC
         lsyktqQmCkMMh4A8kM9vWOAXEzB9spDxoX+00s1w=
Received: by mail-lj1-f171.google.com with SMTP id g11-v6so991742ljk.3;
        Thu, 13 Dec 2018 00:21:29 -0800 (PST)
X-Gm-Message-State: AA+aEWb0XguQ7L2KZY/5ARi2nQ1P+LBH/VFagoiFR/0z6ep1WfNAZOsj
        zFq2Q7k3KYpqNrDa7i9FY8peAUpKH7YU+rMwW0o=
X-Google-Smtp-Source: AFSGD/UsO8xGxAZFJ+Ut2AleD9hkjhN/NwPU4MZeaoN1bX04qGjqbebeQhuipW1GBMue4Y7mmpIktue9Vba8kVcFBU8=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr15598316ljb.89.1544689287635;
 Thu, 13 Dec 2018 00:21:27 -0800 (PST)
MIME-Version: 1.0
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
 <1544613406-27026-3-git-send-email-krzk@kernel.org> <20181212122227.GB11088@amd>
In-Reply-To: <20181212122227.GB11088@amd>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 13 Dec 2018 09:21:16 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcka9qc7CgXhA0jbEFUurAYO=GZP0utiuYcNee4AmnMNg@mail.gmail.com>
Message-ID: <CAJKOXPcka9qc7CgXhA0jbEFUurAYO=GZP0utiuYcNee4AmnMNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] leds: Add helper for getting default pattern from
 Device Tree
To:     pavel@ucw.cz
Cc:     jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, baolin.wang@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 at 13:22, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-12-12 12:16:43, Krzysztof Kozlowski wrote:
> > Multiple LED triggers might need to access default pattern so add a
> > helper for that.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> >
> > New patch in the series
> >
> > ---
> >  drivers/leds/led-class.c | 25 +++++++++++++++++++++++++
> >  include/linux/leds.h     |  3 +++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> > index 3c7e3487b373..44b95e6480f6 100644
> > --- a/drivers/leds/led-class.c
> > +++ b/drivers/leds/led-class.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/leds.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/timer.h>
> > @@ -244,6 +245,30 @@ static int led_classdev_next_name(const char *init_name, char *name,
> >  }
> >
> >  /**
> > + * led_classdev_get_default_pattern - return default pattern
> > + *
> > + * @led_cdev: the led_classdev structure for this device
> > + *
> > + * Return: Null terminated string with default pattern from DeviceTree or NULL
> > + */
>
> Is it valid kerneldoc?

Yes, maybe kind a short but in general it follows style.
https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> Note that core still owns the string so that
> caller is not expected to free it?

That should be obvious by returning "const char *". The
of_property_string() does not mention such case neither... I  can
document it but really "const char *" is self-documenting code.

> > +const char *led_classdev_get_default_pattern(struct led_classdev *led_cdev)
> > +{
> > +     struct device_node *np = dev_of_node(led_cdev->dev);
> > +     const char *pattern;
> > +
> > +     if (!np)
> > +             return NULL;
> > +
> > +     if (of_property_read_string(np, "led-pattern", &pattern))
> > +             return NULL;
> > +
> > +     if (!strlen(pattern))
> > +             return NULL;
> > +
> > +     return pattern;
> > +}

I missed here EXPORT_SYMBOL_GPL.

Best regards,
Krzysztof

> > +
> > +/**
> >   * of_led_classdev_register - register a new object of led_classdev class.
> >   *
> >   * @parent: parent of LED device
> > diff --git a/include/linux/leds.h b/include/linux/leds.h
> > index 5263f87e1d2c..9da2bfa183ea 100644
> > --- a/include/linux/leds.h
> > +++ b/include/linux/leds.h
> > @@ -129,6 +129,9 @@ struct led_classdev {
> >       struct mutex            led_access;
> >  };
> >
> > +extern const char *
> > +led_classdev_get_default_pattern(struct led_classdev *led_cdev);
> > +
> >  extern int of_led_classdev_register(struct device *parent,
> >                                   struct device_node *np,
> >                                   struct led_classdev *led_cdev);
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
