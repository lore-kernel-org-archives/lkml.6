Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27296C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A142086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odb7xUUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfASXOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 18:14:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39693 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfASXN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 18:13:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so13001489lfh.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 15:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz4Tob51gVDT4+Ce7WDGP97gOPDiLJEEpyq665QE4zw=;
        b=Odb7xUUMaq7k/Bm34SeNsOj21bTKJEY69QprOwJdXb1PfMFqDaD2HtCLzM2QiSIn+0
         AD7ikEi8rcWFaWkLtfRBoietZj5f5mnUT0b+D3EobiB5ygFzmhhaLiWrWv/YQSfUzX8L
         tGBRqu6dnLQ4QfTAbVu3wRCFocMWHV/Gem8+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz4Tob51gVDT4+Ce7WDGP97gOPDiLJEEpyq665QE4zw=;
        b=sEgV3WKlzAOadd43Cyir/AyFisoFxuCIQx5fvXgZlR5yHO47nWeBhziTSZ8b1NfoT5
         VMrrFNqCUtFEgE4Qu2+httAvIS4aiRvn0qKlY7ZhYOfprCBgjQ4i19ejLdik04SplamO
         BX0CCu8Zlj2Q5YlTYzYY75cA9O3XdvyzzKo3HxsTUtv1oIhqLXEge/vxAuxuqKSpp4dg
         X3E9ru3M5yNM3Iv25a05c7t6yGdzBsk8UZdJCwokfTf6SEoFEp1hE0sRu/Ad/+dGJfyo
         KjAT4PWin+UdtHvQu0j7RTQuCFGDriJjCe54A7xdLXEUtSz402lRH5qoOiKxrGbKw1fK
         O0ow==
X-Gm-Message-State: AJcUukf80Rl2TO3Dq5xByCJcOE9LtTTsSPnxFLNhCGrEkBBYVVU2NyC8
        e0llurqFqJCZOqEawdhmVxcUjdQjK33fl0r/mZ4JZw==
X-Google-Smtp-Source: ALg8bN7w4e0qghOAoM0BlkxRXqMvp5itu3dSJukH5ukhhAL8/+BpUIi5QqhkgoKLaZFSzQ46emzipwnkT0ITPJhqWb8=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr14859569lfd.149.1547939637315;
 Sat, 19 Jan 2019 15:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20190119204252.18370-1-masneyb@onstation.org>
In-Reply-To: <20190119204252.18370-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 20 Jan 2019 00:13:45 +0100
Message-ID: <CACRpkdaumxXfFW6SeMzrrQjX7hxc2PddC8=DuL_d9x7CH3ZwWA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] qcom: spmi: add support for hierarchical IRQ chip
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 9:43 PM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to spmi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.
>
> For more background information, see the email thread with Linus
> Walleij's excellent description of the problem at
> https://www.spinics.net/lists/linux-gpio/msg34655.html.
>
> This work was tested on a LG Nexus 5 (hammerhead) phone. My status page
> at https://masneyb.github.io/nexus-5-upstream/ describes what is working
> so far with the upstream kernel.
>
> Changes since v5:
> - Patch 4: Set handler to edge or level when the IRQ is mapped.
> - Patch 7: Change IRQ_TYPE_NONE to IRQ_TYPE_EDGE_RISING
> - Patch 14: New patch to validate type when mapping IRQ

If Marc Z is happy I think I will apply all patches on an immutable branch in
the pin control tree, so that ARM SoC and GPIO can pull it in later if need
be. (E.g. if they get conflicts.)

I was thinking to also include the DTS changes as it all is so neatly
coupled, then offer the branch to ARM SoC.

Anyone against?

Yours,
Linus Walleij
