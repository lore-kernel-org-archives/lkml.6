Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513176-2-15972921791786680082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.67', Host='mail-pg0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513175; b=k10oZVw6R3QwfdgfqQEg4mozeQgygpgwNqwGkEWm+m1WO0O
    vKxkCz/do/SY3Gad1U5Rh/lzix3JDG3HXF84OWtarvYzxFL66UnoHNczgt+AVZpe
    mRZibRvhyB8l1BM0pzo+VtFG/O5k7VE8OA9h5nT5lHO7rbWuqktBNo0uuMXn6Edh
    duRvTnU5Ks0oG25WRiLdQRU/0irsABdf8PPFRhynu1ortcafSar4xx17dIgxIbgE
    VHxDFqKtveyH0KZWp4+A5YH9Invw1hCuJpS19Qd0Gv+vDQHwfPow3Tk6Zuioi86h
    LEj/iOtaGPMTuT4sroZgwoN6rOOnRIhL2M1DdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513175; bh=zX9koImdB7AhjRikenlNsExayxTbrJNGYAsjfhpGOH4=; b=a
    ifXOnKxa65pz4Am7wDBMSVz+vCBCipnQxXpnVOCEcvSW6pUUbKECg/89AAsmY9W/
    aZbL3tUDb4Rd5VaBKoXFcKroe55uuJnUt3U+6xPArVuOeyI9fAMHRoKD9N7QPqvF
    d0aUcb0qVSkXAIDNXv+fjsw++NH44324yUZdUAjfVvoA5nt3WrUZe2rKGKCQUOKG
    ymqbH7utIqppEI2qd9rY0+H5XHchSZqPOzS+TGVmCMV9lCE0cyo6Qkrth/Y6ZcJJ
    mnEJ6/ckSlc+Pr8cSnlRC+xGQTa2IL4jNRBXV1wFWXoQZCmmmiAgmmN9YKXo2sIt
    gxCU6Ad7jn0GKcJk0uhFA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kfvXFCxI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zyhs8hok;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kfvXFCxI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zyhs8hok;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225G5wN3slGDXhasEkgi+NR3SfoqJ7e6UxUVAFn1PThsZDkXprzUJM9GAM/mGR7khsPtcgp0Tw==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 28/37] nds32: Miscellaneous header files
Date: Tue, 13 Feb 2018 17:09:32 +0800
Message-Id: <1fe57da7da5849ae0d73e828067226149676777e.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces some miscellaneous header files.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/delay.h          | 39 +++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/linkage.h        | 11 ++++++++++
 arch/nds32/include/uapi/asm/byteorder.h | 13 +++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/nds32/include/asm/delay.h
 create mode 100644 arch/nds32/include/asm/linkage.h
 create mode 100644 arch/nds32/include/uapi/asm/byteorder.h

diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
new file mode 100644
index 000000000000..519ba97acb6e
--- /dev/null
+++ b/arch/nds32/include/asm/delay.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_DELAY_H__
+#define __NDS32_DELAY_H__
+
+#include <asm/param.h>
+
+/* There is no clocksource cycle counter in the CPU. */
+static inline void __delay(unsigned long loops)
+{
+	__asm__ __volatile__(".align 2\n"
+			     "1:\n"
+			     "\taddi\t%0, %0, -1\n"
+			     "\tbgtz\t%0, 1b\n"
+			     :"=r"(loops)
+			     :"0"(loops));
+}
+
+static inline void __udelay(unsigned long usecs, unsigned long lpj)
+{
+	usecs *= (unsigned long)(((0x8000000000000000ULL / (500000 / HZ)) +
+				  0x80000000ULL) >> 32);
+	usecs = (unsigned long)(((unsigned long long)usecs * lpj) >> 32);
+	__delay(usecs);
+}
+
+#define udelay(usecs) __udelay((usecs), loops_per_jiffy)
+
+/* make sure "usecs *= ..." in udelay do not overflow. */
+#if HZ >= 1000
+#define MAX_UDELAY_MS	1
+#elif HZ <= 200
+#define MAX_UDELAY_MS	5
+#else
+#define MAX_UDELAY_MS	(1000 / HZ)
+#endif
+
+#endif
diff --git a/arch/nds32/include/asm/linkage.h b/arch/nds32/include/asm/linkage.h
new file mode 100644
index 000000000000..e708c8bdb926
--- /dev/null
+++ b/arch/nds32/include/asm/linkage.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* This file is required by include/linux/linkage.h */
+#define __ALIGN .align 2
+#define __ALIGN_STR ".align 2"
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/byteorder.h b/arch/nds32/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..a23f6f3a2468
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/byteorder.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_BYTEORDER_H__
+#define __NDS32_BYTEORDER_H__
+
+#ifdef __NDS32_EB__
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#endif /* __NDS32_BYTEORDER_H__ */
-- 
2.16.1
