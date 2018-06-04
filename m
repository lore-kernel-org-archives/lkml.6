Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeFDLtB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:49:01 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35612 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeFDLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:48:56 -0400
X-Google-Smtp-Source: ADUXVKIzAR4YDfV85pKEIA4Y36UCM36eghY2jVuFjhMuYEnvJPsPNN+mN+X6+BRrNjaoeJr9TR1JAcAmnjAQ42pIwtU=
MIME-Version: 1.0
In-Reply-To: <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 13:48:55 +0200
X-Google-Sender-Auth: XzMtV8mwRtphqDM1m1t9U_RrH00
Message-ID: <CAMuHMdV6sKMLGhWLELqJWXS8Vj5Cnh82NE8MYOwU6EDWvoSTrg@mail.gmail.com>
Subject: Re: [PATCH 03/11] macintosh/via-pmu: Don't clear shift register
 interrupt flag twice
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Clearing the interrupt flag twice in succession creates a theoretical
> race condition. Fix this.

I would add that the caller of pmu_sr_intr() has already cleared the flag,
so the casual reviewer doesn't have to hunt for it.

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
