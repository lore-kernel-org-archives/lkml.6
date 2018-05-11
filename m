Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZpMv/Y99KAhqPoBGUispbr/F0uzd+HkdaPFcTGwbDgzMbbBwHhF5j85ZBhNG5wCq5XrbEHB
ARC-Seal: i=1; a=rsa-sha256; t=1526083155; cv=none;
        d=google.com; s=arc-20160816;
        b=kwA9UalyEDnnFJ7I1Vs58fTGDA+Afhvh8ftFfG0UfPKkU3fzC8bteZ+ynXHxG4nwq+
         8fKQ9xEaO9sQb8kUlZWUGTBX1ztXCERQxPSmHdQ8bclPly0DrIYyD8KN7HOy/ida8Q1Y
         StihXuX1V+rQGHR7z5WmTnx6YQJ+beZo8TRyCzfC2hMSEpZ3FOV5A0RfhfIpe8KTVRPU
         9Q68dgtLVSUWyf9j//RvS0B9prc1z79bUCUlrOLzANB8ltwaP9TikPa1KM3H4ZfSs2Kh
         qvddzg4EQna0Waw3u3cJQD1GJjZ+ZKSVjRCTVwd8kv/wJWU7Az3hp1Husja/jkPvqkLI
         kukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DB0pBct4ccSptnvCXG86pljY0ZWaDTsn6qjVUUJotfs=;
        b=mcMCzGKeWAa8mmb94AzJksUEjcDg2uslAsX6hfDSweEAMq8Ch+UZlkjD5Ri467GboO
         apGmEvG1sfA3j4PuIAP/QUsmEUrI+wfUvhYSB87gDdyMe7+rBrsv8Zmd+Bh4H17MoPEy
         OTQr8KFXRU5lRONJY56I9RJPBS5+LKFVsGL0VLIn69WPDwxcplX9ANvgq6M+TrTnywoG
         ARLO5gOYYCcL/MnjYr2K7CGLD9fjr0ftW0GpWiNDOJ/Azs6HYOr7W5ACCQtbvBuBn/jG
         LM817YvCQWfW7etuqg/ODk4wg/b2FkOCyR2Kq70ZC23aKaE6Hya2tfdN61YqNlBsUKFJ
         EGng==
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
	Jeremy Linton <jeremy.linton@arm.com>,
	Geoffrey Blake <geoffrey.blake@arm.com>
Subject: [PATCH v9 11/12] ACPI: Add PPTT to injectable table list
Date: Fri, 11 May 2018 18:58:06 -0500
Message-Id: <20180511235807.30834-12-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214171156065873?=
X-GMAIL-MSGID: =?utf-8?q?1600214171156065873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add ACPI_SIG_PPTT to the table so initrd's can override the
system topology.

Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
