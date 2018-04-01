Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeDAUnj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:35 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 33/45] C++: Move irqchip_irq_state enum
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:33 +0100
Message-ID: <152261541370.30503.392919432710840130.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the irqchip_irq_state enum to linux/irqflags.h so that it is defined
before its first use.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/interrupt.h |   10 ----------
 include/linux/irq.h       |    1 -
 include/linux/irqflags.h  |   10 ++++++++++
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 69c238210325..6975377bda00 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -413,16 +413,6 @@ static inline int disable_irq_wake(unsigned int irq)
 	return irq_set_irq_wake(irq, 0);
 }
 
-/*
- * irq_get_irqchip_state/irq_set_irqchip_state specific flags
- */
-enum irqchip_irq_state {
-	IRQCHIP_STATE_PENDING,		/* Is interrupt pending? */
-	IRQCHIP_STATE_ACTIVE,		/* Is interrupt in progress? */
-	IRQCHIP_STATE_MASKED,		/* Is interrupt masked? */
-	IRQCHIP_STATE_LINE_LEVEL,	/* Is IRQ line high? */
-};
-
 extern int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 				 bool *state);
 extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
diff --git a/include/linux/irq.h b/include/linux/irq.h
index a0231e96a578..34c1338215ae 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -32,7 +32,6 @@
 struct seq_file;
 struct module;
 struct msi_msg;
-enum irqchip_irq_state;
 
 /*
  * IRQ line status.
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 9700f00bbc04..59854eafbedf 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -159,4 +159,14 @@ do {						\
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+/*
+ * irq_get_irqchip_state/irq_set_irqchip_state specific flags
+ */
+enum irqchip_irq_state {
+	IRQCHIP_STATE_PENDING,		/* Is interrupt pending? */
+	IRQCHIP_STATE_ACTIVE,		/* Is interrupt in progress? */
+	IRQCHIP_STATE_MASKED,		/* Is interrupt masked? */
+	IRQCHIP_STATE_LINE_LEVEL,	/* Is IRQ line high? */
+};
+
 #endif
