Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48g+21fpmM2+IedIvUd1J6ZQER+LBzwQKy7FSgIubIDr1AAl6xukRmSHUmr+PWK/oTf2fo2
ARC-Seal: i=1; a=rsa-sha256; t=1523021303; cv=none;
        d=google.com; s=arc-20160816;
        b=Pn+WFmyQlxfIE2sVnQsBKhhauCIteLhO0IAj9J9+/DLGibBqU2ExY8gyYfYKYEZasZ
         OQ+92bzm/FuLaT+/FQjlZdOCo141igfiIPYLNUMGOoUwngLVCxw5H1auT8Gdu8AzA8c0
         KthVtUkJrNSrgCr/kTnLNXOJjGqSqChUUJHvYsqwcVhu62aQzAguMyFHaH1x6lll+z3F
         6ZGM44Vn3Kz5ZKc4NYo4gzIz6I33ExNgxFrEbajKFr7FQZ/quaB7PicTv0UJTaIX1+zX
         n+jhoPCBQqTIofa5VMs0eAw1rLiwT3dxOFQhqG8BD8ODVKYXjJlgHYrd3k13sokjzk9d
         WQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ll/lv9Znw5PNeJ8Bb6SJ5ujF6p+2rAcTDZY8jN7T1uc=;
        b=cAqvu2RNm9J+3M2X0Xs3rn6pmZwPpatCpWyAIdVUrCmQaMcHbZFPIEfQhGDyFdxkBA
         iTuxNf2rEGXm8gyZF3p8vAMjZBS7esHP++vAxBNIPq1aA98S1QUniGvZacfylu+ESr6H
         2aNksnHpvcYNeCOoDy00/qfeFJkgJFjvjfY2xzozWgWjQnrw4oNWKuAnCEZ67sgU32oX
         cg+uJTQUM5tTnghsLdbbXQ0ZwTvj7csm1A7HmhRyvKolutZbJmfovQIt66ugjYx8UdYs
         cAv3hvNGS2Oay3cDkM9eVPzvBfXm1ui79zmVwms2p6c6mY2xY36J7Sm/H2jKp/tAKKgl
         llbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH 3.18 80/93] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Fri,  6 Apr 2018 15:23:49 +0200
Message-Id: <20180406084228.658908540@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003586402493539?=
X-GMAIL-MSGID: =?utf-8?q?1597003586402493539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
