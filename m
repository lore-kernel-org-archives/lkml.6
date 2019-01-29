Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9DC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8E12086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762688;
	bh=QChf1skLul+RI1jz9lueHS69X9VyoYyFL4ac8BnXkJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oHyaUVWJc0kdc9su4wdm2v2JyPqPYdOGl1PhKXuzChci1fMhfFEzmPFj6NDldZcDM
	 wvFtewkJrSh3qcMxb0cs+DPXyP+Ie62MpmZhApA+5VsZeBMQOmE6G2jOkIdXB0ucWB
	 BK3KlDuElfzy1FnumXAF5cJv9GgY5O93PIc6Ta/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfA2Lv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbfA2LvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1243F2083B;
        Tue, 29 Jan 2019 11:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762684;
        bh=QChf1skLul+RI1jz9lueHS69X9VyoYyFL4ac8BnXkJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gqvi8Hw7z7Cgk8jDYggDhp+b2BAKdyuJ5Rd4kE1i/U2eqs8JfeJYzO0mcEWa+po0
         qh2OdHoEqe/7+nU9WtL4bnU+UBJIuP47FYGNN2GmDMnnCWAtqoEISu6x56ZPsdOKVM
         +LD3hIz+KqqjEyr0eM0xYdELCGOUE0mcQM6M8Vc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Schulze <max.schulze@posteo.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 09/44] USB: serial: simple: add Motorola Tetra TPG2200 device id
Date:   Tue, 29 Jan 2019 12:36:04 +0100
Message-Id: <20190129113140.844956506@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Schulze <max.schulze@posteo.de>

commit b81c2c33eab79dfd3650293b2227ee5c6036585c upstream.

Add new Motorola Tetra device id for Motorola Solutions TETRA PEI device

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0cad ProdID=9016 Rev=24.16
S:  Manufacturer=Motorola Solutions, Inc.
S:  Product=TETRA PEI interface
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb_serial_simple
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb_serial_simple

Signed-off-by: Max Schulze <max.schulze@posteo.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/usb-serial-simple.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -88,7 +88,8 @@ DEVICE(moto_modem, MOTO_IDS);
 /* Motorola Tetra driver */
 #define MOTOROLA_TETRA_IDS()			\
 	{ USB_DEVICE(0x0cad, 0x9011) },	/* Motorola Solutions TETRA PEI */ \
-	{ USB_DEVICE(0x0cad, 0x9012) }	/* MTP6550 */
+	{ USB_DEVICE(0x0cad, 0x9012) },	/* MTP6550 */ \
+	{ USB_DEVICE(0x0cad, 0x9016) }	/* TPG2200 */
 DEVICE(motorola_tetra, MOTOROLA_TETRA_IDS);
 
 /* Novatel Wireless GPS driver */


