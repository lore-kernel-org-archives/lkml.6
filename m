Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513057-2-6492935955690791488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513056; b=kmbV81vDOpRNbpFphcAsg0MeYtECFhhffjID5sZgs6cF0er
    SuMLHGUjSg7jQfgRoIL9s6+TaulIRQ9RSSQQnOYy9cpDcddfB9luZs+YHUzYyuBh
    TjTzK/tk60GPwAfAlY0hVF1l8LSNEW5sjQKRMJFQRyppLnemPzUSklZnuj+NDMUm
    sCGyIujkW0nvdHNryBYNXziH9nENvSlfsIgllD49XavMDhJab1tTajmbTOol3XwW
    BzxD1OPNHujLaEYYoasbKuGSHdGhzC/dptaZiIr+9CBaZp86b7lDUsrfR0b0mPwg
    PTiBhgoCYZjuzVD0l0Q5I1LzUj0c/aRo5ZxNWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513056; bh=ysOgTqE6RhoVaXB60FgQNE8hMyB4z7Rf6ZJB+VnT6a4=; b=i
    AXEDnyFMbvCC3Ez7wn4cRGZv4lptoqUGVjm+FZuyhenbs9PfKTIigscqZSqBQ32j
    EZCIomv/lym5KoN71MsDGfSMy/OPhL1boae1UNgX+wliWpIyeQ4N0mvu1ip1Za0A
    MrP/dvmZ09sJzD0Hl606bPqskCpDDu6VpDZPts+A3i/HpEczrYu/aKONWTs86aJm
    eJ9lRXxyAzyyd4gPnOH1Oe3SnlHCW4sy4p8QmKcMM98L9aAVJtEnmXsTlLb29q4C
    o/wG/nRNqtQvl+MmallHXqeS3wP1jHtMrMbdr/PTl37Um/C28qm0vXIjJ9+9IrWZ
    PTtApVK2I8LMy2He9oysw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ix46k4bw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r+riQggm;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ix46k4bw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r+riQggm;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226sp1kL7gqu8def5xsohf2dzk5bHymksoSpaKVdIcSoM3isUeLzFSVdjGdnRnqW/TcjsBWZgQ==
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
Subject: [PATCH v7 03/37] sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
Date: Tue, 13 Feb 2018 17:09:07 +0800
Message-Id: <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of	ifndef CONFIG_MMU")
will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
in order to suppress re-definition errors we need to remove the #define
in io_32.h.

Also, the change adds a prototype for ioremap where size is size_t and
offset is phys_addr_t so fix that as well.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/sparc/include/asm/io_32.h | 5 -----
 arch/sparc/kernel/ioport.c     | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index cd51a89b393c..df2dc1784673 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -127,12 +127,7 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_nocache(X,Y)	ioremap((X),(Y))
-#define ioremap_wc(X,Y)		ioremap((X),(Y))
-#define ioremap_wt(X,Y)		ioremap((X),(Y))
 void iounmap(volatile void __iomem *addr);
-
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
 void ioport_unmap(void __iomem *);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7eeef80c02f7..3bcef9ce74df 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -122,12 +122,12 @@ static void xres_free(struct xresource *xrp) {
  *
  * Bus type is always zero on IIep.
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size)
+void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	char name[14];
 
 	sprintf(name, "phys_%08x", (u32)offset);
-	return _sparc_alloc_io(0, offset, size, name);
+	return _sparc_alloc_io(0, (unsigned long)offset, size, name);
 }
 EXPORT_SYMBOL(ioremap);
 
-- 
2.16.1
