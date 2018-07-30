Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC4FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4C620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="fSoU42K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4C620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeGaAtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:49:09 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55766 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbeGaAs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:48:56 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id F3EFAB00AC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:11:39 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532992299; x=1533856300; bh=pB
        0QxR6Mq0Y0Qc5m5invDwx1Zcet/ooIHAQUIw+LPaI=; b=fSoU42K/aOrXQnjbFR
        +0HF/FTNjaiVpGB4VQmm+zkVJUupfOYfdrOY4YFwFtbHJ2jQQrwGkw/qrDp84dL4
        LZh7+yw+dlleNBh/e7LPBNhsXvlOlS9zxEic/Jw3oIS9iia9Wh45rjk5i5VM55Tk
        jFSv6+w4m9LG/sD081OjwfkAY=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2-ALXV7YoSeq for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jul 2018 01:11:39 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id AF74CB0038A;
        Tue, 31 Jul 2018 01:11:35 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 3/5] dt-bindings: Add CDTech S070WV95-CT16 panel bindings
Date:   Tue, 31 Jul 2018 01:11:15 +0200
Message-Id: <20180730231117.5631-4-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for S070WV95-CT16 panel

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../bindings/display/panel/cdtech,s070wv95-ct16.txt  | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt

diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
new file mode 100644
index 000000000000..505615dfa0df
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
@@ -0,0 +1,12 @@
+CDTech(H.K.) Electronics Limited 7" 800x480 color TFT-LCD panel
+
+Required properties:
+- compatible: should be "cdtech,s070wv95-ct16"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.17.1

