Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x224ShvYQjNrfUZ2iy8qcMVmBfl4EnM4dT0Xa4otkjCUbBoIrzgL6Tn11ZJgB+TnyKMwEWHK5
ARC-Seal: i=1; a=rsa-sha256; t=1517586433; cv=none;
        d=google.com; s=arc-20160816;
        b=H6ZoGWm0FZa0QdfPbhHQUYVQieLbixKvOXmSS+YMwTOtk81d2t6w31ZanyTnESrBlZ
         vGUw/65JeosZTDPcKQ+YtPCHQCW/jAscAplAOMr3hkjGqfby99rwNGpsVM08ltmT1kxx
         O0OZpWvgbPwFtQUc1x8T8KLjnlRNM650ufwU9sZQvdkJSgWqxjqM8r+jDAtNyE8KBvu+
         IX/sRxg8QxobSuG9mT3QnHypgcYhfxPmOgNbcy7YLoSUHIWq+DF5O8qucuk0bswVKkff
         CSxRv5jFaQTTykVtxOjzC3O26GjepMj+hNpbDfLwibRePRgQRXvsTvOXXJmMJ0r2J53V
         iefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=wOYry3/reDkNznYD3EyWWs6IsDqD2hkfs/ti6M8gJ1c=;
        b=DmhMUmMjbumJUOO4WeH9MUsq7q97bmqgXEt06iZQtqsKNVS8pb6t8KX5JMmMPab52F
         blFv1iM06vCn4A4tFRAvmJpx+dR2V2U6vqaCO/VxGn4J/NScvT3mO+psMvf1pf9Ml+rf
         E5C/CNW/CmiDEPsPog/lh7VvL1g/e0/elA99DyxOCt7ArJ3DIVUDM0UH8155nh5Eg9fv
         POXqx3TPTXBqFazC0VftOqlFQp2dR24OPSPiTVuIp+xnadW+/05xsb4h6kWNk91OxjnX
         pgbaVVn4xmHSxJ+4ci/KzLNaHgIu/FWYTEfNIzcf6XHFQumtU981exLfRSnGmshdURMx
         jXNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.24 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.24 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>,
	Andi Kleen <ak@linux.intel.com>,
	Babu Moger <babu.moger@oracle.com>,
	Will Deacon <will.deacon@arm.com>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] locking/qrwlock: include asm/byteorder.h as needed
Date: Fri,  2 Feb 2018 16:40:44 +0100
Message-Id: <20180202154104.1522809-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:TsOBgWWVAzowO3S5IpWgn+9z8V3m3+ACevvCnQgbj5YYHS8FsK5
 NrLRnIEwaovjGRBaOyo8Tv2eUu5dpN2SgBe+SArQdZr5iLYSVzdDXpoPFlyT3bSN63ypmHT
 PaQnMlW8TOFab2/DQMubN+TJyktuNsytcM7YkKKjhQpDpOOnHfI/53A+Y4/iop1jL4SakrM
 OuWI5MlLME72e3VT+nnrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W92YmiA5Riw=:/X0ZQApivGwwCGdBR7SGkZ
 alMh8VFPSWCmM40dxR0bLcrQch4C+QHNn4QNYN8P8p6zIQ9a9cjWjilhZumZ6x0xODYk2OCPw
 qCNeq5+p13Vg6ZnHLOQ8LMKeseCHeimA5HNe2GrxREsr3ZwyhVG+SLySyiNRW/sUBB7dmuYPP
 4NcfPPERFhJ/cxm7JhT8Bhhf1wX1BzyTYz/nadUbCJ24BYbmkXoQmaHKrx9qNYktuHiylt/K4
 07ge3hlbXvOoxQA0AStLPOOv35qsWDngGYev06DgLZohnOpqyCmcZqPXyrfMgnB1ZvAR9pRwJ
 NtBMEAQMUw/SHTVXi7qboM1DbHzZMihY2PhFzNnJKUakhiGdDLEj/4jXGRDV4OqqMEVwFKp2h
 wxc9TCNbR1k4/ycOZRH0hsAGH6CCo4U35EJRXppfWcBlxuKEL7Uc59I9silBA2qQ2vJfWB0MK
 UI15LO6Ot5jABkenZFI0yG/6qeY8GkNDVnsAqStcyrstrjRj7aNvK/fIhxq4gAnL6Cd2wezBW
 m/BX6dDdRVFtThZBBEGSE3IUp9ydKkLDCekwhwDad0U+Uf9ckVkp45PXroMsPiS1SQsndXkt+
 gi98sMA1ydSpH6eS8j88nreRT8LTzvWKl/mF9Igu3fci/4fFAyWLy2qU4WI7kOhHicD1LQ/eG
 p6OEHOAfMZ9kQ5MYh7p5mHG9K1jKNh5jAdyDJe+fm+h/J1X6z4hXM21vbmrZZDSNERS7lWY4d
 +/LqOcMcTmQ50eDupE672kUDyC4GnPXc8kI2XA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304711998635461?=
X-GMAIL-MSGID: =?utf-8?q?1591304711998635461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Moving the qrwlock struct definition into a header file introduced
a subtle bug on all little-endian machines, where some files in some
configurations would see the fields in an incorrect order.  This was
found by building with an LTO enabled compiler that warns every time we
try to link together files with incompatible data structures.

A second patch changes linux/kconfig.h to always define the symbols,
but this seems to be the root cause of most of the issues, so I'd suggest
we do both.

On a current linux-next kernel, I verified that this header is
responsible for all type mismatches as a result from the endianess
confusion.

Cc: stable@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: e0d02285f16e ("locking/qrwlock: Use 'struct qrwlock' instead of 'struct __qrwlock'")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/qrwlock_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 137ecdd16daa..c36f1d5a2572 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_QRWLOCK_TYPES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #include <asm/spinlock_types.h>
 
 /*
-- 
2.9.0
