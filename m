Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeBZPGi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:06:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753996AbeBZPFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:01 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 07/12] arm64: lse: Include compiler_types.h and export.h for out-of-line LL/SC
Date: Mon, 26 Feb 2018 15:04:55 +0000
Message-Id: <1519657500-15094-8-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the LL/SC atomics are moved out-of-line, they are annotated as
notrace and exported to modules. Ensure we pull in the relevant include
files so that these macros are defined when we need them.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/lse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index eec95768eaad..e612a6be113f 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -4,6 +4,8 @@
 
 #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 
+#include <linux/compiler_types.h>
+#include <linux/export.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 
-- 
2.1.4
