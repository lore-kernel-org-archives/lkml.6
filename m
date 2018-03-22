Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeCVUVT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:21:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44089 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeCVUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:10 -0400
X-Google-Smtp-Source: AG47ELtlLGd6gPI2dRDiZdh5V//2a39shh0/dqj9m849IKsb4yTtykJFwYy7p6jsJby3YQL4CwCvDg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 17/19] powerpc/32: Add a missing include header
Date: Thu, 22 Mar 2018 21:20:03 +0100
Message-Id: <20180322202007.23088-18-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file <linux/syscalls.h> was missing from the includes. Fix the
following warning, treated as error with W=1:

  arch/powerpc/kernel/pci_32.c:286:6: error: no previous prototype for ‘sys_pciconfig_iobase’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/pci_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 85ad2f78b889..51cba7d7a4fd 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/bootmem.h>
+#include <linux/syscalls.h>
 #include <linux/irq.h>
 #include <linux/list.h>
 #include <linux/of.h>
-- 
2.11.0
