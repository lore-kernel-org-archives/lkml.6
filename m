Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELvH66jaEKzxy3YwTJ6dHUW9XJ045kPjogkW1Hj7kWvDJaSLbZEvfgNpGBj3LNitPdJ4M1Ss
ARC-Seal: i=1; a=rsa-sha256; t=1521215350; cv=none;
        d=google.com; s=arc-20160816;
        b=byQI5OPf4JgnBLUVAO+94wo7G2jydTmFcBuoHRRSeLd95VRiRBf8ceG2IC0vhuD9OX
         8YC5rY7Cgpr88Eu1aZ9bsSwkwpKe/eubY9fII1NJ/n3BtjxbcjLJ9fteJNXKHZh2n2+w
         t+0uBIsADbCcP+FOs7bRClwbllt0G9CqCBKaKtvYKiQI4uoVgqm5KW7LiMj8rxIpIBHH
         sgzkrlPBTzl14Id3otRGyH0yj/dqjr1m5233Ki9XIgOvVkE/KpJlodDNa16ArsuBtKsi
         Ep8osY843KcjYEs/0+jqBTBaDWJe7/cIPfU6JFaCpGB/+EYJ7u0KEC8ynyRnT23g0iBA
         er/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=lvEEXKeDYMuD8/6qjzClEzfkfBm4WHE6w/P6yRMe56g=;
        b=khHM9fnJkAXVxpHv41Rv9tfKZiqGpoLDmBk05c3bvupwLT3gV3OawE8jHb6jq3NTYa
         MRs9/asN+E3V2LZISwqXyf5/Ph9eS267M5ohXHPP1NCcLtTK2gj6pasWL9JgzgiohCIV
         IcYBwEF+jzQUGOuhKtsyHwaFp7VFrdPMN7DBUbypm1JhK8+bgbrcRD/9SYf3s/kNac7z
         xrOZonqxZrrOkN+beDUnbOQM4NMTfAOoFdrM0dw8zdudtbONt7Po/KY22MjnUbU2cHsL
         6LMrC/s5JVcOf27Nw3dMIo+I2bdTfTr5pU4V6WeCW85ijuAfmCS1xjeEztS5CLvmgkyK
         DNeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 16 Mar 2018 09:48:45 -0600
Message-Id: <20180316154852.13206-3-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180316154852.13206-1-logang@deltatee.com>
References: <20180316154852.13206-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jejb@parisc-linux.org, deller@gmx.de, pombredanne@nexb.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 2/9] parisc: iomap: introduce io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109907866667170?=
X-GMAIL-MSGID: =?utf-8?q?1595109907866667170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for io{read|write}64() functions in parisc architecture.
These are pretty straightforward copies of similar functions which
make use of readq and writeq.

Also, indicate that the lo_hi and hi_lo variants of these functions
are not provided by this architecture.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/parisc/include/asm/io.h |  9 +++++++
 arch/parisc/lib/iomap.c      | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 27c62baa9c4e..34c133066d3c 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -311,6 +311,15 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  * value for either 32 or 64 bit mode */
 #define F_EXTEND(x) ((unsigned long)((x) | (0xffffffff00000000ULL)))
 
+#define ioread64 ioread64
+#define ioread64be ioread64be
+#define iowrite64 iowrite64
+#define iowrite64be iowrite64be
+extern u64 ioread64(void __iomem *addr);
+extern u64 ioread64be(void __iomem *addr);
+extern void iowrite64(u64 val, void __iomem *addr);
+extern void iowrite64be(u64 val, void __iomem *addr);
+
 #include <asm-generic/iomap.h>
 
 /*
diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index 4b19e6e64fb7..0195aec657e2 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -48,11 +48,15 @@ struct iomap_ops {
 	unsigned int (*read16be)(void __iomem *);
 	unsigned int (*read32)(void __iomem *);
 	unsigned int (*read32be)(void __iomem *);
+	u64 (*read64)(void __iomem *);
+	u64 (*read64be)(void __iomem *);
 	void (*write8)(u8, void __iomem *);
 	void (*write16)(u16, void __iomem *);
 	void (*write16be)(u16, void __iomem *);
 	void (*write32)(u32, void __iomem *);
 	void (*write32be)(u32, void __iomem *);
+	void (*write64)(u64, void __iomem *);
+	void (*write64be)(u64, void __iomem *);
 	void (*read8r)(void __iomem *, void *, unsigned long);
 	void (*read16r)(void __iomem *, void *, unsigned long);
 	void (*read32r)(void __iomem *, void *, unsigned long);
@@ -171,6 +175,16 @@ static unsigned int iomem_read32be(void __iomem *addr)
 	return __raw_readl(addr);
 }
 
+static u64 iomem_read64(void __iomem *addr)
+{
+	return readq(addr);
+}
+
+static u64 iomem_read64be(void __iomem *addr)
+{
+	return __raw_readq(addr);
+}
+
 static void iomem_write8(u8 datum, void __iomem *addr)
 {
 	writeb(datum, addr);
@@ -196,6 +210,16 @@ static void iomem_write32be(u32 datum, void __iomem *addr)
 	__raw_writel(datum, addr);
 }
 
+static void iomem_write64(u64 datum, void __iomem *addr)
+{
+	writel(datum, addr);
+}
+
+static void iomem_write64be(u64 datum, void __iomem *addr)
+{
+	__raw_writel(datum, addr);
+}
+
 static void iomem_read8r(void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
@@ -250,11 +274,15 @@ static const struct iomap_ops iomem_ops = {
 	.read16be = iomem_read16be,
 	.read32 = iomem_read32,
 	.read32be = iomem_read32be,
+	.read64 = iomem_read64,
+	.read64be = iomem_read64be,
 	.write8 = iomem_write8,
 	.write16 = iomem_write16,
 	.write16be = iomem_write16be,
 	.write32 = iomem_write32,
 	.write32be = iomem_write32be,
+	.write64 = iomem_write64,
+	.write64be = iomem_write64be,
 	.read8r = iomem_read8r,
 	.read16r = iomem_read16r,
 	.read32r = iomem_read32r,
@@ -304,6 +332,20 @@ unsigned int ioread32be(void __iomem *addr)
 	return *((u32 *)addr);
 }
 
+u64 ioread64(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read64(addr);
+	return le64_to_cpup((u64 *)addr);
+}
+
+u64 ioread64be(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read64be(addr);
+	return *((u64 *)addr);
+}
+
 void iowrite8(u8 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
@@ -349,6 +391,24 @@ void iowrite32be(u32 datum, void __iomem *addr)
 	}
 }
 
+void iowrite64(u64 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write64(datum, addr);
+	} else {
+		*((u64 *)addr) = cpu_to_le64(datum);
+	}
+}
+
+void iowrite64be(u64 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write64be(datum, addr);
+	} else {
+		*((u64 *)addr) = datum;
+	}
+}
+
 /* Repeating interfaces */
 
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
@@ -449,11 +509,15 @@ EXPORT_SYMBOL(ioread16);
 EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
+EXPORT_SYMBOL(ioread64);
+EXPORT_SYMBOL(ioread64be);
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
 EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
+EXPORT_SYMBOL(iowrite64);
+EXPORT_SYMBOL(iowrite64be);
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
 EXPORT_SYMBOL(ioread32_rep);
-- 
2.11.0
