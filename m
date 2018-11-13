Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4B224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4B224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeKNHjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:39:06 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45878 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:39:06 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so3708698uam.12;
        Tue, 13 Nov 2018 13:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmdSfl/YfKTGvEeMheBPWRnpnKSQK1usUNeGd+QT/+s=;
        b=c7E27sIIo57yrdEnfk0JYVIeEsmY7qvQAqQxEFRaMzPagGWkWqcmbJl+LDILIo6QPN
         L76kl1a20iTzzdBtFJN11FqKhsLzAGYKHT1oHQEwe6Cokp/2yg29RC5lHo/obKgpvuWp
         UFZAub00vuCUBAjeSURoDnsRnAjQZMTWThHgGkuAO6JdYRMbYN1Uc38iVKkOJPxqKyJs
         nn+IhQSpg5pk5b3w2xUFXJER0TdXBw20TvGB1OAy+iUWjhzbxunwzckTxGf4OEsOk51j
         0v2s7QE18Yf8qrjoT4OFchzPvmkiThkyT/xC/v4b9wNEEJXV2cWXU9ECnhYddsT9pVdt
         GVKw==
X-Gm-Message-State: AGRZ1gJi5KMpFl6us0xUVQpCrtx7v7fS5dbB8eQ7ULAbrdFpjiHAwt1s
        H82OoDo/zkQ07xF+/19XqG6ZYUbk/+URyVlZh7E=
X-Google-Smtp-Source: AJdET5cOnqvBu/9ARumlRoUw+C1sacAqiEqVUg3wSGRBH8bOC9ldSJLTi9iWWCbk1qALJLQmyWDKQoBhWLGqC+/udyQ=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr3154876uae.75.1542145141849;
 Tue, 13 Nov 2018 13:39:01 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd> <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd> <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd> <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
 <20181112190554.GA13959@amd> <b167cfc1-e392-eec6-6455-5983dc1c7212@gmail.com> <20181112220616.GB11942@amd>
In-Reply-To: <20181112220616.GB11942@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Nov 2018 22:38:49 +0100
Message-ID: <CAMuHMdVAYpXPZie8DTrmMz+KXiVP=WNyFNtfTZPYHYkFOa9wqg@mail.gmail.com>
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        Linus Walleij <linus.walleij@linaro.org>, oleg@kaa.org.ua,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Nov 12, 2018 at 11:07 PM Pavel Machek <pavel@ucw.cz> wrote:
> Not really, I'm afraid. Hard drives have no red LEDs on them (and the
> LED would not be visible, anyway) so the "device" symlink in such case
> would point to some kind of i2c LED controller.

I've seen hard drives with LEDs on the PCB.
External USB enclosures with hard drives typically have LEDs, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
