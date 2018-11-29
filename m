Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D965C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65D72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr9vucAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65D72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbeK3Bcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbeK3Bck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B342145D;
        Thu, 29 Nov 2018 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501628;
        bh=sBjj2y8mNv1OWS2SLnMhS43bPeIETakPDg6fgWlH8wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr9vucAlqyqAS/WsogSMEwE953wXCbCbQmCrjTBCsDkM5WZBMx79ofMQxZQi8NbOA
         CS+E8h/iFndoQQME1JXMpCc9iQH2shYuLrIQmQ8Oq2cPl8UnT+LoMtVKQXqjtfuC/u
         S5KcN4O+2GZ3+oZzUXip0D5kWdeScXSSVGyh3H4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Francis Therien <frtherien@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/100] Input: xpad - add PDP device id 0x02a4
Date:   Thu, 29 Nov 2018 15:12:45 +0100
Message-Id: <20181129140105.256543105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c6c848572f4da0e34ffe0a35364b4db871e13e42 ]

Adds support for a PDP Xbox One controller with device ID
(0x06ef:0x02a4). The Product string for this device is "PDP Wired
Controller for Xbox One - Stealth Series | Phantom Black".

Signed-off-by: Francis Therien <frtherien@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 53f775c41cd1..d2a1857fdae5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -231,6 +231,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x02a4, "PDP Wired Controller for Xbox One - Stealth Series", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
@@ -480,7 +481,8 @@ static const u8 xboxone_hori_init[] = {
 
 /*
  * This packet is required for some of the PDP pads to start
- * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ * sending input reports. These pads include: (0x0e6f:0x02ab),
+ * (0x0e6f:0x02a4).
  */
 static const u8 xboxone_pdp_init1[] = {
 	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
@@ -488,7 +490,8 @@ static const u8 xboxone_pdp_init1[] = {
 
 /*
  * This packet is required for some of the PDP pads to start
- * sending input reports. One of those pads is (0x0e6f:0x02ab).
+ * sending input reports. These pads include: (0x0e6f:0x02ab),
+ * (0x0e6f:0x02a4).
  */
 static const u8 xboxone_pdp_init2[] = {
 	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
@@ -526,6 +529,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
 	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
 	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
-- 
2.17.1



