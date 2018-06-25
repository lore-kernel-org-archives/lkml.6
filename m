Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848DE25660
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848DE25660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754843AbeFYJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:07:25 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43510 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbeFYJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:07:21 -0400
Received: by mail-ua0-f193.google.com with SMTP id z16-v6so8122489uaz.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TorOwruUNp57xWE0RsAcyQ/AI6wGTDQqMCU/mvNIRRI=;
        b=lDqA6RuBuFQm0pYafItZ0bcX4G7EEGBJDOxPfMyJIByjp1/rKUvge6uAJO4zWpJvxP
         N0swNUfxXtX0QvLLO7IqEQIEa91wyTk/hyzt9JcTBmGBWczUdzuvn3zImn3ABvtUygWw
         tNtQc3j89JmCjF4QkWAo5kDdxik7yTj8u2mlklSSIvRVr2sdAe5p1O+8HJOd8uBYdwSp
         5YWOD8TW1VBi2zMM+LgigNR75T2Fv1zzihb7HDXx1pfFw3ecOXjCfYXKm37g4mF8wOmG
         ypv/d71XAE3K9xRRFzocaktedDgg7SN7gJorG560fztY2hHHqLrddktuT7QO26E8NmGz
         2E7g==
X-Gm-Message-State: APt69E1TEAJjXsrd7j+w89FIza4tm3Hk9BUvLXexUcwlaZTvgMMo0bCF
        w7t1U+st8FD4dxkj1U5l71+pUnl80tWpIY0nF7tKt7Di
X-Google-Smtp-Source: ADUXVKKxQXIP8MoglaZsNyW80mC0eXS0orm9chMYNwAR4dRqKy87WrIvKqltUfY1HAmX4IBJZjWCKFwqGKy5xrWF7Kg=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr8025779uas.26.1529917640801;
 Mon, 25 Jun 2018 02:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180625090329.10895-1-geert@linux-m68k.org>
In-Reply-To: <20180625090329.10895-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jun 2018 11:07:09 +0200
Message-ID: <CAMuHMdW--a2btaTWu3ZP_KtTD6zKFCYsG8FV9KA0y-W6Vg0gQw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:04 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc2[1] to v4.18-rc1[3], the summaries are:
>   - build errors: +6/-4

  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_handle_notify_resume' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 873:29
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_handle_notify_resume' from incompatible pointer type
[-Werror]:  => 873:3
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_signal_deliver' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 804:22
  + /kisskb/src/arch/mips/kernel/signal.c: error: passing argument 1
of 'rseq_signal_deliver' from incompatible pointer type [-Werror]:  =>
804:2
  + /kisskb/src/arch/mips/kernel/signal.c: error: too few arguments to
function 'rseq_handle_notify_resume':  => 873:3
  + /kisskb/src/arch/mips/kernel/signal.c: error: too few arguments to
function 'rseq_signal_deliver':  => 804:2

Lots of MIPS, fix available.

> [1] http://kisskb.ellerman.id.au/kisskb/head/7daf201d7fe8334e2d2364d4e8ed3394ec9af819/ (231 out of 244 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689aedb85d56ab40/ (233 out of 244 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
