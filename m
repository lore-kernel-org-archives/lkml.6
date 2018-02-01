Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeBANGd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:06:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeBANGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:06:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v11 3/4] crash: export paddr_vmcoreinfo_note()
Date: Thu,  1 Feb 2018 14:02:59 +0100
Message-Id: <20180201130300.9962-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180201130300.9962-1-marcandre.lureau@redhat.com>
References: <20180201130300.9962-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is going to use the symbol from the fw_cfg module,
to call the function and write the note location details in the
vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Baoquan He <bhe@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4f63597c824d..a93590cdd9e1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -376,6 +376,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
 	return __pa(vmcoreinfo_note);
 }
+EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
 static int __init crash_save_vmcoreinfo_init(void)
 {
-- 
2.16.0.rc1.1.gef27df75a1
