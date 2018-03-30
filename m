Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeC3Jyq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:54:46 -0400
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:58748 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751096AbeC3Jyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:54:43 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 2/2] x86/mce: add CMCI support for centaur CPUs
Date: Fri, 30 Mar 2018 17:53:42 +0800
Message-ID: <1522403622-31146-3-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
References: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to tell the kernel that centaur CPUs support CMCI
mechanism which is compatible with INTEL CMCI.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 82b25e1..62aa85c 100644
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
