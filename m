Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELv86+s+Bx+oLDF4xLczYJD9re8u6ioix4WJIJML/fCNgU4xfM+QmzH6uNB+Sp6qzlIIJ3lE
ARC-Seal: i=1; a=rsa-sha256; t=1521739035; cv=none;
        d=google.com; s=arc-20160816;
        b=onq4Wt2lFTaG/QiImrhwmnTNJOSxmlDCs9NzpRJzpefRW5il4bf4vQDIWlFYyjPlJu
         HnUcr5pNyXehuZGj+uiFT0F8oqIKMbqRnp4pi+qNmSVJd9Hu/nonY8toad0CSl//2+/w
         BbI/XM1eqKf/EmMElQlbzHAev5kHQmhfmC7henME4+sR300+dz+bTu5Vu7dx36NYwJMT
         RI5wG6Tfu6c+z4zPcHvdJK9Q77gq+jBjnn5Ln2INQlvv3tlBOzADynP1OwTBoyhlhCt0
         QguwnD1i2vUZHUp+isPgQZjS7Ibm9ztZrklLZFVXmdIey5gqEdH2i/DBU5M0XOvG4Jsx
         6ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=ZResSvF71S4b9JnFuePZhxuGdTdkgn2/HrjfNWEuCO4=;
        b=YV/d8fuNCU6fae9U2rEdZszVjvBB4htGPsDMu27RiZuJbnFDLpdFHbT0li6PUuCwKy
         YEYKXS9vzaN8B2cxUwvQAIsR3o4qqTk/fru5Vdzv4WBWYiFSxXtJUNRUarA6n51XQhWv
         DVdMSwvYsbFCgyExPdN+ayCRX7fXwjWSYuMobCKk/gzqdQNwuc5fPEDOLMslUQaz4neM
         PmKkddj2hWQQAhMeOgeqn+J1KP1+os7lxkRkBHu3fNNHJXFFb/Us6FHKwojPgPdaWTYA
         lVBkaPh/BwFPwjkJw5WYz2T93T19VGyEajWiN6hUAwSSPI5QDn7JfoWUHzg/Q8D2n+ED
         qSgA==
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
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Suresh Warrier <warrier@linux.vnet.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 22 Mar 2018 11:16:57 -0600
Message-Id: <20180322171703.4300-5-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322171703.4300-1-logang@deltatee.com>
References: <20180322171703.4300-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com, andy.shevchenko@gmail.com, npiggin@gmail.com, oohall@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 04/10] powerpc: io.h: move iomap.h include so that it can use readq/writeq defs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659030952058458?=
X-GMAIL-MSGID: =?utf-8?q?1595659030952058458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Subsequent patches in this series makes use of the readq and writeq
defines in iomap.h. However, as is, they get missed on the powerpc
platform seeing the include comes before the define. This patch
moves the include down to fix this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Suresh Warrier <warrier@linux.vnet.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
---
 arch/powerpc/include/asm/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 422f99cf9924..af074923d598 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -33,8 +33,6 @@ extern struct pci_dev *isa_bridge_pcidev;
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
 
-#include <asm-generic/iomap.h>
-
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #endif
@@ -663,6 +661,8 @@ static inline void name at					\
 #define writel_relaxed(v, addr)	writel(v, addr)
 #define writeq_relaxed(v, addr)	writeq(v, addr)
 
+#include <asm-generic/iomap.h>
+
 #ifdef CONFIG_PPC32
 #define mmiowb()
 #else
-- 
2.11.0
