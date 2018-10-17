Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD64ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7D42145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddhw3KSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7D42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJRGZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:25:04 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:50445 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJRGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:25:04 -0400
Received: by mail-ot1-f73.google.com with SMTP id m91so15456396otc.17
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=Y3dOOoJ3k1/pt/2HO0ztXr3ZxTEqnAXn7l1xFrknVgw=;
        b=ddhw3KSS1y5kiwUCrxcc/gPSedSWZ5YAPlcbWsQ8dG0PQaKyF7s/GHnq432VdkNiYa
         YBIqLMTdhmKcMLDVnfSyLYr+pgynNAoswfVGNvbKh246/b42znnOwgToka3y66CqKQVS
         rz6OMfff1PcHjWezBksDi4nFxRA/+pj8zYhKKSg9mmsHLktb5cUX2nxb5D7DqB2ey2Ip
         k8ukAyWI95xeU73s7HKdkmZ10Vds2N90FUO93eIV6++rjDAYJnhTluuFdrt7rlSdHgpY
         JSF+NZrKCsJfYeNWGET4s75CtVmscuDnUrwSztaD330O/CKSvjbueQnBEmmRTt6VhZTL
         SBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=Y3dOOoJ3k1/pt/2HO0ztXr3ZxTEqnAXn7l1xFrknVgw=;
        b=hoHsKMfx03CpXfsoRxrA1606ctxlU3exe4WDZkPfYjQDqpTCVzNFvXA/fhskg5s7F9
         XpwXmkjs4RO07ljNXoULJLEvDmm/WNRXyhlrxxZBPAuPc7vdb+1IAzjFs3CNbXFcLPsy
         G9p4l1tQmR9Q/Y+j2P4qfvbB9iuGsQnOXQdpl/tEgDkOtgR+JLkINbnemG3jDjIAEf6+
         H8H4pShcxZR9zRH+yel2mQlXJMSE4IHfhO4ZV+aD3jvuSyJltY8pLmL70IvzAUPgaZ79
         g+KAxg2oCm3szEZ7DsoOv3xKt80G8rBS5yp9THoWMk9eL/ZYKQgFiDH7D9r60UaMVnB6
         rkzw==
X-Gm-Message-State: ABuFfojn5I8jMPjb9CTsarvzn5c/SnlkGdWOc3K22Csrddhq9Xs/Lkve
        EmHNSPPyzNuF564VEXQ/tAxQ15zbyA==
X-Google-Smtp-Source: ACcGV62Oo+q7GwylrMubYABFZdqNKgCCqLgaZV+JF5xgx5JVeNHyDG9uJsNW/FCuyUSJvo5Q9MrKjZHjxw==
X-Received: by 2002:a9d:5b74:: with SMTP id e49mr21433135otj.56.1539815238695;
 Wed, 17 Oct 2018 15:27:18 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:27:09 -0700
Message-Id: <20181017222710.254994-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v3 2/2] dt-bindings: hwmon: Add adm127x documentation
From:   Kun Yi <kunyi@google.com>
Cc:     openbmc@lists.ozlabs.org, kunyi@google.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adm127x are hot-swap controllers that allow a circuit board to be removed from
or inserted into a live backplane. This patch adds the device tree
bindings documentation.

Signed-off-by: Kun Yi <kunyi@google.com>
---
 .../devicetree/bindings/hwmon/adm1275.txt     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt

diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
new file mode 100644
index 000000000000..1ecd03f3da4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
@@ -0,0 +1,25 @@
+adm1275 properties
+
+Required properties:
+- compatible: Must be one of the supported compatible strings:
+	- "adi,adm1075" for adm1075
+	- "adi,adm1272" for adm1272
+	- "adi,adm1275" for adm1275
+	- "adi,adm1276" for adm1276
+	- "adi,adm1278" for adm1278
+	- "adi,adm1293" for adm1293
+	- "adi,adm1294" for adm1294
+- reg: I2C address
+
+Optional properties:
+
+- shunt-resistor-micro-ohms
+	Shunt resistor value in micro-Ohm
+
+Example:
+
+adm1272@10 {
+	compatible = "adi,adm1272";
+	reg = <0x10>;
+	shunt-resistor-micro-ohms = <500>;
+};
-- 
2.19.1.331.ge82ca0e54c-goog

