Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513048-2-3840961816083399317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.67', Host='mail-pl0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513047; b=dGugEeEE95aBrikr+tJjFHVEZQcnRfU/Obstl60irWAi86J
    HV4ebWKYXFL2YIOiexsFVHcAKyBg5md5bjWLbQjwKgN8FYFyRIPZtKpPqWiKJkkF
    gcXffDTgGE7L35QuJC2utURA/u0JZLmrkuHfqpcE7mjp7aau9uD2Hd9N20cyzqFd
    bxW3/Lugt5ivwN4ozk/DW1hv/QDpimRYsRJP67lVEcwiUaaO2fUu52rFZG99bfFS
    XXG9AZAarb+2rMun/WLVlxpkFDckRCRR4f03Nk+jKwJeeB0mBIOJ4uUIg6oiPuhu
    kOXSrC4Wx7SNfAD7cMKn4Ypt8e3WjVIdAZr+axQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513047; bh=6Hccp1w6lfWdEImsVwNtq4as/iGji50NQFu3DnbEjfQ=; b=g
    dF6qScqNc6lqp0i9oEQWkFxR6UxCYd5CyiEGqznjTUST350CwIQ41RxwmwaHu+86
    nxNE/vMpEh9MORG8aTJgLygZ8Qqjd+ZAj8dfPwH6uJbu0qJxmeMZTidQ+JHpmJdq
    uoQ4CxFHf0C11r07wJd7/REuACg0FIsdSwoC9ShYr5MJwq3Y6xJ0aAfRCEdEdleP
    BaTCpyrKRKkuLnrg6G907mVWzI2v0aFR+sL65rYrZ2+Be36373gZqtHVXAwvlQCL
    W4Rw6SS5kdoSdCJLHTSA4LZXngr8Ks4hoEn83lBffDv/84z8/jL7bCInYiXkfKjO
    GzjAIdgJkmoz4q1/jJ7kg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uzuZ84tI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UPwzsD5P;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uzuZ84tI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UPwzsD5P;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224ZHjvblwciVSbYCY9BqxWO4cnEPEHd93HF2AXVXPpb/0F679lX9PMsXF0sW1hLuNL/mHEznQ==
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
Cc: green.hu@gmail.com
Subject: [PATCH v7 01/37] openrisc: add ioremap_nocache declaration before include asm-generic/io.h and sync ioremap prototype with it.
Date: Tue, 13 Feb 2018 17:09:05 +0800
Message-Id: <a5d727ac3c73a02c1ef3eff81be1494b1fad3644.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A future commit for the nds32 architecture bootstrap("asm-generic/io.h: move
ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
in order to suppress re-definition errors we need to setup #define's before
importing asm-generic/io.h.

Also, the change adds a prototype for ioremap where size is size_t so fix that
as well.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 7c691399da3f..6709b28a0221 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -29,13 +29,14 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
+#define ioremap_nocache ioremap_nocache
 #include <asm-generic/io.h>
 #include <asm/pgtable.h>
 
 extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
 				pgprot_t prot);
 
-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	return __ioremap(offset, size, PAGE_KERNEL);
 }
-- 
2.16.1
