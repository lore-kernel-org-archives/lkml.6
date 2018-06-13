Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96462C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B925204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc/ZQpQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B925204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935539AbeFMMuB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:50:01 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46498 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935477AbeFMMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:49:55 -0400
Received: by mail-ua0-f196.google.com with SMTP id d7-v6so1597666uam.13;
        Wed, 13 Jun 2018 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rADTA9TbqPwc/cMkJSdUFqnXFkf9pf2L2M34uAvZukA=;
        b=tc/ZQpQ/lrQkl3JLSw3tZ4fUxLngRPnFcG4V+bGA/994E9GK1vqDP2XII5m7/s5VDf
         a5Y3kHPHkciI/Yf0ndyOsZea6THDB5cKXGpIyNAOOvxwZ5jg6aekWcnHr7qc23mDm/YI
         Avz8y8r8yP9zqQkG8bALRiMzwcr0kZpuK1mf5BwJ8PK7/cOWWvBN/diA95XVU83PkiVC
         h03eRbtxQ9xrNSjKnqIhBKl+G6cZ6NXIMDOx493VxZH/aWb0/JR53R3kTOkBU+/2jGbR
         oMVJF6DUvuyaEBHJBy8Y9+goMUdlOW05Ppb0C7pnUCAV1VI0AdT+c/YObWSNN1H/LVaa
         ETRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rADTA9TbqPwc/cMkJSdUFqnXFkf9pf2L2M34uAvZukA=;
        b=OLitofzi/wm6I3iRU0WUOLOItPXbq+WGcTgdx+ZI3nJpY3yC7hF06WE1QoeRGozsBy
         MQCe8BwZqEsbTyjdRyvhlcNjA06NEnj7tJ7SA4/YgsX+DQXVvrrufsSAvY2iYB67Ygjm
         bAZ/ONnUcHlVeAb1K1r6KJWfU0yWy/LI057ucv4reIf+Zk/uI9U6GZhc+wdFNWMs4+Af
         RvuO4o0tMut4OOI9zQCOb2CxOJymK3HrvA0Nxyl8qsVLBAmir9s5sfZ2dXES4rkpga2q
         2t8SQuvsQmnz2QkJNhzphpm+y682XE+oFCur+NAiQYWZb5WRubfS8Ue4J70mOs3h0TKz
         fR6w==
X-Gm-Message-State: APt69E31O8PdhwZaktuxlSkwi30yiQYphzjn+cW+rWrPy6WtC7ARW62C
        jFuG5tbvGGMjkuLGpUF4YRuCGMDAEheq27Rgju4=
X-Google-Smtp-Source: ADUXVKJqD+z7Fq4jBmBof1/3H19EMiWv8y6Xs+GHPeEIbknDATRXl2S231qBbvf6tyVdLXt0UeYzln6PDEp8eLYp9jk=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr3340185uad.49.1528894194921;
 Wed, 13 Jun 2018 05:49:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 05:49:54
 -0700 (PDT)
In-Reply-To: <20180611071838.47945-1-chiu@endlessm.com>
References: <20180611071838.47945-1-chiu@endlessm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 15:49:54 +0300
Message-ID: <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:18 AM, Chris Chiu <chiu@endlessm.com> wrote:
> Make asus-wmi notify on hotkey kbd brightness changes, listen for
> brightness events and update the brightness directly in the driver.

> For this purpose, bound check on brightness in kbd_led_set must be
> based on the same data type to prevent illegal value been set.

> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>
>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>
> -       if (value > asus->kbd_led.max_brightness)
> +       if ((int)value > (int)asus->kbd_led.max_brightness)
>                 value = asus->kbd_led.max_brightness;
> -       else if (value < 0)
> +       else if ((int)value < 0)
>                 value = 0;

I didn't quite understand this part of the problem.
Does it exist in the current code? Can it be split to a separate change?

Can we avoid those ugly castings?

-- 
With Best Regards,
Andy Shevchenko
