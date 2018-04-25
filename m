Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx48A18qScVkzkg5QvNkirjHEwTLbT7u96VAVHHWSBj7JJytzbSY8Hxl+ne/NtAnA4qDONoTK
ARC-Seal: i=1; a=rsa-sha256; t=1524702386; cv=none;
        d=google.com; s=arc-20160816;
        b=E6zA6fvkGh8W5960p8FAl6BBoHwbxlQbDH73Nvswkun5oVeR9NGti5BlhcxN5Y1Xjq
         lntglVFXvUeHQSEtCbZGWwiic+SuajXCJjQkFOKg5wqGcEkrHEE93hoHicuR/HcL+7Ee
         490OUMAf4HAHj6uOcmxNl/XyFDCfhbNEvJ5drzzB1l8fjyWavjoBRxM9Zj/LeapdGX2r
         VSDFmER8uIJa32L1mFTNxmjOzhdbPIBqEZTNYhDhbKIJKLy/CJjc2/iRxbBu3/kK1PdU
         /2XpO4f8bvngB5cfHe409hKAYe67HN63NZUhwACaAFhPOq852mlEmvLh7dRFeLV6WGmY
         o8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DOJqq1MJ4p83qWOXM/ZoNm0Gwq13cSNLND7RvqHJu/g=;
        b=U3TaZhBTFh7G0Kfpz2UtihBLzRES8GCPZMTpgXV6XzGrKda0Xse9YtAAdtNsHF1Kjy
         4gpeygfj2ZTyo0JJlzQsUTudJhGXTsicN/lwDBU8oCbEqpb2mAsJSd4XjBDiVmqrs4ty
         1IMSJ4JAgo8a1IimqQpU9mjhgg7YTU6A2IJi0UViwVIshGM9h5cEUqqtuM5h3QUzdKzo
         riVrK0+x+RjA8HyPsF7gOOhVWUsOWiftMO33W047YcZxbIktgMS3H3daKOx20pfleso3
         wLh5MGvMSh8IJQXwk+jebgRmendhYWF8szOE0UZtNLSDDNUDYOjLsJ8d/j3Gjn8V/3E9
         1M9A==
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
	Jeremy Linton <jeremy.linton@arm.com>,
	Geoffrey Blake <geoffrey.blake@arm.com>
Subject: [PATCH v8 12/13] ACPI: Add PPTT to injectable table list
Date: Wed, 25 Apr 2018 18:31:20 -0500
Message-Id: <20180425233121.13270-13-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766329419145364?=
X-GMAIL-MSGID: =?utf-8?q?1598766329419145364?=
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
index 849c4fb19b03..30d93bf7c6a2 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
 	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
-	ACPI_SIG_NFIT, ACPI_SIG_HMAT, NULL };
+	ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.13.6
