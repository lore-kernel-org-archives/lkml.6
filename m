Return-Path: <gq@lvk.cs.msu.su>
X-Google-Smtp-Source: AH8x224LEVLEImTZ5MckdjzEPB5G2bdJpBsaQwTf59ez3d16MIc38pLAG/w04pyz27DHapixMugu
ARC-Seal: i=1; a=rsa-sha256; t=1517701121; cv=none;
        d=google.com; s=arc-20160816;
        b=epRMrtTV8gtISWOfmneWun2al/NN9Leus8hM6p+IK9fXsKdEFZTfIAachhcS1f1Mut
         gqOBpOogjodsfJn1GNNh/RY9NkqYfD7b/ZUFCv4e3kB0hk+BPp17NppHjrdN8Rjr+sk8
         EG8RSL4mOtZZNvF82v7ylPlAVNXBwzJ6fC+NvUSolfHDpp/XmZi+vdvbx2kteKlsqCOt
         fS704fJ57dmRUXCqcknF2pWs2OUQN6sn/JQTkgm6p7gV2EXoJDERneqh/CnO6aUfpAa7
         rhC7Y8dYYIl3ySr0MBG58pkD4k51vJdwYY4d5HOiWURrnSWqFfOo181redr5mdbMJ1HF
         cqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sOFL4/o+lkBna2SGfAHF6CsnVh4Rm08nXKGvKYMQo4w=;
        b=X8eJZE8BBaPlnJVB/jP+TV6CHNeC9/pimeEPPv7bCv/Vu340geXgOgsmYQySw3cUu6
         kHdiQoPZ8Tl01XwAZGcMijVDnS65roiJH7b6gsxVhQBz+qF1tnfOCKrb7QpReESi05WO
         LAJDBuiwam3088zyr5djuRLI7JzV+B5H5K3N6yxRWi431dgwBfEmS28kN59isjIXWAzj
         SQNFhgXO1xBCbVwflPd1i3YTQW0S8ld6vWml8Rxm9kxP4McRLbntI0A++BPekSpq4oMx
         jJjEjszARpypRMDBqRe2QRxdNk9BptDVUEYa5jkHJfyLrvp4DFv7bnysvsXFS3aDjqxA
         vJ2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gq@lvk.cs.msu.su designates 188.44.42.233 as permitted sender) smtp.mailfrom=gq@lvk.cs.msu.su
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gq@lvk.cs.msu.su designates 188.44.42.233 as permitted sender) smtp.mailfrom=gq@lvk.cs.msu.su
X-Spam-ASN: 
From: Alexander Gerasiov <gq@redlab-i.ru>
To: <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Sun,  4 Feb 2018 02:37:40 +0300
Message-Id: <1517701060-31846-1-git-send-email-gq@redlab-i.ru>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CAHp75VetHWsJ6=o-7uER24DtOf+mOcbdgh9HGrBC-Y6t=ouBPw@mail.gmail.com>
References: <CAHp75VetHWsJ6=o-7uER24DtOf+mOcbdgh9HGrBC-Y6t=ouBPw@mail.gmail.com>
X-AV-Checked: ClamAV using ClamSMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1572114236405083515?=
X-GMAIL-MSGID: =?utf-8?q?1591424971178639948?=
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
index 489492b608cf..aa6bb50384ee 100644
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
2.11.0
