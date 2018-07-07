Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D0C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8172249E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8172249E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGGBrv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:47:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:59974 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932714AbeGGBru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:47:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w671l73d014948;
        Fri, 6 Jul 2018 20:47:09 -0500
Message-ID: <05d4a75389d4143bcb53a730ad2e9ceddc99ceb3.camel@kernel.crashing.org>
Subject: Re: [PATCH] [RESEND] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE
 dependency
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sat, 07 Jul 2018 11:47:07 +1000
In-Reply-To: <20180706135840.908258-1-arnd@arndb.de>
References: <20180706135840.908258-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 15:58 +0200, Arnd Bergmann wrote:
> Without that option, we run into a link failure:
> 
> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
> 
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Greg, as discussed in https://patchwork.kernel.org/patch/10427921/,
> please apply this as a bugfix for 4.18.

Which I acked too though on second thoughts, shouldn't the driver
select USB_LIBCOMPOSITE ? No biggie, either way and that patch
can/should go in, we can change things later if we change our mind.

Cheers,
Ben.

>      Arnd
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> index f0cdf89b8503..83ba8a2eb6af 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> @@ -2,6 +2,7 @@
>  config USB_ASPEED_VHUB
>  	tristate "Aspeed vHub UDC driver"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on USB_LIBCOMPOSITE
>  	help
>  	  USB peripheral controller for the Aspeed AST2500 family
>  	  SoCs supporting the "vHub" functionality and USB2.0
