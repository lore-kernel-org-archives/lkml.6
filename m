Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BD5217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 17:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ljsMjeyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeLWRTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 12:19:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLWRTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 12:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BKMdZRzF2Gst15kdL0mdX/Y4isLsoiPx0spM1T0uI5M=; b=ljsMjeyCzSw/J7FfhyqvBdtiv
        VGHCu52V2TFQq+V04WzP9I4EmoQoY95t54315HcA91gR28Wr4O3QZN9/zQBuUDJqDdIMVbxMYilPU
        W2zpnvCnXEKc4Fd4+1oLYaDLEoAd7esxrTZbfG9T3d/eWcI+Z0cVzS9H2umayDQbkf95O3i07UMQ0
        feLUC0D5SznJyTt+iC2AYnLul7FfkutOPibqOUrVxjqettJG35NxSluvw0gGwtN1Fph8ULBCv2iEm
        P2399fSilvn0+vA/Jcrup2gXxfNk4+lxk1KLBXVACeTh+vwD6mLfuk5gpgGC0mp3YShgLO6+TvqlP
        BKcQ6RthA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gb7Pf-0007qt-Pa; Sun, 23 Dec 2018 17:19:39 +0000
Subject: Re: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        adouglas@cadence.com, jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com,
        sureshp@cadence.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
 <1545577992-4013-6-git-send-email-pawell@cadence.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b55eb76-70d8-a53a-b7d2-985dfe7d6fed@infradead.org>
Date:   Sun, 23 Dec 2018 09:19:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545577992-4013-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few Kconfig text corrections.


On 12/23/18 7:13 AM, Pawel Laszczak wrote:
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> new file mode 100644
> index 000000000000..4adfd87811e8
> --- /dev/null
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -0,0 +1,44 @@
> +config USB_CDNS3
> +	tristate "Cadence USB3 Dual-Role Controller"
> +	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
> +	help
> +	  Say Y here if your system has a cadence USB3 dual-role controller.
> +	  It supports: dual-role switch, Host-only, and Peripheral-only.
> +
> +	  If you choose to build this driver is a dynamically linked

	                                     as

> +	  module, the module will be called cdns3.ko.
> +
> +if USB_CDNS3
> +
> +config USB_CDNS3_GADGET
> +        bool "Cadence USB3 device controller"
> +        depends on USB_GADGET
> +        help
> +          Say Y here to enable device controller functionality of the
> +          cadence USBSS-DEV driver.
> +
> +          This controller supports FF, HS and SS mode. It doesn't support
> +          LS and SSP mode

	                mode.

> +
> +config USB_CDNS3_HOST
> +        bool "Cadence USB3 host controller"
> +        depends on USB_XHCI_HCD
> +        help
> +          Say Y here to enable host controller functionality of the
> +          cadence driver.
> +
> +          Host controller is compliance with XHCI so it will use

	                        compliant

> +          standard XHCI driver.
> +
> +config USB_CDNS3_PCI_WRAP
> +	tristate "Cadence USB3 support on PCIe-based platforms"
> +	depends on USB_PCI && ACPI
> +	default USB_CDNS3
> +	help
> +	  If you're using the USBSS Core IP with a PCIe, please say
> +	  'Y' or 'M' here.
> +
> +	  If you choose to build this driver as module it will
> +	  be dynamically linked and module will be called cdns3-pci.ko
> +
> +endif


g'day.
-- 
~Randy
