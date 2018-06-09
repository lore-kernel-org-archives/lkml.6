Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ewVgFAJSHFuoMAAAmS7hNA
	; Sat, 09 Jun 2018 22:18:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 06816607E4; Sat,  9 Jun 2018 22:18:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hu+tK8F+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxMIy2yL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 751026074D;
	Sat,  9 Jun 2018 22:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 751026074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=fastmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeFIWSp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:18:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59229 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753408AbeFIWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:18:43 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DE1521AF1;
        Sat,  9 Jun 2018 18:18:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 09 Jun 2018 18:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=QxiVZ8Aj8dmtiP/T/coD9WlHU+tkSgYVh6doGw5DV
        D8=; b=Hu+tK8F+JlylwOyYuJrF0aB2Y2tORT3BcOpo1Xd/QvViiKr/EvWa8LoRS
        rGLO5GAb4WBWsVFjvAFtSUo4xG4nWXXO2XM1qSvi6mY1l7KrnEB/xv41bvBvBdMC
        l2MJ0YxnECLb3dUQaNU+T1KpIB6VaUKuRbmsOjmm+KCte9T0OMmo2AURsb1dLDYQ
        nG7IiRbhmPvocKC3IPODxdKDerIH5g3VRmzu7A50DkMxA9w81HYfDm+xVKvWllov
        QH5pNMKFe+zIRqHpaxy49DPkIgxDlygST3Cr+GOWHd9VStBI4yKtw1MUyDnqsQ0m
        7hFL/XhVSc5fU8tlEFN4ihP1JtEbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QxiVZ8Aj8dmtiP/T/
        coD9WlHU+tkSgYVh6doGw5DVD8=; b=NxMIy2yLe5fGVE/tZKYLaXszxFhqHsvGA
        GoA03YQzeDGbgxSnQZKa2KDE3tQMPA2m4GF4KSTj6Z8avExrVFd3Df1iqWpipUma
        qtrWd4F9IDoy8SoKuJNvfBhEDN+/SizFR+NO2iA5gajEk4TauynVYkTDC4ezNPRE
        mG4prq5zRfKkLo7KvekG/D8NdF8sU+jOGgDwcjRH+Gm4n57ZxEvgV9gioIGhGHcU
        cF6GI9yM264QMoFbqCfjPJojPlUYJOJIwhw6Nef21IAFkq4SXgGXKxkUo2qk6SXn
        YbCYOcs46iAGUnuHCjOBThsLwS2b94WSzWTBSGbyD2i8NZIKYwaZA==
X-ME-Proxy: <xmx:QFIcW7f_ZnTh3TuBp8-Lm8wUYeb7DhdenjGKSELCVs7FxPJ7zxyUNQ>
X-ME-Proxy: <xmx:QFIcW6RAvOECAWUS1Z1MBQOnjDkzljkrSSCSk4ODDaKfVTpJyl21Vw>
X-ME-Proxy: <xmx:QFIcW9k61xKiOPc2e8tGnSZ-ITHob02y9_AiDBstlk6AUFYmqKFnLA>
X-ME-Proxy: <xmx:QFIcW4uDcfODRCBFE1i1DYTcIFdv0aDkqFN4jqwORlZh1rjkUdDMjw>
X-ME-Proxy: <xmx:QFIcWw_rf8iN7DLOwkX9AH3lAOhT3FkbqJA2rGV0slaSdgaCGlHOvA>
X-ME-Proxy: <xmx:QFIcW-KFcxZhdOslcW4AP5JRuYO3whPdHYdwRtJ77IT_YQ2S18_vbQ>
X-ME-Sender: <xms:QFIcW1HTZAWDvI8LY7BZcXoQxDUmzHM32ML2aNj6XttRAFwjHcKKpA>
Received: from blackbeard.lan (pool-108-18-105-9.washdc.fios.verizon.net [108.18.105.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id EE89910255;
        Sat,  9 Jun 2018 18:18:39 -0400 (EDT)
From: Tristian Celestin <tristiancelestin@fastmail.com>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristian Celestin <tristiancelestin@fastmail.com>
Subject: [PATCH] acpi/x86: enable touchscreen on Dell Venue Pro 7139
Date: Sat,  9 Jun 2018 18:18:06 -0400
Message-Id: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permanently enable the SYNA7500 touchscreen device on the Dell
Venue Pro 7139. The DSDT hides the touchscreen ACPI device on
the 7139 in the same fashion as the 7130, and needs to
be enabled in the same way.

Signed-off-by: Tristian Celestin <tristiancelestin@fastmail.com>
---
 drivers/acpi/x86/utils.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index ec5b0f1..3a13b2a 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -62,14 +62,20 @@ struct always_present_id {
 	 */
 	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
 	/*
-	 * On the Dell Venue 11 Pro 7130 the DSDT hides the touchscreen ACPI
-	 * device until a certain time after _SB.PCI0.GFX0.LCD.LCD1._ON gets
-	 * called has passed *and* _STA has been called at least 3 times since.
+	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
+	 * the touchscreen ACPI device until a certain time
+	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
+	 * *and* _STA has been called at least 3 times since.
 	 */
 	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
+	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
+	      }),
+
 	/*
 	 * The GPD win BIOS dated 20170221 has disabled the accelerometer, the
 	 * drivers sometimes cause crashes under Windows and this is how the
-- 
1.8.3.1
