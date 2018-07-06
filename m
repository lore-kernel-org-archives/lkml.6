Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4FEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346E423EA9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346E423EA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeGFPSY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:18:24 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37333 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeGFPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:18:22 -0400
Received: by mail-ua0-f195.google.com with SMTP id u8-v6so7769118uao.4;
        Fri, 06 Jul 2018 08:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgKVtnJeWCGH0vfMYWitAPgd2nmuV+PxD2DlV4HvNhA=;
        b=m5IHyBm2e1130Kvtunro6ScVGBVEJ0eJLBuFQcF6Md7gGAF0+v3Olk5iu7+YJQ5ilh
         ikxhViVW5s5l6a4vZUodYh0Kkn3IalXPkKLbaEoIDY7OeE/hniLZIiuULyYUt9DdTw4E
         lEI5KQw0zdMipm5+U//EAOP6VeergCcz2QI4lUPT8SCg9c6lWcsgtn+xCF72EeFGNtfw
         FCIHwLjHeBgLNsp7IDJPllMfX4L7aCrxOQ0xEFUUvy4Ln/c6goGGujy1movmhDoC1nQp
         YcajvxyXFdTBXtvwu6Awm+7SU19XAliqvXYLSJghIqklw9BRXONnlpByEPHFkGn2yzIt
         Q0Uw==
X-Gm-Message-State: APt69E3azV0jwznwabq9IqqUvOCCpI25hqKPaPtjxuxpk4HleIJLACb0
        iXa+Ws1jaDjU93thiRuA/uDlhqrijjnyVdyA84A+mA==
X-Google-Smtp-Source: AAOMgpcICOHXYfm3DOPcj6hHJf8E3qB0b6JQTVtUu8jes8IvLmWLvixDiukeZ5v36vNX8S4KmBMq5wkqCp05JHeEDlY=
X-Received: by 2002:a9f:37c8:: with SMTP id q66-v6mr6440411uaq.180.1530890301872;
 Fri, 06 Jul 2018 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180704130103.31790-1-geert+renesas@glider.be> <153088993646.143105.11674939438681531758@swboyd.mtv.corp.google.com>
In-Reply-To: <153088993646.143105.11674939438681531758@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jul 2018 17:18:09 +0200
Message-ID: <CAMuHMdWKsC74T5EZ-iPaWK6d+ZZQLXp4dzbXb3PFA1+hprcbKg@mail.gmail.com>
Subject: Re: [PATCH] clk: Really show symbolic clock flags in debugfs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jul 6, 2018 at 5:12 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-07-04 06:01:03)
> > The last-minute fold-in of the ENTRY() macro did change behavior:
> > instead of printing the symbolic name (e.g. "CLK_IS_BASIC"), it prints
> > the expansion of it (e.g. "(1UL << (5))").
> >
> > Use "#" instead of  __stringify() to fix this.
>
> Do we need the stringify.h include anymore then?

No we don't. I had planned to remove it, but forgot in the end :-(

Thanks, v2 sent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
