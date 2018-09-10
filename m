Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C92086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tL5z19yJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0C92086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIJQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:20:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46792 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeIJQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:20:24 -0400
Received: by mail-io0-f194.google.com with SMTP id y12-v6so280792ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bJTojSwImwK8PVoQRxmnr5beTpJ4GQQKIKg4TB6gSs0=;
        b=tL5z19yJvD681RFiehnQrUlHW9EiOvvwfQ0TRQ/bZMVTBEbvRj+jFIc7pErU6VEZBm
         cALtr5oMg8YbzsJKcKU1Mrl0EvQU0/DMraz5RNfF557DdvXjRCCEBMdWJlAvDIHqAyaH
         Ekl6oe2PceT1FgQbQvBFnRlglXmHIV8LbOV7Hqpy3qt1/NxUhSrO7cnTgGQt2X7NLxrb
         kDS1zPbpcfVl4y1yQ2zsgSAB8j4+6zZhaV/vKCTrB1eDE0B+CYLfzzm/I//ZoCkvCt2b
         5+OXxK+74lI1dgzDPJDfLNi4zvujbVHUZ5EDeE/FQWh+4qLTD6MWjv8PY5sAhSx4tR2h
         SAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bJTojSwImwK8PVoQRxmnr5beTpJ4GQQKIKg4TB6gSs0=;
        b=qYSKyHXbJLNSLk0M8TWKIUza6CJWq7rHVw57RSYD5OknoNSpNktjTQvDYCvDwhQNvd
         M3S9TSM069YTnLYc3GNCQ9nnzvzkLOa7ctpry9ZrfHwhPsbHEl/iMZL7eczWD38+XgOX
         79aevt1FqYZHauX+wMkMz3G9i2Pl22f0I2Vu69r7h34BwVn6MPqv3IOu41OSenY1+vZt
         8zsF/rPqm4BH82LSZ4U2tGo5SHw55YqajOqyw7UWg3EyGHBQl/kIYd0JEVYSF7IteIZj
         E3srrguNuuZTExiW10tpqcBmR2GSsa5Ko+wZqTuL2ungtw9g2ZHsmRLAEFpaOrQUas5Z
         l4bA==
X-Gm-Message-State: APzg51Bd380Y6qE3yqBeUPzTpsbeGsMHmnpkRjSbv7+jZDpTCOE9eji8
        YxS9i7Yg+KeeAhp+2kPs4nW9eodl4ezcQ/jHSHPeUw==
X-Google-Smtp-Source: ANB0VdbU041mT3aFPgQ01KNj5ph2Utz41VlsNbFDyAORkghYIeThOzHSAvH92JgCuYwtJ8zp/5LUwwgzXwGvjLPXMI8=
X-Received: by 2002:a6b:9157:: with SMTP id t84-v6mr16331007iod.187.1536578808460;
 Mon, 10 Sep 2018 04:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 04:26:47
 -0700 (PDT)
In-Reply-To: <f161f5fd-a651-eee1-78ee-63607021db7f@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl> <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org> <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon> <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
 <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com> <f161f5fd-a651-eee1-78ee-63607021db7f@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 13:26:47 +0200
Message-ID: <CAMRc=McUsDyAfSPAEdDBODQ9QubDPVU-C+j3mJLTC7GEriESfA@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from machine code
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 11:50 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 10:45, Bartosz Golaszewski wrote:
>>>
>>> Yes, this is how it should be!
>>>
>> Any actual reason for not putting these definitions into a separate
>> 'machine' header? This approach is currently used by gpio, pinctrl,
>> iio and regulator framework because most systems use either DT or ACPI
>> and don't need to pull in any stuff aimed at board files.
>
>
> I don't want to create header files specific to usecase!
> Lets keep it simple!
>

I won't argue this point anymore, but I disagree. This is not specific
to a usecase but to a whole family of users that need to a) define
nvmem cells without knowing the provider and b) associate them with
consumers. Something normal providers and consumers are not bothered
by, thus a new header file would be in order.

But as you wish...

Bart
