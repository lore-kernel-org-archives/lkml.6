Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELt7mrdPIM9vZ5nGSCQnJr6fqYr09lOzn24yhp2uj3/4y8rQdbHERCAXpEiEH5HR6nSS3IQq
ARC-Seal: i=1; a=rsa-sha256; t=1520295995; cv=none;
        d=google.com; s=arc-20160816;
        b=PX4wwFQl9b+o7MTvbPRJpA84/gcDMaJk+0LfMEezPeSkSFQE+qC/Iidnbea4sUBHku
         obgoPEjV03tuqfjn9FX/GeIMJNwf5lBhRoLeqTyYzmLqRIzLfz7F/oTGF2JrrXYkfjwZ
         f3MUDEvGDRiquIvrXq9hp8L65KQ+8ValXPNjJMj6E1SC/iycsApyYmvjJyDChBk12I+5
         CkQwUrLBIhe2JXuEN1Dy+QPWkO1rBl+ol55r2u0ow0+pIAilCMdaMYgxEfkgfGi122iC
         V95cX+CtpTH2p/n9qoVZ5kXzhsUvPjf1PAWMFqcENvwsjknBV5osMhfE/SHTmNhWFbJV
         WjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=qNwpxnvqF5sfCd/CGo2ZPpRl567XksepB4GVvtBL48k=;
        b=zRnWa+5j/MtPrAyQs6OtwHyMrleQkKaxVmVGJdR/dwQ6Zun9cWVQVzwLKrVJhs0cni
         Ac+w5LSDPk7BPURob+7hiV1EnX5E2T8SsAJomWZ3fESMJW71ROdPi5cIdNHp07rq4lGP
         iTt5wW37QOm9Xrhk/UtIV1bkprO0bnBT/JSgBy6gz5koOg9dAIFfb+rLb7s0DYHYhLDb
         PloWGqw6Qjlr8eSSFwJeaPIy2Tv2DF7zecD4ee7RMiiOJrqpLjZokvKDudgT7yik4FqP
         yz449pZWoAZAzHcgY0C7zu6QlzVTRk3ug5FLbSNxoXZaPSCgfZyHHhCRt3PVAvxLWciG
         YYxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=fK9nrhRi;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=fK9nrhRi;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 39/65] kaiser: name that 0x1000 KAISER_SHADOW_PGD_OFFSET
Date: Mon,  5 Mar 2018 19:25:12 -0500
Message-Id: <20180306002538.1761-40-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=711
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145894427651678?=
X-GMAIL-MSGID: =?utf-8?q?1594145894427651678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

There's a 0x1000 in various places, which looks better with a name.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit aeda21d77e22fb382c51fd3f6bbb18df69bc032f)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/include/asm/kaiser.h | 7 +++++--
 arch/x86/kernel/entry_64.S    | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 7394ba9f9951..051acf678cda 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -13,13 +13,16 @@
  * A minimalistic kernel mapping holds the parts needed to be mapped in user
  * mode, such as the entry/exit functions of the user space, or the stacks.
  */
+
+#define KAISER_SHADOW_PGD_OFFSET 0x1000
+
 #ifdef __ASSEMBLY__
 #ifdef CONFIG_KAISER
 
 .macro _SWITCH_TO_KERNEL_CR3 reg
 movq %cr3, \reg
 #ifdef CONFIG_KAISER_REAL_SWITCH
-andq $(~0x1000), \reg
+andq $(~KAISER_SHADOW_PGD_OFFSET), \reg
 #endif
 movq \reg, %cr3
 .endm
@@ -27,7 +30,7 @@ movq \reg, %cr3
 .macro _SWITCH_TO_USER_CR3 reg
 movq %cr3, \reg
 #ifdef CONFIG_KAISER_REAL_SWITCH
-orq $(0x1000), \reg
+orq $(KAISER_SHADOW_PGD_OFFSET), \reg
 #endif
 movq \reg, %cr3
 .endm
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 8e4056d4b1d6..5c6c11d9d779 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1542,7 +1542,7 @@ ENTRY(nmi)
 	movq	%cr3, %rax
 	pushq	%rax
 #ifdef CONFIG_KAISER_REAL_SWITCH
-	andq	$(~0x1000), %rax
+	andq	$(~KAISER_SHADOW_PGD_OFFSET), %rax
 #endif
 	movq	%rax, %cr3
 #endif
@@ -1780,7 +1780,7 @@ end_repeat_nmi:
 	movq	%cr3, %rax
 	pushq	%rax
 #ifdef CONFIG_KAISER_REAL_SWITCH
-	andq	$(~0x1000), %rax
+	andq	$(~KAISER_SHADOW_PGD_OFFSET), %rax
 #endif
 	movq	%rax, %cr3
 #endif
-- 
2.16.2
