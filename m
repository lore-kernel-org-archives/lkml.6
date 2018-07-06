Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D78C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0782923E56
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0782923E56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932765AbeGFN7L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:59:11 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeGFN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:59:10 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LiCiR-1fwhOB1WLb-00nMs9; Fri, 06 Jul 2018 15:58:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
Date:   Fri,  6 Jul 2018 15:58:10 +0200
Message-Id: <20180706135840.908258-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:KvyuPYuai9obFLh/kvDcrI47KRwgDKX2E3Ry6HQ2dBsIhVuX7dQ
 GnQEqLXHO4OTJCdZsiz9niTIbGA6HxqeaiLlGNj7WbvO1eV9QwGmS86ME/ilzENDBPcv9qf
 5eHbSD4fna0aFduZOtcZIrlNyv/WnMKDXHamac0CZXu076nSZOUwH7SpS/+/C3/py44no3H
 Ys9WDG19Q+CazmLKpqCaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RHZXWbbCw6w=:HH4P/kPioplMCd43E+1gh6
 8aBlwc8xAXNPXlK4QjVgk81BogOtpXyVKXd83iq4Yk82pfVpRtUVSE8L5tJqvnY+JBCkMLge7
 sqqcb8toYFqz2/7fbhkmmGi6WwKo6E5ycvoFOklOquBMLeDDwRfAGWIKE61N3/OFX9K66+1FG
 P0m29BVD5INqsDcLn58g+XL8Q7ioGSZu8BYCB+2ntN6+XD8qoFEnveHfF1lOgm8kZHVrBxmJO
 Wp1pnIB+xNTUTuC9DGux+mAoCAKkZMmRCG6ARAjI4mAW2ODnXOcQHgs3iV3GkA2FI0VTimzsw
 0NY1Pp6eymH9GNv/I9F4bb9PhwYaENeYcwyV7lT0PZYOrlFNFns29sOi2SMDX9agfffFt1R0p
 KnTd/DFtZbtj09liWPxX2II7imuuHvbJa54Q7DW5M5ffnAFBMSS4uH4/6DIF2lL4pvISIyt6h
 EeGokJvWd3q6zspGCBcHSwjcTMGlRk5m4WoXRFp9YfjhffdxKv7Eee0T3m+O2WY5Nv0Y9zpm5
 eBrxVTWtWa7qSBX9+O711azYSy1T/+7Q6D3Y0U3q4q/qBDUuc682my63qQ8kPI5B0xjAQde5s
 jvfd81vSwl+e6UG0Uzm9eHZ8yfl//KA/oYk709YZP/DX8kM2qB6KufK2VDMPsH0xLju2lj9qS
 JCw8cwEbP+qDlU74B3M8ErlHMfjWCmQXAsyUEGhUrgKEBtNt5hSKXxMCaqgM3nBx6yzQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without that option, we run into a link failure:

drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'

Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Greg, as discussed in https://patchwork.kernel.org/patch/10427921/,
please apply this as a bugfix for 4.18.

     Arnd
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

