Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDRJav (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:30:51 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45662 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeDRJat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:30:49 -0400
X-Google-Smtp-Source: AIpwx4+rDGM9QEmU4Km4jOMa9DTOVOKZuxsPAzjfyyHyNmfnqzhWKRAvJ0NAeUwyJjtaHlTf4TYZ9RpgKkKEbpzLR0U=
MIME-Version: 1.0
In-Reply-To: <20180416215032.5023-6-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com> <20180416215032.5023-6-mylene.josserand@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 11:30:47 +0200
X-Google-Sender-Auth: ydqY3PIRRw_LEGfhevbRqg9bAeU
Message-ID: <CAMuHMdWFyLCQb=c=gnWokxGFtsQF2i+s1nPWtJJmZPXAQjnu4g@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] ARM: smp: Add initialization of CNTVOFF
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3I9UtHn017962

Allo Mylène,

On Mon, Apr 16, 2018 at 11:50 PM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> The CNTVOFF register from arch timer is uninitialized.
> It should be done by the bootloader but it is currently not the case,
> even for boot CPU because this SoC is booting in secure mode.
> It leads to an random offset value meaning that each CPU will have a
> different time, which isn't working very well.
>
> Add assembly code used for boot CPU and secondary CPU cores to make
> sure that the CNTVOFF register is initialized. Because this code can
> be used by different platforms, add this assembly file in ARM's common
> folder.

Thanks for your patch!

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
