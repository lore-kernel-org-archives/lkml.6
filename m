Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELuPd1rnPia3c0lKfI5F/FAGzGHi0aQww1DyIFlHSydHVPCYVx+V4gRlnPIXT0XLVqe+UW1I
ARC-Seal: i=1; a=rsa-sha256; t=1521215346; cv=none;
        d=google.com; s=arc-20160816;
        b=Y4ckT65WoWLeRZGaGFDXAcBrXMFlCmhDArfI6XL1ObWzmxygoHlUUY7gRH0LVBNjPI
         bX6gBwS7Uc5Nu5DgreSyn3Pu82cuBk+d+NXN4LmRmatZtsfnVzFG4Xz3KAJwgr8YxV6O
         zadGhXjAvi4z92iPbTt6fWui+t+wBGtdsBU/fIveEiSetmXG2a05VDxlkvXHWxitwmOS
         412aOeAJHo9hqjBlONz4Oj+1Bwon9/GcnKLYoEJeJ9KVtRX+fS/8mij1zmAyhqSvC95f
         JGmzrUA4w6XMo0mxq0ef1dA8Ya3rxrt31X8hIjnYBLCKplRZzPlklle/dT5pt7fCNC1F
         cwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=ZResSvF71S4b9JnFuePZhxuGdTdkgn2/HrjfNWEuCO4=;
        b=XU/E1V35+pC1a5fMWpxVPHerLG+NKfczRyZBxL3M4z1R+3100fhD/RG6teXRVYI+Q/
         5SjjxDvyFRpivNEOTZiynp5mIsTndEUhtC1aJRM7B49RnQytg3EjGgYnRf5kt85ruH8D
         52DwmFdz+huG18o+c0vDVxtdC6Q9ytGQglJ8S19lX1dyQ7aWG67WXvF+zo97lZ5hgnwQ
         ZMpAqxdN5wwtUU3EJp3ANRa3R+Ap34+t9+zVBV9SkubgYrBIeHGO8U+bJnpVHzcOi29d
         +ONN3qxEawm6BhsUA+jP9gM3E06Iy+nAbNjzfXaf0SHAwaULdqtSiQREGibgSDvIflgA
         JqGw==
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
Date: Fri, 16 Mar 2018 09:48:46 -0600
Message-Id: <20180316154852.13206-4-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180316154852.13206-1-logang@deltatee.com>
References: <20180316154852.13206-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com, andy.shevchenko@gmail.com, npiggin@gmail.com, oohall@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 3/9] powerpc: io.h: move iomap.h include so that it can use readq/writeq defs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109902942535434?=
X-GMAIL-MSGID: =?utf-8?q?1595109902942535434?=
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
