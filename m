Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02561C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79E520869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8W97xke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfBHNnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:43:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36949 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBHNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:43:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id n23so2574283lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ak8sWzffUyrcQCU1W3k6TUN+Fn5XFQtEQCgmteCDOUs=;
        b=o8W97xkeVhsgVy42lx21GmTl7v9inxQMSoYAS7QX9dQclJc5UtHs5FWZzEq7x3SD6f
         qFY4SVC6Be/EN6T/w4MSbkcpV2flHbuDvXWh0Vjw+qgro4MJnAYYEMri3ytoYp9enCAI
         Y/1Qlxca7PCW/o1+Uoh1pgAFjnyeN3YlUDkJ8LClEPJ/1CQEsJKYur5CySaQEZx29rHV
         Cw6gWgL/4il3SxDhCzai9WrPFX8cjLR79G9RYLd75xzmJprpdauD7lIrc/m+TeOW+ABt
         Z9E50785As1wnff6FR7+wAgTpUfEBrbV3aAfZqVYsG2uZwMxu8uOd/Pk9nTzTgEo1IGq
         3s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ak8sWzffUyrcQCU1W3k6TUN+Fn5XFQtEQCgmteCDOUs=;
        b=NBMjis9LQeV8UBaQz/P0QmEeY9jZJWcGbqc5V0on8Y4EItN7TgmX8JMD4GoPMcx1DI
         hge38XgqCxVe5Ofgj4J+va7DZ7GG3huvaec3a661QjML9LAji35tl5IdnoCjADlPloqN
         v3Vd4Em+UfVo/3/B9RpnBiMmvP91tyC1MtzYJt3ZKXWyggA7rJBP+NqKZ680CyKfl3uv
         SEkp8KiBs9E7UUXHfFv8VsWUIT+a62u39FFnxFITt+ovMaYx42+XhN73o2OCj9ntsDfV
         0oc0eIC9vYB6bLFsRvnT+LRhMp0e6meNfc4xExbpInRKja308sjBEh2vKMWJQyRus8yu
         wpkg==
X-Gm-Message-State: AHQUAuavlWy/T1NecSD+FilLBngniBwuCpmvRbbJuCrOHgqYEmA8UGSv
        xtSGXvGvXH94Vodmz6t8NKqv/yRj0tsONP2YvYOwjYRa
X-Google-Smtp-Source: AHgI3Ia5KOEYIj5twFgbJ+uFOrVSnKkwmomiJLMwLmQTjciamrraq8797+lf8sPWQo4UAzt3gl7hOyYGg6HxnTQd/e4=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr12350627lfl.129.1549633392190;
 Fri, 08 Feb 2019 05:43:12 -0800 (PST)
MIME-Version: 1.0
References: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
 <3230ace6f820fccadb51097ae9ba9f5ee247d79b.1549379326.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <3230ace6f820fccadb51097ae9ba9f5ee247d79b.1549379326.git.nikolaus.voss@loewensteinmedical.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:43:00 +0100
Message-ID: <CACRpkdYUCyL6ZE=OgWQd5ps-1s8-Xzm8P-NMfiVCviOm3s3sAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/gpio/gpio-adp5588.c: switch to events system
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 4:17 PM Nikolaus Voss <nv@vosn.de> wrote:

> Interupts were generated using GPIN interrupts of
> ADP5588. These interrupts have two important limitations:
> 1. Interrupts can only be generated for either rising or
>    falling edges but not both.
> 2. Interrupts are reasserted as long as the interrupt condition
>    persists (i.e. high or low level on that GPIN). This generates
>    lots of interrupts unless the event is very short.
>
> To overcome this, ADP5588 provides an event system which queues
> up to 10 events in a buffer. GPIN events are queued whenever the
> GPIN is asserted or deasserted. This makes it possible to support
> generating GPIN interrupts for both edges and to generate only one
> interrupt per state change.
> Thus it is possible to chain the gpio-keys driver for some GPIOs.
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Patch applied with Michael's ACK.

Yours,
Linus Walleij
