Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvHJmI4TIGQlQbL+yoJoFmD3MKuobMrtSeR2qjjsvqIUsrqOY20nPgkpa3tW8feBJMHxPfK
ARC-Seal: i=1; a=rsa-sha256; t=1521214163; cv=none;
        d=google.com; s=arc-20160816;
        b=tYFH5IziKmX3AASUWGOsoWSrMV3hrjKW6ias/hCJn9XwDwM8PMF7DV4wkjrE9HMaji
         gMvDM4+QN77p+ztVB0rAaVh904yUseAdLnk1qodC4dYUXSypH/saPBDM74AopuGdQDzz
         B0ec5Y5WxdN5aLd1KNPLsSJZgB1loDAxfvLOqQ8ybQibavZfmUmzULlYOz+T/y1ukQ1H
         OSTinv8iiW/GLXvbUk+RbT+wh3hq2l9AcGbSF3nL50gJTg/htBkS7VjHxK1eZ6eqZVJm
         3AsSP6Qz7ygRYz0gkHpUECTTM374BeghApeGEbm/dLFI6L6YaOSpaDF+EgeHj/QvRDHj
         D1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gUNh28o8aAf6m339jK4H8Zo2joeAlbex1KTIaoErVig=;
        b=h/aeN6kCh4RZWeEqB4HPQ15ubKswzfemoiXEZE8qWgz9N0rlKI/xvm8K4Aam7giF/i
         3WQbtHRjanhjbWD2mbppCusqWW0Q0hVx4DblVhLcJf/q4Q1jWTjl/uMASJxxT94IoFHP
         gsJMWQHRs+6qpbcHvGHsVt5GZamAZunqlvczi0LRSKj58sdeFJphm5FUNx9xhAIqiGDJ
         jmqfyYfCS2E67UHeOhO3Vhcpzss7V0G6BASJYXg5/aYv+f/UvfSg1b1MmWnhaTYw+DoP
         Rmuj9XX+Dm6dLTZB4p2WeWhA3D32u81d6BXjHKoxo59dW/Zo4Mw7gwmewpXDe656PAGR
         kf+A==
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
Subject: [PATCH 4.4 62/63] serial: 8250_pci: Add Brainboxes UC-260 4 port serial device
Date: Fri, 16 Mar 2018 16:23:34 +0100
Message-Id: <20180316152306.773883747@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108325664123514?=
X-GMAIL-MSGID: =?utf-8?q?1595108662387475891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5300,6 +5300,17 @@ static struct pci_device_id serial_pci_t
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
