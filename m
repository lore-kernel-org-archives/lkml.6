Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeEQQoy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:44:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32873 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeEQQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:38 -0400
X-Google-Smtp-Source: AB8JxZpqK99VRTycvpBWHtvDCm25wUrKrfyZyGj/GRiIZvFK6NTX/bLvKFgPGOgb5o4CmOVJ5A4t7RkxykM4xMUeEH8=
MIME-Version: 1.0
In-Reply-To: <20180517131727.29263-1-eric@anholt.net>
References: <20180517131727.29263-1-eric@anholt.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 17 May 2018 17:44:36 +0100
Message-ID: <CALeDE9MCox38f9w5wrWtvefNCZoWSRHAqcec0Xi0qdZidHKHQw@mail.gmail.com>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
To: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 2:17 PM, Eric Anholt <eric@anholt.net> wrote:
> The a53 and a7 counters seem to match up, so we advertise a7 so that
> arm32 can probe.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

We've carried the same/equiv patch in Fedora for a while with no issues.

Peter

> ---
>  arch/arm/boot/dts/bcm2837.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
> index 7704bb029605..1f5e5c782835 100644
> --- a/arch/arm/boot/dts/bcm2837.dtsi
> +++ b/arch/arm/boot/dts/bcm2837.dtsi
> @@ -17,6 +17,12 @@
>                 };
>         };
>
> +       arm-pmu {
> +               compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
> +               interrupt-parent = <&local_intc>;
> +               interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
>         timer {
>                 compatible = "arm,armv7-timer";
>                 interrupt-parent = <&local_intc>;
> --
> 2.17.0
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
