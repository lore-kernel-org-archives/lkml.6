Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82048C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477592054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQVwDx48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477592054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeKAGaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:30:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36754 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKAGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:30:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so16244294lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zVxuEYHA0OjT0GBGxNcDM0Kyu3TPQo/tjna7UCNe4A=;
        b=XQVwDx48gboYDBcFkyNV+veyMdOGbUZG4bJnNRRWpoVJQn/ZjL9j3i6FUI4PNRMX5t
         //UixLDMte0FI0E++uHHqQK5A+A7I8JOo5BizaXWUjvCJI21tejWBsqMZIS64Ac3BcZC
         8B8icMjkqBAYC6h1HZ4h/0OYNHiwL8i8jZXTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zVxuEYHA0OjT0GBGxNcDM0Kyu3TPQo/tjna7UCNe4A=;
        b=bVbwPxlA2++xhXlrAo6w9A8txky/hGfEyuQkSM2RbAvFM9amceZtHMkMNwpjfLgkcI
         eCLWtiU9n/2HGtqd4GndmBerS2LKImnqm8USkV4EKZ/FbzIY4jmYmHKTsPq1CiqVaFn7
         2/7HV7x/4KlQWo5q8KfwQFgFX6p4411UfcQa2lSYOcQNx+G7Hb11SWkuA12n17jUF2KM
         5lbEuLr/Zj2nsymDiMoMasDLa8Xiq57Qv2zqI8GpdJMThftDVo/eBcP8ZPBJSFatBzGZ
         Y7Q7HU2zizzQ26wLQbgnr2AtnHEVW77cg3fBIfNlut3wHhwCFvqn9xWbkZfp+xbt73MH
         wHxQ==
X-Gm-Message-State: AGRZ1gKaKJ4f8up+nqS/PLOMsbVzoK8wTpjzS//QRLlKLdFV8CaZIbf7
        FItVxmCWy9nAl2HdsqTuqK8tZIrALnquXwW6Mwep3g==
X-Google-Smtp-Source: AJdET5d4YzYiAQSo9tOiK+kEWJYxEgb2DdR5sAIIKChwhlTwt110MViPIGts/7KhMvU9ZXGv6wU4P7J8ncVbp0QdLC4=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr3184566ljg.23.1541021432468;
 Wed, 31 Oct 2018 14:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com> <1541018689-20625-4-git-send-email-dan@emutex.com>
In-Reply-To: <1541018689-20625-4-git-send-email-dan@emutex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 22:30:20 +0100
Message-ID: <CACRpkdajUt7Brrf9jCOhEvrzvx24A8tp1NpGKuDPi_0uh5++eg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
To:     "Dan O'Donovan" <dan@emutex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-leds@vger.kernel.org, carlos.iglesias@emutex.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, Oct 31, 2018 at 9:45 PM Dan O'Donovan <dan@emutex.com> wrote:

> The UP2 board features a Raspberry Pi compatible pin header (HAT) and a
> board-specific expansion connector (EXHAT). Both expose assorted
> functions from either the SoC (such as GPIO, I2C, SPI, UART...) or other
> on-board devices (ADC, FPGA IP blocks...).
>
> These lines are routed through an on-board FPGA. The platform controller
> in its stock firmware provides register fields to change:
>
> - Line enable (FPGA pins enabled / high impedance)
> - Line direction (SoC driven / FPGA driven)
>
> To enable using SoC GPIOs on the pin header, this arrangement requires
> both configuring the platform controller, and updating the SoC pad
> registers in sync.
>
> Add a frontend pinctrl/GPIO driver that registers a new set of GPIO
> lines for the header pins. When these are requested, the driver
> propagates this request to the backend SoC pinctrl/GPIO driver by
> grabbing a GPIO descriptor for the matching SoC GPIO line. The needed
> mapping for this is retrieved via ACPI properties.
>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>

It appears you missed my review comments so please read them
and reply or respin the patch accordingly.

Yours,
Linus Walleij
