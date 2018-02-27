Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeB0PDA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:03:00 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38553 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB0PC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:02:57 -0500
X-Google-Smtp-Source: AG47ELuH9tCXWDxE57QEdZ0o6XWAGDtBDwNTdRGBndTi7YfbDnRo3ufRXoPWXvdoSjzASrv6J2IUptodTwFvgMwvRgI=
MIME-Version: 1.0
In-Reply-To: <20180227010312.7495-1-f.fainelli@gmail.com>
References: <20180227010312.7495-1-f.fainelli@gmail.com>
From: Jon Mason <jon.mason@broadcom.com>
Date: Tue, 27 Feb 2018 10:02:56 -0500
Message-ID: <CAC3K-4rqYMUBtbwaojWBF-0biEV-WSPpe=0bDocL4TUrrL4gGQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: NSP: Fix amount of RAM on BCM958625HR
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 8:03 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Jon attempted to fix the amount of RAM on the BCM958625HR in commit
> c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
> but it seems like we tripped over some poorly documented schematics.
>
> The top-level page of the schematics says the board has 2GB, but when
> you end-up scrolling to page 6, you see two chips of 4GiB (512MB) but
> what the bootloader really initializes only 512MB, any attempt to use
> more than that results in data aborts. Fix this again back to 512MB.
>
> Fixes: c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jon Mason <jon.mason@broadcom.com>

> ---
>  arch/arm/boot/dts/bcm958625hr.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
> index 6a44b8021702..f0e2008f7490 100644
> --- a/arch/arm/boot/dts/bcm958625hr.dts
> +++ b/arch/arm/boot/dts/bcm958625hr.dts
> @@ -49,7 +49,7 @@
>
>         memory {
>                 device_type = "memory";
> -               reg = <0x60000000 0x80000000>;
> +               reg = <0x60000000 0x20000000>;
>         };
>
>         gpio-restart {
> --
> 2.14.1
>
