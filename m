Return-Path: <stern+5aab093e@rowland.harvard.edu>
X-Google-Smtp-Source: AIpwx4/kdXAOknhBU3iiW55+mPnuq7fQcB+MYHMI8E7b824Lw70IJWHeuBQUIQiMMi94zXm1WRO1
ARC-Seal: i=1; a=rsa-sha256; t=1522088890; cv=none;
        d=google.com; s=arc-20160816;
        b=Ixk/fEn9Aq0/CPzLO/Oz5NX4Vv0H244khNO/gw/I8ZV6M6Uqp2JHBNmU3oSYcuzlTn
         yFGRItRzisaYV/g6UddgZL2+XaKdMh+5S/fXVzhyZAyUTJcpvHy0tY6CaYh6saFAFAmj
         66lgYS1ODqnEbi/sJP8hzb45bD1gfSTzIbk1PTI1LpZerJPGMWWeelN1wvVkVupVLfQ9
         ji/G0DHjq4NHMKcYtF6SjkZkTMEMP4rkcTm1N6d0w1B8X4Ua4Wt8wWhAUaM9gMz+k3wW
         tLxx77SkcKtvlunSaNmS8OXYT6KQG5zAAw3pRDTKudx886ZL0Vnq+qjbpXS2ru4cUddX
         qUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=JMIRjVfW0yhb4HC+GW2Dbp43hxR+6Kj76ofts2PLzhU=;
        b=V6vHq2Q1FLuXWZQuFyDZQ4oGcJQoKd6yb+i9VkErSVGJ6K4jkqlKFCzt4tmhn1Wlvm
         LOtMUxvLmMu+RfGaP+8tsI+3Z9Wm+wYEHEcwtQ9+fMmd1EhsJRl4Os405EtFKW46FWJZ
         HGZ9Z8OvPCEvLj93AC3M7OdUSsD7e9F7KCbyntNAsaX/1PWDr8/6L8lX9VM1nUA+YIOz
         dDKnI0YCD0X+uzDO+bggSknT37s8Z4bjZh4DAToSARRN2HN0GpTqHktr2A9WNSuEN0Sq
         iTwpFXkqGyohd/+3TAX5C6s6udw/mVbioHcYlb2YOhMFkd+1MlX+SUNaF0kLkUM+GWGH
         Mqbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Date: Mon, 26 Mar 2018 14:28:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alban Bedel <albeu@free.fr>
cc: linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
    James Hogan <jhogan@kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Benjamin Herrenschmidt <benh@kernel.crashing.org>,
    Alex Elder <elder@linaro.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
    Lu Baolu <baolu.lu@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
     <linux-mips@linux-mips.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: Remove the deprecated ATH79 USB host config
 options
In-Reply-To: <1521931644-31326-1-git-send-email-albeu@free.fr>
Message-ID: <Pine.LNX.4.44L0.1803261427380.1382-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595861037035248904?=
X-GMAIL-MSGID: =?utf-8?q?1596025880448499239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018, Alban Bedel wrote:

> The options USB_EHCI_ATH79 and USB_OHCI_ATH79 only enable the
> generic EHCI and OHCI platform drivers, and have been marked as
> deprecated since 2012.
> 
> These can be safely removed if we make sure that USB_EHCI_ROOT_HUB_TT
> still get enabled for the EHCI driver. This is now done be selecting
> this option when the EHCI platform driver is enabled on the ATH79
> platform.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/Kconfig        |  1 +
>  drivers/usb/host/Kconfig | 25 -------------------------
>  2 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8128c3b..61e9a24 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -200,6 +200,7 @@ config ATH79
>  	select SYS_SUPPORTS_MIPS16
>  	select SYS_SUPPORTS_ZBOOT_UART_PROM
>  	select USE_OF
> +	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
>  	help
>  	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
>  
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 4fcfb30..55b45dc 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -293,19 +293,6 @@ config USB_CNS3XXX_EHCI
>  	  It is needed for high-speed (480Mbit/sec) USB 2.0 device
>  	  support.
>  
> -config USB_EHCI_ATH79
> -	bool "EHCI support for AR7XXX/AR9XXX SoCs (DEPRECATED)"
> -	depends on (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X)
> -	select USB_EHCI_ROOT_HUB_TT
> -	select USB_EHCI_HCD_PLATFORM
> -	default y
> -	---help---
> -	  This option is deprecated now and the driver was removed, use
> -	  USB_EHCI_HCD_PLATFORM instead.
> -
> -	  Enables support for the built-in EHCI controller present
> -	  on the Atheros AR7XXX/AR9XXX SoCs.
> -
>  config USB_EHCI_HCD_PLATFORM
>  	tristate "Generic EHCI driver for a platform device"
>  	default n
> @@ -489,18 +476,6 @@ config USB_OHCI_HCD_DAVINCI
>  	  controller. This driver cannot currently be a loadable
>  	  module because it lacks a proper PHY abstraction.
>  
> -config USB_OHCI_ATH79
> -	bool "USB OHCI support for the Atheros AR71XX/AR7240 SoCs (DEPRECATED)"
> -	depends on (SOC_AR71XX || SOC_AR724X)
> -	select USB_OHCI_HCD_PLATFORM
> -	default y
> -	help
> -	  This option is deprecated now and the driver was removed, use
> -	  USB_OHCI_HCD_PLATFORM instead.
> -
> -	  Enables support for the built-in OHCI controller present on the
> -	  Atheros AR71XX/AR7240 SoCs.
> -
>  config USB_OHCI_HCD_PPC_OF_BE
>  	bool "OHCI support for OF platform bus (big endian)"
>  	depends on PPC

For the EHCI and OHCI portions:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
