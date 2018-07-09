Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5368C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5672220863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iwrZbNhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5672220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeGIPGB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:06:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54247 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932994AbeGIPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:05:58 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so25811243itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4MqhEgSGzFJLmyM4Jm+5VNO3Gx6Y0+tgLOX6Q0Zc2wY=;
        b=iwrZbNhbGqnBSq5JWSVtYpNrjoa+RcYdtN8oxkcwfz4E6I+6CGyc3bZvbs833Kl6+w
         /QP6muMoNZEPOSw8N8OLEATdhO8SXTePiMT/4MKbGsp3wCy910f/98JmpG0+StBJKQpU
         DRf4PdWX6Y1f0s1Gv2S/FiuyMMz5AJ1nLJLy8l3LIL4Le5mvhefxKwDJUxxLGQKjurG2
         wHHEAq6HAlTNtKnquF8eBmFViqK/0TGAXGPgG05ymQ0EoRXiGaruSf1OeTn8nbvby1uk
         vwv6s2nAcU+pnqWiet3UL/HuGdsQdr1h6EQ6wnwt7foSZGqbOjQbGUI/KSlwttlgVEJb
         ow9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4MqhEgSGzFJLmyM4Jm+5VNO3Gx6Y0+tgLOX6Q0Zc2wY=;
        b=duArfPXmSUZ9Z2UCDbrfNI5WmJx/5G3HecOXiH0QqdMq3e1z9q3qSINdYQ9B3F2YEk
         naA13qN3vSIwQTDw5iPSfyyY0+B+reskwAoCPlDutgUMOxpQgI+xEh7a3qrHN30ms2AT
         0o45Qww2tZkPIj+waJ/VGdR7+BpNzLQsuGs/eWLMsGXnjd6BDJEKL+Mv/PUeCg2U61t2
         EiRfqTAwNtKZaD7SuacmWIeLDOQXBGOUPsz5S0ayC/C4EHDk9lEyyweNAMAXZaKHTZn7
         yBAW6bfmUgmkl25xu+Vbe+QIZKkTgLZAXz4xhvMVW2zIIcgik/W9r0rbAZrsxjNOf6RM
         bRYQ==
X-Gm-Message-State: APt69E3n9nKki2w+dRoDTwEG0h32PZao248v4PkYb6PhFU3nlHKJ3cV9
        1yyBEpZOG5eH6kcfLa4SmjDI9y5PbjusMiJa0xY1XA==
X-Google-Smtp-Source: AAOMgpeZqr4tdT0ReMEka659PT2j+b1H6+5zyAm5VMBnxbn9mRfLpCOChVsDNwvXbm1kISf0Dx2QaXRuqJ+DFUxv/H8=
X-Received: by 2002:a02:b70b:: with SMTP id g11-v6mr17690503jam.34.1531148758331;
 Mon, 09 Jul 2018 08:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 08:05:57 -0700 (PDT)
In-Reply-To: <CACRpkdZny9ixvz8=dVXfLG04_5pSoHYJa01qeB+gXqpkPCoGpA@mail.gmail.com>
References: <20180606174424.9630-1-rafael.tinoco@linaro.org> <CACRpkdZny9ixvz8=dVXfLG04_5pSoHYJa01qeB+gXqpkPCoGpA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Jul 2018 17:05:57 +0200
Message-ID: <CAMRc=McK1G74ih7fvgqzjRB=vgWPqr4WvoFm5R_0P7uvy1f=eQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: gpio-mockup-chardev GPIOHANDLE_REQUEST_OUTPUT
 fix
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>, shuah@kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-09 16:08 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Jun 6, 2018 at 7:44 PM Rafael David Tinoco
> <rafael.tinoco@linaro.org> wrote:
>
>> Following logic from commit: 22f6592b23, GPIOHANDLE_REQUEST_OUTPUT
>> should handle errors same way as GPIOHANDLE_REQUEST_INPUT does, or else
>> the following error occurs:
>>
>> gpio-mockup-chardev: gpio<gpiochip1> line<0> test flag<0x2> value<0>: No
>> such file or directory
>>
>> despite the real result of gpio_pin_test(), gpio_debugfs_get() and
>> gpiotools_request_linehandle() functions.
>>
>> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
>
> Patch applied. Sorry for forgetting about it.
>
> Yours,
> Linus Walleij

Oops somehow I just now noticed it in my inbox. It's too late anyway,
but it looks fine for me.

Bart
