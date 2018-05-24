Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158730-2-7826433430030949052
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
    1527158730; b=T7BNj/j8IJgqA+QSJZSyQZ1FlHfFtDiGaiOCuFjb8i+xLgTg9t
    DZw05VIrncn0irVeJ0ZOZbvj3Wwxz+/zyLvEJ2A6bDzP9Y8kSEciZUwVhyH2VAYS
    5F2aC7wJjSClizYJZGGbiYFfiNd8JeADS6U4Q0bstcJK3yWQARBWvfNNrw0V6NxS
    15WMlFsgEGl4oY51NZmmMibc+ik2WY2bpPG7ra/itbGkGME8ssLfP+MdqZnPIvtD
    p/EHTvwMmZ8qkKOenxH30mrOX6WtfO/5s7gDoHyT1/9/s1ZsLtcPlm2F4heo+WIm
    xr6ZSuVeV7oAi1G1xNhbkfpgsWCP0vkrqlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158730; bh=wWXie26zGr88rAR4yZ5OnvGswGI0iM
    FyWogDAaxkhm8=; b=NwoW9P2sLmVgGKugSM4JItozb7+osTWbbZrxfocJVpSgEI
    rYNXGOSpEJjTCNwxuAVJtVgu3kqbfrsrlnJEK73ltB2mjY1JQGmniGe6DY3crHXv
    k/N24uTLp8n84rAgD06u97KueMCz0kQgcMdqNdymAdvzQN2qbwt+HPEDelsGjYUk
    sjxYvUztUYqnDtX4hgXboM5igoebODhhORvZHbJ4wZgkF7Zh8AfnTCvNcu2CwTY5
    mzLmTwkNHrAmDnNpT/u4LRPOZdg35Mw4/fDhDrbHRgx8N0Y8rdettoF07eQQHO0Z
    I2BYdlZaTa/+ySwJMUh7aLjfkYeFspHAT01+gS/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GaZCo1+6 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=GaZCo1+6 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFrpDUfoqMJNSMYQHTtw0FUQg/xqEjpas780TBI7ze7oaM7hQg4dGoJH783cBqxxD8RHfv49T02VxOdsNgYr14gPtxwLb5VL9oevEBzzEcXSIlfslyWI
    ZfqP99BdhOGjOQ0kiE2IlQKdEKxW+MTJjowDaIzaOVCAzTpLA/ndUkhx2dExMSP6IWMJltRURJoRbxtQYQ/gq/iATEtOfeKL/w3i9gVStnJeOIYPoMcVTuRn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xq3W2uTSAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=kcAGdoF0S6WsxfrmBFYA:9 a=QEXdDO2ut3YA:10 a=P5L7wpMTXyg1GfFA3Gwx:22
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968147AbeEXJ54 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030447AbeEXJ5q (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 144/165] media: em28xx: Add Hauppauge SoloHD/DualHD bulk models
Date: Thu, 24 May 2018 11:39:10 +0200
Message-Id: <20180524093627.898837190@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -508,8 +508,10 @@ static struct em28xx_reg_seq plex_px_bcu
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
@@ -2392,7 +2394,8 @@ struct em28xx_board em28xx_boards[] = {
 		.has_dvb       = 1,
 	},
 	/*
-	 * 2040:0265 Hauppauge WinTV-dualHD (DVB version).
+	 * 2040:0265 Hauppauge WinTV-dualHD (DVB version) Isoc.
+	 * 2040:8265 Hauppauge WinTV-dualHD (DVB version) Bulk.
 	 * Empia EM28274, 2x Silicon Labs Si2168, 2x Silicon Labs Si2157
 	 */
 	[EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_DVB] = {
@@ -2407,7 +2410,8 @@ struct em28xx_board em28xx_boards[] = {
 		.leds          = hauppauge_dualhd_leds,
 	},
 	/*
-	 * 2040:026d Hauppauge WinTV-dualHD (model 01595 - ATSC/QAM).
+	 * 2040:026d Hauppauge WinTV-dualHD (model 01595 - ATSC/QAM) Isoc.
+	 * 2040:826d Hauppauge WinTV-dualHD (model 01595 - ATSC/QAM) Bulk.
 	 * Empia EM28274, 2x LG LGDT3306A, 2x Silicon Labs Si2157
 	 */
 	[EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_01595] = {
@@ -2548,8 +2552,12 @@ struct usb_device_id em28xx_id_table[] =
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
@@ -2610,7 +2618,11 @@ struct usb_device_id em28xx_id_table[] =
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
