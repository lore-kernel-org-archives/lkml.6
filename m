Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D75BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3360420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DuMobcSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3360420C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeKZSRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:17:55 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:38339 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeKZSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:17:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wAQ7N1v3019779;
        Mon, 26 Nov 2018 16:23:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wAQ7N1v3019779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543216982;
        bh=W+odO2qR68+okWsE4v5K50oO9m1QxNzqqqNLgsQeyiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuMobcSOAjGSh1967QLjUSgEuCLvU+E4i5tJa8W/dihXXqFvNfrJL0JTeGIkAEuvF
         VDZJSNmu/oGtKHnDsqPDKhOMrLF3TAoCj3qQwfxF7fgXvrUPVyUWSFBMfeffedLX2L
         Q3Y93gTOZA7D4JAABnL9BVPNanaF3Puc3AJG2SrILVhoTE24Jf4BUEysTI1qgb0Zmk
         tTo7H9dLpcae1DXDrKErW8QziMtqOLMkfiRFgscAe33kHX7Yujlwsq7JMVY4vKSy3a
         ty7RckFyiq7onYwo98L8hVCYehKcL2c2hJ41lUs0icPn3XpZBtKIXA3JDI2ca+Ol6W
         TmKF1M7EijRKA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Taehee Yoo <ap420073@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: tests: test reverse dependency with tristate if-conditional
Date:   Mon, 26 Nov 2018 16:22:49 +0900
Message-Id: <1543216969-2227-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543216969-2227-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543216969-2227-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test-case for the fixed reverse dependency handling.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../kconfig/tests/revdep_with_tristate_if/Kconfig   | 21 +++++++++++++++++++++
 .../tests/revdep_with_tristate_if/__init__.py       | 14 ++++++++++++++
 .../tests/revdep_with_tristate_if/expected_config   |  9 +++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 scripts/kconfig/tests/revdep_with_tristate_if/Kconfig
 create mode 100644 scripts/kconfig/tests/revdep_with_tristate_if/__init__.py
 create mode 100644 scripts/kconfig/tests/revdep_with_tristate_if/expected_config

diff --git a/scripts/kconfig/tests/revdep_with_tristate_if/Kconfig b/scripts/kconfig/tests/revdep_with_tristate_if/Kconfig
new file mode 100644
index 0000000..2bd1141
--- /dev/null
+++ b/scripts/kconfig/tests/revdep_with_tristate_if/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config MODULES
+	def_bool y
+	option modules
+
+config A
+	tristate
+
+config B
+	tristate "b"
+	default y
+	select A if C
+	imply D if C
+
+config C
+	tristate "c"
+	default m
+
+config D
+	tristate "d"
diff --git a/scripts/kconfig/tests/revdep_with_tristate_if/__init__.py b/scripts/kconfig/tests/revdep_with_tristate_if/__init__.py
new file mode 100644
index 0000000..ad95cec
--- /dev/null
+++ b/scripts/kconfig/tests/revdep_with_tristate_if/__init__.py
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+select/imply property with tristate if-conditional
+
+The reverse dependencies (select/imply) are used to define a lower limit
+of another symbol. The current value of the selector is set to the lower
+limit of the selectee. This did not handled correctly in the past when the
+property has a tristate if-conditional.
+"""
+
+
+def test(conf):
+    assert conf.alldefconfig() == 0
+    assert conf.config_matches('expected_config')
diff --git a/scripts/kconfig/tests/revdep_with_tristate_if/expected_config b/scripts/kconfig/tests/revdep_with_tristate_if/expected_config
new file mode 100644
index 0000000..9826223
--- /dev/null
+++ b/scripts/kconfig/tests/revdep_with_tristate_if/expected_config
@@ -0,0 +1,9 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+CONFIG_MODULES=y
+CONFIG_A=y
+CONFIG_B=y
+CONFIG_C=m
+CONFIG_D=y
-- 
2.7.4

