Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7EFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6345C2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544430900;
	bh=lNLkRLuoIfZwUiemH76DsKLnqhpBlinuluGBwNK7sP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1h8LqCHqGO6vJAYx2DO0qLQjtMAWF8/buUoiE6dTh70bv5+fC/4W3zI3evPZqjc23
	 MUNDrbqf0jC1GCh2muiOsoyd9fkO1Lv2LD3P2U23mfCNyyTRV5f7MPATMSuIWrV8F/
	 li+v0baVHYpvLU0jg5lgQQc6Zk055xmRcbMLwYRw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6345C2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLJIe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJIe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:34:58 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2E720874;
        Mon, 10 Dec 2018 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544430898;
        bh=lNLkRLuoIfZwUiemH76DsKLnqhpBlinuluGBwNK7sP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XoQqAu2g/AolAOgMGF2x0tt/9h01orrjbOlkD31anUPbofJQPIxpzeNQSSEXzG9Nm
         KYI/Ojy8sWWG6srGvjojNqjFiM0u7Oex4xqf00P6eIND19mgzQyfDQw0IcNXiIIoi6
         OOKAl6Ok5RxbNqgrsVu4VGLj5pCeWEdUZk/aQ+2o=
Received: by mail-lf1-f50.google.com with SMTP id z13so7300035lfe.11;
        Mon, 10 Dec 2018 00:34:57 -0800 (PST)
X-Gm-Message-State: AA+aEWYu1dKvxwtdROoPCxOdskLNY9M5DwsaAHa+IoTmTjyL4RCqA7HT
        eMBpfDkULkCZevuhmvbm6KKjqc06uP7MMkCqFGE=
X-Google-Smtp-Source: AFSGD/WzSkZ6h4LPnEcO+HMeEvBoKgbiP1yf1wwucEeQMJnaUdw/1dOojRqFFv1TiDDzmGHNOfFf3OriGlCSsNhLREs=
X-Received: by 2002:a19:2d16:: with SMTP id k22mr5828522lfj.12.1544430895663;
 Mon, 10 Dec 2018 00:34:55 -0800 (PST)
MIME-Version: 1.0
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
 <1544185974-5932-4-git-send-email-krzk@kernel.org> <20181209081722.GB7561@amd>
In-Reply-To: <20181209081722.GB7561@amd>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 10 Dec 2018 09:34:44 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfGFUBsaUixth4T3qzDu_mdvZ9XQNhEUExWogv_5mfySg@mail.gmail.com>
Message-ID: <CAJKOXPfGFUBsaUixth4T3qzDu_mdvZ9XQNhEUExWogv_5mfySg@mail.gmail.com>
Subject: Re: [PATCH 4/4] leds: trigger: Add pattern initialization from Device Tree
To:     pavel@ucw.cz
Cc:     jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, baolin.wang@linaro.org, rteysseyre@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018 at 09:17, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2018-12-07 13:32:54, Krzysztof Kozlowski wrote:
> > Allow initialization of pattern used in pattern trigger from Device Tree
> > property.
> >
> > This is especially useful for embedded systems where the pattern trigger
> > would be used to indicate the process of boot status in a nice,
> > user-friendly blinking way.  This initialization pattern will be used
> > till user-space is brought up and sets its own pattern, indicating the
> > boot status is for example finished.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/leds/trigger/ledtrig-pattern.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> > index 1870cf87afe1..96309d3bc43c 100644
> > --- a/drivers/leds/trigger/ledtrig-pattern.c
> > +++ b/drivers/leds/trigger/ledtrig-pattern.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/leds.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> >  #include <linux/slab.h>
> >  #include <linux/timer.h>
> >
> > @@ -331,6 +332,21 @@ static const struct attribute_group *pattern_trig_groups[] = {
> >       NULL,
> >  };
> >
> > +static void pattern_init(struct led_classdev *led_cdev)
> > +{
> > +     struct device_node *np = dev_of_node(led_cdev->dev);
> > +     const char *pattern;
> > +
> > +     if (!np)
> > +             return;
> > +
> > +     if (!of_property_read_string(np, "linux,trigger-pattern", &pattern)) {
> > +             if (strlen(pattern))
> > +                     pattern_trig_store_patterns(led_cdev, pattern,
> > +                                                 strlen(pattern), false);
> > +     }
> > +}
>
> "  if (of_...())
>       return;
>
>    if (!strlen())
>        return"

Sure.

>
> Check return value of pattern_trig_store_patterns().

i can add printing of error in such case but I am not sure whether it
is worth to fail entire pattern_trig_activate().

Best regards,
Krzysztof
