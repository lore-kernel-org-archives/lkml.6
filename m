Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx4+G31RlKzX+Hyai+4bV5VHJ0WmfrIbHtpBCll152sjRc+iCJV6Tq3l5tPCAMe3KBMLnKtfa
ARC-Seal: i=1; a=rsa-sha256; t=1522747608; cv=none;
        d=google.com; s=arc-20160816;
        b=CXPNeBUphxEQMLAuf5dmJkn9P7CGP/H+42zZXsnqrj0kYHwTBLtc8LNacQ/yx04RMS
         +qLTkwnV8yQjRzAjkVQcHFy666jeRvYMddUKm5IzUVAtuiZW0E1z5ydnqLD69WfCaOp2
         Wk6kt9fnEwyZsmKOMJp4LVEQm+9kSjy/P0exX/ukqLT3k3h3UthxU98760S3wid+5+Rd
         3fhhzKane0gS6hSWTVUQJEo8lkhiPaD0nzSMjnesuGNHQLZShTlsiqkNCJSWEXz0F6ky
         OEoQzb69HFdDt/wDSaCIJJngv23X5S/UExeRklUsfoh47nddISMdrkwR5afasLpE6jXt
         lSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=An8jODE/5nAVtt3iyRuNX/N/NgsELRXi9MvugPgy7eA=;
        b=ZEk+CHPOYSqmNpCuv+GE8yCNgDkToXLWrXelQbNnk21QHYdVJmJh3RJOBo+SGigPcL
         /1vg7xiNijHtg4/pwzy5YgxiP57LSRZDkXjowcZaf5QBd1l1k0V8t1VTQd3cZXeC0bbD
         DJGNUhNbth3Lxti04ii/NdQ3OXMZM2ZcddtUFHoSFA3E1F4tOLoNuxnMMmnQFwzxTxjc
         c3ofZUAsEgrH+nRGeyQ53svObxTij7InsbeXMd1trK+6clrKno/aE8vR6eOS7gZMiP/9
         I46PxbrbRh4VlLlAiESXxf8wPK54FOZhwLu15hlSiqTMzXHLo11rqLgCJvPXVd62o21e
         fqAg==
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
	<jk@ozlabs.org>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Bart Van Assche" <bart.vanassche@wdc.com>, Rob Herring <robh@kernel.org>,
	"Nick Terrell" <terrelln@fb.com>, Dan Williams <dan.j.williams@intel.com>,
	Albert Ou <albert@sifive.com>, Al Viro <viro@zeniv.linux.org.uk>, Tom Herbert
	<tom@quantonium.net>, <linux-kernel@vger.kernel.org>, Richard Weinberger
	<richard@nod.at>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v5 2/3] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
Date: Tue, 3 Apr 2018 10:24:25 +0100
Message-ID: <1522747466-22081-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522747466-22081-1-git-send-email-matt.redfearn@mips.com>
References: <1522747466-22081-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522747462-452059-13822-47957-2
X-BESS-VER: 2018.4.1-r1803302241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191650
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596716596411217880?=
X-GMAIL-MSGID: =?utf-8?q?1596716596411217880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When these are included into arch Kconfig files, maintaining
alphabetical ordering of the selects means these get split up. To allow
for keeping things tidier and alphabetical, rename the selects to
GENERIC_LIB_*

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

---

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
