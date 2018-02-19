Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeBSODj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:03:39 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44269 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeBSODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:03:37 -0500
X-Google-Smtp-Source: AH8x226I+MSSVYFOHRDq6T4RO7JjD6R57DO3aQAoozGD20WKgFA2txl9McvJh05A1iKSf2Ou2D2Txc/eoi2PJnegndo=
MIME-Version: 1.0
In-Reply-To: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
References: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2018 15:03:36 +0100
X-Google-Sender-Auth: ZH1p55LjI0SdgvJQwtqMwmoxcgc
Message-ID: <CAMuHMdWs9r4F7FnuHvQGX1L9g91MCepSHroRDhj1tB9E70d5gw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc2[1] to v4.16-rc1[3], the summaries are:
>   - build errors: +5/-2

  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: junk at
end of line, first unrecognized character is `U':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: missing ')':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected
characters following instruction at operand 2 -- `movk
x1,:abs_g0_nc:0xff00ffffffUL':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected
characters following instruction at operand 2 -- `movz
x1,:abs_g1_s:0xff00ffffffUL':  => 677

arm64-allnoconfig
arm64-allmodconfig
arm64-defconfig
(patch available)

  + error: hotplug-cpu.c: undefined reference to
`timed_topology_update':  => .text+0x410), .text+0x138)

ppc64le/pseries_le_defconfig+NO_NUMA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
