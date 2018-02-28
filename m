Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965082AbeB1XdE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:33:04 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33048 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964903AbeB1XdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:33:00 -0500
X-Google-Smtp-Source: AG47ELvxlNKyuwAuPBn8318TAz4uZrOW5iU31xZpMwyTeiP1htNViqQWiUi00Z/ekR5T0xNNAdtFXA==
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] kbuild: add dtc as dependency on .dtb files
Date: Wed, 28 Feb 2018 17:32:45 -0600
Message-Id: <20180228233249.26281-3-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228233249.26281-1-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dtc is rebuilt, we should rebuild .dtb files with the new dtc.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bc2f90cb8c0..6aeb91524c76 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -316,7 +316,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
-$(obj)/%.dtb: $(src)/%.dts FORCE
+$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
-- 
2.14.1
