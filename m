Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AEA20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dI0NAXXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AEA20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeKITEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:04:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38737 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKITEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:04:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so994894ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xu2NPQwzos0qy0HkChtgTVO85LAdAEVRFFSBbO/c+1A=;
        b=dI0NAXXjTVsEtdvhEBS/pImwVsGCLMCinRvGYNFdtfYM3Uc3gymNXZfLRvkYgvq6NN
         dlncZ3A+rMDkAon+FF0/2qFUCpP8MHiqi2J7RYT+Gm3i5J7UMez7334Qlm6bw4f8vc1h
         2qKQvcIXT4J6lP5lL0PPGm7QAWOQwpzTCKP3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xu2NPQwzos0qy0HkChtgTVO85LAdAEVRFFSBbO/c+1A=;
        b=mIyDbYkdS55vIjbijAph+tP8X5MHeAs+XeHr+W8I2bt9e7Gxc+sHjU1beR5KbwRQtQ
         J0Bt1va9O40dxDc124vlwhsSAjaLhWGfjfv+zOSpzJ1J8i8ohv49zzgxK8EmFvTIRfuT
         GKZ7sKzqN/RQ1Zd1oHbIIY6w9O+PST95ZfjmuvNHI66ggObtX1P/iAuZZrYotCU8k7DH
         VTcBf5JRQzUEuEcx/Pb/Ty4BxYjHiQgYEzZbHpGkacos4IF8Ya8VIjqsnMVVDObMdT1F
         I2ssKULK6C44QOhKJKiQUYmM2Nywwzh40FQOOu+F9v8z1ol1iXIuo0Lzg+rIUhRKj6aA
         78xQ==
X-Gm-Message-State: AGRZ1gJqgfv6nhXtixms/XUKRZKeBYUWcjhidW8FHhmnFsPr3YPDEr/D
        +Xg+ZyqBMA6U2GGn0gGGzd4hHrXAwHARLtLWGJ4fT5C/SqU=
X-Google-Smtp-Source: AJdET5feKN4iz5HbHyNuxk+RcEXlCVv2SEytAx9f1ULSJNu2bpbgz87aFav+kQbnWRYN1LKjvqnw4ayyE6uC8snHFFs=
X-Received: by 2002:a2e:1510:: with SMTP id s16-v6mr4984525ljd.4.1541755479119;
 Fri, 09 Nov 2018 01:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20181101005257.8778-1-natechancellor@gmail.com> <20181101150007.14145-1-natechancellor@gmail.com>
In-Reply-To: <20181101150007.14145-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:24:28 +0100
Message-ID: <CACRpkdZLywABfeHYvV6wGKU7iVe-RVHBB+12iCC3-7BxmcRpeQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: lpc18xx: Use define directive for PIN_CONFIG_GPIO_PIN_INT
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 4:02 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
> from enumeration type 'enum lpc18xx_pin_config_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
>         ~                          ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
> from enumeration type 'enum lpc18xx_pin_config_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
>         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/140
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:

This v2 version applied.

Yours,
Linus Walleij
