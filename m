Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtKpeWJ4NJOzyKChQpRPXTW6DtP6BzxJ6LI5Gfc3mbyO/quwhxjZZLCKMtURS2RgsKWprtw
ARC-Seal: i=1; a=rsa-sha256; t=1522141927; cv=none;
        d=google.com; s=arc-20160816;
        b=PZPIZYORFPSls9Vk/eFlbUeia+cuurJfXrVf5BOE4K4v8DTVlXeFdvIRzPy3FR0WUR
         5WAnNLRysAIXkJ7C25hSfEth3b+/vwgNxaXwGDAkv3MHm9OdL/LxBD5iztrff4grWCZn
         Fqi+erugGpAHidWdb1KyUH5WKKScVvD60prPmq423OWEsTcEcnGHcYYUxXi+LaUf+4nN
         5L51a9upUTgnTnBHjbDnRCMrAlbW9SCHvKcalYMLXiCPNquOJnX03j+8O7g7UQI3Yg7V
         +cOmc4ahnSWZ6isSlTOTzRquyKLE8Kz2z2ziQ8wmz4Ra5CTeI7qpAJiIzLfmcSWGczeE
         UFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tzJQBnLrquW9gPrO0wrE8hf4p81Ai5DUJuOG1lGQd4s=;
        b=my54hgRy6dbFLfOrtdHGeXI3laXVxI4HPKbAXVdUwNetwCYl5JtiyLpaRRtjNqnG8P
         rFpa3CJomeE8evB8hoyKnMkE7JQoZ5gMAD0iOeTZEQpm6hsdPy8qCMJfEd42oCuHaJ0h
         GiPQV2d7Sx8Mg15POJ30V2w+Hu/fTQ1CJ2Q1NsGo2fhe/s4rtXCdRzxzHaXtFRggGt4x
         BxdwpUgi0gGI5JvWJjV50EInjkQsfoga8E2m+PP3aeWSttEFOajBWHf3qQ6b3wZs97ec
         P6Oon/NTBTzc40ED7ozJ0gKLqqBKW90V17wCEEFGQrYDZVEbf8eYf8SD5BgJtaIiQLzu
         4LSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=eE+pTq7c;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=eE+pTq7c;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeC0JJx (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 05:09:53 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43795 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeC0JJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 05:09:49 -0400
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de
Subject: [PATCH v13 1/3] mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS is enabled
Date: Tue, 27 Mar 2018 02:09:26 -0700
Message-Id: <1522141768-25485-2-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
References: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596081494033031489?=
X-GMAIL-MSGID: =?utf-8?q?1596081494033031489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VM_PKEY_BITx are defined only if CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
is enabled. Powerpc also needs these bits. Hence lets define the
VM_PKEY_BITx bits for any architecture that enables
CONFIG_ARCH_HAS_PKEYS.

cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |    2 ++
 fs/proc/task_mmu.c               |    4 ++--
 include/linux/mm.h               |    9 +++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0d3c630..99344d7 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -26,6 +26,8 @@
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
 # define VM_PKEY_BIT4	VM_HIGH_ARCH_4
+#elif !defined(VM_PKEY_BIT4)
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif
 
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ec6d298..6b996d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -679,13 +679,13 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MERGEABLE)]	= "mg",
 		[ilog2(VM_UFFD_MISSING)]= "um",
 		[ilog2(VM_UFFD_WP)]	= "uw",
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+#ifdef CONFIG_ARCH_HAS_PKEYS
 		/* These come out via ProtectionKey: */
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
-#endif
+#endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42..ad207ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -228,15 +228,16 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
-#if defined(CONFIG_X86)
-# define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
-#if defined (CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)
+#ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
 # define VM_PKEY_BIT1	VM_HIGH_ARCH_1
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
-#endif
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+
+#if defined(CONFIG_X86)
+# define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
-- 
1.7.1

