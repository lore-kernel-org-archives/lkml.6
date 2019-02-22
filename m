Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B210FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5DF2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocMNPdFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfBVQ3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:29:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43822 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfBVQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:29:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so2147253ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dcy6Xq4QSGQNqs2OFk3E23YJ0faYLfpOBkrfaORLYY0=;
        b=ocMNPdFTx+rN/fi7Z5gT/t+cQBaHe5IhIvE0gskAjTksWchlye6xoYmSTmDZz7B6KJ
         s69Wb/pIZaPLUDu+kvGYmoo6Q13IcFHPBSqg/VGFhnig/tSpFFjDUagakQK53wUTbihT
         BQNw4g150Egk+OeRo4rkQEQPJPXf+WOGndxVcmDtDkepbwJXmQCzLy6AXSxf/vzNiwr8
         v0PSUTHWYpyJ3WCj0JV+EVH7774v/X6C1SU6zH+TwWjV4JqPy/vNftiFCqNgOqZvAPJ9
         OPcCpD0FGAfPriwBPrP4QHMOC5SpSglmyFY5aN+kZxk3AKpcQnwQqe6v+8/XE6+zDiSm
         8POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dcy6Xq4QSGQNqs2OFk3E23YJ0faYLfpOBkrfaORLYY0=;
        b=JxjzLqFT2LC+5YHe7+vHQNMilqvtXf3+bUoM1XC4sqY29L9RxN+jIRmP3LWRJNl25T
         MPiR5m8N2uSKELCLCtDjhnEpGKM5DwLdJqh9PgppQxuF7dJYzEBYz4WxgjJ7zDlXgYTb
         ZrvVomK+XPqbu/GvUP72ADPTWxYoJKIf65AlJBxmcrJet4+bzxnnJC3qmlBKHU9FkGGt
         c+DGlIj0g1GN555FVp3piW3xlx3qK6HBjVmOMs3E48RTSKQ1vn/qwUNnJPVFvyKBuo1F
         UiZ2nTeyLHeQ+O0Y/uJLF3shrS69GoTDQw0qy3JtBPKqyzGeInk72IZpAmsawg0vpz92
         lhdA==
X-Gm-Message-State: AHQUAua1ni0LgazH9kUTbtzsrORR2+g2yXDS7GqZ8YfL5xLVfUnOAC6/
        V/VG55R3EPuTuEbD8bAxEKXTq03Uc+pqLczZTnhvzw==
X-Google-Smtp-Source: AHgI3Iam433r4fPaHJa6qJE3GhhtvaHLpe4bMjYA5LAF2af0CEeYhsqXeoJvzglDiHboQtcmI/n4VTpFlUUDWsIX8x0=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr2715764ljt.107.1550852951674;
 Fri, 22 Feb 2019 08:29:11 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <1550181897-2596-1-git-send-email-info@metux.net> <1550181897-2596-3-git-send-email-info@metux.net>
In-Reply-To: <1550181897-2596-3-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 17:29:00 +0100
Message-ID: <CACRpkdZXPqi-tQkf+JSiVqidj2yuv9X6m3BuEX5DhDR5ifPMCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:05 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Driver for PCengines APUv2 board's front LEDs and Button,
> which are attached to AMD PCH GPIOs. Due to lack of dedicated
> ACPI entry, detecting the board via DMI.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: linus.walleij@linaro.org
> Cc: bgolaszewski@baylibre.com
> Cc: dvhart@infradead.org
> Cc: andy@infradead.org
> Cc: platform-driver-x86@vger.kernel.org
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Andy's review tag.

Yours,
Linus Walleij
