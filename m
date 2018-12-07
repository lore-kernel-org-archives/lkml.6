Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC44C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F05220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3DCwO+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F05220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLGJ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:26:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42525 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeLGJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:26:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so2502279lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QkaHagf08gk25s2b3H7suyFZBNLTZA4bYfajywwsxY=;
        b=h3DCwO+zSCVZgoHENbFNT6/MbpM8wIw85Q9nofsPchbIY7oktwm7tesgLmnavAau4V
         9sHYVSza1fuECkXfZBTsyPf+tmEcwAB2WYzPGUPUU6fDuxZsdhR9Nfbw9SEaIBUt0p1v
         0vhaeWppZLivvQdBvbmlsGbByQLVtyaOIPB3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QkaHagf08gk25s2b3H7suyFZBNLTZA4bYfajywwsxY=;
        b=CKqcAX1RuYzeG9i5Q77WhwnD4sBGYqXvZgaDpwXiKakg8MiqXBAjzBwiWNGFwW/kM+
         CVx7KB2EnLeo72P2SqLyfAv1XO9uMHkFSWzazH+xKDY7XPproc+zbN0rds3qJsCaPFX2
         MlTeWuShYAmvnIOJie7rXkI+jrjrHcqWETOLqBEbrfVKjYjqRMrQdAytTXebI09HJg7y
         WDAjY6/DwG6+2VAuur0rdAyHkvAlHTTc4fSMk9J2LlqAztz38vPJhlFJAQRpJUGd1B1t
         +mBsGtWnj55Ms2swcXhVb8IrD/gMlreqf4ylAFqcArmrQF7xRtlOxeKmlHhcyEfw6hNj
         CKKA==
X-Gm-Message-State: AA+aEWZEs0Xh2qfYWrvPxOFN2VVPkb+25U4lr8W97nP+e5D0aSpOEe5/
        Hi8PWlQHjsQdK9YRIG/X57tG3Y+W0fXJbIBoa7N43A==
X-Google-Smtp-Source: AFSGD/U/G1RGQrhLlsTLQfGaTPGgLwOKr9N4ACZHrt01DouZxIOrXH2E/iToguPIKDc2uTrg+FPYg1mkS//IJJtcDp8=
X-Received: by 2002:a19:4849:: with SMTP id v70mr855135lfa.62.1544174783245;
 Fri, 07 Dec 2018 01:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20181126081558.32175-1-brgl@bgdev.pl>
In-Reply-To: <20181126081558.32175-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 10:26:11 +0100
Message-ID: <CACRpkdZU6bUKUq0vRrhEW1jr4kUHy72Bn9ZZkc5B9sVvUjaeNg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove a duplicate entry for gpio-mockup
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:16 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I'll be getting all GPIO e-mail now, so remove my name from reviewers
> of gpio-mockup.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It doesn't hurt but OK, patch applied!

Yours,
Linus Walleij
