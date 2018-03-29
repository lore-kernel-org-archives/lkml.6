Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx4+JO3FjVlAyUgdBf/Xh9CLq6UZE+Xnjaov4KagUdNpgNIOD/Z9kX+TVU93NIkXqJ8dTIC3L
ARC-Seal: i=1; a=rsa-sha256; t=1522330024; cv=none;
        d=google.com; s=arc-20160816;
        b=MRtx+adduVkzgWbADsaAQ3dWjz5yTqxpa6DaM+gdmvMynnPg7rvT16+GiRJmkdiGEj
         G8rhbKBunxI2gQYgjQ4HRXxK4s4Gx7yrqWSiaeSI1iwcQGTUdmdm8JFap0aDJksr2hnV
         VZDEU8zXNWgcU7HA2Ni0yApdw5GjJ71idNlQ3Iv3kQ0mjPYVjIGuhb4f3OsOmgCsEZvA
         TXdObtuw0tGUjmyQ9X5YxYZiJo50Tx+x+aa/MTCytAWGM5bK05mYas9HdpEgg/zL8VZj
         FHp+gXima+f9skxB2WWKdhWjem/49sGxAVAMein1QGDQrQN5+dJca2zkSBeNjadmjOd4
         Hc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=Ai/bc4A5R0+oW/HArM20Ix9jpwilGiTZNaQPmg8wf2s=;
        b=S93ybRfNy+ZZ/IWLhHzyxa39LnLZv/0z6D5Ac3mTkIIuxr+AIhVz4DlvIWU9Zmb+5P
         5jEDhPRhJ6H148gO5abMM/w/z25YMJOUNQbTTRu1I/nfQTYpgeFU+gdow85KLXZkCfyp
         9hNTAfuP+4GNn+QD6bDpqJaYnKJfFaRdXLIpq5fKlPe5tDEYY9Mrjwo1gtzqq6Jeg+jU
         lNzGMFRr+Hp+c2krTTBbvRzRTROd+X0xEdDme0jZ4Pru/VpG8QmD2QdZhu/a0bko1QFj
         AEAXlPTgZCpOA63+F0fFgfL5f9w0OtU4HeYZOMpxjf5zNfTa5UtH+0y/HWM+P3pTMnt1
         xYWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
From: Matt Redfearn <matt.redfearn@mips.com>
To: Palmer Dabbelt <palmer@sifive.com>, Antony Pavlov
	<antonynpavlov@gmail.com>, James Hogan <jhogan@kernel.org>, Ralf Baechle
	<ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, <linux-riscv@lists.infradead.org>,
	Chris Mason <clm@fb.com>, Yury Norov <ynorov@caviumnetworks.com>, Jeremy Kerr
	<jk@ozlabs.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Bart Van Assche
	<bart.vanassche@wdc.com>, Rob Herring <robh@kernel.org>, Nick Terrell
	<terrelln@fb.com>, Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
	<mawilcox@microsoft.com>, "Albert Ou" <albert@sifive.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Tom Herbert <tom@quantonium.net>,
	<linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v4 2/3] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
Date: Thu, 29 Mar 2018 11:41:22 +0100
Message-ID: <1522320083-27818-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522329921-321457-5536-21429-1
X-BESS-VER: 2018.3-r1803262126
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191513
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596278727179737524?=
X-GMAIL-MSGID: =?utf-8?q?1596278727179737524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When these are included into arch Kconfig files, maintaining
alphabetical ordering of the selects means these get split up. To allow
for keeping things tidier and alphabetical, rename the selects to
GENERIC_LIB_*

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

---

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
