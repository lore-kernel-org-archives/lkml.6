Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AH8x225PTLX5dNZbJRSEsrONxgTmh7cjG4Z1+UTyPMt9yLCl0Wj5nduG8rBnikQg//K3Lh+OY+p/
ARC-Seal: i=1; a=rsa-sha256; t=1518009808; cv=none;
        d=google.com; s=arc-20160816;
        b=YUH9Nb4uWYLJ4N4llMjNdN3Up7qf0Bp24opRjSXVsr349JFDcxdOVfF2an64EV24Zl
         ekFh0Awj3NzNPERKnuoswc4VNBMx1mG8akNpsDwuxZdTIgI5nphRUjCM3bzmZ2UyEHT4
         8MMLe372jrVdUW6TLZ1ENqUGSGR2jJCDU4axtJKCHWunzUs0RMqFbUORvAaFrc3XRsAP
         QiAeYaQ6fHKkjpF2iD8eCIzclm7AMiIuguejer45+OJBKHdDJL0kX3DScRe4ecZxa5hD
         RLB5kjlnywsokVuK6sXMWkN7emQnmBrce2ECQgYh3p/r47oCEkrj/+oz6jJz+5o+zSgm
         Jqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=OQSVVIQPURkR27YtG2J8rxhsjvPZ9M4ywqweBkAcRU8=;
        b=IOInlrJMhnf5kV05EIyQY82T6Z043t14+gwwczEi1hoky0siYs/9pyX5lStSOf7Lp5
         Q7klppmFUAsoAmNbNVN7S5PyqYyTiDTfv5EDflq2J9jLXGiI6pO6zrbQMK9m6izqmAaq
         g752eFunCGLNTCIsEmTWEGvbN2g2S+MuvJJu06FVIO7nenDq8WqwZVbkfjHiOxagd2kd
         6YxAQPWwzmOvt7N64hXnvZx+LpCLwpS8W1JnMQB2Dw6kiNCTO4En9HaglugLMMTONWwB
         8eKsSKqR8cE0S+kFhw05v9+D6F5DD/Xc1ebe50yoN/F9Ic9BaS/OavYfLDqhbA7CwkLB
         pjzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee.jones@linaro.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: rtsx: make various functions static
Date: Wed,  7 Feb 2018 13:23:27 +0000
Message-Id: <20180207132327.32192-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748652939437980?=
X-GMAIL-MSGID: =?utf-8?q?1591748652939437980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The functions rts5260_get_ocpstat, rts5260_get_ocpstat2,
rts5260_clear_ocpstat, rts5260_process_ocp, rts5260_init_hw and
rts5260_set_aspm are local to the source and do not need to be
in global scope, so make them static.

Cleans up sparse warnings:
symbol 'rts5260_get_ocpstat' was not declared. Should it be static?
symbol 'rts5260_get_ocpstat2' was not declared. Should it be static?
symbol 'rts5260_clear_ocpstat' was not declared. Should it be static?
symbol 'rts5260_process_ocp' was not declared. Should it be static?
symbol 'rts5260_init_hw' was not declared. Should it be static?
symbol 'rts5260_set_aspm' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/cardreader/rts5260.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 07cb93abf685..a493b01c5bc6 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -388,17 +388,17 @@ static void rts5260_disable_ocp(struct rtsx_pcr *pcr)
 				OC_POWER_DOWN);
 }
 
-int rts5260_get_ocpstat(struct rtsx_pcr *pcr, u8 *val)
+static int rts5260_get_ocpstat(struct rtsx_pcr *pcr, u8 *val)
 {
 	return rtsx_pci_read_register(pcr, REG_OCPSTAT, val);
 }
 
-int rts5260_get_ocpstat2(struct rtsx_pcr *pcr, u8 *val)
+static int rts5260_get_ocpstat2(struct rtsx_pcr *pcr, u8 *val)
 {
 	return rtsx_pci_read_register(pcr, REG_DV3318_OCPSTAT, val);
 }
 
-void rts5260_clear_ocpstat(struct rtsx_pcr *pcr)
+static void rts5260_clear_ocpstat(struct rtsx_pcr *pcr)
 {
 	u8 mask = 0;
 	u8 val = 0;
@@ -418,7 +418,7 @@ void rts5260_clear_ocpstat(struct rtsx_pcr *pcr)
 				DV3318_OCP_INT_CLR | DV3318_OCP_CLR, 0);
 }
 
-void rts5260_process_ocp(struct rtsx_pcr *pcr)
+static void rts5260_process_ocp(struct rtsx_pcr *pcr)
 {
 	if (!pcr->option.ocp_en)
 		return;
@@ -449,7 +449,7 @@ void rts5260_process_ocp(struct rtsx_pcr *pcr)
 	}
 }
 
-int rts5260_init_hw(struct rtsx_pcr *pcr)
+static int rts5260_init_hw(struct rtsx_pcr *pcr)
 {
 	int err;
 
@@ -620,7 +620,7 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 	return 0;
 }
 
-void rts5260_set_aspm(struct rtsx_pcr *pcr, bool enable)
+static void rts5260_set_aspm(struct rtsx_pcr *pcr, bool enable)
 {
 	struct rtsx_cr_option *option = &pcr->option;
 	u8 val = 0;
-- 
2.15.1
