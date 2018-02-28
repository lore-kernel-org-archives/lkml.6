Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELtJkxvqvy57h8h+GcHLx4CSTbiR2C/5Fnn6OEt6KPGQ1OL3xpTEQknUi7xOrWXiSACvzJQB
ARC-Seal: i=1; a=rsa-sha256; t=1519855639; cv=none;
        d=google.com; s=arc-20160816;
        b=hadBxaYF+ZsBn5w1mrr+atJemWA6vToaXqn4x1lFTgOdH3Qyl/QCDpblrhf4bUo60G
         wMvE6+1c2MnAHyAvPF/SxmznFOvPH0Va+PJMU2MCj7RgekfeBgeRm6oORPMDyMrJqGcU
         b78OugC4YhCzrNFo1c4v1E6oiTWQEz1mI9cvJRv8YyJ/th5CHh22HTrWDXh8cfWA/p/w
         LzVaDBPG8megnvm8pm0kAXl09a94X7fWECjQ+v6DlBYdJ5R87rssHUD7fWKEoFKMd96y
         r+GY+00crkHOPAkaSwhE90AhWpT/lFbiJhiADGQZeN328HrtENE59u4vnFGYVSUTh7m6
         niWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=X8oIGhkK37WMHWcgEZvYNTfwfcW2tjL2fvwAWo6swsY=;
        b=F8k4xYL36Jjh/+Y7/Z3uQ02VOvNmeBqoab/aI9HgAFyz15b0/08oPLraiqpmsSuuxx
         kPBuAUTKle6dy+aBIEuX7ts1l2wfRqrngcANS4u7ULnxKs8Q9savOb81luJgRyEoIvR7
         ADhKdrKktyg3yHS6E2DQH7qNyl4HuIiSsREhjbCfrL8lwuyQWFVcoCA4f5hTeFXzvvFM
         R57ln61IrOX6E8opKEN8j8IFE2aMCCGaQbGX2QprBnVOvOk9w1nZWlkjItgGVmpKDRCM
         AVMemN6yEkWGT6L7I8BuCCpbcamF6ckPD4NuVkqngT8QJxnzY8LFJWBnkRhRYZPpuke8
         8XGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 04/13] arm64/acpi: Create arch specific cpu to acpi id helper
Date: Wed, 28 Feb 2018 16:06:10 -0600
Message-Id: <20180228220619.6992-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684147211561477?=
X-GMAIL-MSGID: =?utf-8?q?1593684147211561477?=
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
