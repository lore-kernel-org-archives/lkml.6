Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2770C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CFF222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOAiJp0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfBPJRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 04:17:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42926 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfBPJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 04:17:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so6036900pfi.9;
        Sat, 16 Feb 2019 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09VPvvjG3iqG8uhIMPG020teROeozKHz9E/sWH2blQA=;
        b=OOAiJp0LKwj7EtV7IKHrDXrJwdzxJJEtRRNno6Vy9JK+FJKfQ7FVZ7CeOhYKaQKoyV
         +uDzfS6cu3USSTmt7arhQuvkSjFrQOPjJuTC2CTu1+OnyFOcj0vlLCKsSDg6vkNBWpRX
         kTYkGFfz9MY/ZWRV2ZBdtmrFbuyj3UYRUSPXsR6djUejSS4WFNjKnRFkeKQPJMK4Rx3A
         yp1rb/mMw/dqJmxUPqWP4jKJPfDBKAfnYp1i2hH91L9bS0td13MsNnLc1RnYA5r9Mdhh
         x+qRVxz/ZuTnExutoPv3jSI20ksal1KeQrv6PqicLjoZbz/9c43Sj65Xusxf97pYYe8+
         HZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09VPvvjG3iqG8uhIMPG020teROeozKHz9E/sWH2blQA=;
        b=gaeLQtGu5vVbc6sDLHFOUR12T3fxtFZXZz8PKRsvnQmpeIXRNLFlpp+/bd70EtvivR
         lxTRUB8jhjv553qYmqRh/JPgY1Z4r/iHfudVa/FzUsgnNgFZz8reSWf3Ch/cfG0qsvkp
         eCei+eh5EXeRMRGmVmn6CnRb4jIOpieELoC+Y50uWKe7xnw82HHAjS+dq55t9YnLZ574
         1SNyEKb/WTZPmWBne6wWXleYOLyxa4zH39B6wZvEPzFmGFUcpNjnbK4auYYiTlSaFbzH
         5S4XiPyaDLrDLyC2kIfkQ+A+SSluo69w/CKJYjXSaorpvCQm3tVw0vc+HZVoq4mVGB08
         AqRg==
X-Gm-Message-State: AHQUAuZyiwoAVIZGp3w3iFP+049tcB1xs/cOg/ZYphTorsp8FLhfE4wc
        3mriQc1PwsST0x9l7UYKnw5r1eMOoGE=
X-Google-Smtp-Source: AHgI3IZk+mgFDs8OuVGhXNmPtDOWSVQ7Pr5smiOmZTA//UqxTRnFvNgYSh8bY+WULKUzymBxeU+1rw==
X-Received: by 2002:a63:2c8c:: with SMTP id s134mr9485113pgs.269.1550308652414;
        Sat, 16 Feb 2019 01:17:32 -0800 (PST)
Received: from localhost.localdomain (2001-b011-1004-1fe7-cc7e-a132-b6dd-76b3.dynamic-ip6.hinet.net. [2001:b011:1004:1fe7:cc7e:a132:b6dd:76b3])
        by smtp.gmail.com with ESMTPSA id x2sm11732869pfx.78.2019.02.16.01.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 01:17:31 -0800 (PST)
From:   David Chen <david0813@gmail.com>
To:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, jslaby@suse.cz, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Subject: [PATCH] r8152: Add support for MAC address pass through on RTL8153-BD
Date:   Sat, 16 Feb 2019 17:16:42 +0800
Message-Id: <20190216091642.21388-1-david0813@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Chen <david.chen7@dell.com>

RTL8153-BD is used in Dell DA300 type-C dongle.
It should be added to the whitelist of devices to activate MAC address
pass through.

Per confirming with Realtek all devices containing RTL8153-BD should
activate MAC pass through and there won't use pass through bit on efuse
like in RTL8153-AD.

Signed-off-by: David Chen <david.chen7@dell.com>
---
 drivers/net/usb/r8152.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 60dd1ec1665f..ada6baf8847a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -557,6 +557,7 @@ enum spd_duplex {
 /* MAC PASSTHRU */
 #define AD_MASK			0xfee0
 #define BND_MASK		0x0004
+#define BD_MASK			0x0001
 #define EFUSE			0xcfdb
 #define PASS_THRU_MASK		0x1
 
@@ -1176,9 +1177,9 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 			return -ENODEV;
 		}
 	} else {
-		/* test for RTL8153-BND */
+		/* test for RTL8153-BND and RTL8153-BD */
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
-		if ((ocp_data & BND_MASK) == 0) {
+		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK)) {
 			netif_dbg(tp, probe, tp->netdev,
 				  "Invalid variant for MAC pass through\n");
 			return -ENODEV;
-- 
2.19.1

