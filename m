Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8EAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4D92077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4D92077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbeGKMNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:13:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44452 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:12:59 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M7nzI-1fyzzx1Ihc-00vSfd; Wed, 11 Jul 2018 14:08:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sparc64: add reads{b,w,l}/writes{b,w,l}
Date:   Wed, 11 Jul 2018 14:08:06 +0200
Message-Id: <20180711120824.3882108-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711120824.3882108-1-arnd@arndb.de>
References: <20180711120824.3882108-1-arnd@arndb.de>
X-Provags-ID: V03:K1:wkkgXftNy6ebXNUe1Td0Auor9Sdh11vLJ6ZgqhxeXn4FovZjF05
 6XDZDJF4tjIRhK9MQh5T596MZLuhHyuvS/pKoV/J+lEjHONRn6/QmRUVlP47x/+MOfBzfqu
 ox47Fj6UYQNdSeLQD/SejRwlhkzWIl6gvV+yF4+H8hyiXarrIPwkTEaZZKNKfOy29RDseiz
 Og9z3NpucMaEKQiOd/2Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:67xNIxIBSzk=:ocslP4G0Bwp2Kgvc6pyyta
 a+Lgpu5TXbDml3DJtx2nIDp1EVuyg+FZ33JBUjcbVQ+BmceBbFs/m3ZcR7mYsGNXGh53ipTtL
 Gy4A3Wiy999mRSp2G7SUPRjxVZH7b/SniztRTnwEe9HnYkxDhKVzjHjmlVp0Pm7HyozPD6BP3
 0ebBXkF8j7cyDpMDRljjkiD87+yDIJwAT2v95VVYp6BYsWZwmSv53d38qsKEtgHgjb8rNjuMj
 Hjhb9mL2G+FwerOY1RdgIvwvc+XUo2BrH5/KQT9SmExIaeyZvX3SIMitMeR7wtkpgYCtI2fPx
 5kaAdJiy8uAi3ftGtaiofZH+OS/1lB03Cpu5/u/i9y69LWSbcv9MJrbT8qshjvTA7IVRoMv+M
 3jyV9A+BWCq+cRww63fUJKcZoAul2QxqqMAQZ0T1bBYtOPqxWgKbv5V75MCBE+Soh++0QrJDX
 u2hofn+Yp4Qo5wv1nZGqSO0FbTHe9PGQU9wj5fK/zSnEl7aQv9jSUk0/7WBX3JeAqzoM7SQam
 qLmaoB7iaLfyigIbVVzD8fFPPVihlTU/EeJbsJ/960fxQ4yynhUkSEWQZdthth3L/piWdcxV/
 JiVFRmrhAIOMGClSH7u11NozFSPQW7OawqDvIWQY9MP5RaFHTURxyqe7st0YEEXuO1u2D6fNJ
 GxrVA6uvq93RoVD4C3O/o/VOQZXYXeJDOdLiInLErwtjmgo/mVWa+8z9VaRpe4WmNZ8M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need these for compile-testing. On most architectures
they come from asm-generic/io.h, but not on sparc64, which has its
own definitions.

Since we already have ioread*_rep()/iowrite*_rep() that have the
same behavior on sparc64 (i.e. all PCI I/O space is memory mapped),
we can rename the existing helpers and add macros to define them
to the same implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/io_64.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9a1e9cbc7e6d..b162c23ae8c2 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -243,35 +243,42 @@ void insb(unsigned long, void *, unsigned long);
 void insw(unsigned long, void *, unsigned long);
 void insl(unsigned long, void *, unsigned long);
 
-static inline void ioread8_rep(void __iomem *port, void *buf, unsigned long count)
+static inline void readsb(void __iomem *port, void *buf, unsigned long count)
 {
 	insb((unsigned long __force)port, buf, count);
 }
-static inline void ioread16_rep(void __iomem *port, void *buf, unsigned long count)
+static inline void readsw(void __iomem *port, void *buf, unsigned long count)
 {
 	insw((unsigned long __force)port, buf, count);
 }
 
-static inline void ioread32_rep(void __iomem *port, void *buf, unsigned long count)
+static inline void readsl(void __iomem *port, void *buf, unsigned long count)
 {
 	insl((unsigned long __force)port, buf, count);
 }
 
-static inline void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count)
+static inline void writesb(void __iomem *port, const void *buf, unsigned long count)
 {
 	outsb((unsigned long __force)port, buf, count);
 }
 
-static inline void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count)
+static inline void writesw(void __iomem *port, const void *buf, unsigned long count)
 {
 	outsw((unsigned long __force)port, buf, count);
 }
 
-static inline void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count)
+static inline void writesl(void __iomem *port, const void *buf, unsigned long count)
 {
 	outsl((unsigned long __force)port, buf, count);
 }
 
+#define ioread8_rep(p,d,l)	readsb(p,d,l)
+#define ioread16_rep(p,d,l)	readsw(p,d,l)
+#define ioread32_rep(p,d,l)	readsl(p,d,l)
+#define iowrite8_rep(p,d,l)	writesb(p,d,l)
+#define iowrite16_rep(p,d,l)	writesw(p,d,l)
+#define iowrite32_rep(p,d,l)	writesl(p,d,l)
+
 /* Valid I/O Space regions are anywhere, because each PCI bus supported
  * can live in an arbitrary area of the physical address range.
  */
-- 
2.9.0

