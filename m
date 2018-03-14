Return-Path: <dev@g0hl1n.net>
X-Google-Smtp-Source: AG47ELs11/lzTZ/BkPBE1YE0wD9e12rdjy5XJEBbLe75btO29FF/IskbtQrXJZoedgHrRl/SGgCM
ARC-Seal: i=1; a=rsa-sha256; t=1521023392; cv=none;
        d=google.com; s=arc-20160816;
        b=PppOQsxcFfOI1OO94T8NmXP3rr9SvDdTH/I55Vd53TD2Znx/vF6fHrvATx/6oTiMXp
         Vs//KVQpQ6wGoC1icnCZ3Ib56p66hsWBAo2pBWm3TZuvuBGCPXLJXeOTe9qsMBntonbg
         pYzxMHi5a/w/4pIxCiKoH8DPyXCWIjM5f58ES4Q+JF6BnGjBxQsC6MKahV568KTE5w1E
         brljUI7AOo1fzcr1rbPsPnvW4MFDXXj9mFOKeTzDNfQuQQprdkCD42lS4F3W9n2NJu38
         933WNwcSj1ZKoUJAjvojAhwtwOYiCRcCarvKI6FkePpNQ4WC32iFqpSH+P4U1L8fqmdE
         bjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mQozJP0Id94Wn7dEft/1tXhK0mFwc8jXg5l5+AIp/xc=;
        b=dAuJgFWtcrxMK2K5RYRPfO2H0geZe6UDLIDb8uNMY/99nIFJrbzkZOB0R2hon7covx
         D8n6jsZjqHlrmWQ5Cs0ZF6do9AYKom41i1XyF5I+jQt6kxWllifgTk7jvZUyk4VrKLMt
         6nJI42pAtZHadthkQrSyw3VPEDR22ds8pCFZJ9D97hiPtfHlYxh5XCzDNcL9Kw0sdlfh
         VFQ8FgpJkVWHjvDQ1UUW/x9AkrpDt+r3vWmAjMy/03WIHlDQYuGPyjIZhljJ+0feQoKg
         inBH/+MtoF9bZA4fJqtZmiSl6YbD25e+LvTa7rOZj7onCJaHeMQBoa9KSGs/0nB4sEtg
         PC+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.237.142.245 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.237.142.245 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
X-Spam-DCC: : 
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com,
	bhelgaas@google.com,
	richard.leitner@skidata.com
Subject: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
Date: Wed, 14 Mar 2018 11:29:32 +0100
Message-Id: <20180314102933.21367-3-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180314102933.21367-1-dev@g0hl1n.net>
References: <20180314102933.21367-1-dev@g0hl1n.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908624828665894?=
X-GMAIL-MSGID: =?utf-8?q?1594908624828665894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

Replace the hardcoded PCI vendor ID of Netlogic with a definition in
pci_ids.h

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/usb/host/pci-quirks.c | 2 +-
 include/linux/pci_ids.h       | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 4f4a9f36a68e..39d163729b89 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1243,7 +1243,7 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
 	 */
-	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
+	if (pdev->vendor == PCI_VENDOR_ID_NETLOGIC)
 		return;
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e8d1af82a688..d23a97868dee 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3067,4 +3067,6 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_NETLOGIC		0x184e
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.11.0
