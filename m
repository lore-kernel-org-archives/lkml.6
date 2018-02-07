Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032886; cv=none;
        d=google.com; s=arc-20160816;
        b=pFw8vaV+mltWp+Pjb7vWG4mbTpplCu17tTY9dGksnPCWHBqGFTpcRlfmpqEFEhkf6J
         9kNLZiocfBOHkFhpG18IM/9tkwayd82aINL1g2rSV0st5czrhLftGwGm75PsPO0GLD8e
         BMXxpHuW8QlsrM2GC3feqpq+kBCYzGyu/ct9vR1XQoBATPqn2npwmZ0BDGmwJ9tQdgHS
         c+zXYQRE8NMfGzzKRwVLiWOiOMrT3m7MV6k4ScayyfqPxQHWSHGfqoXPtujrFrBH1fzk
         uPEYVQUm1GucR7a1DWf/+lCG0kDZekIvaChZr+3adkH3ZlLmqCB4a+WepP3eS3oJtQwY
         NKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=h6DAIICCfHEsBjO+jWzFqCJYXlCaJQ13Lb0/p4V7MHY=;
        b=SmwNO3924Ua41IPhyKO4pT4PyrvQn1ga/fCJiKPPAi76kW6m5g/Ya4jEHP8a/tDgpm
         jRZ7Aw423N6uC6tZ3h7o96oURFogaLqj2Odp9leRNWgm1B/m0wm785VnFUQVWOxxqgXQ
         +KUJhlxqlVmPw9tGhQqQj/tGy+5xrVr/GG9D+/R5UedR+LbTilF4lzusebhFHLxMvOBO
         Qweumr4TWeNOmojggFPtzf+D5qaYJ7uqPMgimgudoieSPvqmC2WgZJvYHNSd4SiqsUnL
         hEkVKwdKT+2RuQH7VLOXkje4xIUzVox0mqbZLcHSi19pNQIXWLgBL/ZrLlvr6Z0Ro0ov
         SXJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ttq8HzTA;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ttq8HzTA;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2246Q2Anw/n6OI/xIrc6/KwCPx/X/isaupiJNYfk3igsNezXYyS3WkepjmT0ewUJnI/z+4FAGQ==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 04/12] parport: Add support for BrainBoxes PX272/PX306 MIO card
Date: Wed,  7 Feb 2018 19:47:51 +0000
Message-Id: <1518032879-5844-4-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772851782971263?=
X-GMAIL-MSGID: =?utf-8?q?1591772851782971263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This adds support for BrainBoxes Multi I/O cards (4+1 serial + 1 parallel port):

02:00.0 0702: 135a:4100 (rev 02)
        Subsystem: 135a:0443
	Flags: fast devsel, IRQ 18
	Memory at f7d02000 (32-bit, non-prefetchable) [size=128]
	I/O ports at e000 [size=128]
	I/O ports at e080 [size=64]
	I/O ports at e0c0 [size=16]
	Memory at f7d01000 (32-bit, non-prefetchable) [size=128]
	Memory at f7d00000 (32-bit, non-prefetchable) [size=128]
	Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Legacy Endpoint, MSI 01
	Capabilities: [100] Virtual Channel
	Capabilities: [800] Advanced Error Reporting

Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e15b484..53a3eae 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,7 @@ enum parport_pc_pci_cards {
 	wch_ch353_1s1p,
 	wch_ch353_2s1p,
 	wch_ch382_2s1p,
+	brainboxes_5s1p,
 	sunix_2s1p,
 };
 
@@ -153,6 +154,7 @@ static struct parport_pc_pci cards[] = {
 	/* wch_ch353_1s1p*/             { 1, { { 1, -1}, } },
 	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 	/* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
+	/* brainboxes_5s1p */           { 1, { { 3, -1 }, } },
 	/* sunix_2s1p */                { 1, { { 3, -1 }, } },
 };
 
@@ -261,6 +263,10 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
 	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
 
+	/* BrainBoxes PX272/PX306 MIO card */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_5s1p },
+
 	/*
 	 * More SUNIX variations. At least one of these has part number
 	 * '5079A but subdevice 0x102. That board reports 0x0708 as
@@ -504,6 +510,12 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.uart_offset    = 8,
 		.first_offset   = 0xC0,
 	},
+	[brainboxes_5s1p] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 5,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 	[sunix_2s1p] = {
 		.flags		= FL_BASE0|FL_BASE_BARS,
 		.num_ports	= 2,
-- 
2.7.4
