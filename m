Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D70C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6DE2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6DE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emtrion.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757136AbeFSKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:01:59 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:15925 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756533AbeFSKBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:01:41 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 06:01:37 EDT
Received: from tuelinux-v3.emtrion.local (2003:5a:a012:1:7eac:eac5:fc1b:7f56)
 by bmk019s01.emtrion.local (2003:5a:a012:1:d9c:d045:28a7:5f84) with Microsoft
 SMTP Server (TLS) id 8.3.485.1; Tue, 19 Jun 2018 11:56:08 +0200
From:   <jan.tuerk@emtrion.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: display: Document the EDT et* displays in one file.
Date:   Tue, 19 Jun 2018 11:55:43 +0200
Message-ID: <20180619095546.24445-1-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180427132445.3458-2-jan.tuerk@emtrion.com>
References: <20180427132445.3458-2-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23916.005
X-TM-AS-Result: No--10.688400-8.000000-31
X-TM-AS-MatchedID: 705441-700378-702796-702311-701475-703523-188019-700016-7
        03529-704410-847575-700454-704425-700324-702900-704568-702890-712124-711139
        -702762-139504-148004-148036-42000-42003-55
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Document the Emerging Display Technology Corp. (EDT) using the
simple-panel binding in one single file.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 .../bindings/display/panel/edt,et-series.txt  | 39 +++++++++++++++++++
 .../display/panel/edt,et057090dhu.txt         |  7 ----
 .../display/panel/edt,et070080dh6.txt         | 10 -----
 .../display/panel/edt,etm0700g0dh6.txt        | 10 -----
 4 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt

[Changes from v4 of emCON patch-series] 
 - rebased to mainline/master
 - split as requested by Shawn Guo

As requested by Sha

diff --git a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
new file mode 100644
index 000000000000..f56b99ebd9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
@@ -0,0 +1,39 @@
+Emerging Display Technology Corp. Displays
+==========================================
+
+
+Display bindings for EDT Display Technology Corp. Displays which are
+compatible with the simple-panel binding, which is specified in
+simple-panel.txt
+
+
+5,7" WVGA TFT Panels
+--------------------
+
++-----------------+---------------------+-------------------------------------+
+| Identifier      | compatbile          | description                         |
++=================+=====================+=====================================+
+| ET057090DHU     | edt,et057090dhu     | 5.7" VGA TFT LCD panel              |
++-----------------+---------------------+-------------------------------------+
+
+
+7,0" WVGA TFT Panels
+--------------------
+
++-----------------+---------------------+-------------------------------------+
+| Identifier      | compatbile          | description                         |
++=================+=====================+=====================================+
+| ETM0700G0DH6    | edt,etm070080dh6    | WVGA TFT Display with capacitive    |
+|                 |                     | Touchscreen                         |
++-----------------+---------------------+-------------------------------------+
+| ETM0700G0BDH6   | edt,etm070080bdh6   | Same as ETM0700G0DH6 but with       |
+|                 |                     | inverted pixel clock.               |
++-----------------+---------------------+-------------------------------------+
+| ETM0700G0EDH6   | edt,etm070080edh6   | Same display as the ETM0700G0BDH6,  |
+|                 |                     | but with changed Hardware for the   |
+|                 |                     | backlight and the touch interface   |
++-----------------+---------------------+-------------------------------------+
+| ET070080DH6     | edt,etm070080dh6    | Same timings as the ETM0700G0DH6,   |
+|                 |                     | but with resistive touch.           |
++-----------------+---------------------+-------------------------------------+
+
diff --git a/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt b/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
deleted file mode 100644
index 4903d7b1d947..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,et057090dhu"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt b/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
deleted file mode 100644
index 20cb38e836e4..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Emerging Display Technology Corp. ET070080DH6 7.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,et070080dh6"
-
-This panel is the same as ETM0700G0DH6 except for the touchscreen.
-ET070080DH6 is the model with resistive touch.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
deleted file mode 100644
index ee4b18053e40..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Emerging Display Technology Corp. ETM0700G0DH6 7.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,etm0700g0dh6"
-
-This panel is the same as ET070080DH6 except for the touchscreen.
-ETM0700G0DH6 is the model with capacitive multitouch.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-- 
2.17.1

