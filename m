Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeBZJq3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:46:29 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45136 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeBZJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:46:26 -0500
X-Google-Smtp-Source: AG47ELvanxOdC9FBThLB6YDA9WxzayODAK5LfcOV3dP/XMFVAtaCbNAMvFVdfVdisaPFVuhLzIy52DvTIMMAuwZgGA8=
MIME-Version: 1.0
In-Reply-To: <20180127235140.EA71C296D4@kvm5.telegraphics.com.au>
References: <20180127235140.EA71C296D4@kvm5.telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 10:46:25 +0100
X-Google-Sender-Auth: rByR7LlWPx5sGF8C-aJSMvt-f2k
Message-ID: <CAMuHMdUuYF7uoH5ZAHsnEv+Y9VJXEUBAiYKxBpHkXpdDMi+FWw@mail.gmail.com>
Subject: Re: [PATCH] macintosh/via-pmu68k: Initialize PMU driver with
 setup_arch and arch_initcall
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 12:51 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The PMU watchdog will power down the system if the kernel is slow
> to start up, e.g. due to unpacking a large initrd. The powerpc
> version of this driver (via-pmu.c) has a solution for the same
> problem. It uses this call sequence:
>
> setup_arch
>         find_via_pmu
>                 init_pmu
> ...
> arch_initcall
>         via_pmu_start
>
> Bring via-pmu68k.c into line with via-pmu.c to fix this issue.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
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
