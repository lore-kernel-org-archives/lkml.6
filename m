Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeEMBsy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 21:48:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeEMBsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 21:48:53 -0400
To: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Richard Kuo <rkuo@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] hexagon: fix printk format warning in setup.c
Message-ID: <adce8db5-4b01-dc10-7fbb-6a64e0787eb5@infradead.org>
Date: Sat, 12 May 2018 18:48:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning in hexagon/kernel/setup.c:

../arch/hexagon/kernel/setup.c: In function 'setup_arch':
../arch/hexagon/kernel/setup.c:69:2: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat]

where:
extern unsigned long	__phys_offset;
#define PHYS_OFFSET	__phys_offset

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180510.orig/arch/hexagon/kernel/setup.c
+++ linux-next-20180510/arch/hexagon/kernel/setup.c
@@ -66,7 +66,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	__vmsetvec(_K_VM_event_vector);
 
-	printk(KERN_INFO "PHYS_OFFSET=0x%08x\n", PHYS_OFFSET);
+	printk(KERN_INFO "PHYS_OFFSET=0x%08lx\n", PHYS_OFFSET);
 
 	/*
 	 * Simulator has a few differences from the hardware.
