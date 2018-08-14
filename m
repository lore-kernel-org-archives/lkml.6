Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24288C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA53C2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeHNFnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:43:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729955AbeHNFny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:43:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A8D116CA693A6;
        Tue, 14 Aug 2018 10:58:45 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 10:58:44 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tony.luck@intel.com>, <fenghua.yu@intel.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <oleg@redhat.com>, <rppt@linux.vnet.ibm.com>,
        <dhowells@redhat.com>, <akpm@linux-foundation.org>,
        <viro@zeniv.linux.org.uk>
CC:     <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc: Use ARRAY_SIZE to replace its implementation
Date:   Tue, 14 Aug 2018 10:46:54 +0800
Message-ID: <1534214814-9043-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
So just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index ac2b55b..f3f57a1 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -966,8 +966,7 @@
   { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
 };
 
-const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
-					   / sizeof (powerpc_operands[0]));
+const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
 
 /* The functions used to insert and extract complicated operands.  */
 
@@ -6980,8 +6979,7 @@
 {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
 
 /* The VLE opcode table.
 
@@ -7219,8 +7217,7 @@
 {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
 };
 
-const int vle_num_opcodes =
-  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
+const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
 
 /* The macro table.  This is only used by the assembler.  */
 
@@ -7288,5 +7285,4 @@
 {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
-- 
1.7.12.4

