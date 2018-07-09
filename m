Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC83C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C1520878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuuJSsd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C1520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeGIOJP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:09:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45837 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeGIOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:09:09 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so17155761ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVqb9KsxVn6aQpbuzEcDPf/og0/Nb+B6n4i1vufHFO0=;
        b=CuuJSsd4HtybUqRlLS86ad7d5FmZYZD1Oo9RUlCCRlXhen3RvUJ+if+x3iLNQhPtGG
         3LpTkNybT9bL0oyr9IJyRRtEhjvHjIKq5yIg6p6nYUJDx5twyBCW/eNRmpi0ZGy/JZ1d
         FgBes6FznpIRe/tDcu3dvXJmBG/f1v1C8umms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVqb9KsxVn6aQpbuzEcDPf/og0/Nb+B6n4i1vufHFO0=;
        b=hWpZ1Uv7DxV5VzaWRwoZNnqo532Nu5k4Wj7VjJ4s8qbT/yM07Zr0HFt4ggM6B5fMOh
         9JLA8N39qrlKRhT0mZ16H+XapGpMXvLmXPYwKqp2rb4ECpRaLwzyOJKJvE6tIscC2RYW
         mXkPm2BkpV4kNd2g66piVZbe0usPEqYT/SLnZtTOydD3vTXEniKWbwAJ8POcyDn5z0JH
         JxJmwVn4PKfgJsA3QP5D4demOmVJLcfpcvgXocDUEIzaCE5gYv7empqraWeFJOPi6mHy
         w/9nRcBLE/LZhkJPQkzTzPYd4Mg1YFTfLT1xyA5kE+cj0TQgQphGVg+aJ5kRP5ZaGfpv
         71lA==
X-Gm-Message-State: APt69E0p2goZ998enCwt67BfGhqAiIvFisvKwzSKCCRM0LDUxVseRzno
        +OxDm/HQx8dGqu+3N1H2KnLHxUvO2tbsJBMKggegLQ==
X-Google-Smtp-Source: AAOMgpdVnmIF7wMWyhHVreHmcNfdhyfPAGHEMZXvX50ENpZp9jaqUxZka7BekVWOJGBvt3kmIuW9yMNWm+hUDYgydjA=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr17116066ioh.175.1531145348493;
 Mon, 09 Jul 2018 07:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180606174424.9630-1-rafael.tinoco@linaro.org>
In-Reply-To: <20180606174424.9630-1-rafael.tinoco@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 16:08:57 +0200
Message-ID: <CACRpkdZny9ixvz8=dVXfLG04_5pSoHYJa01qeB+gXqpkPCoGpA@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: gpio-mockup-chardev GPIOHANDLE_REQUEST_OUTPUT
 fix
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, shuah@kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 7:44 PM Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:

> Following logic from commit: 22f6592b23, GPIOHANDLE_REQUEST_OUTPUT
> should handle errors same way as GPIOHANDLE_REQUEST_INPUT does, or else
> the following error occurs:
>
> gpio-mockup-chardev: gpio<gpiochip1> line<0> test flag<0x2> value<0>: No
> such file or directory
>
> despite the real result of gpio_pin_test(), gpio_debugfs_get() and
> gpiotools_request_linehandle() functions.
>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Patch applied. Sorry for forgetting about it.

Yours,
Linus Walleij
