Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02E78C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA40120864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h14NNRth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966389AbeFNOUG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:20:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43029 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755290AbeFNOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:20:03 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so7279421iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iy4iSAK3ipi0yEzwtCcixxyaVTM0TRh7J3Blr4blS8Q=;
        b=h14NNRth+p9O02EkAygzLvvnsbjSbvLwE2OF5ceRZWKn5Xv5RT5/j2QzaxeZtMPFf0
         zr2AhYTorzp8fdRUMB4Veysibmx2PQMIhi2PyUEB6LBvcwH8+dwNQCthUKK09yblP7TP
         +1T+YKS+ubgx5alCZHxyrGMde1V+t4C9NO3Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iy4iSAK3ipi0yEzwtCcixxyaVTM0TRh7J3Blr4blS8Q=;
        b=r1Y7BA09mpPXqnNwHRUqeou+3TnQQPpz1z13RBInJprzu9CsHxy2APLyADdGkDrMxy
         UlDuhTxkASv4xugwYOrlpgaVnzvAf+Rpg5Zwu/hq0N7K7PTNRp75o5lffdRfjoKZ4Iez
         Bv64DTXHNe004ZKQOW+szb1aMOdTyhL2ypbVl1kxBknvH6VTQqNZSGfAch/Py3Z0YPLW
         oK9f3r5kPesFjbpuBqv967QxKMCd7TLFiCfJdf1qKe/qkn7kVmO0ct6C9s9xeuXEcJTe
         iXuxh9aGXWoSh9zCEI1y3jA8gSSm3FsI5AOmzfeGJ5TgvRch2AgXxNTSP2x0HbwFp+r+
         Rv8Q==
X-Gm-Message-State: APt69E2kLJSMt4g+P2B1Yd9E2gqRh/Pw+AO3mA/4VSR9mCCn1GzTUjXt
        OVO2MOrFSzCbnAelaNgGuDALVVrL1ys5EbpRmpzJkA==
X-Google-Smtp-Source: ADUXVKLmAjLSlG6RamurjAGAv0tU0re02XWzsC944ODaBwVzzIiP1v1UtkToy1dwPEVhy/IYdCp7FAhvRGyic2pyuB0=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr2308392iob.277.1528986003088;
 Thu, 14 Jun 2018 07:20:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:20:01
 -0700 (PDT)
In-Reply-To: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:20:01 +0200
Message-ID: <CACRpkdYKO6BArTXzk9ms70AJrNC4kAk_ZyaNHUGJANwuBqqUtg@mail.gmail.com>
Subject: Re: [PATCH] gpio: uniphier: set legitimate irq trigger type in
 .to_irq hook
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 7:27 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> If a GPIO chip is a part of a hierarchy IRQ domain, there is no
> way to specify the trigger type when gpio(d)_to_irq() allocates an
> interrupt on-the-fly.
>
> Currently, uniphier_gpio_to_irq() sets IRQ_TYPE_NONE, but it causes
> an error in the .alloc() hook of the parent domain.
> (drivers/irq/irq-uniphier-aidet.c)
>
> Even if we change irq-uniphier-aidet.c to accept the NONE type,
> GIC complains about it since commit 83a86fbb5b56 ("irqchip/gic:
> Loudly complain about the use of IRQ_TYPE_NONE").
>
> Instead, use IRQ_TYPE_LEVEL_HIGH as a temporary value when an irq
> is allocated.  irq_set_irq_type() will override it when the irq is
> really requested.
>
> Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
> Reported-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Patch applied for fixes!

Yours,
Linus Walleij
