Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90141C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BB920870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R89q5oPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BB920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeG2Xb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:31:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37449 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeG2Xb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:31:59 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so14286100itf.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7bZhcyTpE+i4skso6b+guWe1n4YDRE/3xREZIjVyiA=;
        b=R89q5oPFQU0WYedUgAws16ttipG+p4zgfD9c1uHZ+lhtcNHDOZ7hi+FsuCNqJLq+fN
         N0U/8Rj7/Fah/gUaYcDKum1WSOflRQlPsomNVfcfnZm12QL0+3rYj8bAYh35o5qpY/Bj
         XY3UiGW3Z1Niu+CIPOjbxUwGm1pJg8qdkLR4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7bZhcyTpE+i4skso6b+guWe1n4YDRE/3xREZIjVyiA=;
        b=h1LcdQu757ST5DLMrGeng085xr7XZp8PCMYou9kXFrMmVjWD/aWs43qWH4svhmjJMp
         cmGaKn8OU+X/jGQMqb+ZvcmjhDDGTj1KiN5AAQptiKQbYmU3loekE5kODn3BrgdEvlIQ
         GlR8nAgXEE3DFXOPfTqBYKqDa2tgMwcGpl048tyG72uKtBNV+MzcbjL55psgSX1LHfmt
         7I345Z8ZslFMSqEAINshwOYz4A0lnRCZzL+kPp0G/j5GB9BoqstG9oD1i+wPBnSPGWrF
         1uB4ucTmvmeGbwEqmosS6nq8C6zT9vlyP8pzarM6LW647Zm9no9S13t3FBaxK0Pwf3S3
         hhuQ==
X-Gm-Message-State: AOUpUlHrTYWuOnj0f+6JP3br96G2yN2lDcWdKbWNwpcZW4J6zLtKIQb9
        WJzScZ8fZw41BPRF0a5TwdOi6kzOxkO/r7G1ztHhpQ==
X-Google-Smtp-Source: AAOMgpcXJjDlWCveC8+vtZ4s9b+bB2/b1V6q6PHef6zUUqEDNBVEgESLYW6Z4udN4prI4HPyKrAsP2gDDao2EGxtnhE=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr14110254jag.112.1532901599201;
 Sun, 29 Jul 2018 14:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180712214203.114844-1-tmaimon77@gmail.com> <20180712214203.114844-3-tmaimon77@gmail.com>
 <CACRpkdYOQMkA6BHtY3-NSXhyhoG7KzDg8SkqL2B6M8GQrvXgMA@mail.gmail.com> <CAP6Zq1h5TXBcfvxDA5Ae9XuW65s_zQd_JrM3vRWR6KBRYCHRrg@mail.gmail.com>
In-Reply-To: <CAP6Zq1h5TXBcfvxDA5Ae9XuW65s_zQd_JrM3vRWR6KBRYCHRrg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:59:45 +0200
Message-ID: <CACRpkdbcqA4gBv7W2SNSFJRQ26GGCE315UsDDG9zr458GK709g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver
To:     tmaimon77@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, avifishman70@gmail.com,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Patrick Venture <venture@google.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 2:01 AM Tomer Maimon <tmaimon77@gmail.com> wrote:

> I initialize bgpio as follow:
>
>                         ret = bgpio_init(&pctrl->gpio_bank[id].gc,
>                                          pctrl->dev, 4,
>                                          pctrl->gpio_bank[id].base +
>                                          NPCM7XX_GP_N_DIN,
>                                          pctrl->gpio_bank[id].base +
>                                          NPCM7XX_GP_N_DOUT,
>                                          NULL,
>                                          NULL,
>                                          pctrl->gpio_bank[id].base +
>                                          NPCM7XX_GP_N_IEM,
>                                          BGPIOF_READ_OUTPUT_REG_SET);

(...)
> The problem occur when reading the GPIO value from bgpio_get_set function,
> because the directions value are inverse it reading the wrong I/O registers
>
> For direction out it reading dat register (instead of set register)
>
> For direction in it calling set register (instead of dat register)

Hm I don't quite get it... sorry. Maybe if you show your fix and what
you expect to happen I can understand better?

Do you mean that because you write the inverse value to
IEM this happens, and the BGPIO code assumes that
you always write 1 to set a line as input and 0 to set it
as output?

I would say if this causes the problem we should just add
a new BGPIOF_INVERTED_REG_DIR with comment in
include/linux/gpio/driver.h and make the necessary fix to
respect this flag in the gpio-mmio.c core so it works right.

If you do this as a separate patch I would be grateful :)

Yours,
Linus Walleij
