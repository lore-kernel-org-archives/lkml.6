Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8809C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED3C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED3C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeICTQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:16:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56845 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:16:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83Eu8793339840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:56:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83Eu8MU3339837;
        Mon, 3 Sep 2018 07:56:08 -0700
Date:   Mon, 3 Sep 2018 07:56:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-3013c2be600fe22d336ab4de91aedde258f1f7d5@git.kernel.org>
Cc:     hpa@zytor.com, jgross@suse.com, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
          jgross@suse.com, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180828074026.820-4-jgross@suse.com>
References: <20180828074026.820-4-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/xen: Link platform-pci-unplug.o only if
 CONFIG_XEN_PVHVM
Git-Commit-ID: 3013c2be600fe22d336ab4de91aedde258f1f7d5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3013c2be600fe22d336ab4de91aedde258f1f7d5
Gitweb:     https://git.kernel.org/tip/3013c2be600fe22d336ab4de91aedde258f1f7d5
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:33 +0200

x86/xen: Link platform-pci-unplug.o only if CONFIG_XEN_PVHVM

Instead of using one large #ifdef CONFIG_XEN_PVHVM in
arch/x86/xen/platform-pci-unplug.c add the object file depending on
CONFIG_XEN_PVHVM being set.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-4-jgross@suse.com

---
 arch/x86/xen/Makefile              | 2 +-
 arch/x86/xen/platform-pci-unplug.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index a964f307a266..dd2550d33b38 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -19,11 +19,11 @@ obj-y				+= mmu.o
 obj-y				+= time.o
 obj-y				+= grant-table.o
 obj-y				+= suspend.o
-obj-y				+= platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
 obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
 obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PV)		+= setup.o
 obj-$(CONFIG_XEN_PV)		+= apic.o
diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 33a783c77d96..3957946a6cfe 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -30,7 +30,6 @@
 #define XEN_PLATFORM_ERR_PROTOCOL -2
 #define XEN_PLATFORM_ERR_BLACKLIST -3
 
-#ifdef CONFIG_XEN_PVHVM
 /* store the value of xen_emul_unplug after the unplug is done */
 static int xen_platform_pci_unplug;
 static int xen_emul_unplug;
@@ -214,4 +213,3 @@ static int __init parse_xen_emul_unplug(char *arg)
 	return 0;
 }
 early_param("xen_emul_unplug", parse_xen_emul_unplug);
-#endif
