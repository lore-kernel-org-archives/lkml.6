Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE15C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC64216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuajaJvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC64216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHOB1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:27:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42095 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbeHOB1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:27:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so9878258pff.9;
        Tue, 14 Aug 2018 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQyQ6AmHQWYN4xS2QhlHOblSHuntwiGA/VJq5hmO1sM=;
        b=HuajaJvrbVe2EwHow/DMfUlWQLEJJVDmroJiuNnKiWNC7mPezXpjhXArVar1BULACK
         2qjF6VGCmZdES0rKPvNwGKniJVa3UkUg69G7l0/3DsLLEexR7/H+JYtMEjw3FOg40ceF
         afrMuLSIdYX7iEhVOQndo1xjMJBAT4bTQSKONrObvc+3J7DIwtS8QtpEJJ8dXij5NiLr
         Eop+Md0DisDBYFlCHU4WCs1m544CfOGHGg/pE3QAXVls3IrAowC9CIhSJVERGK2euFb/
         KOY34wTfH04pB70zOGbKQqZ61bg+hKa06crAjg+s9zod4TyjggvNM01BXNhfcprFI1FB
         6JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQyQ6AmHQWYN4xS2QhlHOblSHuntwiGA/VJq5hmO1sM=;
        b=jGxgfYZKJ2iJlQ9RqH8ON+rC2MV9w1q4x/cnYdbr1WnZWJYatRtw3Bs7cCc9M7t5rl
         t30sqMjU7MwyR36mAr0HkZ9/8nn4t0EB8+UUyf75/p+YyjqUxLPBWldpXUiXVNrYILNh
         +MGO/Ho3bSbA/7m5G0MOKTPh4/Dt1VB/cKkhnezFBcrMmeSfPjVpc+jREyFgVgqJSWib
         Zh1WBvCuYMdDfuI5JEQ8vEoHOfjcuVASZQG1vG4wBzQZ8Lk+MllBn8UAHPsWqkK1FGl9
         Iel2CjEl9VzVPE0Glzyu/TNMs5BcFVmxlqPetndxpHHCw8CnUqNmEZlDp3uL15sLVO6j
         /AEA==
X-Gm-Message-State: AOUpUlG2U5qAx6iQRCpUXuiJ/a1psMUixMysEtBDcZcYvgdt7fRmwQ4y
        CllGJzgDBAAzWdkiLe+U/6qdNNbz
X-Google-Smtp-Source: AA+uWPyHr6woUqZXbqKthDGa7nhpt+XyB4C5H1T1stEObgyk5OnIJBk9MfqK32F5iRmixMvWNcNeSw==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr22609662pgd.326.1534286306345;
        Tue, 14 Aug 2018 15:38:26 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id e126-v6sm48420948pfg.31.2018.08.14.15.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 15:38:25 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
X-Google-Original-From: Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH v1 1/3] dt-bindings: net: Add 'mac-address-lookup' property
Date:   Tue, 14 Aug 2018 15:37:56 -0700
Message-Id: <20180814223758.117433-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814223758.117433-1-briannorris@chromium.org>
References: <20180814223758.117433-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some firmwares present data tables that can be parsed to retrieve
device-specific details, like MAC addresses. While in some cases, one
could teach the firmware to understand the device tree format and insert
a 'mac-address'/'local-mac-address' property into the FDT on its own,
this method can be brittle (e.g., involving memorizing expected FDT
structure), and it's not strictly necessary -- especially when parsers
for such firmware formats are already needed in the OS for other
reasons.

One such format: the Vital Product Data (VPD) [1] used by Coreboot. It
supports a table of key/value pairs, and some systems keep MAC addresses
there in a well-known format. Allow a device tree to specify
  (1) that the MAC address for a given device is stored in the VPD table
      and
  (2) what key should be used to retrieve the MAC address for said
      device (e.g., "ethernet_mac0" or "wifi_mac1").

[1] Ref:
https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
TL;DR: VPD consists of a TLV-like table, with key/value pairs of
strings. This is often stored persistently on the boot flash and
presented via in-memory Coreboot tables, for the operating system to
read.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/net/ethernet.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
index cfc376bc977a..d3fd1da18bf4 100644
--- a/Documentation/devicetree/bindings/net/ethernet.txt
+++ b/Documentation/devicetree/bindings/net/ethernet.txt
@@ -4,6 +4,18 @@ NOTE: All 'phy*' properties documented below are Ethernet specific. For the
 generic PHY 'phys' property, see
 Documentation/devicetree/bindings/phy/phy-bindings.txt.
 
+- mac-address-lookup: string, indicating a method by which a MAC address may be
+  discovered for this device. Methods may be parameterized by some value, such
+  that the method can determine the device's MAC address using that parameter.
+  For example, a firmware might store MAC addresses in a table, keyed by some
+  predetermined string, and baked in read-only flash. A lookup method "foo"
+  with a parameter "bar" should be written "foo:bar".
+  Supported values for method:
+    "google-vpd" - Google's Vital Product Data (VPD), as used in the Coreboot
+      project. Documentation for VPD can be found at:
+        https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
+  Example:
+    mac-address-lookup = "google-vpd:ethernet_mac0"
 - local-mac-address: array of 6 bytes, specifies the MAC address that was
   assigned to the network device;
 - mac-address: array of 6 bytes, specifies the MAC address that was last used by
-- 
2.18.0.865.gffc8e1a3cd6-goog

