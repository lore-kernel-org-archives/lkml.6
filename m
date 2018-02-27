Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x227aSkHSMCwPCOjpExyEMm9UFaWGGWnPZwWyYclkpEGgCxm98VjaiA7bJj0Jqi3r51TQGLKJ
ARC-Seal: i=1; a=rsa-sha256; t=1519738226; cv=none;
        d=google.com; s=arc-20160816;
        b=udp4qmkOraqxqjnzYG5u5rrrf67tVwReuOt+p6lcTKRU2BJtEl07N1uhpu4D82SJnh
         d7viwFs32KEPs/JteE/6o3KSQxaV38EpcmJ4+73w2tDXegNPpxYvYw/YSnV0HFFL4g6M
         nyoaaxx7IfZ1FuKWFe4bQTDPCb/cGW4ipGjG6TF0uWk2AzAj5L+BvT5zvF4GR74AIFGD
         uR+7QMi4PvczgbgHfCGGN9m+JlFvThH3jEuCnCx9K10LAHHaqmQh9F9emXeIj+Ey7lw4
         fEjpvdKgB4ksUdyvrU0ET+OHcI7VIQG6Cdf9iz02sQLytYXf/TjoPzxKt6hZkqK/L5ni
         ahvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=z8fhABteM57vPCOirIkaX1bAnjxha74ifBpKK3JbGT4=;
        b=aISEUji5YqlupzqWy9sq/cFIka7LQGGkVPBLT8DvQxAfjmKtJ5HKDtoqoyFDigk/R6
         gJRbcsPE49z1iy6JlWJEUYtcLT7c678vCOeJjoKx/JvrXV3boBJreq+ObHyWM4N6pHKq
         6t1Zwbocdx35W1tSg5RotYK+YQSVJbyGJprVfMLB0+c56+2xGTt+rWK+UggzspZ04HLK
         oNGU2eX8ePK5CsaLcO/xx/wQcjnlIIzVQOD1LnsXftMFzdVmTl+i5c843NrNvlTn1G1k
         O5rINDtDSNsgtxY2P2/xLdHRskr/k5zqdMBW153mFaAFUkczdfTsFz/IKRT62gsrmwXz
         xjFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	=?UTF-8?q?Andreas=20Gei=C3=9Fler?= <andreas.geissler@men.de>
Subject: [PATCH 2/2] mcb: add Altera PCI ID to mcb-pci
Date: Tue, 27 Feb 2018 14:30:18 +0100
Message-Id: <20180227133018.7732-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180227133018.7732-1-jthumshirn@suse.de>
References: <20180227133018.7732-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031162206643?=
X-GMAIL-MSGID: =?utf-8?q?1593561031162206643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some older PCI attached MEN FPGAs use an Altera PCI Vendor ID instead
of the MEN one. Add it to the PCI ID table so the driver automatically
attaches to it.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Ben Turner <ben.turner@21net.com>
Tested-by: Ben Turner <ben.turner@21net.com>
Cc: Andreas Geißler <andreas.geissler@men.de>
Cc: Michael Moese <mmoese@suse.de>
---
 drivers/mcb/mcb-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index af4d2f26f1c6..286b32ca526f 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci_ids.h>
 #include <linux/mcb.h>
 
 #include "mcb-internal.h"
@@ -117,6 +118,7 @@ static void mcb_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id mcb_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEN, PCI_DEVICE_ID_MEN_CHAMELEON) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTERA, PCI_DEVICE_ID_MEN_CHAMELEON) },
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, mcb_pci_tbl);
-- 
2.13.6
