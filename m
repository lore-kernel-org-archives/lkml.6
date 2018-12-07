Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768AE20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768AE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGI1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:27:25 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43533 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeLGI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:27:25 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so1958323vsc.10;
        Fri, 07 Dec 2018 00:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzd9ASVo9zxXqUYdIbjNE4QaXoFVCNTzLwfU9rmv4PY=;
        b=pAPEgMRysrGs73x/c4zOe4nYWmhSJ5CndSxwM+Y/IKKG62oxPtx2YGeAy3IZaSQGK4
         cCnrRAHntRYtxMdEGKEdRfO9CHTKB9+v/QhnArxvgvSIOXHJ6uBk+FiSjGemcQ56Ju45
         i4QOJgOPieEjk+IplyT7jQwftrPYEQT/VgS65wYDDobD33XIID8K8VrKji0DUDYUHdNf
         N2Kdw12ei8vlDEEOcm4ljRIAzSfnkmiQDuo1XD1KUDBrRl2RPPZJtkrvyvwMiGaCkTEu
         J8IxBBYdi5Gx7pLL4RdccyCmjFj9ZEcBQEUk1Nn8i+BnJq71BZ6y4++SfOEnU5gva/mX
         nxUw==
X-Gm-Message-State: AA+aEWYo4rc9kQpRTuVg44sOKW8ZqQy7EFtm1PGNRdUow+VsB3MzqinH
        /TasqQj7fptAvPQL5n93yuKHTVoGW7WMuB3NkZM=
X-Google-Smtp-Source: AFSGD/X/pFkkpk049tCymCTuMMc/tsu8s52mdjQ61f8SjPZbQRGZdyslj00PNM/VVUxUDD76sy/QWRxElGFRlZhn/ns=
X-Received: by 2002:a67:f43:: with SMTP id 64mr512520vsp.166.1544171243338;
 Fri, 07 Dec 2018 00:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-2-sboyd@kernel.org>
In-Reply-To: <20181206215858.3880-2-sboyd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Dec 2018 09:27:11 +0100
Message-ID: <CAMuHMdVWbcoVr9E9nmKvhrUAAf4817wEQnQ6QrF1sWeHpgL_2g@mail.gmail.com>
Subject: Re: [PATCH 1/8] clk: renesas: Remove usage of CLK_IS_BASIC
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Dec 6, 2018 at 10:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> This flag doesn't look to be used by any code, just set in various clk
> init structures and then never tested again. Remove it from these
> drivers as it doesn't provide any benefit.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: <linux-renesas-soc@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume you want to apply this yourself, with the rest of the series?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
