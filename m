Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+YBlN7T9OiC6d2drmU25TkqFzAwpzn8uJA8mHb8t7+0fgGZG/M9lNaSPubyFIRjPnLujQJ
ARC-Seal: i=1; a=rsa-sha256; t=1523021950; cv=none;
        d=google.com; s=arc-20160816;
        b=ck2N9WzV/yFTY4Ue7yuJAO+zl6Y8H7VfBdF99mMOum2hlMW8oYJyJ6uaoEr6sX/nEL
         zTT9hce8GhEAqbuDbgj3NPgwvyfRSEvS+RMhecl4Tj7AEFu2Kg/ZFn4XUNXL8QXzQdJ3
         mAfFPJofgHJT+Yphr2S3XGCk1H7NZthsYAepvJzIDikhAQjVxky1x+VBxZwiacr1Ua+C
         ++FTJOhTx5SSwzH3KW1vv1i/SRjLj39ueiBfsykXjWxgjJztKPDMnK18PiscIo+OCL/p
         lVycfXJI3fWollVATNB4NWCpgbwbUJ0aK6NqXba9YATm6bgkEGa2XYma/pNMCW3Hy6IB
         RCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=upQfXN34d1/dAQoCOZBFqoqGl2cjLGogh0JJxAYaznM=;
        b=0StEtO5avlcPuurFfspuBr35GvyhsxPPs3+lr/pxbqQyJ21LSAQiAhm4B3vfvyQ4vC
         DQTCvrtDygrSCLreu/ngUmkIb/t/lUvz6+ms1ul3pSMdiPDgaOS0TH3U1GY+fzdKopm6
         abaYBMvNNB2/jIcV89mAHonfCG70DZaZ+OXb6VvJz+saOp/tCjxGtgsOAhPHCCdYOjWg
         N/35TiHhnZ7i2GjO/3QQmpYmeU16nXjP7S3JUpYh6BE1l0hM6vsw2pFhisGd+4u/LlP0
         3UE2YobLBqw4x6aU40g0HCMOggxjohbrQ4khDIwDhk7R58LCfx4V+scYmH8AdHhPdFKQ
         xO5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH 4.14 45/67] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Fri,  6 Apr 2018 15:24:15 +0200
Message-Id: <20180406084347.305379910@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003586402493539?=
X-GMAIL-MSGID: =?utf-8?q?1597004264991732092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Gerasiov <gq@redlab-i.ru>

commit 823f7923833c6cc2b16e601546d607dcfb368004 upstream.

WCH CH382L is a PCI-E adapter with 1 parallel port. It is similair to CH382
but serial ports are not soldered on board. Detected as
Serial controller: Device 1c00:3050 (rev 10) (prog-if 05 [16850])

Signed-off-by: Alexander Gerasiov <gq@redlab-i.ru>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parport/parport_pc.c |    4 ++++
 1 file changed, 4 insertions(+)

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
@@ -2797,6 +2799,8 @@ static const struct pci_device_id parpor
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
+	/* WCH CH382L PCI-E single parallel port card */
+	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
