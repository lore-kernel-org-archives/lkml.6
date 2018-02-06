Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeBFGmA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 01:42:00 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:37444
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752054AbeBFGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 01:41:53 -0500
X-ASG-Debug-ID: 1517899309-093b7e4cf11fb90001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Yang Shunyong <shunyong.yang@hxt-semitech.com>
To: <rjw@rjwysocki.net>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Jiang Yutang <yutang2.jiang@hxt-semitech.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v4] ACPI / tables: Add IORT to injectable table list
Date: Tue, 6 Feb 2018 14:37:12 +0800
X-ASG-Orig-Subj: [PATCH v4] ACPI / tables: Add IORT to injectable table list
Message-ID: <1517899032-39073-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1517899309
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4997 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47617
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loading IORT table from initrd can be used to fix severe firmware
IORT defects temporarily before platform/BIOS vendor releases an
upgraded BIOS binary.

Moreover, it is very powerful to debug SMMU node/device probe, MSI
allocation, stream id translation and IORT table from firmware.

It is also very useful to enable SMMU and devices behind SMMU before
firmware is ready.

This patch adds ACPI_SIG_IORT to the table, which enables IORT
from initrd to override which from firmware.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
---

v4:
Add more accurate description for fix operation in commit message
according to Dongsheng and Hangjun's suggestion.

v3:
Add more detailed commit message according to Hanjun's suggestion.

v2:
Change typo ACPI_SIG_PPTT to ACPI_SIG_IORT in commit message.

---

 drivers/acpi/tables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 80ce2a7d224b..7bcb66ccccf3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -456,7 +456,8 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
-	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
+	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
+	NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
1.8.3.1
