Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvcIrtKLB7DhoPB67R26f97gryHvqHK4rI9p1t0SyAiqz0A2PmMkLnvGKoyjBUgWlg3uKq9
ARC-Seal: i=1; a=rsa-sha256; t=1521214794; cv=none;
        d=google.com; s=arc-20160816;
        b=pGrQPnL+jWWgGql8RgZPvqbh/OJa8q9D5q+/ppIZCWflXgwS/B1HuiYE89PgXRmPge
         XLYCjf6cgsneWawWdKlZtma8M60JWHYKm8HEc38xPOKslqweT09s6ArruxWbGly1ZYSv
         SMk60BUf/oZ9NWLqtChTF6MRx2xC4psW3Cd6r1/j/3KD0PXfVTYIADtAnqw3oGNsMGTZ
         /g6DPKCFnLwe0Vqunqf1Ntp/48aQCn3dF+qCOUPa5ELJNJ9tF1GweyGsnkLdLISYV3HJ
         vNNI/jr2XZNdmwtWWJGGJiS01z6WS3qfCxc/2qDC4OFFJrQW34/urTGHnX0mw6+rHLnf
         ljJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8I2J/gGYgRCVC/yJ3FFeKDQj9RtfRXQr6H+xx88Pn9Y=;
        b=ic7sBYtSH1bP/+bfkqlBO9IU5AkKL3kdymjbpwVTVW3bBl4ZkmxybQ36FNzfuqvMF1
         yVs7Fw7JGG78q9GEmCeDi9TcaRV+gy7QkfXf9E+5wC1UQT31AVtUWmV3m5cxZwi9vomj
         JNizJtx+pgPXxnPZliXaW2kzne7X8PGIaUfMImi2QDuUAbngOJ3xoI+aByQOOVecGbZx
         8JWuzzsuYMHVfvjN919YYR67QlNqaEkF21JhOSK7Sequ6U2W5qpCubvi3xCJ/H8fxkoZ
         ZIfYEl3lyc3o8ukkDaHZJEi4LryzhbWEN4gc87kp4RwG6gLcnQDVBs+AbDaZl3rrGW3c
         qcJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: [PATCH 4.15 021/128] serial: 8250_pci: Add Brainboxes UC-260 4 port serial device
Date: Fri, 16 Mar 2018 16:22:42 +0100
Message-Id: <20180316152337.518125066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108325664123514?=
X-GMAIL-MSGID: =?utf-8?q?1595109324151148871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>

commit 9f2068f35729948bde84d87a40d135015911345d upstream.

Add PCI ids for two variants of Brainboxes UC-260 quad port
PCI serial cards.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4699,6 +4699,17 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
 	/*
+	 * BrainBoxes UC-260
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0E34,
+		PCI_ANY_ID, PCI_ANY_ID,
+		 PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b2_4_115200 },
+	/*
 	 * Perle PCI-RAS cards
 	 */
 	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
