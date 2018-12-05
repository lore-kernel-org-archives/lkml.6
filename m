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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1A5213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYw2/cp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1A5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeLEVWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:22:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44816 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeLEVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:22:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so15828789lfe.11;
        Wed, 05 Dec 2018 13:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bb6R0lNoDRSvcSJTAtlwAlkyhi3D9kGRzDB5MlzRjH4=;
        b=TYw2/cp4jzFaT/WfGTmdO4FZdniKNLmYLKf9cKek2QH2STtwKAh/N9e6cJOC7Q4AOG
         /hy0LjwmYTZeOzdaAmEJcHHFPtTUWMiTrojEdy3vamlyTubz7631qXamm4Ta7UarTVg7
         3FTA3sTw5cmk7kj0eke/Pior5gmq4KkkuU/YyHjLc4tTVHBGfl2Uwr5W3SbRsImRWBXE
         14/6DjMUfxN2l7lUgyoRJuVcuWw67HAR5ZuV8WId/CKGd7Tl36y/ZyZ0ormvi6tW461x
         a1/c3VlLaRRAysQWLad0oY7DJ4/F09Dc+JklARAxTDgv1MrrHXpRfP3CL2dKOXexZiru
         0ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bb6R0lNoDRSvcSJTAtlwAlkyhi3D9kGRzDB5MlzRjH4=;
        b=WgbsjN5Xzk5R2qzwcoUNebkhRaMRifX1yMelvukVKaS1bYWgFbzIFZfBAZ9dLxg5wt
         LNNdBHdcEMGdiPU3Hl/HLCClbFVnSaSRzNp2VVTTb15klKjbqLKJg5tdlCHOyFfB0LdG
         /7lVl4Dn9ijjwPvFIMO3rPDPAz7HhqTijpkgYJAdlO0fEFPywKOI10UsVQvl1oqIwrvz
         FJJ/ZU8nEx+TfkSWip+Qdg+vDZCgC+HahuOySs+73YpESyM+OtC2FBBMrni9b/exmyg1
         Fe4m0nlXfxDnbd7JDwkz6BCs9Kne4AbOzjDJ7gq3WSr5a6JCqTuIdmfu+cNd4JSQgY2r
         8VyQ==
X-Gm-Message-State: AA+aEWa99CYmFA/SBODvvCECg7WtVCgAh09yVXXBOns8Ps354aIuAcER
        OqeHa4Xd1AEfSE4v3sWTPpQ=
X-Google-Smtp-Source: AFSGD/XNQKdAlBogG98EMGmKZ4+qSosfnbAF1jlp9ldiqeCuAH6GrBhFKUwQi1iYRaDZ/lCAIeWv8A==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr16070856lfa.32.1544044968182;
        Wed, 05 Dec 2018 13:22:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:41e8:260c:942a:b736])
        by smtp.googlemail.com with ESMTPSA id g66sm3843444lfe.42.2018.12.05.13.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:22:47 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_bcm: Handle specific unknown packets after firmware loading
Date:   Wed,  5 Dec 2018 22:22:32 +0100
Message-Id: <20181205212232.3947-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v1:
	- Rename UNKNOWN to TYPE49
	- Rename UNKNOWN2 to TYPE52
---
 drivers/bluetooth/hci_bcm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a0ceb..7e7a2cfb2f93 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -51,6 +51,12 @@
 #define BCM_LM_DIAG_PKT 0x07
 #define BCM_LM_DIAG_SIZE 63
 
+#define BCM_TYPE49_PKT 0x31
+#define BCM_TYPE49_SIZE 0
+
+#define BCM_TYPE52_PKT 0x34
+#define BCM_TYPE52_SIZE 0
+
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
 /**
@@ -561,12 +567,28 @@ static int bcm_setup(struct hci_uart *hu)
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

