Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B0E208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtCItKIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B0E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeLETqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:46:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35788 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLETqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:46:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so19482131ljb.2;
        Wed, 05 Dec 2018 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pECtvteeo7795cmfljqIf27awj6Ab3REDnb3qaExur0=;
        b=WtCItKIZNRA9n2qD05ZW0dQe18cfOtSQjZaRIqeYsV2+nRkEj8KvBeMlwP9Mdmr6FC
         Pgi73L/qgQcmrfJQy4u/8853siqol4I8p3m7XM+g/U1hNoYklcFAvpaTtroaBEAqOUjp
         aEqzdL/mkzH0Rqprj3Hr1FIWI0ySgHbS789aTiMNgwAtl0VJVQODQAx3SNWrPlrrVVOT
         20yv42aY1IqaOAWhx0hnQrRf8v836feJzR3DWyAPvrYfWyjubLi/c8ByuJBUorSMnND6
         YHPoYrpyIBA+buBwSe7SVZNOQuWv9Ulw4h+dJ9vXcwzl9cCR/oMBqZKyvzm2RWD+5D3E
         PvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pECtvteeo7795cmfljqIf27awj6Ab3REDnb3qaExur0=;
        b=SlQEgaR+lq0Paorhg41ypFk6uIR3SIOOTKdOBW/EXVcBC/YhIZb+OTDMiEK1rF3V/f
         dWvehCDgaofg5M7IeDZVLvRJoLE2doUlulvzcEql+bw2O4Q09K77VYj1SYk8TlVL76Mu
         R4UMuwRdixZDl8ZDeCsz6nBrufqyjT7jwzc3RUI3Rg+hq7BZwtcWqPQr30uE+BlCCwEq
         DIJH8jiBz84sSoOjMVWDZh9ShQV9Bbejreua03+xXVXWPY9I/mEMU0pOZbdRcOe8AFpf
         vv7njv4ZOBOYgNHBa+sCwydQQZlh7qLMLjgOSqyZMHlDmYfdgceYAzRvidDpjeKh3Gsh
         VIWQ==
X-Gm-Message-State: AA+aEWbZ+5FTwDwUyd2rA2tyzjlL1l8bBe+eKPya9vjDDMIVPdLnpUxN
        g1adoUysHAlimYa+co5spokjuJNLq6E1fw==
X-Google-Smtp-Source: AFSGD/VkAQERmgoJ5BFgUKqcvZh0RhI2QzDOrMXI7lJCrjz2wMs1Pk2cGY4TvO12AYsdAP6DhK8Hfg==
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr16131640ljb.48.1544039201494;
        Wed, 05 Dec 2018 11:46:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:41e8:260c:942a:b736])
        by smtp.googlemail.com with ESMTPSA id u15-v6sm4284096lja.63.2018.12.05.11.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:46:40 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Handle specific unknown packets after firmware loading
Date:   Wed,  5 Dec 2018 20:45:38 +0100
Message-Id: <20181205194538.8074-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The Broadcom controller on aries S5PV210 boards sends out a couple of
unknown packets after the firmware is loaded.  This will cause
logging of errors such as:
	Bluetooth: hci0: Frame reassembly failed (-84)

This is probably also the case with other boards, as there are related
Android userspace patches for custom ROMs such as
https://review.lineageos.org/#/c/LineageOS/android_system_bt/+/142721/
Since this appears to be intended behaviour, treated them as diagnostic
packets.

Note that this is another variant of commit 01d5e44ace8a 
("Bluetooth: hci_bcm: Handle empty packet after firmware loading")

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a0ceb..ae271836dc26 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -51,6 +51,12 @@
 #define BCM_LM_DIAG_PKT 0x07
 #define BCM_LM_DIAG_SIZE 63
 
+#define BCM_UNKNOWN_PKT 0x31
+#define BCM_UNKNOWN_SIZE 0
+
+#define BCM_UNKNOWN2_PKT 0x34
+#define BCM_UNKNOWN2_SIZE 0
+
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
 /**
@@ -561,12 +567,28 @@ static int bcm_setup(struct hci_uart *hu)
 	.lsize = 0, \
 	.maxlen = BCM_NULL_SIZE
 
+#define BCM_RECV_UNKNOWN \
+	.type = BCM_UNKNOWN_PKT, \
+	.hlen = BCM_UNKNOWN_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_UNKNOWN_SIZE
+
+#define BCM_RECV_UNKNOWN2 \
+	.type = BCM_UNKNOWN2_PKT, \
+	.hlen = BCM_UNKNOWN2_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_UNKNOWN2_SIZE
+
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
-	{ H4_RECV_ACL,      .recv = hci_recv_frame },
-	{ H4_RECV_SCO,      .recv = hci_recv_frame },
-	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
-	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
-	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
+	{ H4_RECV_ACL,       .recv = hci_recv_frame },
+	{ H4_RECV_SCO,       .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,     .recv = hci_recv_frame },
+	{ BCM_RECV_LM_DIAG,  .recv = hci_recv_diag  },
+	{ BCM_RECV_NULL,     .recv = hci_recv_diag  },
+	{ BCM_RECV_UNKNOWN,  .recv = hci_recv_diag  },
+	{ BCM_RECV_UNKNOWN2, .recv = hci_recv_diag  },
 };
 
 static int bcm_recv(struct hci_uart *hu, const void *data, int count)
-- 
2.17.1

