Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86434C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD6420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bR6/5SS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD6420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeKIUyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:54:04 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33199 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIUyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:54:04 -0500
Received: by mail-io1-f66.google.com with SMTP id f12-v6so1009669iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+O2cbi/9+7ZWCqdG7yju5c5d/4m6buagZgVKiTh1/c=;
        b=bR6/5SS0jf+aa20TQ7aseTvua7qn9bVmKX7q+bjaHEEOg+l4SEO/I5kYBZ6NBzc+XQ
         hqKhJnAmccC01wz89cXnx7oWH9nwNtBgar7xzAihLCbQWEJBCqtysV1riCCPbvneiXxF
         2OmKEU9wuwarN3IyxqInef2LvZQQoguYkAehn0sfF0Og9WyeUAe3J+1VaeTj5141GByB
         iIb+HBVDGfLe4dJ7xWV6Umtz6QPpR8EkBR5ryEvvaNEfhwdwNf42C3752R5T8RcbC8ZM
         qOeSX0SozJ/wzfqNzhQfpd78zJ1L5umgT4xZxkibnrC4NaPi9XhxHBc5B3TiZOiydeMB
         QYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+O2cbi/9+7ZWCqdG7yju5c5d/4m6buagZgVKiTh1/c=;
        b=jCBqCzD9tlFAhgKPPHmX2pgtxddvRNr8BdnKLvPnAKLGcmybSbeLzKYOfpR9sBK3m9
         SQ7g40L14VY2vyQzEKvB/pssjoN4W+ascuM+77lyW6pmcemPnlhQ6XAKNor8qIBVTHb+
         aeYT/fhaGGDXVOeI8HIBDapy0KfE0lS+8YtlZLkK3kURdFOzDh0NIY0n/pQDDLDHO4ov
         jNDcagIJvfYJ/ikQBim9l882HtgJFB7nKDfwaUY4Lv4EYbt57Ho56HhKxQ3lib5NveNV
         I1KBTpmTsGi67Ogi+LdUt0RGW42+tkKPdgcWWoIyLt1kEfo4hrp1AvpMWn7cwdxgqoUg
         W17Q==
X-Gm-Message-State: AGRZ1gIHkpYwob7mZrwWXZKyuccx9G0qyx615bEIIu6IS3djZeltMXhX
        CFTCqyGioU3s4WCKcRvHXU10dpJmSnFgJeHtqL5yqg==
X-Google-Smtp-Source: AJdET5f4GUE/39wUcSMFJYXSwABx7ohpohLusY2uMSsr6hBcjZ6dlWYAGXr9+t0l3A4CKJZI8sTpWTJxF7Dv5fQrCHU=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10-v6mr7069390ioq.111.1541762034889;
 Fri, 09 Nov 2018 03:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-2-brgl@bgdev.pl>
 <20181108203546.54rncnydgamud5z3@pengutronix.de>
In-Reply-To: <20181108203546.54rncnydgamud5z3@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 12:13:44 +0100
Message-ID: <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: mockup: fix indicated direction
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 8 lis 2018 o 21:35 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Thu, Nov 08, 2018 at 05:52:53PM +0100, Bartosz Golaszewski wrote:
> > Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
> > beginning") fixed an existing issue but broke libgpiod tests by
> > changing the default direction of dummy lines to output.
>
> The indicated commit only changed what was shown in debugfs, but didn't
> touch the actual direction of a GPIO, doesn't it? If someone called
> gpiod_get_direction before it would have returned "output", too, unless
> I miss something.
>

This commit (3edfb7bd76bd) sets the correct direction of the line by
actually calling get_direction() instead of assuming input if
direction_input is not NULL. It just so happened that previously the
default direction of gpio-mockup lines was output but it would be
displayed as input due to this inconsistency.

My commit fixes it by simply setting the value of GPIO_MOCKUP_DIR_IN
to 0 so that when we kzalloc the line structure, we'll get the right
direction automatically.

Bart
