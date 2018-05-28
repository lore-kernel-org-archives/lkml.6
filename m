Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936537AbeE1Xty (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 19:49:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:33923 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936467AbeE1Xtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 19:49:50 -0400
Message-ID: <bfc6394b14a70f2be55a736963b2e167f66b93d6.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 09:49:06 +1000
In-Reply-To: <20180525160729.92026-1-arnd@arndb.de>
References: <20180525160729.92026-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 18:07 +0200, Arnd Bergmann wrote:
> Without that option, we run into a link failure:
> 
> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'

Thanks ! I hadn't realized these functions were part of an optional
library.

> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

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
