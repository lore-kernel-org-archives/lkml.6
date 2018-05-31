Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeEaEOr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:14:47 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38408 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeEaEOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:14:35 -0400
X-Google-Smtp-Source: ADUXVKIHHYkrd8uT/Ig3FLzib2PNSwo8RSbOHOeLBHikESr5vZ0JmbmByc/WBLZBcA339AIIYD5iVg==
Date: Wed, 30 May 2018 23:14:30 -0500
From: Rob Herring <robh@kernel.org>
To: avifishman70@gmail.com
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        brendanhiggins@google.com, mathias.nyman@linux.intel.com,
        bjorn.andersson@linaro.org, jhogan@kernel.org, albeu@free.fr,
        chunfeng.yun@mediatek.com, tony@atomide.com, baolu.lu@linux.intel.com,
        elder@linaro.org, digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v1 2/3] USB: DT probing support to ehci-npcm7xx
Message-ID: <20180531041430.GA2862@rob-hp-laptop>
References: <1527582935-31175-1-git-send-email-avifishman70@gmail.com>
 <1527582935-31175-3-git-send-email-avifishman70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527582935-31175-3-git-send-email-avifishman70@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:35:34AM +0300, avifishman70@gmail.com wrote:
> From: Avi Fishman <AviFishman70@gmail.com>
> 
> Device Tree documentation for Nuvoton npcm7xx EHCI driver.

Bindings are for drivers, but for h/w.

> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> new file mode 100644
> index 000000000000..628692dff7e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> @@ -0,0 +1,18 @@
> +Nuvoton NPCM7XX SoC USB controllers:
> +-----------------------------
> +
> +EHCI:
> +-----
> +
> +Required properties:
> +- compatible: "nuvoton,npcm750-ehci"

And usb-ehci? Though I would just drop it. It is pretty useless.

> +  that services interrupts for this device

This line goes below.

> +- interrupts: Should contain the EHCI interrupt
> +
> +Example:
> +
> +	ehci@e1800000 {
> +		compatible = "nuvoton,npcm750-ehci", "usb-ehci";
> +		reg = <0xf0806000 0x1000>;
> +		interrupts = <0 61 4>;
> +	};
> -- 
> 2.14.1
> 
