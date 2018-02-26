Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeBZJWS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:22:18 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34011 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeBZJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:22:14 -0500
X-Google-Smtp-Source: AG47ELvvxdZCNBcBmBxDOnNjiAi5enff92B+eXkIYtHcBh779p+9WtqadngvZ3bQm64jnTUVeZwFpDK5GmGlm7h482o=
MIME-Version: 1.0
In-Reply-To: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
References: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 26 Feb 2018 09:22:13 +0000
Message-ID: <CAKv+Gu8pGzrgQk2nGMeOXL_d2bPx_BOZVBZ6PvHkR8EcbVDNRA@mail.gmail.com>
Subject: Re: [RFC PATCH] irqchip/gic-v3-its: apply ACPI device based quirks
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 February 2018 at 14:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Reapply the SynQuacer quirk for ITS frames that are matched by 'SCX0005'
> based ACPI devices, replacing the dummy fwnode with the one populated by
> the ACPI device core.
>
> This allows the SynQuacer ACPI tables to publish a device node such
> as
>
>     Device (ITS0) {
>       Name (_HID, "SCX0005")
>       Name (_ADR, 0x30020000)
>       Name (_DSD, Package ()  // _DSD: Device-Specific Data
>       {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>           Package (2) {
>             "socionext,synquacer-pre-its",
>             Package () { 0x58000000, 0x200000 }
>           },
>         }
>       })
>     }
>
> which will trigger the existing quirk that replaces the doorbell
> address with the appropriate address in the pre-ITS frame.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Marc, Lorenzo,
>
> I am aware that this patch may be seen as controversial, but I would like to
> propose it nonetheless. The reason is that this is the only thing standing in
> the way of full ACPI support in Socionext SynQuacer based platforms.
>
> The pre-ITS is a monstrosity, but as it turns out, Socionext had help from
> ARM designing it, and the reason we need DT/ACPI based quirks in the first
> place is that the IIDR of this GICv3 implementation is simply the ARM Ltd.
> one (as they designed the IP)
>
> Please take this into consideration when reviewing this patch,
>

Ping?
