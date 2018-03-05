Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeCEPrQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:47:16 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:37809 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeCEPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:47:15 -0500
X-Google-Smtp-Source: AG47ELsv8ed+V8se9VBy0yXJ/+eScz77UBFwDtuJcunyyVxTgszGU010WKYDmrulQ5f2iqwIwArno28SgF1JVxbyZKI=
MIME-Version: 1.0
In-Reply-To: <1520264492-22030-1-git-send-email-geert@linux-m68k.org>
References: <1520264492-22030-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Mar 2018 16:47:14 +0100
X-Google-Sender-Auth: gZuBNp9yyfseBBLSSx68FLa-kmg
Message-ID: <CAMuHMdXHO1ZpceHiNr66TkacpL47Vino4F-4=8zoaovjM6jRug@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 4:41 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc4[1] to v4.16-rc3[3], the summaries are:
>   - build errors: +10/-1

  + /kisskb/src/drivers/net/ethernet/intel/i40e/i40e_ethtool.c: error:
implicit declaration of function 'cmpxchg64'
[-Werror=implicit-function-declaration]:  => 4443:2, 4443:6

mipsel/mips-allmodconfig
mips/mips-allmodconfig

Reappeared, seen before in v4.16-rc2.

  + /kisskb/src/net/sched/sch_dsmark.c: error: unrecognizable insn::  => 325:1

cris-allyesconfig
cris-allmodconfig

  + error: "mdesc_get_property" [drivers/sbus/char/oradax.ko]
undefined!:  => N/A
  + error: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko]
undefined!:  => N/A
  + error: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
  + error: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko]
undefined!:  => N/A

sparc-allmodconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/661e50bc853209e41a5c14a290ca4decc43cbfd1/ (all 274 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/4a3928c6f8a53fa1aed28ccba227742486e8ddcb/ (268 out of 274 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
