Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx49pqLGULivDD5l/WMRfOglnZ0tTJp7If4EY/HfmXw0y12YDW4DgLKxHidXWC0QB2I4Aezun
ARC-Seal: i=1; a=rsa-sha256; t=1522329996; cv=none;
        d=google.com; s=arc-20160816;
        b=pB1cXyMeclkWbjC2hTh2ARYLrRq+E7JJIUyw+vHj64nDImgL1Y1iu+CdzEMrABm+Tc
         F9zBwt1CvdtZSwSzD4jY0MQWtikYHB2aCZIhRoR7wy6yatukFlW8N7pJuKt9tcVAG91a
         ITRIZkq32A60hoGRuPCywGqnam+/3yhL5vH1ivfmq+C5n1EMudwhbA3Po8vaeWXM6s6R
         PqOktnkn+11GLGJxZl3y4F/jCH2o8DO/3NvDQSQb5+1DasRji6Q4cZyuzB3npSueYoWN
         +A22vu+ZyTi+D7Yvxt+UZFoaC7T3MMsGlvzNYrMmJNP3l96O+buCk95V8hrqYB5nboCK
         +SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=WtZJW3/PDwRmEx2o7KiwAM6JLc2uald6zhWxa1BEuls=;
        b=gMbLZTLjxZLIxFdwO1h03gmdHu4IRz/dxupfTM1fJUnNlPVee9QKkHfpZLhcpeMkPs
         ygX3+eDlGSiHJCw+TUFUUDjkpN3IwPvqaC/ULxnB6Id8OAuGkwxtKJLis+/ovBrwhzzo
         4aWeJE3VWggxk6+m2/4LSSsAXG64WcxT5Nawx3OJtQnVxq1fCuLass9FuPV85ihmTeYm
         yGXzQY/g02pT72NLFXd6KcnFGPwFn0n5HDMkEYA4T5JD8zPWfmofVs2eYqEO7WqNvCYj
         OxtbGRvrRdxMgL6rI/0QxYg/CRtLLNAfoPu9tD5cPTjqvIv564dNWJeU51FoRfgtNq87
         GGfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
From: Matt Redfearn <matt.redfearn@mips.com>
To: Palmer Dabbelt <palmer@sifive.com>, Antony Pavlov
	<antonynpavlov@gmail.com>, James Hogan <jhogan@kernel.org>, Ralf Baechle
	<ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Paul Burton
	<paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Al
 Viro" <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 3/3] MIPS: use generic GCC library routines from lib/
Date: Thu, 29 Mar 2018 11:41:23 +0100
Message-ID: <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522329928-452059-22111-59230-1
X-BESS-VER: 2018.4.1-r1803282120
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191513
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
	0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596278698028411080?=
X-GMAIL-MSGID: =?utf-8?q?1596278698028411080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Antony Pavlov <antonynpavlov@gmail.com>

The commit b35cd9884fa5 ("lib: Add shared copies of some GCC library
routines") makes it possible to share generic GCC library routines by
several architectures.

This commit removes several generic GCC library routines from
arch/mips/lib/ in favour of similar routines from lib/.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
[Matt Redfearn] Use GENERIC_LIB_* named Kconfig entries
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org

---

Changes in v4:
  Rework to use the new GENERIC_LIB_ Kconfig entries

Changes in v3:
  Maintain alphabetical order of MIPS Kconfig

Changes in v2: None

 arch/mips/Kconfig      | 5 +++++
 arch/mips/lib/Makefile | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8128c3b68d6b..98955a76c656 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -22,6 +22,11 @@ config MIPS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_UCMPDI2
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index e84e12655fa8..6537e022ef62 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -16,5 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
-	 ucmpdi2.o
+obj-y += bswapsi.o bswapdi.o multi3.o
-- 
2.7.4
