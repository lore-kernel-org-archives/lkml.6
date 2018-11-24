Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F1D20881
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="VT5ukN8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F1D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeKYGzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:55:53 -0500
Received: from onstation.org ([52.200.56.107]:42422 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYGzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:55:53 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6D1962E4;
        Sat, 24 Nov 2018 20:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543090002;
        bh=MPdfZHj9sdY9mICSPGCOhgnMYH6JbIF51iauhh6x474=;
        h=From:To:Cc:Subject:Date:From;
        b=VT5ukN8ixYvLkJWoafPMkscH5gHgV0vaSutIedZMqQTOXn+kfUiREXWvjy/7lVJzR
         J1Siq/9jhb6CPFSs5cWOXznK094xc3rtcc5njRpb/3hF5Bqu8xGqNVR949Hyv5jWIp
         Yidf2D3Ye8CmltlHTOqPY2y9523QlyofXHCAIEqU=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH 1/2] dt-bindings: drm/panel: simple: add lg,acx467akm-7 panel
Date:   Sat, 24 Nov 2018 15:06:27 -0500
Message-Id: <20181124200628.24393-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the LG ACX467AKM-7 4.95" 1080×1920 LCD panel that is
found on the LG Nexus 5 (hammerhead) phone. This appears to be a JDI
panel based on some Internet searches, however a specific model number
could not be found. I disassembled an old Nexus 5 with a broken
screen and the LG part number is the only model number present on the
back of the panel, so I think that is probably the best ID to use.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../devicetree/bindings/display/panel/lg,acx467akm-7.txt   | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt b/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
new file mode 100644
index 000000000000..fc1e1b325e49
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
@@ -0,0 +1,7 @@
+LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
+
+Required properties:
+- compatible: must be "lg,acx467akm-7"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.17.2

