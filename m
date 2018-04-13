Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDMHDL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:03:11 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:55117 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbeDMHDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:03:10 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <mpm@selenic.com>, <herbert@gondor.apana.org.au>, <arnd@arndb.de>,
        <grehkg@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH] hwrng: via-rng - support new Centaur CPU
Date: Fri, 13 Apr 2018 15:03:03 +0800
Message-ID: <1523602983-3418-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Centaur CPU(Family > 6) supprt Random Number Generator, but can't
support MSR_VIA_RNG. Just like VIA Nano.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 drivers/char/hw_random/via-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index d1f5bb5..d9448b1 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -135,7 +135,7 @@ static int via_rng_init(struct hwrng *rng)
 	 * is always enabled if CPUID rng_en is set.  There is no
 	 * RNG configuration like it used to be the case in this
 	 * register */
-	if ((c->x86 == 6) && (c->x86_model >= 0x0f)) {
+	if (((c->x86 == 6) && (c->x86_model >= 0x0f))  || (c->x86 > 6)){
 		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
 			pr_err(PFX "can't enable hardware RNG "
 				"if XSTORE is not enabled\n");
-- 
1.9.1
