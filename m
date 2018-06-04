Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeFDLoo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:44:44 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44135 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeFDLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:44:40 -0400
X-Google-Smtp-Source: ADUXVKJwMLrHhIT39lLPV4Ve1/ZPQqeCmmSirOQYA1sSCkxLgLSgbKrekglJe3/xhaeUqjaC9mhIhhai5ftMvCOCXTE=
MIME-Version: 1.0
In-Reply-To: <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au> <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 13:44:38 +0200
X-Google-Sender-Auth: k23nsIszwCJv3kRDgwcDSNWsd1g
Message-ID: <CAMuHMdXVR3g6Pm8RoVbpcs+JpTpHDkTnZvhNsKLWBszcgsXRfA@mail.gmail.com>
Subject: Re: [PATCH 01/11] macintosh/via-pmu: Fix section mismatch warning
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

Hi Finn,

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The pmu_init() function has the __init qualifier, but the ops struct
> that holds a pointer to it does not. This causes a build warning.
> The driver works fine because the pointer is only dereferenced early.
>
> The function is so small that there's negligible benefit from using
> the __init qualifier. Remove it to fix the warning, consistent with
> the other ADB drivers.

Some other ADB subdriver .init() and .probe() functions aren't that small.
But with the current scheme using adb_drivers_list[], they cannot be __init.
Probably the long term fix is to change the ADB subsystem from the
centralized approach of letting adb_init() call all subdrivers, to making the
subdrivers platform drivers registering with the ADB core.

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Anyway:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
