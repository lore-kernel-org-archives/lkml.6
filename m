Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeBZJqI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:46:08 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34684 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeBZJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:46:05 -0500
X-Google-Smtp-Source: AG47ELtFX0R9+0GrSZDlYdjjUuELDrZRe8HeEZsR6oC7K4QS+n9hF14zqpwuhhYBGSAMIemHMprobfaLpzGG9QDGMzQ=
MIME-Version: 1.0
In-Reply-To: <20180127235140.CBFF12962D@kvm5.telegraphics.com.au>
References: <20180127235140.CBFF12962D@kvm5.telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 10:46:04 +0100
X-Google-Sender-Auth: S1EsMCij_wEOO45TL17yDqmWK8Q
Message-ID: <CAMuHMdU4+Ag0VEVB0p7HG+J-Pgr95XmSwdB-PF3LO6CiVxe0kA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Fix apparent race condition in Baboon interrupt dispatch
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 12:51 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The algorithm used in baboon_irq() appears to be subject to a race
> condition: an IRQ flag could be lost if asserted between the MOV
> instructions from and to the interrupt flag register. However,
> testing shows that the write to the flag register has no effect.
> Rewrite this loop to remove the apparent race condition.
>
> No-one seems to know how to clear Baboon IRQ flags, or whether
> that's even possible, so add a comment about this.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queue for v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
