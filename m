Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965581AbeCACws (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:52:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:3362 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965522AbeCACwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:52:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="31505283"
Message-ID: <1519872327.58658.187.camel@intel.com>
Subject: [PATCH v2 1/3] x86: devicetree: call early_init_dt_verify()
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Date: Wed, 28 Feb 2018 18:45:27 -0800
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call to early_init_dt_verify() is required to prepare DTB data.
It was called from arch/arm and arch/powerpc, but not arch/x86.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 25de5f6..44189ee 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -278,6 +278,7 @@ static void __init x86_flattree_get_config(void)
 		map_len = size;
 	}
 
+	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
 	early_memunmap(dt, map_len);
 }
-- 
2.7.4
