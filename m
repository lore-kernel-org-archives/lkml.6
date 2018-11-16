Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79AC07208
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E62086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9E62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbeKQCiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:38:07 -0500
Received: from shell.v3.sk ([90.176.6.54]:57092 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390040AbeKQCiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:38:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B802A531BC;
        Fri, 16 Nov 2018 17:25:00 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zqiRkGA0TpfN; Fri, 16 Nov 2018 17:24:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A877252BCA;
        Fri, 16 Nov 2018 17:24:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GzltHdsBBfvu; Fri, 16 Nov 2018 17:24:20 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 639C252D03;
        Fri, 16 Nov 2018 17:24:17 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 09/17] Platform: OLPC: Use BIT() and GENMASK() for event masks
Date:   Fri, 16 Nov 2018 17:23:55 +0100
Message-Id: <20181116162403.49854-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a cosmetic tidy-up.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- This patch was added to the set.

 include/linux/olpc-ec.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index 7fa3d27f7fee..f7b6a7eda232 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OLPC_EC_H
 #define _LINUX_OLPC_EC_H
=20
+#include <linux/bits.h>
+
 /* XO-1 EC commands */
 #define EC_FIRMWARE_REV			0x08
 #define EC_WRITE_SCI_MASK		0x1b
@@ -17,17 +19,16 @@
 #define EC_EXT_SCI_QUERY		0x85
=20
 /* SCI source values */
-#define EC_SCI_SRC_EMPTY        0x00
-#define EC_SCI_SRC_GAME         0x01
-#define EC_SCI_SRC_BATTERY      0x02
-#define EC_SCI_SRC_BATSOC       0x04
-#define EC_SCI_SRC_BATERR       0x08
-#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
-#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
-#define EC_SCI_SRC_ACPWR        0x40
-#define EC_SCI_SRC_BATCRIT      0x80
-#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
-#define EC_SCI_SRC_ALL          0x1FF
+#define EC_SCI_SRC_GAME         BIT(0)
+#define EC_SCI_SRC_BATTERY      BIT(1)
+#define EC_SCI_SRC_BATSOC       BIT(2)
+#define EC_SCI_SRC_BATERR       BIT(3)
+#define EC_SCI_SRC_EBOOK        BIT(4)    /* XO-1 only */
+#define EC_SCI_SRC_WLAN         BIT(5)    /* XO-1 only */
+#define EC_SCI_SRC_ACPWR        BIT(6)
+#define EC_SCI_SRC_BATCRIT      BIT(7)
+#define EC_SCI_SRC_GPWAKE       BIT(8)   /* XO-1.5 only */
+#define EC_SCI_SRC_ALL          GENMASK(8, 0)
=20
 struct platform_device;
=20
--=20
2.19.1

