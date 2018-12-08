Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58710C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E47D2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E47D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fud.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeLHSXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:23:43 -0500
Received: from mail.fud.no ([87.238.60.8]:40426 "EHLO mail.fud.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeLHSXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:23:42 -0500
X-Greylist: delayed 1006 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2018 13:23:42 EST
Received: from cm-84.210.145.179.getinternet.no ([84.210.145.179]:37004 helo=sloth.lan)
        by mail.fud.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <tore@fud.no>)
        id 1gVh0A-00075u-Ko; Sat, 08 Dec 2018 19:06:54 +0100
From:   Tore Anderson <tore@fud.no>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tore Anderson <tore@fud.no>, stable@vger.kernel.org
Subject: [PATCH] USB: serial: option: add HP lt4132
Date:   Sat,  8 Dec 2018 19:05:12 +0100
Message-Id: <20181208180510.19235-1-tore@fud.no>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP lt4132 is a rebranded Huawei ME906s-158 LTE modem.

The interface with protocol 0x16 is "CDC ECM & NCM" according to the *.inf
files included with the Windows driver. Attaching the option driver to it
doesn't result in a /dev/ttyUSB* device being created, so I've excluded it.
Note that it is also excluded for corresponding Huawei-branded devices, cf.
commit d544db293a44a.

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=ff MxPS=64 #Cfgs=  3
P:  Vendor=03f0 ProdID=a31d Rev=01.02
S:  Manufacturer=HP Inc.
S:  Product=HP lt4132 LTE/HSPA+ 4G Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=2mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=06 Prot=10 Driver=option
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=13 Driver=option
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=12 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=06 Prot=16 Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=14 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=1b Driver=option

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=ff MxPS=64 #Cfgs=  3
P:  Vendor=03f0 ProdID=a31d Rev=01.02
S:  Manufacturer=HP Inc.
S:  Product=HP lt4132 LTE/HSPA+ 4G Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 7 Cfg#= 2 Atr=a0 MxPwr=2mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=06 Prot=00 Driver=cdc_ether
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=06 Prot=10 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=13 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=12 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=14 Driver=option
I:  If#=0x6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=1b Driver=option

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=ff MxPS=64 #Cfgs=  3
P:  Vendor=03f0 ProdID=a31d Rev=01.02
S:  Manufacturer=HP Inc.
S:  Product=HP lt4132 LTE/HSPA+ 4G Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 3 Cfg#= 3 Atr=a0 MxPwr=2mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=14 Driver=option

Signed-off-by: Tore Anderson <tore@fud.no>
Cc: stable@vger.kernel.org
---
 drivers/usb/serial/option.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e24ff16d4147..1a6fa4726def 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -552,6 +552,10 @@ static void option_instat_callback(struct urb *urb);
 #define WETELECOM_PRODUCT_6802			0x6802
 #define WETELECOM_PRODUCT_WMD300		0x6803
 
+/* HP products */
+#define HP_VENDOR_ID				0x03f0
+#define HP_PRODUCT_LT4132			0xa31d /* Huawei ME906s-158 */
+
 
 /* Device flags */
 
@@ -1941,6 +1945,11 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x10) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x12) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x13) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x14) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x1b) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.19.2

