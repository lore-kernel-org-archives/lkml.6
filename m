Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08188C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BDE20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKcF4CHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BDE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932707AbeGIMJn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:09:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35708 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGIMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:09:40 -0400
Received: by mail-it0-f65.google.com with SMTP id l16-v6so26051908ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWaPhleJe7m6TQHcJO0TPPfjhBzbM+n+HtPE9y0Cz60=;
        b=LKcF4CHhwf1EFU+fmke5bGvCiD+dS48P9v3owRnsXIAT9yk9Iz+raCBedRhkmrym/o
         H+Jh0YpDfkBqF7Z7YeDhhFpPduoD0jRhCWHEGniyFrIL672mjdKSTLxdGkPaUseuqOem
         0L1yJ34C1xTgQm+BOURQ8ZvoELKLfRd0oqXw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWaPhleJe7m6TQHcJO0TPPfjhBzbM+n+HtPE9y0Cz60=;
        b=kUGy43HqBbIOb5J6aW0Hlf4pXabyZyGvjFnA0edK4/J5RM43Ij3xgiG7gcZ2FAIYFL
         JoguAQL76xZo2GQg1t3elixJD51SE/klmL1fK0G8xdpf/XIKzu3M7QNbdrfVhz/Okc5/
         wsPqz2ncH8HxHuFByyuFrpWXRra5tJ29KX+l6QClrIET5qvBi+lRrfGgk6MsSFgV9hQn
         cgmbJDtCzjNS+6FRa4nJ5Bzk5tdYxKyH8sxlkajjYJPStj3tI4Q3V0/j7/u/l6gVf4Vr
         lrONQekvsw0T17Dx6lr9cch2pDCHS+8egbwktSkRZn/aSPAIKGtm5rYv37dd/0W5RLKd
         Hqjw==
X-Gm-Message-State: APt69E0FXsFo8KWHFub/3JL8CK2kESofGkczlg9LeQ5bJghdPs3EvdEL
        QC7X8wJf4yl8c6mrdixkYpt+B0fQv/3nPJYNrxBATk0F
X-Google-Smtp-Source: AAOMgpcy5yVGRnRnhgGzI7sjw9qCrkWsmC/t63DWIqLXFbDndThY6+5Ftg1CIFUu5Wulf+xMncu48YdO8C7MzmMXlCI=
X-Received: by 2002:a02:c007:: with SMTP id y7-v6mr17006255jai.87.1531138180280;
 Mon, 09 Jul 2018 05:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180627114904.10890-1-paul@crapouillou.net> <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
In-Reply-To: <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 14:09:28 +0200
Message-ID: <CACRpkdav3FV7hc20Fj=n=DaNzvSaA2uLuj8QgHwwcevDkn_6_Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Wed, Jun 27, 2018 at 7:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Even if GPIO and pin muxing has only one set of buffers to indicate
> input or output (same registers in use) it's a GPIO driver business to
> get direction from GPIO part of IP.
>
> Looking into the existing code I would rather say that
> pinctrl-ingenic.c should incorporate gpio-ingenic.c as they are
> (partially) sharing same registers.

Usually we only split the functionality into two drivers if the two features
pin control and GPIO are explicitly in different hardware blocks,
and typically not sharing the same memory range.

If these registers are intermingled and the hardware actually
just one piece of silicon, I would suggest to try to merge the
two drivers into a combined pin control and GPIO driver
inside drivers/pinctrl/pinctrl-ingenic.c.

We have a few drivers like that already, good textbook
examples of how to do this include
drivers/pinctrl/pinctrl-sx150x.c where the two blocks are
handled in one driver using both APIs.

Paul could you have a look at if we can simply merge these
two into one big driver? It is much more natural to write
into the same set of registers when we do that.

If you still prefer to proceed with the GPIO/pinctrl as separate
drivers we need to look into this patch set, which I am
a bit ambivalent about, because it makes sense but at the
same time I want to keep GPIO and pin control business
separate because separation of concerns is just nice.

Yours,
Linus Walleij
