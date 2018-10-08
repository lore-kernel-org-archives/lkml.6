Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D033BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2A2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDeguI/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB2A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJIBqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbeJIBqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:46:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4222C2087D;
        Mon,  8 Oct 2018 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023623;
        bh=2Boz1A2Bw+voaXL5v+YXHLHzPLcO+pVEgCxzfX1PlfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDeguI/zW/989lcunVJgXc72zgWO2Wqa3c0tGqk6yPN/xVEUHqtG6ttVGx6euwLL3
         lPx6SYKTECw9t9TZaYbVIHCQK+7uIchsqQmS/XjF+YrJ4pGz4+mEKqR0vtVxnWXlvc
         IrDB9XUox9JT74TackbMhXD435t5SqtIkVFXLfUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 008/113] Bluetooth: Add a new Realtek 8723DE ID 0bda:b009
Date:   Mon,  8 Oct 2018 20:30:09 +0200
Message-Id: <20181008175531.259692526@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit 45ae68b8cfc25bdbffc11248001c47ab1b76ff6e ]

Without this patch we cannot turn on the Bluethooth adapter on HP
14-bs007la.

T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b009 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=802.11n WLAN Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -340,6 +340,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8723DE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8821AE Bluetooth devices */


