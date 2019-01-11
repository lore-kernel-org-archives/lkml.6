Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE8C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B68E2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYVMVNbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfAKJjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:39:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37345 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:39:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so12351958ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOAK6HVhb+bILEvywTUCsGY0OkknxUI9FX+ir9zNtFw=;
        b=IYVMVNbnXugYliKQnhoZU8ETetDGRI7qiDCCBphRY6bSSpuPWZT2DToct1wvV40/En
         j9UFGSfp/URY+0OnvA1YVWm6r3keqOzjnN9OkCQfKdziQpa99pXKdPO0b3nppk+8RcGG
         xQ5hX9VBvcGwPsuPX8ZbFPX9lK1K3NEBtJxXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOAK6HVhb+bILEvywTUCsGY0OkknxUI9FX+ir9zNtFw=;
        b=C1oUWKdVwqvk84T2PkUNL3xfik1VroASbW4FbN0TyKwYzbybPK4iXylu51pxAa6HcT
         aG9xZSHKG2sG++8q1pnEHEADX98vJQSVVbGTci6QT3diUrxbH0o2izUru158y4iPg0bL
         WqN54pZh+q6sCw9p5VoAa/01WhSV+yol8kqAt1QM+vGZmcZ8rtQt4IRqE0K4XzN/RPE9
         EQk43wsqxsRLISNCKF4ldnizV6TOb8d/My5tBv8hqgEVILXbnxiwejlQtmJheFypxcTq
         bCCondgwnoc1tK1i7THjHH4R0etuSwA6WnABl4yzTP/oSLsp9KS9HeIIJ7OvHw+hkWPH
         VvjQ==
X-Gm-Message-State: AJcUukenXsxiy/1OxWvPl9Z3pexmOIYKqC77M1mewGn+uCfvcI2oF9q7
        an03hEFwGL5683VoGlH3wPw6UDbJ7r+8KuPF+t12kQ==
X-Google-Smtp-Source: ALg8bN5lcoLI+IT16sWF+XNGvCR5lrV8HdBcXvdZfYHydXGJMT1G5VbheWLsQ3Sje4bS0pEMlXzLv8I/cL7VmtbJuJ0=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8093148ljc.97.1547199542027;
 Fri, 11 Jan 2019 01:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20190103151104.11839-1-brgl@bgdev.pl> <20190103151104.11839-2-brgl@bgdev.pl>
In-Reply-To: <20190103151104.11839-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 10:38:50 +0100
Message-ID: <CACRpkdapcG1bWCOk=SWHfKvpPMdBiEu0QOj4M+Zbx11Xhc59cA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: davinci: da830-evm: fix label names in GPIO
 lookup entries
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 4:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
> automatic base selection") the gpiochip label no longer has an ID
> suffix. Update the GPIO lookup entries.
>
> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose you will push this upstream through ARM SoC.

Yours,
Linus Walleij
