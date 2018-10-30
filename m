Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D89C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2C120838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQElLcHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2C120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJ3Vop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:44:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37022 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeJ3Voo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:44:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id p17so2298185lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJAdylFjVw0nc/YXuWZ5CovdZrsIuKDi/84gZzNW5Q4=;
        b=UQElLcHI/Tt+DjwwuEJY23rtNvXXqkdjfSGb0GAU7lHDNtM7OXHc3EcmIsMe20MWa8
         2eY4rWEJ3WTHF8jcOcVJng0Y3Agdb+c5n8xPBOnZnQ0b/btMgAEAyIhrXSjBO+fJV6BS
         CAXvTYOOkrk2h3kAoJLIR3SmpgXlw0pbytZ2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJAdylFjVw0nc/YXuWZ5CovdZrsIuKDi/84gZzNW5Q4=;
        b=k80bxl/WoLkGM3wFuQveZHIoggRG5IHpMqRTy+mtD+sZD1hO3bVlAn4R1eMI4AEREy
         IIOl7/i2NivcP+5G2ZHcK6ShwNTQ2wNjZuAYRzT6Tzh1nF6L0lYm0KV5vMbZGnjF/Tu6
         LrLpl8mq4tSJX4M8Qw+1j/9xaUj7KBBsikt9pxk27XjM5nbv8KZANL4HLsXHqT8dbmvM
         YQGxfqSq8FTGDG9K7jKVSyHgq239g3tvjKSJKOXKM4gsQBSPlTB7wsChsvsWdus9ktl5
         Oo9peHJPZDc92Hek5rNKIef+yPYAmQtE3hJkRr1WQh0nwJi5zlR6CAJBanoD2OfeIW/z
         Q9Ig==
X-Gm-Message-State: AGRZ1gKPHXtAsHakakK9OoEARzL91RpHKw3h1XlXqd7jN7BzTXDBWZw2
        YuwTGFLh28VP6IDNQ1Ok6cSxV//NOeV31LYoqOdAgw==
X-Google-Smtp-Source: AJdET5eVm4AzH1DXY9Y0q/cb9rdZkUNK+SLdGXhi/OfP/joyvRgnUt5/ZxPrZb2q5Y6ZtDAkowStxOdRRAZKotpN/NM=
X-Received: by 2002:a19:f813:: with SMTP id a19mr1754249lff.67.1540903883879;
 Tue, 30 Oct 2018 05:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-6-manivannan.sadhasivam@linaro.org> <c8d65395-c60c-5d06-92ad-c389642c22ba@gmail.com>
 <20181011164429.GA18174@Mani-XPS-13-9360> <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
 <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com>
In-Reply-To: <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 13:51:11 +0100
Message-ID: <CACRpkdb-Er8z6JdvYWE8UXUa3dfVSu4S-VbnqvcV+vf9erJuNw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
To:     sean.wang@kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Cheng Mars <mars.cheng@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 5:06 PM Sean Wang <sean.wang@kernel.org> wrote:

> the driver currently only supports the basic operation, not including
> driving operation, so
> what value for the driving mode for a certain pin seems not really
> matter in the early patch. I think these advanced operations can be
> added with another patch.

Sean can you provide an Acked-by for the pinctrl part so I can merge
it once Manivannan resends it for v4.21?

Yours,
Linus Walleij
