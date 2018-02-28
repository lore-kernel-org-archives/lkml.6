Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELvY5LyBepIOfnsmdklgglexGC9E1iiZ1G2V4jA7ar+1JvYbm555BnQTNh5iHZBn/HuaBJ9w
ARC-Seal: i=1; a=rsa-sha256; t=1519855652; cv=none;
        d=google.com; s=arc-20160816;
        b=oKIhOkG7us9NJt35wqu1M9D8ATKc1FaVGCLkw1MFOzao+QRDH7LhTNbJ7022WN3xpy
         CIgQrN++5VIO4IPiyDi13EdJvYHaYDliNxgTB47q1SOUOne7ATeo8bdRejW3GnN3Etvj
         bKL3zHtX7IMErSROlow3OWNS7S08KjARCJY9cSkmxJe16VRj6WXabDCnaxF+UJIM70Zw
         PVRjFDwFRe/N+rHtSjzwub9zg36oGneFZccWsSjiMguSYhbiQGaUACrUExFAsFeUkDmT
         qUlYCkWjPiYqai5XoV8Vg8NxvRtxht3bgJ7xSAmbmixzGU0pJIky/9Zm44pUTYWIQPWt
         xsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rN3giRi+Nev6a16TArNPeUyHIXQID4ZWZP7BqTgawvg=;
        b=cwdnC2QmAkdPLleStGxpOuKUlNCiXyYdObJbqkagVx4pcRlXmoAUjb6LxTjaAEi6yI
         aw1O/NJC7hAiGPTYV1jEwZpRs4UB8UK+a91U0jdUUdt68AMUpl5fdt3TIIOgxrMFZfSU
         ZPSMfvBOjKfRGdoygCuuETbms+Ss2jdALt8CeldOnOerMJTWXqf/C0Q8AnHIqxwIF21J
         ZXPvIw9C0kCCTgYPeHhHx2nw3gvsaFIPMKJPHRTCdK1EH9BIR+fIypp04ty81TIzz1J0
         mgVuINdmV8Iukr5/Xu8ehzNUMQI71suMUkB936gtGbenM2SAV5TYz5isnU6z4jJN9jsX
         9sSA==
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
	Jeremy Linton <jeremy.linton@arm.com>,
	Geoffrey Blake <geoffrey.blake@arm.com>
Subject: [PATCH v7 12/13] ACPI: Add PPTT to injectable table list
Date: Wed, 28 Feb 2018 16:06:18 -0600
Message-Id: <20180228220619.6992-13-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684160869346370?=
X-GMAIL-MSGID: =?utf-8?q?1593684160869346370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add ACPI_SIG_PPTT to the table so initrd's can override the
system topology.

Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 7bcb66ccccf3..b2efaa503c34 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
 	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
-	NULL };
+	ACPI_SIG_PPTT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.13.6
