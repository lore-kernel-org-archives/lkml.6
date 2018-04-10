Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDJONu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:54623 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeDJONt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:13:49 -0400
Date: Tue, 10 Apr 2018 16:13:45 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xunlei Pang <xlpang@redhat.com>, Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "=?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau" <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: export PG_swapbacked to VMCOREINFO
Message-ID: <20180410161345.142e142d@ezekiel.suse.cz>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6326fec1122cde256bd2a8c63f2606e08e44ce1d PG_swapcache
is an alias for PG_owner_priv_1, which may be also used for other
purposes. To know whether the bit indeed has the PG_swapcache
meaning, it is necessary to check PG_swapbacked, hence this bit must
be exported.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a93590cdd9e1..f7674d676889 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -454,6 +454,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PG_lru);
 	VMCOREINFO_NUMBER(PG_private);
 	VMCOREINFO_NUMBER(PG_swapcache);
+	VMCOREINFO_NUMBER(PG_swapbacked);
 	VMCOREINFO_NUMBER(PG_slab);
 #ifdef CONFIG_MEMORY_FAILURE
 	VMCOREINFO_NUMBER(PG_hwpoison);
-- 
2.13.6
