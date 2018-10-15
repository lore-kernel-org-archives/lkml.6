Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A67C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D877520652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoFoG0z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D877520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJOIJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:09:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46872 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:09:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so8387532plz.13;
        Sun, 14 Oct 2018 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1eIq+bpAJjW92EtiaqYATBx5CfeVYNbB6/35CF3TsEg=;
        b=LoFoG0z4djWfCNWrmlTfkOJ8gI3cf0TUCAFw5Ul6YGRCTrmapvDPGir/nsVK0/68+o
         vdipEEeCp9Yh83lLDvN0ccG+nu7bk3zBjY5ZxOyDhsOUN57h6HAJ20dtfmoRP1LjqeKz
         wQJdgi4L6aF57vqe/JG0FnaZYt4C7gXR6B4S17D/MVIZl7g4PcywhZwx9NmnlWwoRyJT
         pHh7bgr1txoXhPrgehFjL78ihE1LraMbOg7XLbTJ93LZGRFe2jSJqUxNnnbZDqAUmHS7
         e0X3JHMd5V6uEaWh5XXWk+kDSzxcey7doBAAkwmrZarDZI5JfwS72DyQ+8CPqS0G0NB/
         6F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1eIq+bpAJjW92EtiaqYATBx5CfeVYNbB6/35CF3TsEg=;
        b=UeBNW+jQQ8D7ZfxrKUxj/5Vzxc8b+8lLx6EH92kPr0tddoWZjomcvNiHz1hkYWrlPM
         1NFhC9NpIrG7CRbBsihlq3WA/vYK5keiyi6Owsc5GBRFpLc4OGgznna4C3VDzR+z2oDr
         tgAPH8V9rrbrv3FPP+2brGTcaGyJl5m2deGop18u4lPsQGHjR3d1EiMjUqk/ifmq39cr
         LG/M7OAflFjXGDkH9RgF+Zwauy3cPKIUAql93W1MtzbYsk2ZZBt/jD+Lkk2w4Pak4yGj
         QURtenP0dVYOF/y+/HNvcYcbBWf3LeXNNX5Uw0Ea/bppXXKw/pzfZB/+SxYeuIApP5o3
         NfyA==
X-Gm-Message-State: ABuFfoiucUSfO2cscWb8MZ+FuElGy6KJ7OxjZyKO2O+pURR7wnHi2hNE
        uuTFcKSP/hl+kL50peJd3rE=
X-Google-Smtp-Source: ACcGV618xE1lA4L3Mkze3dqIWBO1N64nQOACIO4CENbAMUAOYN+yUSXwAlElTjtEzf+S9SOmQzgvRg==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3-v6mr15376728plt.125.1539563173692;
        Sun, 14 Oct 2018 17:26:13 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:13 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 11/18] of: overlay: test case of two fragments adding same node
Date:   Sun, 14 Oct 2018 17:24:23 -0700
Message-Id: <1539563070-12969-12-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Multiple overlay fragments adding or deleting the same node is not
supported.  An attempt to do so results in an incorrect devicetree.
The node name will be munged for the second add.

After adding this patch, the unittest messages will show:

   Duplicate name in motor-1, renamed to "controller#1"
   OF: overlay: of_overlay_apply() err=0
   ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
   ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed

   ...

   ### dt-test ### end of unittest - 210 passed, 1 failed

The incorrect (munged) node name "controller#1" can be seen in the
/proc filesystem:

   $ pwd
   /proc/device-tree/testcase-data-2/substation@100/motor-1
   $ ls
   compatible    controller    controller#1  name          phandle       spin
   $ ls controller
   power_bus
   $ ls controller#1
   power_bus_emergency

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest-data/Makefile                  |  1 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  | 28 ++++++++++++++++++++++
 drivers/of/unittest.c                              |  5 ++++
 3 files changed, 34 insertions(+)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 013d85e694c6..166dbdbfd1c5 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_12.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
+			    overlay_bad_add_dup_node.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_node.dts b/drivers/of/unittest-data/overlay_bad_add_dup_node.dts
new file mode 100644
index 000000000000..145dfc3b1024
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_bad_add_dup_node.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/*
+ * &electric_1/motor-1 and &spin_ctrl_1 are the same node:
+ *   /testcase-data-2/substation@100/motor-1
+ *
+ * Thus the new node "controller" in each fragment will
+ * result in an attempt to add the same node twice.
+ * This will result in an error and the overlay apply
+ * will fail.
+ */
+
+&electric_1 {
+
+	motor-1 {
+		controller {
+			power_bus = < 0x1 0x2 >;
+		};
+	};
+};
+
+&spin_ctrl_1 {
+		controller {
+			power_bus_emergency = < 0x101 0x102 >;
+		};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 722537e14848..471b8eb6e842 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2147,6 +2147,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_12);
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
+OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
@@ -2169,6 +2170,7 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_12, 0),
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
+	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	{}
@@ -2413,6 +2415,9 @@ static __init void of_unittest_overlay_high_level(void)
 	unittest(overlay_data_apply("overlay", NULL),
 		 "Adding overlay 'overlay' failed\n");
 
+	unittest(overlay_data_apply("overlay_bad_add_dup_node", NULL),
+		 "Adding overlay 'overlay_bad_add_dup_node' failed\n");
+
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
-- 
Frank Rowand <frank.rowand@sony.com>

