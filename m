Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513253-2-10944088748855928841
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enrofr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.65', Host='mail-pl0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513252; b=EbzcodD8Dks97GgpVboC2yB6vm60rogrpnGtdA/vPqOZ1nA
    c0pXwb/eWCFgfcW9V1gMzS89tgektfHYnf4NCbm6W11iyf7ezkEZAzM2nkke7A0N
    I6bYXwThsV3UvcU7KEGNSvfW/gzAVSDswfECnHlcpy1tAME4IZYBt5zH0MNbxdYP
    A0pQmu4i1wNl31XXKm7DAlllKzxIrDyEk4pqKhWOkNcasvEgQgjejtjl+fIHSqfC
    UbPKCTcjv7+531K4FIdPo6gEXVCBj1eU0pYEJQYG7cG20SGdmUqhmvrrZYlFSAn2
    JzuaAJE75lSiJoDTq/W53Yt90phS1AXSL5Y1wJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513252; bh=zLVet+OWhr997Wwul3+mbiHPuceMesvlfi3Ik7QpOQk=; b=g
    b/RBejF8rX760MILfbb1goEIDYMPjlUQc3sygbya2OT5qD0u2TSGtPxzgjdAj1XJ
    xKKjFIPPiAv8UPwSfi28k3vY0zgP/daQ91nTz2yb1PfUkl/kbs3rhSy26JjT5MaY
    cp9Ss0U9Dma7o5iPG1LBE4Cz6OKc4oAK89t3kjupXJ8kE2fC4ulKT7yBAjeG1SWL
    G0AUr6OemIDCxT3ur72j1yPVgEy0cG0za4vtbs+C5ReEK4J0tvFgnKiczsqx4Thi
    pWIaVSZkygueNWlkbmVEf6VD31B6vcFW2UwoQsjzia22uJ99RJz61Ho2YtWsDjop
    0GQdpeWqeo/d7SLLEN9fA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ihDMITE+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.65 (mail-pl0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tH66rMrC;
    x-ptr=pass x-ptr-helo=mail-pl0-f65.google.com x-ptr-lookup=mail-pl0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ihDMITE+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.65 (mail-pl0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tH66rMrC;
    x-ptr=pass x-ptr-helo=mail-pl0-f65.google.com x-ptr-lookup=mail-pl0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x2240jRXGTzKA7oeV8k4y98zm6y83s6BMUK/KpqT/WG0MzCn4h2l5C3bwJ54BbgHNdIrX4ZdiqA==
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
Cc: Rick Chen <rickchen36@gmail.com>,
	green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 2/3] clocksource/drivers/atcpit100: VDSO support
Date: Tue, 13 Feb 2018 17:13:18 +0800
Message-Id: <43bd7f8f5379f2c63af9dc0672e19f0e4671d425.1518505425.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rick Chen <rickchen36@gmail.com>

VDSO needs real-time cycle count to ensure the time accuracy.
Unlike others, nds32 architecture does not define clock source,
hence VDSO needs atcpit100 offering real-time cycle count
to derive the correct time.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 drivers/clocksource/timer-atcpit100.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 2190096cffa3..5e23d7b4a722 100644
--- a/drivers/clocksource/timer-atcpit100.c
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -18,6 +18,9 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include "timer-of.h"
+#ifdef CONFIG_NDS32
+#include <asm/vdso_timer_info.h>
+#endif
 
 /*
  * Definition of register offsets
@@ -204,6 +207,17 @@ static u64 notrace atcpit100_timer_sched_read(void)
 	return ~readl(timer_of_base(&to) + CH1_CNT);
 }
 
+#ifdef CONFIG_NDS32
+static void fill_vdso_need_info(struct device_node *node)
+{
+	struct resource timer_res;
+	of_address_to_resource(node, 0, &timer_res);
+	timer_info.mapping_base = (unsigned long)timer_res.start;
+	timer_info.cycle_count_down = true;
+	timer_info.cycle_count_reg_offset = CH1_CNT;
+}
+#endif
+
 static int __init atcpit100_timer_init(struct device_node *node)
 {
 	int ret;
@@ -242,6 +256,10 @@ static int __init atcpit100_timer_init(struct device_node *node)
 	val = readl(base + INT_EN);
 	writel(val | CH0INT0EN, base + INT_EN);
 
+#ifdef CONFIG_NDS32
+	fill_vdso_need_info(node);
+#endif
+
 	return ret;
 }
 
-- 
2.16.1
