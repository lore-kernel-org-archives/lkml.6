Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67911C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C66720827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C66720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeJ2TO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:14:28 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40143 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2TO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:14:28 -0400
Received: by mail-vk1-f194.google.com with SMTP id h20-v6so1892892vke.7;
        Mon, 29 Oct 2018 03:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKSrj5R7qlAwQbENRVeHgM/B94DGqbgniUVAbXEOv7A=;
        b=oNBaiYM2dInrP6Sk8S8Yblv8SLK0x4xrr4kWiHY3jtjZT/s9B/U9pn0CcyXM3jTQeF
         mkBRcRHl7IafBRGfAFU+p6YiXk7a05CbHpggDEpnufbMfJvGX6d3t988KoTSq1eq16fp
         VUZJXGCrGhc1I9PYP51WlX4VUEZaZvB9zcICvjVBtuglzmVI7w4FJBEsvP5BBSesP6Pe
         PpkJMbdTTUwmmrfN0EpMdjuMKwX3GG9T1XMwP2Apt9gd6axnbMtZrRJmVplDvVl7feva
         KOFUZ/tRh5eqR4iSEKjKEp/5mAxUmCZ/2jEgXHdsm+QJeruhOMM/amppzWEqBgdIm3Nx
         dVkA==
X-Gm-Message-State: AGRZ1gIIqSPZhPlCuV/e4eKq0uVgapj/gLheTlGX5ourLOaJgKHR5L7X
        xBmobMsMBWhIf+ofe36LoGPadSR6VtHsjK4AmdE=
X-Google-Smtp-Source: AJdET5drlR3PbNeD0SfUZ2kvcnYX1She5iVtD09kTfEkl+VHFikB0ukoFxzQWaxTezOCwp9DBgG+WbWbTy22fl7xSLI=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr313596vkh.65.1540808784685;
 Mon, 29 Oct 2018 03:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com> <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Oct 2018 11:26:12 +0100
Message-ID: <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com,
        Marta Rybczynska <mrybczyn@kalray.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> One more general comment: I think this may well be the last new CPU
> architecture we ever add to the kernel. Both nds32 and c-sky are made
> by companies that also work on risc-v, and generally speaking risc-v
> seems to be killing off any of the minor licensable instruction set projects,
> just like ARM has mostly killed off the custom vendor-specific instruction
> sets already. If we add another architecture in the future, it may instead
> be something like the LLVM bitcode or WebAssembly, who knows?

Kalray MPPA?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
