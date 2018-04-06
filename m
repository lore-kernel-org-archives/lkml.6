Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/jXn/ZAFRw3EYzZm10/1XNNvWRYCZsNhpS9xt2oW0qYXJ6ToBrRjo2xM/oeDLFr5fmN0qm
ARC-Seal: i=1; a=rsa-sha256; t=1523021543; cv=none;
        d=google.com; s=arc-20160816;
        b=DCzdi5iZ4x6WBaWAWW00f2bdgJ5FRRqv7dJSwfkM44MUwF3rwrRB6zRingCpenmSRs
         Gx3i7g9RE4quJRO78W6WrCTvfN8dklyniKcW6WFKU4EM1pBVrgGqeFau4EfidQK7JthW
         War2LzS0CDK6LXD3BLokRUie2PmRJxQOji393s0q2L93DmP0fo6PHgezi+q+HjfZyEdv
         1Eb72BeYX2wMwdON7BPUe5Jx9yHwteJ3HoDjTvsg7L7eSeCQuibafxJHQKCKZKWAEDI7
         LFQrwfL0rDkyVqIxGu2XC/CPqIjOyhUWPTgt+b+gJyRAgxWGzm+/yg9G+objAVKcU4tf
         YJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kyCvMI2rLl2uAfWW/JouGh7EWWiKsLWs7sByITtBlbs=;
        b=UeHlWFjsY6aBT+F6nWcUfLwEmgYCvcJIqfNQ3/nESxLe9XtZhqo0CdrIYFUmcTMubQ
         WxrgSPAW3PdNEkDUstgScQLv20gsAssPZPdeBVbq1DG18QmOdB+aQMyQ1mXM3ZQCh4rc
         BgDur6YxHL5UK2yu4VLhT+2jd3wkPItMJKt9lr6XqnKun39f05nNcDUBBh/pXv75Urrg
         n8yrDQLCVkVQoOE/W0KXmnP9ed4w/fyMu0P4LNUuAca/9LZ5xCXzDTklnNqj8stXSPCd
         YX67539kOMSiAKI+g/UvW6D3UXxj9/avr2Dss3ybzilRxkbtA5xeeqVtXFeRRgTeln+3
         7zgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH 4.4 50/72] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Fri,  6 Apr 2018 15:23:51 +0200
Message-Id: <20180406084309.421548143@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003586402493539?=
X-GMAIL-MSGID: =?utf-8?q?1597003838163359518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
