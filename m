Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967232AbeEYQIY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:08:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966599AbeEYQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:08:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
Date: Fri, 25 May 2018 18:07:15 +0200
Message-Id: <20180525160729.92026-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:XpsWrogyUgHklP59h2FvF7KkS5VBgqe4ixUNg/lDlRCt3hQYpzv
 W4Ls25q+itWePewSR5Ay1dcOwKUJq4JzkmKkq5nJclKetii1LGBufWlC0oamkgSnhdypQfu
 7aJWXzX0Z+e2drM//3TNjrOaNl6TqPUj15XP5o6+FJJ4x5YB4s8BssddFsqvQaheScM6aLw
 OQDLn8nwQyQui+UpuwRfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VDn1PnYvVKA=:nQQonX5ioVYBYDWz6WzxwA
 ANSIdoi3/2aXXRxYILfNG0DZMhef4Zic2wobosZxaUzad6buqGz4vCHBus76DFGOwAaPwH/Qr
 noqLyUjrkdqc/uVCQxFKIW47sbXOf0mJDiZ1WAYE2UE+yVDX1vj4/e371jif2snXXgWIwWopg
 YWWzfxc2s1eU+3zt8ADf8fm6diHE326rnuJrtP6oKiRHNourPmTbF4KsxbqyYwH4J1w/9ck46
 A1HB7GgOK4tSxNpiWQD5iu2ky/kR+LIbJNiuHS1wZoXLSaZhb7C+1AJlxB+WKqnWVhvtMPJFZ
 vxOcu0bNqV3omyq2eM97u/PGD3grlWQ1Zq11TEBerPTlEVkgC0o9sSiuzs6ybfbU6Y6j0r9Xz
 2sE6RIKJ9ZsOQGfrBAjRVigdlo8iyyIUSHHHGbQE61TcKeT64xKHBP0NUoQqMIxR/Oo91YJK7
 9Pz033aJWnOOMUfdd8Znu3BIZFe5Fena6l2B2JCuvmEPq/CqqJR6uEDEU38MCSXwfZqHGpWRO
 FFx4qrFOtCFmWdFi6V95c+uFqiYNpVARkQKulkwX7VDOE0YxQEpuLhBXXXOCEFjzbB+c7I06Z
 vvLeMNRp6CDR8NQDdCqMOkld1smDk+jzP5AIS1vd2jocgm/0BGenlZqKQx51SDsVAjHTIkMbc
 BvrNoZLe/+b8LoV9/+UpG/Y50Gz+zWJ6/lHULD4WuHsEO2cS5uYNphrKWUzBXY5ZGRfQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without that option, we run into a link failure:

drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'

Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
index f0cdf89b8503..83ba8a2eb6af 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
+++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
@@ -2,6 +2,7 @@
 config USB_ASPEED_VHUB
 	tristate "Aspeed vHub UDC driver"
 	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on USB_LIBCOMPOSITE
 	help
 	  USB peripheral controller for the Aspeed AST2500 family
 	  SoCs supporting the "vHub" functionality and USB2.0
-- 
2.9.0
