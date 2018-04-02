Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeDBDeP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:34:15 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:33934 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754048AbeDBDeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:34:11 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v2 2/2] x86/mce: add CMCI support for centaur CPUs
Date: Mon, 2 Apr 2018 11:33:52 +0800
Message-ID: <1522640032-3357-3-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522640032-3357-1-git-send-email-davidwang@zhaoxin.com>
References: <1522640032-3357-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to tell the kernel that newer Centaur CPU support CMCI.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index c3db7ce..361d95e 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1751,6 +1751,7 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
+	case X86_VENDOR_CENTAUR:
 		mce_intel_feature_init(c);
 		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
-- 
1.9.1
