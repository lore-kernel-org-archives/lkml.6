Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsnLdB9r/4fQdgxV+qbN8BN1mJUJKnG7JaGpT8KyAZSgV0K7y7+E2uuWDA1SbClEVbJJw0C
ARC-Seal: i=1; a=rsa-sha256; t=1520295992; cv=none;
        d=google.com; s=arc-20160816;
        b=HjWcHuZK+nzBTQzUguvykptTYe0gz4KvGnfx5kEsJndcOYrvR34QxHaUjx6NM80fGK
         gwEShWHgeFPM0/rlAXGsFkimRNjqrgghijSbJlw2yVen9Ahaxu0WE4RuBVkB+KR3CtF3
         fXhd2N5K71qXu6lDW+BbuNwq9xA4nkTxupvuWpRqKLlmRLkgUd5fMF94VYVSEnNRZ2Dv
         7aMEWznR5jnZbSpPx+aaGNEuZmyZKyywlWW9j1goL22RwPVTL7WOqb2hgSn6jHC2xCwm
         MY5w1UKnnbmBfwWv9Mg2iO0y1yGohDpGqcLe8zJa1M1mOVNNToEwMpCBaQnBjf2WAOA0
         tuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=cBju0fcsWALdnxT2xkObz5EpSe54+uNW7LwMsIinAj4=;
        b=xqWn0pqn+bb56EDI8eC6znDIz+JNlkPBdDwUSbNZPn6fyn2evw5iLwyzaUbyWkW5tC
         zlUcQSJKnOIkpwHoYmcnOSVHhQwFU5hVQ71S7nSiYYubV2P3ITu9+B1CCPz8sM8tfiip
         pHBThyw5uja69kwBGfPUOO/ZTtjDzHVUWYRU8TXY2UzI9n7ESwHpwR1eZW9oHg4EzLTz
         IUiY+tJ+n1sGyZ24NsaJ+nwFVStvMAXNcGuVt7Yh8LPBslT3xjoYkX+7nir4ikJh8eM6
         mS6mNH6DR6b9xRoinca8xZuu3cegjCs7tXTF7QXq48zCYHOYAIpA98aWr5GaQlHoJlNW
         P8VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iV4bPvYh;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iV4bPvYh;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 35/65] kaiser: tidied up asm/kaiser.h somewhat
Date: Mon,  5 Mar 2018 19:25:08 -0500
Message-Id: <20180306002538.1761-36-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=795
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145890900694448?=
X-GMAIL-MSGID: =?utf-8?q?1594145890900694448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Mainly deleting a surfeit of blank lines, and reflowing header comment.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 5fbd46c4be78174656b52e1b04d3057a5dd7af66)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/kaiser.h | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 0703f48777f3..7394ba9f9951 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -1,15 +1,17 @@
 #ifndef _ASM_X86_KAISER_H
 #define _ASM_X86_KAISER_H
-
-/* This file includes the definitions for the KAISER feature.
- * KAISER is a counter measure against x86_64 side channel attacks on the kernel virtual memory.
- * It has a shodow-pgd for every process. the shadow-pgd has a minimalistic kernel-set mapped,
- * but includes the whole user memory. Within a kernel context switch, or when an interrupt is handled,
- * the pgd is switched to the normal one. When the system switches to user mode, the shadow pgd is enabled.
- * By this, the virtual memory chaches are freed, and the user may not attack the whole kernel memory.
+/*
+ * This file includes the definitions for the KAISER feature.
+ * KAISER is a counter measure against x86_64 side channel attacks on
+ * the kernel virtual memory.  It has a shadow pgd for every process: the
+ * shadow pgd has a minimalistic kernel-set mapped, but includes the whole
+ * user memory. Within a kernel context switch, or when an interrupt is handled,
+ * the pgd is switched to the normal one. When the system switches to user mode,
+ * the shadow pgd is enabled. By this, the virtual memory caches are freed,
+ * and the user may not attack the whole kernel memory.
  *
- * A minimalistic kernel mapping holds the parts needed to be mapped in user mode, as the entry/exit functions
- * of the user space, or the stacks.
+ * A minimalistic kernel mapping holds the parts needed to be mapped in user
+ * mode, such as the entry/exit functions of the user space, or the stacks.
  */
 #ifdef __ASSEMBLY__
 #ifdef CONFIG_KAISER
@@ -48,13 +50,10 @@ _SWITCH_TO_KERNEL_CR3 %rax
 movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 .endm
 
-
 .macro SWITCH_USER_CR3_NO_STACK
-
 movq %rax, PER_CPU_VAR(unsafe_stack_register_backup)
 _SWITCH_TO_USER_CR3 %rax
 movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
-
 .endm
 
 #else /* CONFIG_KAISER */
@@ -72,7 +71,6 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 
 #else /* __ASSEMBLY__ */
 
-
 #ifdef CONFIG_KAISER
 /*
  * Upon kernel/user mode switch, it may happen that the address
@@ -80,7 +78,6 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
  * stored.  To change the address space, another register is
  * needed.  A register therefore has to be stored/restored.
 */
-
 DECLARE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
 
 /**
@@ -95,7 +92,6 @@ DECLARE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
  */
 extern int kaiser_add_mapping(unsigned long addr, unsigned long size, unsigned long flags);
 
-
 /**
  *  kaiser_remove_mapping - unmap a virtual memory part of the shadow mapping
  *  @addr: the start address of the range
@@ -104,12 +100,12 @@ extern int kaiser_add_mapping(unsigned long addr, unsigned long size, unsigned l
 extern void kaiser_remove_mapping(unsigned long start, unsigned long size);
 
 /**
- *  kaiser_initialize_mapping - Initalize the shadow mapping
+ *  kaiser_init - Initialize the shadow mapping
  *
  *  Most parts of the shadow mapping can be mapped upon boot
  *  time.  Only per-process things like the thread stacks
  *  or a new LDT have to be mapped at runtime.  These boot-
- *  time mappings are permanent and nevertunmapped.
+ *  time mappings are permanent and never unmapped.
  */
 extern void kaiser_init(void);
 
@@ -117,6 +113,4 @@ extern void kaiser_init(void);
 
 #endif /* __ASSEMBLY */
 
-
-
 #endif /* _ASM_X86_KAISER_H */
-- 
2.16.2
