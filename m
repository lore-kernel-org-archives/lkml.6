Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCVUUz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:20:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42076 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeCVUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:47 -0400
X-Google-Smtp-Source: AG47ELuDeeaY0LNAaNzNTiMRtI54uSJQVtXCOsDpLyvDWuisVHeURNMenKBJLsq8/hfbvXeyrPgUKg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 05/19] powerpc/chrp/setup: Add attribute unused and make some functions static
Date: Thu, 22 Mar 2018 21:19:51 +0100
Message-Id: <20180322202007.23088-6-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc attribute unused to silence a warning.

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous prototype for ‘chrp_show_cpuinfo’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous prototype for ‘chrp_setup_arch’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:385:16: error: variable ‘idu_size’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous prototype for ‘chrp_init_IRQ’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous prototype for ‘chrp_init2’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/chrp/setup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 481ed133e04b..85df479fd631 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -94,7 +94,7 @@ static const char *chrp_names[] = {
 	"Total Impact Briq"
 };
 
-void chrp_show_cpuinfo(struct seq_file *m)
+static void chrp_show_cpuinfo(struct seq_file *m)
 {
 	int i, sdramen;
 	unsigned int t;
@@ -299,7 +299,7 @@ static __init void chrp_init(void)
 	of_node_put(node);
 }
 
-void __init chrp_setup_arch(void)
+static void __init chrp_setup_arch(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
 	const char *machine = NULL;
@@ -382,7 +382,7 @@ static void __init chrp_find_openpic(void)
 {
 	struct device_node *np, *root;
 	int len, i, j;
-	int isu_size, idu_size;
+	int isu_size, idu_size __maybe_unused;
 	const unsigned int *iranges, *opprop = NULL;
 	int oplen = 0;
 	unsigned long opaddr;
@@ -523,7 +523,7 @@ static void __init chrp_find_8259(void)
 	}
 }
 
-void __init chrp_init_IRQ(void)
+static void __init chrp_init_IRQ(void)
 {
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_XMON)
 	struct device_node *kbd;
@@ -555,7 +555,7 @@ void __init chrp_init_IRQ(void)
 #endif
 }
 
-void __init
+static void __init
 chrp_init2(void)
 {
 #ifdef CONFIG_NVRAM
-- 
2.11.0
