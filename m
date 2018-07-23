Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C8CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B744C20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B744C20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeGWJxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:53:51 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46677 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbeGWJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:53:51 -0400
Received: by mail-ua0-f193.google.com with SMTP id r18-v6so11234746ual.13;
        Mon, 23 Jul 2018 01:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rt/v0RTvBVHgn77HNIIeDmhu6kCvKlWdStRulBtPndw=;
        b=dYkU0K8JzUdQzgyMNpZMN0XgL1DIyI9PTWhO24EBQCoYCr0IX760jCnTq5JmjcAZfx
         f3q6ZV4Og2gTrLtuVeS/gJaOZZjTQREX5RTY3+/oSkT5p144QUnbBtkdXn112fm7Cake
         Z5S8ZbDbvQXSaFOfY4X3wbx8/DIVQEaV7tdIhW2PgzlIAE4hL9VKpDBaoya8pQUdadk6
         7hfdl5o8NhHaBS0XbldiemAPkClB09nXosqgEUEPVs0m/I52wDqFNoyQDU1v8PCYEkWl
         YK3Gl+oGtu6TZI8pwio+42wdl8EsO60kFETCriugfmvDli16J2yppXvFpooJeIpwPIAH
         eY+A==
X-Gm-Message-State: AOUpUlGLSSmdbaSPmqiIsu+Vf72ksVKLia/yxkT1ZgnXt65HhFsRdD4g
        QvvN60yDh7dTgXonQHJZOeU4CxdNQKlHehvxaoELD/h8
X-Google-Smtp-Source: AAOMgpfdevKsgH35IOS3ddEhwksipcq6dYDTA1cO0TcR8vEyITp5AoE/OAJuocRX9Qb13CDyQW4lgoLG2VR9p7AdyR8=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr8610894uap.33.1532336021593;
 Mon, 23 Jul 2018 01:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl> <20180721074319.GA30454@kroah.com>
 <20180721213843.wkculy5cdrrbmuij@angband.pl>
In-Reply-To: <20180721213843.wkculy5cdrrbmuij@angband.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jul 2018 10:53:29 +0200
Message-ID: <CAMuHMdWvZnU_p-c98sag8t1BCaBLSqZmiH88sgD2kACbvax0pA@mail.gmail.com>
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sat, Jul 21, 2018 at 11:39 PM Adam Borowski <kilobyte@angband.pl> wrote:
> Technically, every console can be made to blink by drawing/clearing affected
> characters a few times per second, but that'd be quite a waste of coding
> time and kernel size.  There's a reason browsers dropped support for <blink>
> and text-decoration:blink.

It's very simple and fast to implement in fbcon for FB_TYPE_PLANES or
FB_TYPE_INTERLEAVED_PLANES and FB_VISUAL_PSEUDOCOLOR ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
