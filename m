Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F861C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5032145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPevAkLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5032145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeK3BZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbeK3BZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:25:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1015D21019;
        Thu, 29 Nov 2018 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501186;
        bh=QZtSs2H7DMbORaqFAyw9bWEbwVeU9mYsDI3w/j7dB+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPevAkLF4Oygn3+V9qcx7AAbzgsWCovaEX2pFDwd3rrHnvNBlzDERGQR19tT3KseG
         qqDM4za8s6qgem6btqbE1PuSW9L2vT2snmOXKmqgczWQyUAHZoD5RbBOSHMJRarnTg
         5iBRqd7Os4jqOS2OERii/oZ1imhS04Y9+ZxjFFSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Pierre-Loup A. Griffais" <eduke32@plagman.net>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 42/86] Input: xpad - xbox one elite controller support
Date:   Thu, 29 Nov 2018 15:12:07 +0100
Message-Id: <20181129140113.758069253@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
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

[ Upstream commit 6f49a398b266d4895bd7e041db77a2b2ee1482a6 ]

added the according id and incresed XPAD_PKT_LEN to 64 as the elite
controller sends at least 33 byte messages [1].
Verified to be working by [2].

[1]: https://franticrain.github.io/sniffs/XboxOneSniff.html
[2]: https://github.com/paroj/xpad/issues/23

Signed-off-by: Pierre-Loup A. Griffais <eduke32@plagman.net>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c8897fc3202c..dcf9053a801e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -87,7 +87,7 @@
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
 
-#define XPAD_PKT_LEN 32
+#define XPAD_PKT_LEN 64
 
 /* xbox d-pads should map to buttons, as is required for DDR pads
    but we map them to axes when possible to simplify things */
@@ -129,6 +129,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
+	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
2.17.1



