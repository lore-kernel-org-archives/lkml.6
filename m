Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BFAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE12569F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EE12569F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754834AbeFYJVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:21:06 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40121 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeFYJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:21:04 -0400
Received: by mail-vk0-f65.google.com with SMTP id o71-v6so7433269vke.7;
        Mon, 25 Jun 2018 02:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBzvh9rbN/YiC1yLuddFuoOnGCjizmGENjzNEPCPgHg=;
        b=MJciQ39r7G4PEKA2OUCIlArYZAIOIcn0ZyqB0bma4L9WHutZty901skaJuo09lZzct
         a5SB0FJ5Ko8oMehNJ+gp0EMGyFy8z3EX2DfExLTRTCZ1fEgS1aqMj+qiLF4X5uvvruuU
         FdbPwL5X4hZT2maSqbtu14RBbm/yyF8Y7D3IhDtq72dWH+xLWkoh9+6pMgYoXXNzZnZP
         uYo/6rCPXF2y13MA/PoI0IR4XOnC+ECm/O+QgdGxAXlB3hyeHea6FkWgqMLZQsZnCe8k
         Im5i6AVgWy9v0b7uDfp92z64gpHhoGxUqee66W7/5BXr+GRSY/5Fg1AGSwQ8DBk0BRUb
         lNiw==
X-Gm-Message-State: APt69E1X5Yw5RZmPiZXvsBpRKvorAi/MS7E985ZqwdShoNya/Dl5m+CA
        0Mtslrvnl/1BwThnSRWPmDV+/7Lk61EdpeLB0wwodQ==
X-Google-Smtp-Source: ADUXVKK6fpvEzDYpEBkBDD1t0aCoZ6wtPwaVshtr09EL6SX52A+SN70R35pTe07JscHYZxrj0hWvF4CR70iSwR1jGO0=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr6947758vke.176.1529918463343;
 Mon, 25 Jun 2018 02:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <1529915064-5014-1-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1529915064-5014-1-git-send-email-michel.pollet@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jun 2018 11:20:52 +0200
Message-ID: <CAMuHMdVtkxvpBjSy2+2MHvZ15t5ZTSq-4H+pfgsayOx+EHXnEg@mail.gmail.com>
Subject: Re: [PATCH v10 1/1] clk: renesas: Renesas R9A06G032 clock driver
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Mon, Jun 25, 2018 at 10:29 AM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This provides a clock driver for the Renesas R09A06G032.
> This uses a structure derived from both the RCAR gen2 driver as well as
> the renesas-cpg-mssr driver.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks, updated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
