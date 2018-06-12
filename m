Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E2E7AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962DB20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962DB20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeFLIcG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:32:06 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37911 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbeFLIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:32:03 -0400
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so15409824uas.5;
        Tue, 12 Jun 2018 01:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibDo8n6JdWD+/E8bFGdmWAd8Xc4e9ymJcXprcPQ1qB4=;
        b=i6Befhx84TCQmxpICM78E8TEyEx5EjNtzIl1w27ug0mLjihiJe598urpk/k+gLOtiS
         5eASHA5rmOn6ZhYSPLdgfZPCHBq3choduU3BlNE+/stceG22UzF+9XhXfOtuWXppnozj
         gz+1FVbqOJk2uoJcVmu4jR2KPwe4ccgMgzgzDQR+QtwXdJFAqdO5psKi1THCARti2UlO
         3ZtnsoxmRsJMlKMXVBChD0t1qhqEkpxhD+ymMcswFYr/wEhvK/8i6JJlVW/n1vojd+LH
         v6IXk5OYnR9cbOYWBXbzQjBlgAXWLDgFP22+6Irg4a8wUsQIVz4TkZAYfdl1CEEMHeqP
         33jw==
X-Gm-Message-State: APt69E3V84f4z+Fm8K6dM9v00yaocNn+mCVBgXHQMrmIOTldjY/mwige
        7qvuuWj3DEhTKP3P0AZnkLxnRYMoVk1Pwc2AR/I=
X-Google-Smtp-Source: ADUXVKJ6co7bkC//oyd390D4OzNZeIDbSANWl/IV1/4LlYl9fCM9IVRaNc7w7RyUEyQ5VWiZtuQShq5EPyhTQ1hUzrc=
X-Received: by 2002:ab0:5b18:: with SMTP id u24-v6mr1751980uae.72.1528792322235;
 Tue, 12 Jun 2018 01:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <1528310824-12706-1-git-send-email-clabbe@baylibre.com> <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com>
In-Reply-To: <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jun 2018 10:31:51 +0200
Message-ID: <CAMuHMdVZjPRknHY-3b7qr+FgwWmK3g3rCgjjK09Thh2EOLXbcQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 6, 2018 at 10:27 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> > This patch fix the following build error on M68K:

Not plain m68k, but coldfire only (and MIPS AR7, I guess).

> > drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
> > 8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
> > 8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'
> >
> > So 8250_dw need to depend on COMMON_CLK.
> >
>
> Makes sense.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Please see "[PATCH 0/3] Legacy clock drivers: Normalize clk API"
(https://lkml.org/lkml/2018/6/11/122).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
