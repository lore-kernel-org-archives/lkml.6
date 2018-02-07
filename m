Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032894; cv=none;
        d=google.com; s=arc-20160816;
        b=NIglFPr5YikTyhQB/Nz9X2VWC9GZcFxKS455RyjEPuvBfVnZ0FWzh8EO2OLxrvW2U2
         Ate3DQXZUsKl+AgnrBS5rIPRsaXQ0bysUY91gkOxtqoc7KEREdC7TiQlsJprYC+UQDqU
         kyTyI3s/6Rsh7jlphFZ1hDpM2qQq+SWJD8aZxsttUZp+r0TwWqtyUvqodMJvPri2AmbT
         TBGwMl162SxQz+iAIDYDvAAm2nF2z9svAW7hXhaRt+RZyq4xz07a7eUgPMyv7ku2TRwD
         LLb4zGvlYHHLM+dMLR5ETwqmK3DH+R9tJfv1Nuuz9sJ8zEI9WPrUU1nRMVurUxra2Y5s
         DDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Q9OgcuDHxIqwrasIWbTmdvHa0R3mF1szxba/avMiwT4=;
        b=OWdv3AWoNdNehsAYlNMboaL6oAA/Se/u8mDzG6uSnMISSUm5W4pHD7JiVmHvgbBp+X
         ncxHaBUJdDFcBUH9+Am+E3SqzfPjckwJtD7BblY9U7Owe1Z9wMk8RmtRE/jnW8qTFbHU
         /Lo+5obLgbyXlRexV+4VX5qH2P1b9MsbnFnfJCaa7++1bcIeSzTjbmGT9XfdMoChUM6a
         Z0wNDQ81DwFLYEX6wimoTEYpssN9eSECbjlrKkQPIeKS35duSCPitgqpylm+PTbteaJW
         i8VMDTTLmTi91zSh0fJlml5cdHKQP8l6M/txVeCukK9ATXXzVBdou2Xdav96Th8YQXKX
         Hn3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MEUE4AS1;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MEUE4AS1;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227hu2LfQHmpXwmFDSXZu2rBsJyS1M5v2MGJlEJvdgeNsKvQk+cUFRU8Wj4MFPTYJkjhqnOqDw==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 12/12] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Wed,  7 Feb 2018 19:47:59 +0000
Message-Id: <1518032879-5844-12-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772859826521493?=
X-GMAIL-MSGID: =?utf-8?q?1591772859826521493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Gerasiov <gq@redlab-i.ru>

WCH CH382L is a PCI-E adapter with 1 parallel port. It is similair to CH382
but serial ports are not soldered on board. Detected as
Serial controller: Device 1c00:3050 (rev 10) (prog-if 05 [16850])

Signed-off-by: Alexander Gerasiov <gq@redlab-i.ru>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 489492b..aa6bb50 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2646,6 +2646,7 @@ enum parport_pc_pci_cards {
 	netmos_9901,
 	netmos_9865,
 	quatech_sppxp100,
+	wch_ch382l,
 };
 
 
@@ -2708,6 +2709,7 @@ static struct parport_pc_pci {
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
+	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2797,6 +2799,8 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
+	/* WCH CH382L PCI-E single parallel port card */
+	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l},
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
-- 
2.7.4
