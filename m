Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6B4214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="OfT5s/jy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgAgLQsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6B4214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeIQT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:26:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40879 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:26:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id l202-v6so18943546oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kZbZBrMuTcRef6SfXV2mspjsEoJ3kc6pYd2ikKr3Jw8=;
        b=OfT5s/jyMaSUV7MYh9aPTDkJwGnggI5kH58NS4JXaoP+8vZluogCQuo/ipnauh9x8u
         5mM31vEyQ8V2bZr2+5zrvloHEf/SIfCdCkzJmYCS8b0Fik/nuJ/jS+xq/sUGQQdcjYQ5
         hER3dmGeUNJL7TnSQ+tacrRgrztSxZWPu8Rq4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kZbZBrMuTcRef6SfXV2mspjsEoJ3kc6pYd2ikKr3Jw8=;
        b=rgAgLQsIkbswEI2KIZUhzrR+q60YDvcI6v3W0oJLZlhZFO2xQlewgLq9VTHsoSO4kk
         tzcf6Zba4sgG3HrkAhJBThXqSC8uzKD+MNTA4RDjZGJRISIcB7cXHOzPQL+2XT5prufD
         kAdq6UXBovSy/nzD6HqPPqVx53jI22ZAJSuulg+kahfqAQOXBiDAl0TLIrMRBGojLvwT
         1kXGv/8ehaLgzLFyGkFb9NvxURYvWWoYNw1VmNudkNXLgsZML5f+TXyr/ETTVqKUYCum
         k9alCHAreucX2zswgxqGW4UP5jImUk5NXfRqMYCqvIv0wBsdh9VC+jt5s5istPEOasLn
         i14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kZbZBrMuTcRef6SfXV2mspjsEoJ3kc6pYd2ikKr3Jw8=;
        b=YNPskFNL8p1cihNMpWL8m4T772JVNITRDmypgKvO3hfJRpPw3VpgCrxqQ1uIFoD8NE
         5aejeSqrz0cOzpQEs7mbaFu0zh1JXrx/JPxxhFte/pXjUI20LKWQXdBOqvBo6u1a3ldR
         hqLv/aLXua5tLp6R03qgBuJesiyZ+XS7yV2fh7hL9ewlagsAOKmvvBZtA4nQq/nQrLq2
         i8F1D7XiJHg2/+UoOWsInOMg/EFwCqHj+JqSa+a/MKQQsJ9wQTq+nVhybQw9T5QTPs4l
         6YHzi7TZJbNM2f++COqKCPsakSt2uUjQ6+0MHHn8HzR0qQK40TaHB7yEcT0uLmGXZmSq
         w55Q==
X-Gm-Message-State: APzg51CHQEdmP7rb+WJJ8EwtdbYRwosMIcJ6Xz1QGbwFXoEnUUmNSbRY
        lJYXpzXiuISHj5Bu9qXnsaLgkXH9f88OUZEtKQGskQ==
X-Google-Smtp-Source: ANB0VdYbXMLevS4qv+VLGOxlRnsQ0V+WkKaCHr+Ss4DVYFjPPc5daZq//UbK72amBl6V/2Sve9SJJorXvQOjUpSQjNU=
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr18310456oih.58.1537192746163;
 Mon, 17 Sep 2018 06:59:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:328a:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 06:58:45
 -0700 (PDT)
In-Reply-To: <20180914102732.GP14988@piout.net>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-3-romain.izard.pro@gmail.com> <20180914102732.GP14988@piout.net>
From:   Romain Izard <romain.izard.pro@gmail.com>
Date:   Mon, 17 Sep 2018 15:58:45 +0200
X-Google-Sender-Auth: 1YKlElW2lcb93Wo48WNbZR0eA5Q
Message-ID: <CAGkQfmPydsn6cH2pHQ9HQeGQo0J4qJ9vXjkQD+_W5iyz---KEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: sama5d4: write the mode register in two steps
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-14 12:27 GMT+02:00 Alexandre Belloni <alexandre.belloni@bootlin.com>:
> On 14/09/2018 12:13:39+0200, Romain Izard wrote:
>> The specification for SAMA5D2 and SAMA5D4 chips, that use this IP for
>> their watchdog timer, has the following advice regarding the Mode Register:
>>
>> "When setting the WDDIS bit, and while it is set, the fields WDV and WDD
>> must not be modified."
>>
>> I have observed on a board based on a SAMA5D2 chip that using any other
>> timeout duration than the default 16s in the device tree will reset the
>> board when the watchdog device is opened; this is probably due to ignoring
>> the aforementioned constraint.
>>
>> To fix this, read the content of the Mode Register before writing it,
>> and split the access into two parts if WDV or WDD need to be changed.
>>
>
> Hum, that is really weird because when I developed
> 015b528644a84b0018d3286ecd6ea5f82dce0180, I tested with a program doing:
>
>         flags = WDIOS_DISABLECARD;
>         ioctl(fd, WDIOC_SETOPTIONS, &flags);
>         for (i = 16; i > 2; i--) {
>                 ioctl(fd, WDIOC_SETTIMEOUT, &i);
>         }
>
>         ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>
>         flags = WDIOS_ENABLECARD;
>         ioctl(fd, WDIOC_SETOPTIONS, &flags);
>
>         for (i = 16; i > 2; i--) {
>                 ioctl(fd, WDIOC_SETTIMEOUT, &i);
>         }
>
> This would immediately reproduce the reset when changing WDV/WDD with
> WDDIS set.
>
> I'll test again.
>

The issue is visible when setting a custom value for the timeout on startup.
In the past it was only possible to do so with a module parameter, and the
previous patch in the series makes it possible to do with the device tree.

When using the Linux4SAM 5.7 release, it is sufficient to set the timeout on
the command line to reproduce the issue:

In the bootloader:
# setenv bootargs $bootargs sama5d4_wdt.wdt_timeout=10

To trigger an immediate reset (with some code that should work):
# (echo 1; while sleep 3; do echo 1; done) > /dev/watchdog

Best regards,
-- 
Romain Izard
