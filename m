Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx4/rGYpGHhRDq6mXJqfBKHEBlgECIK7smkFFxsT9ry65Y28v1H2DwrOuEJ02yZ0AP+huRCN7
ARC-Seal: i=1; a=rsa-sha256; t=1523433120; cv=none;
        d=google.com; s=arc-20160816;
        b=VZfeYqVEJkTJ8zqYhOwL3vZoIzbf8+B091uSbgbaS2IqCVm/plFz9NFnC+9Fv6Hf+z
         1h6w/lmLYzsVx2ef/YEAddW1wlehwvmmiulhwX0D+baGovvO5rG2hHulfpdZvs2sTyK7
         hFpl0HNSQHn6vI5ivJ3EKkIBAu1tCKsk24+fYIE72/ygYCDSR5n4VyRFDak6ZH4UiWTU
         L5ETyhDWouQ3jumroDxDZ0pfa47O0ERmNEr4Q0EO7aew+ZWtf0AMSKfThI/ypny/E3oC
         qlJpy0jnkwiflDQ/oaC4hp5+QK3bCz2C8Tt9m2in8L+TTqIE+zjqtkIh3wlG0O3PjinT
         3x7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=mkynRC8BEO1atYdJmgMNULAMqsZvMWJErtQFU9diRqw=;
        b=qfMCYki7/Hor/dXh93lNQlzHisK9vloN6h4QQXHfRQtzuI6hUknai9Mp9LWAOBdEmw
         jQPdCOgT+JpWjXUyyRRCLsO4H3qEPcx13IUZ8QPL2sFJqmjBa5R1Ug46aOllfJDmxyjJ
         kVlacozeJProvpV1Q58iCZ8Gqvi4TBHozMMcq4G/t1xA/zrgKRVuR95eYD5gblcJBSnb
         QCB9LuJ7FznFhG5Jx4n4xyWlX9IEV+hSHW1d7yzxzlZmp5HpIBL3XXfsFfOqvOvNmvp3
         LmlJCp/RgUrV7B6QFIJpVc3kZwrWjDoTaSLW5btiqV64qenRDN8yo3c+b2cmVkUf6zor
         ddYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
From: Matt Redfearn <matt.redfearn@mips.com>
To: Palmer Dabbelt <palmer@sifive.com>, Antony Pavlov
	<antonynpavlov@gmail.com>, James Hogan <jhogan@kernel.org>, Ralf Baechle
	<ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>, Yury
 Norov <ynorov@caviumnetworks.com>, "Paul E. McKenney"
	<paulmck@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>, Tom Herbert
	<tom@quantonium.net>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Jeremy Kerr
	<jk@ozlabs.org>, Nick Terrell <terrelln@fb.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Robin Murphy <robin.murphy@arm.com>, Richard
 Weinberger <richard@nod.at>, Albert Ou <albert@sifive.com>, Chris Mason
	<clm@fb.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton
	<akpm@linux-foundation.org>, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v6 2/4] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
Date: Wed, 11 Apr 2018 08:50:17 +0100
Message-ID: <1523433019-17419-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
References: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523433038-321457-11089-33080-1
X-BESS-VER: 2018.4-r1804052328
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191870
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597435408465760509?=
X-GMAIL-MSGID: =?utf-8?q?1597435408465760509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When these are included into arch Kconfig files, maintaining
alphabetical ordering of the selects means these get split up. To allow
for keeping things tidier and alphabetical, rename the selects to
GENERIC_LIB_*

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4:
Rename Kconfig symbols GENERIC_* -> GENERIC_LIB_*

Changes in v3: None
Changes in v2: None

 arch/riscv/Kconfig |  6 +++---
 lib/Kconfig        | 12 ++++++------
 lib/Makefile       | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 04807c7f64cc..20185aaaf933 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -104,9 +104,9 @@ config ARCH_RV32I
 	bool "RV32I"
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select 32BIT
-	select GENERIC_ASHLDI3
-	select GENERIC_ASHRDI3
-	select GENERIC_LSHRDI3
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_LSHRDI3
 
 config ARCH_RV64I
 	bool "RV64I"
diff --git a/lib/Kconfig b/lib/Kconfig
index e96089499371..e54ebe00937e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -588,20 +588,20 @@ config STRING_SELFTEST
 
 endmenu
 
-config GENERIC_ASHLDI3
+config GENERIC_LIB_ASHLDI3
 	bool
 
-config GENERIC_ASHRDI3
+config GENERIC_LIB_ASHRDI3
 	bool
 
-config GENERIC_LSHRDI3
+config GENERIC_LIB_LSHRDI3
 	bool
 
-config GENERIC_MULDI3
+config GENERIC_LIB_MULDI3
 	bool
 
-config GENERIC_CMPDI2
+config GENERIC_LIB_CMPDI2
 	bool
 
-config GENERIC_UCMPDI2
+config GENERIC_LIB_UCMPDI2
 	bool
diff --git a/lib/Makefile b/lib/Makefile
index a90d4fcd748f..7425e177f08c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -253,9 +253,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 obj-$(CONFIG_PARMAN) += parman.o
 
 # GCC library routines
-obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
-obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
-obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
-obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
-obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
-obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
+obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
+obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
+obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
+obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
+obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
+obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
-- 
2.7.4
