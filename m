Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F251C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7BA20847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7BA20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeH2RBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:01:48 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeH2RBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:01:47 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MNvNj-1g1IkR1e27-007WRz; Wed, 29 Aug 2018 15:04:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc:     linux-arch@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH net-next 2/3] asm-generic: generalize asm/sockios.h
Date:   Wed, 29 Aug 2018 14:59:11 +0200
Message-Id: <20180829130308.3504560-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829130308.3504560-1-arnd@arndb.de>
References: <20180829130308.3504560-1-arnd@arndb.de>
X-Provags-ID: V03:K1:hYNj9qlYrG7wffQwQ11kkhNczSOtyzhmsG0cQmDZVsMZFwTtPPp
 u5THBJlqZDetbco7RCXHgfwWBJuivvSe+sgD/W+VMzvp/qXTLsvMutcBYb++5WpF1IlMXIh
 10myQQS18INRmj4/BSUg4YjF2VDSTZHaax3OksgK4G92iatoeAW0d+ZfkfBnuaKd+s3hRYT
 LCIK4N1MD2C2xGOGMpFOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9z4T3+qheSo=:qZb1MXHiPuJ6QTL4OktLsi
 V2psAz6hUqoF896lfsPJ+mDP35GpZwqqpAWaOEULGd90p6ppFNGkvSjbXfVtoE2sH2pvPiwfh
 FBgCWAWQcX+7Y+ZCVTaoxrdsAMigj3pXY3lBhxr7bV7NpB45HlspuGrOE1IAE5fFHcSX6My2c
 0jztUenc+ugWsm9Ga54qgzec7msYKDwPX6x4xt/2DoIbkMO5aAPCBhb6J1RowF+EnizVkNHlu
 4BYLwVFWUFy8fQ4phNDFxLXxPiArEv5KXnEMO24l1RU16aYiTqhwWe+r/T9sIQTVPUidlTokB
 XVS1ZciWk6h4OVGJY0hjhKrCWanuoPjAjEYya3ll9WETMmY/xR1v81TdBprqR3IXGSWH9etIJ
 HABj8ZPb8v0er+pjWEsdIU4heDnR7J5DQVpNBtlYjnSTaIbT1mtCcbHEfm3LKe9QT6gU2FNTP
 RgV89dSz9larFIzeK5lNQPztMUv6+YCMK0mNruXWY7O7uMK1ZGAr/R3o6MNpZHEz0gRcfEdYt
 UY4e4rS6BcwUNyV6kF6x/p72R84lDDH0ImP589+PskrottzATG2aMbFPiOqOAoQqbVWd+RzVP
 KcJxeyP+F5JNpSnFTe+Mahph/Y/eQ/V7bXOcCawJHzJrDY6/YtbqYM3TZSALIjv9r8TRKFn6S
 PS70tnNnM1+aOlOtoqtIAKWJtgjnx67+YLzhuGKOKb4gbSBjLveoW7vuXT4I7gvjXAT0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia64, parisc and sparc just use a copy of the generic version
of asm/sockios.h, and x86 is a redirect to the same file, so we
can just let the header file be generated.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/uapi/asm/Kbuild      |  1 +
 arch/ia64/include/uapi/asm/sockios.h   | 21 ---------------------
 arch/parisc/include/uapi/asm/Kbuild    |  1 +
 arch/parisc/include/uapi/asm/sockios.h | 14 --------------
 arch/sparc/include/uapi/asm/Kbuild     |  1 +
 arch/sparc/include/uapi/asm/sockios.h  | 15 ---------------
 arch/x86/include/uapi/asm/Kbuild       |  1 +
 arch/x86/include/uapi/asm/sockios.h    |  1 -
 8 files changed, 4 insertions(+), 51 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/sockios.h
 delete mode 100644 arch/parisc/include/uapi/asm/sockios.h
 delete mode 100644 arch/sparc/include/uapi/asm/sockios.h
 delete mode 100644 arch/x86/include/uapi/asm/sockios.h

diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 3982e673e967..a6377ad3ba1c 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += msgbuf.h
 generic-y += poll.h
 generic-y += sembuf.h
 generic-y += shmbuf.h
+generic-y += sockios.h
diff --git a/arch/ia64/include/uapi/asm/sockios.h b/arch/ia64/include/uapi/asm/sockios.h
deleted file mode 100644
index f27a12f95d20..000000000000
--- a/arch/ia64/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SOCKIOS_H
-#define _ASM_IA64_SOCKIOS_H
-
-/*
- * Socket-level I/O control calls.
- *
- * Based on <asm-i386/sockios.h>.
- *
- * Modified 1998, 1999
- *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
- */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* _ASM_IA64_SOCKIOS_H */
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index 286ef5a5904b..be6c171f57f7 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += kvm_para.h
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
+generic-y += sockios.h
diff --git a/arch/parisc/include/uapi/asm/sockios.h b/arch/parisc/include/uapi/asm/sockios.h
deleted file mode 100644
index 66a3ba64d53f..000000000000
--- a/arch/parisc/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ARCH_PARISC_SOCKIOS__
-#define __ARCH_PARISC_SOCKIOS__
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index 4680ba246b55..8fdae51d0eae 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -2,4 +2,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += sockios.h
 generic-y += types.h
diff --git a/arch/sparc/include/uapi/asm/sockios.h b/arch/sparc/include/uapi/asm/sockios.h
deleted file mode 100644
index 18a3ec14a847..000000000000
--- a/arch/sparc/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_SPARC_SOCKIOS_H
-#define _ASM_SPARC_SOCKIOS_H
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* !(_ASM_SPARC_SOCKIOS_H) */
-
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 322681622d1e..1d489e6b237e 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -6,3 +6,4 @@ generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
 generic-y += poll.h
+generic-y += sockios.h
diff --git a/arch/x86/include/uapi/asm/sockios.h b/arch/x86/include/uapi/asm/sockios.h
deleted file mode 100644
index def6d4746ee7..000000000000
--- a/arch/x86/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/sockios.h>
-- 
2.18.0

