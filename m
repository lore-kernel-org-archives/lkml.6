Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F472184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tszlL8CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeLSLWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:22:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37238 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeLSLWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:22:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so5051821ljd.4;
        Wed, 19 Dec 2018 03:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wvv+6h2xtQTAcq6rLgBPG7RS7nGtHtlwnBYaaXULXbE=;
        b=tszlL8CNHq0+X/RzT8xpY3BDKwCx7nsuPmL3gBIwM0FaWQ7G4AN2GeADPO3u5M10WM
         i6LMfhoglti5gGuksAZHifcSOYN+w1MCIb+XxdemFunJLxWkvI5r/upujazENE53xcX8
         9/YBIWMddHLOIXNH0dnO9TFoVt5xMEjHXSltV1n4gyPudG/e/0+sAuW7RYUEfoIMGH7y
         UCgGMERlS5ozpmNIOLIyU+Jsj7PdN+NlBtP2qzGAn75S2jedrYIINdrJyx2NwAS27pV0
         3Ftv+xDBRr3/QmkgWzxV0ddTwcLHsEYjTQ9lUp79tV65VOMsHH9aN4Gyu9oQWx2oJ5d1
         ZPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wvv+6h2xtQTAcq6rLgBPG7RS7nGtHtlwnBYaaXULXbE=;
        b=aonNWr1XOxMKieq1f/niBe9wl5E055WRDYBTMJHOqXm2MsDLpOlVo6gbtdUpiuD5LI
         Ze/ZUqwizzgZHukaNt6SDUfG5HrElQqANA2fpWoGMRlQgVfzny4Bdh4QjB3mDR8pePM4
         KEgwvgpm48P66YLJVHqvX8ZVXUtSLakis8u936YAPurJ4HsRIgERxYBVOLXHtu81dZNH
         h1fHr4TMkq+skEbUyH3OmEkkel4WLZAizw/Qvk1WQX/ZWpJGfVNGtvZ7Fw09UXW8mM48
         2kdQ50P989MD5F2BIFKbb8s5uwsdIXdTJidD6PwPLnnuUbYb7d0+Q5oIu2Z4TMVsy4ZU
         ZPaQ==
X-Gm-Message-State: AA+aEWbe4cJV5bStNBVXdbL+FwBdAPjK/ZSLc5RSNdzu9vwE9D5Iuxk+
        4/N9DTa9JwzA+lCMzXxsgPM=
X-Google-Smtp-Source: AFSGD/UHQGFkMW8f6kiY++/Hd17vxhcJVetVe7aAvf5UoHWI0/+sn6LtJZwvyfq+wvj4NIRGPdJcaQ==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr11991322ljg.164.1545218556376;
        Wed, 19 Dec 2018 03:22:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:e05f:a77f:eff8:4ba])
        by smtp.googlemail.com with ESMTPSA id y11-v6sm3522548ljc.85.2018.12.19.03.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 03:22:35 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3] Bluetooth: hci_bcm: Handle specific unknown packets after firmware loading
Date:   Wed, 19 Dec 2018 12:22:28 +0100
Message-Id: <20181219112228.9735-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v2:
   - Rebased against latest bluetooth-next tree

Changes from v1:
   - Rename UNKNOWN to TYPE49
   - Rename UNKNOWN2 to TYPE52
---
 drivers/bluetooth/hci_bcm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index a5cb580a07de..ddbe518c3e5b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -52,6 +52,12 @@
 #define BCM_LM_DIAG_PKT 0x07
 #define BCM_LM_DIAG_SIZE 63
 
+#define BCM_TYPE49_PKT 0x31
+#define BCM_TYPE49_SIZE 0
+
+#define BCM_TYPE52_PKT 0x34
+#define BCM_TYPE52_SIZE 0
+
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
 #define BCM_NUM_SUPPLIES 2
@@ -595,12 +601,28 @@ static int bcm_setup(struct hci_uart *hu)
 	.lsize = 0, \
 	.maxlen = BCM_NULL_SIZE
 
+#define BCM_RECV_TYPE49 \
+	.type = BCM_TYPE49_PKT, \
+	.hlen = BCM_TYPE49_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_TYPE49_SIZE
+
+#define BCM_RECV_TYPE52 \
+	.type = BCM_TYPE52_PKT, \
+	.hlen = BCM_TYPE52_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_TYPE52_SIZE
+
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ H4_RECV_ACL,      .recv = hci_recv_frame },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
 	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
 	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
+	{ BCM_RECV_TYPE49,  .recv = hci_recv_diag  },
+	{ BCM_RECV_TYPE52,  .recv = hci_recv_diag  },
 };
 
 static int bcm_recv(struct hci_uart *hu, const void *data, int count)
-- 
2.17.1

