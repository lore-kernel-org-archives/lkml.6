Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967857AbeBNNa2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:30:28 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42053 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967713AbeBNNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:30:26 -0500
X-Google-Smtp-Source: AH8x225olUH4+b+nNsL9pJEks+iGFRKscZcoSQ4jiw4Cx/LMteerTWWBltYIEG2t7wCqHCOFQg1nEg==
From: Anders Roxell <anders.roxell@linaro.org>
To: akpm@linux-foundation.org, mingo@kernel.org, byungchul.park@lge.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] lib/Kconfig.debug: enable RUNTIME_TESTING_MENU
Date: Wed, 14 Feb 2018 14:30:15 +0100
Message-Id: <20180214133015.10090-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig to ease
disabling it all") causes a regression when using runtime tests due to it
defaults RUNTIME_TESTING_MENU to not set.

Fixes: d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig to
easedisabling it all")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6088408ef26c..64155e310a9f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1642,6 +1642,7 @@ config DMA_API_DEBUG
 
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
+	def_bool y
 
 if RUNTIME_TESTING_MENU
 
-- 
2.11.0
