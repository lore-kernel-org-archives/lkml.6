Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZrJoXPByrbCFfi+DzQjpTUBZtJg0TI+1c4hRcDDr5pc7kwYrMlcb0fc0tHyIEPK6OV/Eq/1
ARC-Seal: i=1; a=rsa-sha256; t=1524702373; cv=none;
        d=google.com; s=arc-20160816;
        b=LZ8ojx46bW1/MXT9p9IiCVbK5zWoGJo6+HXMD8qQBS13h+CDUo22y5AaHcWJGPYyA/
         DKVhFsj7W+YtT5N8BcY9eMIacl4ovFFiBo0/yACZoFkYSEli4jlWZqLsWSXw+QEyLpX4
         sOs/BtvS9HKcJReyfSegq4mp2NHuUkxpg2rv8SWTu/TWr6x4+PRHxsodolS8QEmrD7W+
         hMYpLvw1VZQbZ13LtRFxY//2YHGfPHTBC+ZFQ+b+QoF36PVG6SdoIvcIYT3LvzRIgHUv
         n9/rrvQckXZF59Dt8dxZAK9tDZjiIgCsrNmfJkv30oNXvNx4LEGtZ1JBK6T+XDl/G+ES
         VGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=X8oIGhkK37WMHWcgEZvYNTfwfcW2tjL2fvwAWo6swsY=;
        b=P8lsP9RO82nOG+irJEfjhYCpHaRyKKsVqQTe7UTEDRNKo3QidGuRSiVVTKKtpRvEg0
         bbkPglZQRtTUHMeOgPaEAyIIXPByvVD60vJyPRHcUD44YjNOh30C90bF9+/LqnwUJ5e4
         KySRf95ZAQ6b/O4BB09luNEnzqwDYrS8r7rd+lpu+4uk70XYfZAgPfE2e0zo3gtHWF8y
         E852EcRFuvi4RkGXLVRP3Q1mkpZxvtDVTaev507sdeMgfpW60e8Pru1NiKaalUlidR4o
         ON9YCS0cDFdEygzACshH9MquekpGbWKJwEFI2T1Fv8rRFAFxOYRovezNhfh6Z5WEX0MI
         gPSw==
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
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id helper
Date: Wed, 25 Apr 2018 18:31:12 -0500
Message-Id: <20180425233121.13270-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766316038693524?=
X-GMAIL-MSGID: =?utf-8?q?1598766316038693524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Its helpful to be able to lookup the acpi_processor_id associated
with a logical cpu. Provide an arm64 helper to do this.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 32f465a80e4e..0db62a4cbce2 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
+static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+{
+	return	acpi_cpu_get_madt_gicc(cpu)->uid;
+}
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
-- 
2.13.6
