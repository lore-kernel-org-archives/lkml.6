Return-Path: <gq@lvk.cs.msu.su>
X-Google-Smtp-Source: AH8x224N3Ci9ORgChfFYs3bgdtojyML+ewtKnpF/cij8dAm3ZNTkAbmct4YF8Mnr7Z3JSR4AdjDi
ARC-Seal: i=1; a=rsa-sha256; t=1517701838; cv=none;
        d=google.com; s=arc-20160816;
        b=wF4zWb+zGYI9hVQ4q6ucUqAT9Pmt6ttqUZP9mOnrxV+x8RAkum+LfGUsIQ3VAWQBcQ
         YNbSpkeC/GrRLneR1fD5KL0Y6KOfRGYUMJo13LBcRfJLVI3D1VUp7+f5cvy5ZAg7OXTd
         Qe1ckyzJ7cfYCIr2lJ5M0pMn8iC+YbqHUn7uKXEM9yUFDBsImBLNqYiaCH0U6VGg+AK4
         Mqo3PucnCU3zEqyCPq1rydfa8o54/LudXdVyA7MlPyL92RdD4ShCuTdAndC0Tw4EhjwF
         NlG/Y+fcCKG450eU8/XL4YFooolWsIXDOZIcUPO9JnBF62CkhtRSNlgcai/aUVrOOaJr
         l7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qMi/AfGg/egmXZEm7HDNmbxBrJNTtJTIZHn8/9Z1e3Y=;
        b=XhuVlLdSsaBvmaU+Z+KxrGth7fIzgThax/K7iFq4Q5JwP+SQJKOZkVIwxtyJXDsBmD
         Lu2KuVAfytJHE5kIpxKsUQLevuriXxxAguNcw1r/PVA1MXC6XU3yMQ8kci6eoZJmfdAF
         TfQXHrx0JTq9Lx2PTkVC5OSbBIwmbCbsnlvGLFrvkes+H4jNW2naZoid5l/wQK7bcpTS
         lkNANMiP5AP53kjVFplkz3euIz4pozCbTI6fvEflkEqiKofJLvaMlmlktzpiWcp5YtFl
         l7x8RvFDjHK5H6x+of9959nDoTxVKAN6ZG5MXNkEY9h1nYk8aD8YZBwDPd+DzzN5ZO3l
         s8Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gq@lvk.cs.msu.su designates 188.44.42.233 as permitted sender) smtp.mailfrom=gq@lvk.cs.msu.su
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gq@lvk.cs.msu.su designates 188.44.42.233 as permitted sender) smtp.mailfrom=gq@lvk.cs.msu.su
X-Spam-ASN: 
From: Alexander Gerasiov <gq@redlab-i.ru>
To: <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Sun,  4 Feb 2018 02:50:22 +0300
Message-Id: <1517701822-32462-1-git-send-email-gq@redlab-i.ru>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1517701060-31846-1-git-send-email-gq@redlab-i.ru>
References: <1517701060-31846-1-git-send-email-gq@redlab-i.ru>
X-AV-Checked: ClamAV using ClamSMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1572114236405083515?=
X-GMAIL-MSGID: =?utf-8?q?1591425723005778105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

WCH CH382L is a PCI-E adapter with 1 parallel port. It is similair to CH382
but serial ports are not soldered on board. Detected as
Serial controller: Device 1c00:3050 (rev 10) (prog-if 05 [16850])

Signed-off-by: Alexander Gerasiov <gq@redlab-i.ru>
---
 drivers/parport/parport_pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 489492b608cf..380916bff9e0 100644
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
+	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
-- 
2.11.0
