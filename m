Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDSNUU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35535 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbeDSNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:17 -0400
X-Google-Smtp-Source: AIpwx49voyVHhR46vhX/bEFRYbVIXO8fcSnQ3UwXy9Ynldt0zLjQcsd7Rs8YL5m7tamMApaZY4kbQQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 9/9] nds32: Fix the allmodconfig build. To make sure CONFIG_CPU_LITTLE_ENDIAN is default y
Date: Thu, 19 Apr 2018 21:18:15 +0800
Message-Id: <21ef6561299cdbbe0f3571c5048a2eaf5eb43bc7.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we can build kernel with CONFIG_CPU_LITTLE_ENDIAN=y and allmodconfig
will be available.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/Kconfig.cpu | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index ba44cc539da9..b8c8984d1456 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -1,10 +1,11 @@
 comment "Processor Features"
 
 config CPU_BIG_ENDIAN
-	bool "Big endian"
+	def_bool !CPU_LITTLE_ENDIAN
 
 config CPU_LITTLE_ENDIAN
-        def_bool !CPU_BIG_ENDIAN
+	bool "Little endian"
+	default y
 
 config HWZOL
 	bool "hardware zero overhead loop support"
-- 
1.9.5
