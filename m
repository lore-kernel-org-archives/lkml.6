Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965137AbeB1Xd4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:33:56 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38207 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965085AbeB1XdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:33:05 -0500
X-Google-Smtp-Source: AH8x2268SjZRZ65TYQvXFP5uGJWRv3GIfI2EvmCPlKV0C7dqzyWQux++mhJKJTVoTa/5B9w75lyb0A==
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] scripts: turn off some new dtc warnings by default
Date: Wed, 28 Feb 2018 17:32:49 -0600
Message-Id: <20180228233249.26281-7-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228233249.26281-1-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest dtc update adds some new noisy warnings, so turn them off by
default. Disable 'avoid_unnecessary_addr_size' and 'alias_paths'. They
can be re-enabled by building with 'W=1'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 10906c1d7715..dcc934319f92 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -277,6 +277,8 @@ DTC ?= $(objtree)/scripts/dtc/dtc
 ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
 DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-unit_address_format \
+	-Wno-avoid_unnecessary_addr_size \
+	-Wno-alias_paths \
 	-Wno-pci_device_reg
 endif
 
-- 
2.14.1
