Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156382-2-16028564643385017175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156381; b=BwFAjue3483PoilWuPFNU9fULaO3el89yV+ouEwgEcuwUXcnHn
    2CTx7uvHGE+q3P7MUt0wmiIpecL8SnlUSb0fsh48+VtVJx273qzSNuMQosW6aVop
    D7TJkCL6JqfltScAe0AiRkheNYyPIJUA9dEhnJNKCcv5n6JeTIRFjHHSHs8iL3ZQ
    FPYdOuhlQ8s0x7JblWZz+s0EUjOYTggWsffXzJAKBT+ilXD0P/xPunsk0MddRZ97
    p/pVRy1QCnBia6lmaodp2MWAUi2tPkiuzjDjMpk6DDfzhOd14pqo21q3H0x9j4Vw
    5+f2H2zYlNUngQu7MG+ITvwnf9YxPbZ6uw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156381; bh=RXf/dgB4RTMjZ17vu9Cv6+vI4TMtf+
    11jY3ZUtXyT0s=; b=XpLalQmWazEp6fpdw9achaWDHe4phS4L3ir+NYauGcMIG2
    Lj0hYWltQ8xLSiMiw+if/8JGue0sR1sLEreV6fwVAMqnvWe0iNslWWH23RrV8j6z
    Jjf1B6udlo+KwdC2BGp7v0ilq5sRdOdfG41n/ezrHGPMxZB6h5rX99c60Y8B4b6K
    jnh59hM47JX/F0EldpQdsclprSE8puQqTrRuI1KHXIu7NYFv3Z0hfTOg8RUgfKtS
    v9JioiO4WFoaR0bUx/JZdCe0E727tpnTWYe7YrbSysz0+EHPbitkeCZ8yYjhASRq
    5VULEw/KhTRjbMViFQibvYDCGgWPnF63/O/xFpmA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=y/lwjFAM x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=y/lwjFAM x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJSyHT+tFTfAcXccxZEf+FpVbhoMlClSkjcGQbnLC9+bjeBH08qX3M06Gj8bqndQLYV0ZItyAH4LLLaUnVxtc1dPiSyOD8avVL3Nrl1VeJP7jmGIyaIG
    TWm5zhAA+4MZMacJ0N5yW8Mjvv7o7CirR1uogQkdZze2rBqd9fZvMD/fYBVYc/HFQka9KZxosTv91KXwHCyFBh6UNB8wJBDpC04zy9B7EgXMw4PpIEq3UVDa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xq3W2uTSAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=kcAGdoF0S6WsxfrmBFYA:9 a=QEXdDO2ut3YA:10 a=P5L7wpMTXyg1GfFA3Gwx:22
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031659AbeEXKGT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031391AbeEXKGP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 139/161] media: em28xx: Add Hauppauge SoloHD/DualHD bulk models
Date: Thu, 24 May 2018 11:39:24 +0200
Message-Id: <20180524093035.021890972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit f2a326c928cca1f5e36a3dceaf66e8c6b34e9cb8 ]

Add additional pids to driver list

Signed-off-by: Brad Love <brad@nextdimension.cc>
Reviewed-by: Michael Ira Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-cards.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -507,8 +507,10 @@ static struct em28xx_reg_seq plex_px_bcu
 };
 
 /*
- * 2040:0265 Hauppauge WinTV-dualHD DVB
- * 2040:026d Hauppauge WinTV-dualHD ATSC/QAM
+ * 2040:0265 Hauppauge WinTV-dualHD DVB Isoc
+ * 2040:8265 Hauppauge WinTV-dualHD DVB Bulk
+ * 2040:026d Hauppauge WinTV-dualHD ATSC/QAM Isoc
+ * 2040:826d Hauppauge WinTV-dualHD ATSC/QAM Bulk
  * reg 0x80/0x84:
  * GPIO_0: Yellow LED tuner 1, 0=on, 1=off
  * GPIO_1: Green LED tuner 1, 0=on, 1=off
@@ -2391,7 +2393,8 @@ struct em28xx_board em28xx_boards[] = {
 		.has_dvb       = 1,
 	},
 	/*
-	 * 2040:0265 Hauppauge WinTV-dualHD (DVB version).
+	 * 2040:0265 Hauppauge WinTV-dualHD (DVB version) Isoc.
+	 * 2040:8265 Hauppauge WinTV-dualHD (DVB version) Bulk.
 	 * Empia EM28274, 2x Silicon Labs Si2168, 2x Silicon Labs Si2157
 	 */
 	[EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_DVB] = {
@@ -2406,7 +2409,8 @@ struct em28xx_board em28xx_boards[] = {
 		.leds          = hauppauge_dualhd_leds,
 	},
 	/*
-	 * 2040:026d Hauppauge WinTV-dualHD (model 01595 - ATSC/QAM).
+	 * 2040:026d Hauppauge WinTV-dualHD (model 01595 - ATSC/QAM) Isoc.
+	 * 2040:826d Hauppauge WinTV-dualHD (model 01595 - ATSC/QAM) Bulk.
 	 * Empia EM28274, 2x LG LGDT3306A, 2x Silicon Labs Si2157
 	 */
 	[EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_01595] = {
@@ -2547,8 +2551,12 @@ struct usb_device_id em28xx_id_table[] =
 			.driver_info = EM2883_BOARD_HAUPPAUGE_WINTV_HVR_850 },
 	{ USB_DEVICE(0x2040, 0x0265),
 			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_DVB },
+	{ USB_DEVICE(0x2040, 0x8265),
+			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_DVB },
 	{ USB_DEVICE(0x2040, 0x026d),
 			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_01595 },
+	{ USB_DEVICE(0x2040, 0x826d),
+			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_01595 },
 	{ USB_DEVICE(0x0438, 0xb002),
 			.driver_info = EM2880_BOARD_AMD_ATI_TV_WONDER_HD_600 },
 	{ USB_DEVICE(0x2001, 0xf112),
@@ -2609,7 +2617,11 @@ struct usb_device_id em28xx_id_table[] =
 			.driver_info = EM28178_BOARD_PCTV_461E },
 	{ USB_DEVICE(0x2013, 0x025f),
 			.driver_info = EM28178_BOARD_PCTV_292E },
-	{ USB_DEVICE(0x2040, 0x0264), /* Hauppauge WinTV-soloHD */
+	{ USB_DEVICE(0x2040, 0x0264), /* Hauppauge WinTV-soloHD Isoc */
+			.driver_info = EM28178_BOARD_PCTV_292E },
+	{ USB_DEVICE(0x2040, 0x8264), /* Hauppauge OEM Generic WinTV-soloHD Bulk */
+			.driver_info = EM28178_BOARD_PCTV_292E },
+	{ USB_DEVICE(0x2040, 0x8268), /* Hauppauge Retail WinTV-soloHD Bulk */
 			.driver_info = EM28178_BOARD_PCTV_292E },
 	{ USB_DEVICE(0x0413, 0x6f07),
 			.driver_info = EM2861_BOARD_LEADTEK_VC100 },
