Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199B3C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B853220882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfm1zPJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B853220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeG2XLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:11:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40894 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbeG2XLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:11:24 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so14233921ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BhwEFZe2THtyq2PgjjGqewmZQAG3kusXoL/+0CLnHA=;
        b=bfm1zPJbXyhHU46t+bneG4PDUyyYbDJNoqja+rgtk3P5MzFBa1bKyDpo8EEsHG1nAK
         qYxt867HlryjEeF/O/5VgZ8sQeFbM2cgOf922oSQBK9CglypgXAk528Sng+T9cvRflBZ
         77AbYFHg6wgg6nGBoc/Ljpkl7bjQ/X7VwE360=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BhwEFZe2THtyq2PgjjGqewmZQAG3kusXoL/+0CLnHA=;
        b=rXCnWPDcyX5fvqmGJ/EDNPzW8UqBvNGuVPQPhBvbvIXKe2KZ6EPZOCN5Ih11jw+0m7
         j+3rtjOVvcBh9QOghgBpl2EIcwrkfJJSdSbBIgB3Rh7nfBWnR2sCih3REs9wMRBsQWvg
         TA8uRj6QhmAcIC/5vQHbWC/g2yxxiccwHWOwBiswqYZJlq6UkdfRe9ibTmtIrxBH2Gqd
         aE3jmdjJBQpzYbA2q21Q9GZ2JlgTeW9G6Cmgg8W31iHfrRSNUF55RdR3HDT1svlj8MJF
         p6sOv5Phy3u+7+XaplSooKQVGBZIpnoG/bzT+1Ep57K5nt+Jjr5x/aBKCgbTgOTJZaZv
         P+Rw==
X-Gm-Message-State: AOUpUlF9iJk/GPe1JhQ7+1g9N1oTfqSbg3+2ApPY9LZD9Ebqw4KPcjMK
        E22yfp9zozWDhpx+tSYy8hest6GL0ZhaWR0+VZY6DA==
X-Google-Smtp-Source: AAOMgpdfQ25DT/mq3AgMHk9chhSzcAZWOqyO+hx30D2/40kFoqZbrlgpVp/guUNw2vHv7TIAFV8phq4ghSjdkD/p3Ho=
X-Received: by 2002:a02:9d03:: with SMTP id n3-v6mr13562828jak.113.1532900368148;
 Sun, 29 Jul 2018 14:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180726154252.14137-1-stefan@agner.ch>
In-Reply-To: <20180726154252.14137-1-stefan@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:39:16 +0200
Message-ID: <CACRpkdZtF2SvXHpFtdav=Scw5BGNCEJbT1qzAVbQnkxvdbi6UA@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra: drop tegra specific GPIO lockdep classes
To:     Stefan Agner <stefan@agner.ch>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 5:42 PM Stefan Agner <stefan@agner.ch> wrote:

> Since commit e45d1c80c0ee ("gpio: put GPIO IRQs into their own lock
> class") and commit a0a8bcf4670c ("gpiolib: irqchip: use different
> lockdep class for each gpio irqchip") GPIO lib takes care of lockdep
> classes. In fact, gpiochip_irq_map() overwrites the class anyway, so
> the lockdep class set by the driver is useless. Remove it.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied. Makes perfect sense.

Yours,
Linus Walleij
