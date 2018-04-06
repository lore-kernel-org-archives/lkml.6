Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49i8Fmmd6Lexpmqe81A4JtyZHw5TvCmr5an7L8dcREbYUDC7Vl1KTLTbKsZby0XcyRNf4CB
ARC-Seal: i=1; a=rsa-sha256; t=1523022161; cv=none;
        d=google.com; s=arc-20160816;
        b=NGn9Qu5HNDsV5xT+p1qmcwDEDDWFOfuconVlm6VXtl7Vro9XgDFrfILx5mjqJlJfS3
         qA6GnN8VUGP51lvNyDwkJ4+wGKvQzWzMEP6MLKZA/Nvi57H5rGKLWaHRPKqsvz9zr6Ed
         IcZQKPGR5w/1so67oithuDBWFM5vnd/fdaTyxPlzCr6NKQlObevs1yC8MEvNh75J//vM
         vlDhLDufMWsR6915utqWfbVduVFT9zxu0q+5qdoenst90ZgCw/lOGwHEFA0fOyZcYJsq
         qR+F4Z3dJzoQEpbL2wCzjom8fpkwU4DUVE/TVpx/g5W+TTbsf6DYWHSK81IKA+X8cgKc
         gbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0MCQfrydVdbgcIZEJp775jW9rAclsrYInmH5SLCRIqY=;
        b=JKva0XGsVBKNhMmv2RqkHzkKd+tAFuiGskC/QxWW5kL0jRsGypMGQqOKVPKpEMQr4u
         8IZJOaz+RqS9pStiNjNTb1HqRDFQ4omfMlsWeKm0CAvK17g7J3DHgmo4mMqKx/hZzCZk
         4im+78qCF5Jj0cIj7oKaYHiQ7eV25+jVZW7xb0NwhniZaLf6JOoIZGL3kMYVSpgeqpjm
         PA44O3oNTenrY3OEFZcH4BahC91I89aAtFqobS1dpFjIIgfPUwdK56JqJqqdk12qIwCc
         QJ/x/1Yyu+bCNMiX5gokQnBvCFpvo97WzB7DVQ0M0kPH4bcxxuUt26RPLmdSaWq5C/4u
         a/Wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH 4.15 48/72] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Fri,  6 Apr 2018 15:24:23 +0200
Message-Id: <20180406084352.896375970@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003586402493539?=
X-GMAIL-MSGID: =?utf-8?q?1597004486102360669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
