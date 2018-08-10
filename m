Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0917C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4965B208D4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2KbqWUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4965B208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHJXkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:40:05 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51025 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeHJXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:40:05 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so4462284ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbzwpWyopjb9EZV3NWuSuuA5bL4B2lQRW8OnD9zonvQ=;
        b=P2KbqWUSD6X+nEVM5zQDPxB+UtrdA1VMYkwMTsgMazyXD52Rxa9B/jQ+HG4S+MBGSW
         lQWJWs7f4BKIqvqK0aKSJZuLovf0Q8LdIf4Mrp5facvmLcF34BsesXu/mq/BG5J+zYNY
         VhitQFaFMOzZStbKR79WFiN0DVF9lAzLbIFiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbzwpWyopjb9EZV3NWuSuuA5bL4B2lQRW8OnD9zonvQ=;
        b=lsvUF6RIIkwv9it0HJYmlpz9FYYQhFPchRru9qBLnc911VtYndLWUkyzW8GJR5Gxlf
         aVsIM0O6YkH6ojIqebRww618cGX1/dB0jWRBGTOOuYc/ZYCdb6maReFdJ/SHjIhSEyax
         JczdkJQq+iuZpCsbk0G5u5kTJEMsWr75vjh/jw06a6J/4DUwg4/RUEkjo30cwlXf5AyP
         QI1xRdn3Kq9KAAKpZ2xWvfT1rb21YC7ofau7/PEJ+0HmVxThH2tV5tg5nShF9XfAHJhS
         qEbozWTxZnDwKmxzmSN8bwBkGqstO1RLcM+3XEw4JjV5EDdC59Jk6ha4vnKVZ+v3geD3
         EOYA==
X-Gm-Message-State: AOUpUlFHDcgAeaKgxD4476TLCdeKtCIh1nSntm/ZzfsjEiu+bwHIJKuG
        gRcGSH10Jl2lCkgN7RJQxHEFKjtmA+oLfh0R80hVj1AM
X-Google-Smtp-Source: AA+uWPyinvG4+yfHtNwLH+CPh37eByWKMYlgpD8HpCBy2WyhmCVw/9zhb9x87NmE2SKKDUy4E3F+Qg+/nroLpWvsZvA=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr3642692iti.135.1533935313471;
 Fri, 10 Aug 2018 14:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <1533610179-13885-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1533610179-13885-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 23:08:21 +0200
Message-ID: <CACRpkdYNEhq_3nO1OWokhuop83WAmURHmy0k=xyJRT32UFBSOQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: drop meaningless pin from SD1 pin-mux
 of Pro4
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:50 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The pin 327 was supposed to be used as a voltage control line for the
> SD card regulator, but the SD card port1 does not support UHS-I.  It
> only supports 3.3V signaling, hence this pin is pointless.
>
> Just a note about the background.  At first, hardware engineers tried
> to implement the UHS for this port.  Then, they needed to shrink the
> silicon die size, and gave up the UHS, but forgot to remove the pin
> assignment.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This patch does not apply against my devel branch for v4.19.

Please rebase and resend.

Yours,
Linus Walleij
