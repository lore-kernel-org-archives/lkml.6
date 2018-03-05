Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELu4Owl9PIeUsV0znf2UbDFU738OVlKWvAEX5Vm9t0E1x5Om7HbunRx0T0wks9VrTpbu4h3J
ARC-Seal: i=1; a=rsa-sha256; t=1520276930; cv=none;
        d=google.com; s=arc-20160816;
        b=Ih+zsgUNRTyNoIO+kPnZrMj7vQ4rsZLakb2i1TC9gkrfiFf3oMr3jwqRjeBzhwcAXK
         xgOXyH87MdEa6Aq6E8koHRRJ6JEVMpfgmSVXc2R7XET2g95ixYcIpgAM5ixiW2meEBZF
         M9WLK8UszNuwKNX3MIfbA/QylW8mrK8U2NLW3Ma9rna0azzy0Uu8Vld6caomxMSB6/FK
         MKnEpRz+hlwo4kiSi51In3tBTyra0ofk3D3bM08S96KTHQ8FfJ19rTN16/W1I1BLxltA
         Dbah6BjJ4FGUdKTM+JSgUPlYPZmtw01YPvL+fStfQZFMsfSIg/+BSvr6YohcUZhUzSIe
         3NhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=ZResSvF71S4b9JnFuePZhxuGdTdkgn2/HrjfNWEuCO4=;
        b=VYjbm8xU71cubItDnTsw6slc5Vo0mtAs9mYCFf4Lr5PDP/B8VGHyl/QrzZCF9PpgZC
         JkOHjoyWb57tq37jkNypKDFINdON4YParma2u70xjFkkt/6oqdv7uFwF/y0iif573hNe
         GU6MQsRGlSa5BYX9gZmXospgJPG+liILRjVtu+zLp3P7tGJLcD2WZEysYvcPcKR34FAH
         W5EZkqVPwfM4dpUCrJZJXoamjo4flTgO8uPp3RmpGl/xZQHo0wHLOnq9i9DAbqbtYKJA
         j6m20cQRU6Wgkb08GT6XUFdq49n88wARWot0OFmWq8vc2YNVKaEY1byk7Ul3SWOMzgRB
         o3OQ==
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
Date: Mon,  5 Mar 2018 12:08:18 -0700
Message-Id: <20180305190824.847-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180305190824.847-1-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com, andy.shevchenko@gmail.com, npiggin@gmail.com, oohall@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 1/7] powerpc: io.h: move iomap.h include so that it can use readq/writeq defs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125902614908066?=
X-GMAIL-MSGID: =?utf-8?q?1594125902614908066?=
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
