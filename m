Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12F2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D1F214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216074;
	bh=lAlpHgq1iACcobWIJZImuOYeCd2NqHRAiDJGiiZO4Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlOIS+cFKoQbnipyF/yID//fXbOGnafFxbzJBAWEidkArDUKlOeDnTU/z38udjtkZ
	 7em4TdScrb6qeBzDy3z0Aj2AEsXXVWYEA+8bhHWwrylD3Fh6RT0B886iQlLf+eD87Z
	 IPY2hWXoLNxV5+kfZrlDVwYwerXWiJxr6+tqpATk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfAKOOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbfAKOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238D42177B;
        Fri, 11 Jan 2019 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216070;
        bh=lAlpHgq1iACcobWIJZImuOYeCd2NqHRAiDJGiiZO4Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDNkgILgotf5j0hx6nmuQSeq6VH2v0+rCdmc9DKCrUdZO4VwkFMV9ItOtLjA6BU2g
         hsv4HruifKyVxdDGcWeC/7KiPtqDiAFn0imR+C8bGLuuPmDx7ijoofaR3XkDxaZbiQ
         mvANB9qZKRt0SGXWvdOBHM7OrWWtghC2wAL9q4EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tore Anderson <tore@fud.no>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 02/47] USB: serial: option: add HP lt4132
Date:   Fri, 11 Jan 2019 15:07:47 +0100
Message-Id: <20190111130956.524117569@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tore Anderson <tore@fud.no>

commit d57ec3c83b5153217a70b561d4fb6ed96f2f7a25 upstream.

The HP lt4132 is a rebranded Huawei ME906s-158 LTE modem.

The interface with protocol 0x16 is "CDC ECM & NCM" according to the *.inf
files included with the Windows driver. Attaching the option driver to it
doesn't result in a /dev/ttyUSB* device being created, so I've excluded it.
Note that it is also excluded for corresponding Huawei-branded devices, cf.
commit d544db293a44 ("USB: support new huawei devices in option.c").

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
[ johan: drop id defines ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2042,7 +2042,12 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD200, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) },	/* HP lt2523 (Novatel E371) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x10) },	/* HP lt4132 (Huawei ME906s-158) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x12) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x13) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x14) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x1b) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);


