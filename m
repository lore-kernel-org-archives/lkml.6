Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A999C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D099B20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D099B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJRWhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:37:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46028 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728245AbeJRWhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:37:05 -0400
Received: (qmail 6108 invoked by uid 2102); 18 Oct 2018 10:35:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Oct 2018 10:35:47 -0400
Date:   Thu, 18 Oct 2018 10:35:47 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Al Cooper <alcooperx@gmail.com>
cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        <devicetree@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH V2 6/6] usb: host: Add ability to build new Broadcom STB
 USB drivers
In-Reply-To: <1539815349-24126-7-git-send-email-alcooperx@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1810181032460.1521-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Al Cooper wrote:

> Add the build system changes needed to get the Broadcom STB XHCI,
> EHCI and OHCI functionality working. The link order for XHCI was
> changed in the Makefile because of the way STB XHCI, EHCI and OHCI
> controllers share a port which requires that the XHCI driver be
> initialized first. Also update MAINTAINERS.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  MAINTAINERS               |  9 +++++++++
>  drivers/usb/host/Kconfig  | 29 +++++++++++++++++++++++++++++
>  drivers/usb/host/Makefile | 18 ++++++++++++------
>  3 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ac000cc006d..7e062dcbe173 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3006,6 +3006,15 @@ S:	Supported
>  F:	drivers/gpio/gpio-brcmstb.c
>  F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>  
> +BROADCOM BRCMSTB USB XHCI, EHCI and OHCI DRIVERS

This should say "XHCI and EHCI".  There is no Broadcom OHCI driver any 
more.

> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-usb@vger.kernel.org
> +L:	bcm-kernel-feedback-list@broadcom.com
> +S:	Maintained
> +F:	drivers/usb/host/xhci-brcm.*
> +F:	drivers/usb/host/ohci-brcm.c

This should say "ehci-brcm.c".

> +F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-*.txt
> +
>  BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
>  M:	Al Cooper <alcooperx@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 1a4ea98cac2a..112de3334389 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -94,6 +94,35 @@ config USB_XHCI_TEGRA
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in NVIDIA Tegra124 and later SoCs.
>  
> +config USB_OHCI_BRCM
> +       tristate

This symbol is not used any more.

> +
> +config USB_EHCI_BRCM
> +       tristate
> +
> +config USB_XHCI_BRCM
> +       tristate
> +
> +config BRCM_USB_PHY
> +       tristate
> +
> +config USB_BRCM
> +	tristate "Broadcom STB USB support"
> +	depends on ARCH_BRCMSTB
> +	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> +	select USB_EHCI_BRCM if USB_EHCI_HCD
> +	select USB_XHCI_BRCM if USB_XHCI_HCD
> +	select USB_XHCI_PLATFORM if USB_XHCI_HCD
> +	select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD || USB_XHCI_HCD
> +	select GENERIC_PHY if BRCM_USB_PHY
> +	default ARCH_BRCMSTB
> +	help
> +	  Say Y to enable support for XHCI, EHCI and OHCI host controllers
> +	  found in Broadcom STB SoC's.
> +
> +	  Disabling this will keep the controllers and corresponding
> +	  PHYs powered down.
> +
>  endif # USB_XHCI_HCD
>  
>  config USB_EHCI_HCD

Alan Stern

