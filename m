Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A96CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE021902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfBGMrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:47:03 -0500
Received: from ozlabs.org ([203.11.71.1]:50987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfBGMq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:46:57 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wJ3f5VMrz9sNH; Thu,  7 Feb 2019 23:46:54 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Subject: [PATCH v3 5/7] powerpc: Add ppc_md.name to dump stack arch description
Date:   Thu,  7 Feb 2019 23:46:33 +1100
Message-Id: <20190207124635.3885-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As soon as we know the name of the machine description we're using, add
it to the dump stack arch description, which is printed in case of an
oops.

eg: Hardware name: ... machine:pSeries

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb97cf8..00d900b1e584 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
@@ -638,6 +639,8 @@ void probe_machine(void)
 		for (;;);
 	}
 
+	dump_stack_add_arch_desc("machine:%s", ppc_md.name);
+
 	printk(KERN_INFO "Using %s machine description\n", ppc_md.name);
 }
 
-- 
2.20.1

