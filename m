Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4BDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1E2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216216;
	bh=dx71X9Jby89E2Nzdiu7tDhySy9vjxjen0bAMcMnpSzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fa9dN2dvBIhzfmhjy2ZT22LGnSBoJ0emG+OV9fx779IBMDF4ClkwzcYINXr1exnp9
	 QR09E58dVCfPdRoIQ3zq6P87ew0NX/gchCItV0BwqDBXCkWQArW5OU6t7OSGULLVhm
	 5RyidMF8ItZewT0EpWYNBa1kB1mXvDPPx5niqxRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfAKOQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387740AbfAKOQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:16:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4395821783;
        Fri, 11 Jan 2019 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216207;
        bh=dx71X9Jby89E2Nzdiu7tDhySy9vjxjen0bAMcMnpSzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7JMTATzKdmZDRWOL5U2cqV3M9xL0GXgfRD6smMPaxi7DXRRipn/jxgWM3vRC7AZT
         VFXZRBHDbRclukqal0F9yj+hLQP/PmXVN1Lrfl+ALtXb9HOSKFNd7yGK3TnWlOqw2b
         mUKclYQJN3WcAjwhR+yy2dUmxIAjzDwfwaGVpbO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 07/88] USB: serial: option: add Telit LN940 series
Date:   Fri, 11 Jan 2019 15:07:36 +0100
Message-Id: <20190111131047.379778137@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jörgen Storvist <jorgen.storvist@gmail.com>

commit 28a86092b1753b802ef7e3de8a4c4a69a9c1bb03 upstream.

Added USB serial option driver support for Telit LN940 series cellular
modules. Covering both QMI and MBIM modes.

usb-devices output (0x1900):
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1900 Rev=03.10
S:  Manufacturer=Telit
S:  Product=Telit LN940 Mobile Broadband
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option

usb-devices output (0x1901):
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 20 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1901 Rev=03.10
S:  Manufacturer=Telit
S:  Product=Telit LN940 Mobile Broadband
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1163,6 +1163,10 @@ static const struct usb_device_id option
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, TELIT_PRODUCT_LE920A4_1213, 0xff) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE920A4_1214),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) | RSVD(3) },
+	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1900),				/* Telit LN940 (QMI) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1901, 0xff),	/* Telit LN940 (MBIM) */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, ZTE_PRODUCT_MF622, 0xff, 0xff, 0xff) }, /* ZTE WCDMA products */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0002, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) },


