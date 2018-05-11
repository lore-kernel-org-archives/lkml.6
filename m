Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZr5mwN9lAt9E19DM1FvefZCnrbv2Bp3NaMWz5er21zpZKuuhdkvAYPECL80L0JTD5fxfFs6
ARC-Seal: i=1; a=rsa-sha256; t=1526083148; cv=none;
        d=google.com; s=arc-20160816;
        b=Ohr9Mn3P5eDnPHnFzlUniwlChN4SCDl9LXfA//gvydK6z/lTRAnu8yzD6IH0eBVR9U
         HYxCwTQWBwReuqX+DNkMyitYyVHbaF+Sy9qX2iXEoBuec+MBbHqRfFyVlz6Th+T66LFy
         boLA3buLLPmdcQ4ADRCBMMnGXwSkbpO7vMmxFsvMtI0e6o+c8Z9u7ZS0syB+nvf2CiR2
         9gdXPbjmkl+EP4Usn2vxoz4VBn9oDZeXapmFhwZ0sOVHulsil6sc747HDpHhnVsv+Upd
         TfYYXfTHBVj2pXeWq3srlNX4nMN+LN4gwsb0ph7pKVnCfqarkXyVsXd+1tSjFgXw6yLC
         yTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jRgENAY8BqSeGSYjNEZQnPGhbe7huTPJq64SRke2QnY=;
        b=tPWg5PHplnnLzzLpF0zkmvhyiEgy+HhGyppAQPhs629pJSRDgRka2pDNRM7hx8K82f
         thrC0MF4PjTvMTfOIQs3OaNZaVo156eYmrr/cgrkFam/fXtVBDkm2ZyTAjkwZpiYSYLx
         K1DStQHNxs4fI7Ss6BuheT427/ulQtv7FTJ6JrBibFpr1zd8wZX0y+n1FZYNPXMobZmd
         xxvjiFLVSICdMAIbZJfNlHCbdFBn2vsZWxCHe6qmUfeGRbh+UoR4UnPq9in8/ZIzVwQ7
         EukiAzQ80AY7ObfaGRoc0rMo+OVOA6fq3PlOCWUac/uDJ6HKDPoHcA9yZFdwoRzC3SUY
         H4CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 06/12] ACPI: Enable PPTT support on ARM64
Date: Fri, 11 May 2018 18:58:01 -0500
Message-Id: <20180511235807.30834-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214163752232944?=
X-GMAIL-MSGID: =?utf-8?q?1600214163752232944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig    | 1 +
 drivers/acpi/Kconfig  | 3 +++
 drivers/acpi/Makefile | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..cff33d9eff0c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 516d7b36d6fb..b533eeb6139d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -547,6 +547,9 @@ config ACPI_CONFIGFS
 
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
+
+config ACPI_PPTT
+	bool
 endif
 
 config TPS68470_PMIC_OPREGION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 48e202752754..6d59aa109a91 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
-- 
2.13.6
