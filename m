Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50328C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F284204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F284204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbeJAWD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:03:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37226 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbeJAWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:03:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so10647192oib.4;
        Mon, 01 Oct 2018 08:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FWWpu/rZ73LHeaOx/3FicCXTVC+bW2dp+6ooQF6mKYw=;
        b=jwjlEUlqHfknZcmVHX/gng2XsekZOCF9s/XbXupNkqADUcqahX2UI/83T2BCXbJSHm
         lPDL39Z6GVq2S7Z/QxNqnqkQBTEJlcReLXsosyVXhal3VK1zLcMSuS++yeMIzjK4pmiM
         /5AVjWLK2kp4Tgq6afxTETfdIkKElsqs6uSCEwFWH9QlTAgIPvFwQQisMzxhXLUqNQhj
         Iev+j3/tlvOJSEU5zDsqvotyXV6HI+BuSrPkA60M6VyTIXTwp/NGU3GHLlojKB/02lkc
         kA3aes1SAl/+zF0eFq8SJh88lIRB79uZMHkmGRsbugm4UBr7FA+NUm1JIgZbyzVhbpH8
         Rw4Q==
X-Gm-Message-State: ABuFfoiJ3Rl4dPLcDrf0EyrnH3tWwgGtAYNDFMwY0nZp/M4tVwVb/3bo
        A3BVl2/XvqYAUS6Mcy0SVbUexLGwQQ==
X-Google-Smtp-Source: ACcGV62NVodNcvdZf90LxLWkmhNPWI3dt4389aHyTCPNcc0m3NCdlrr29CfZn43Pa9u81oU1uOqbwA==
X-Received: by 2002:aca:e64b:: with SMTP id d72-v6mr2505124oih.314.1538407536522;
        Mon, 01 Oct 2018 08:25:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v4 2/9] nios2: build .dtb files in dts directory
Date:   Mon,  1 Oct 2018 10:25:24 -0500
Message-Id: <20181001152531.3385-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align nios2 with other architectures which build the dtb files in the
same directory as the dts files. This is also in line with most other
build targets which are located in the same directory as the source.
This move will help enable the 'dtbs' target which builds all the dtbs
regardless of kernel config.

This transition could break some scripts if they expect dtb files in
the old location.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/nios2/Makefile          | 4 ++--
 arch/nios2/boot/Makefile     | 4 ----
 arch/nios2/boot/dts/Makefile | 1 +
 3 files changed, 3 insertions(+), 6 deletions(-)
 create mode 100644 arch/nios2/boot/dts/Makefile

diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index 8673a79dca9c..50eece1c6adb 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -59,10 +59,10 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(nios2-boot)
 
 %.dtb: | scripts
-	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
+	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
 
 dtbs:
-	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
+	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts
 
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 2ba23a679732..007586094dde 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -47,10 +47,6 @@ obj-$(CONFIG_NIOS2_DTB_SOURCE_BOOL) += linked_dtb.o
 
 targets += $(dtb-y)
 
-# Rule to build device tree blobs with make command
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
 $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
 
 install:
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/nios2/boot/dts/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
-- 
2.17.1

