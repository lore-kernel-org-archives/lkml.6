Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC4320859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547042646;
	bh=IgIl0IJURMoFROmg8rvbNphmjBGEMS9yIrmcKVw6ujU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XGpQxTtp1unvmYyZ9IXFJoJy6ZRakmg55ZimAAxef9+xpch/KTqZt9+km+01AYh38
	 +h9zM8AuTLYJIpU3Lb45U1GHHH5AbCFBAZfPntj4k08cMepkFACHu7fJ9TZJ2aOTZO
	 mYU02IDfyD1Fnm5nVksEBvSW09BZb1yJ8HSeKzoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfAIOEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbfAIOEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:04:05 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86ADD2075C;
        Wed,  9 Jan 2019 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547042644;
        bh=IgIl0IJURMoFROmg8rvbNphmjBGEMS9yIrmcKVw6ujU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ryf4qTXaC5OhqGepl0J4WR3tCVSrxRdr6dbqJk/2wjvZiv+YxBBBSyFAslX4bFZSU
         X2c6F2U1lxgFBaXPjYdahIl5KzWIaiMoW85fvI3UsLuOKiEnWPgZkYK/HimP0ntLUo
         bh36iEhYiHxXH0m7h0Ct1dmxblO0KmglzysjPuQo=
Received: by mail-lf1-f41.google.com with SMTP id l10so5702157lfh.9;
        Wed, 09 Jan 2019 06:04:04 -0800 (PST)
X-Gm-Message-State: AJcUukd0Ir9G6P1yFijdTIJz8yMT1lWdqgUceY72C3xL+oKkhB7Ya6Sg
        s9Pw5oBkiW2/ok8T4+kZjSzd/BSaxCWebgC1BME=
X-Google-Smtp-Source: ALg8bN66q7WTNIOleDkHV7pJdI0uAlh5Y2+lPK++inp2sRmAieKWTRic3Mo3FO6M48GkApzIKTabU3V2INbibh/qbhc=
X-Received: by 2002:a19:2d16:: with SMTP id k22mr3434828lfj.12.1547042642684;
 Wed, 09 Jan 2019 06:04:02 -0800 (PST)
MIME-Version: 1.0
References: <1546596524-19863-1-git-send-email-krzk@kernel.org>
 <1546596524-19863-3-git-send-email-krzk@kernel.org> <20190107174924.GD933@amd>
In-Reply-To: <20190107174924.GD933@amd>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Jan 2019 15:03:51 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdhz3PVELFk_zSH+akmCLWgEfWvV+aGUoL9R9sBaQKjDg@mail.gmail.com>
Message-ID: <CAJKOXPdhz3PVELFk_zSH+akmCLWgEfWvV+aGUoL9R9sBaQKjDg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] leds: Add helper for getting default pattern from
 Device Tree
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 at 18:49, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Multiple LED triggers might need to access default pattern so add a
> > helper for that.
> >
> >  }
> >  EXPORT_SYMBOL_GPL(led_update_brightness);
> >
> > +u32 *led_get_default_pattern(struct led_classdev *led_cdev, unsigned int *size)
> > +{
> > +     struct device_node *np = dev_of_node(led_cdev->dev);
> > +     u32 *pattern;
> > +     int count;
> > +
> > +     if (!np)
> > +             return NULL;
> > +
> > +     count = of_property_count_u32_elems(np, "led-pattern");
> > +     if (count < 0)
> > +             return NULL;
> > +
> > +     pattern = kcalloc(count, sizeof(*pattern), GFP_KERNEL);
> > +     if (!pattern)
> > +             return NULL;
> > +
> > +     if (of_property_read_u32_array(np, "led-pattern", pattern, count))
> > +             goto err;
>
> Just kfree and return here. No need for goto if that is just one case.

OK

>
>
> >  /**
> > + * led_get_default_pattern - return default pattern
> > + *
> > + * @led_cdev: the LED to get default pattern for
> > + * @size:     pointer for storing the number of elements in returned array,
> > + *            modified only if return != NULL
> > + *
> > + * Return:    Allocated array of integers with default pattern from DeviceTree
> > + *            or NULL.  Caller is responsible for kfree().
> > + */
>
> "DeviceTree" -> "device tree".

Sure, thanks for the feedback!

Best regards,
Krzysztof
