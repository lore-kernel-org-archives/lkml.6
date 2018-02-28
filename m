Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225PHLjRPhEadYRC/l+vhijiY+AaBMnacGGlWNJAEUMnzO9Z2jgOIe25bd3/bB+wzpS1+re+
ARC-Seal: i=1; a=rsa-sha256; t=1519831335; cv=none;
        d=google.com; s=arc-20160816;
        b=B/svu1oprHGcUvfQc40Wa/WXOWfcEDNlyRn+Jp3s/ij6ieh3SycU+HgY5uPr1y+Stz
         mVQH6UjbqCODwIOuam2fGEl+7nccMCsa3sS0q4QxX+LVk6hWgMl8sTcyWhbiSSayUrIa
         Ap0FEa9HtjcWmY2i3ykzEsCbBrs63iz15CVuVa4+mhpYPt4yIbosB3dX3nhLj/h/uvvx
         BMxpuObu5gNjysefjJ6kh3dcbradmOKm35XaPYCxGTw7xTJpFo6CtYtt3UKQPX3d1MyQ
         OLi9wvdtXggsUXOw1DaSHPQYgSqYZdnzbxSdvQyV6TDFZDWg7l+uM/YTe5b6rZHUEqVA
         ZsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=r7XGY03wTSsh6Tcy7JE3P3LkiHWXV6vCX+3ibr3dsro=;
        b=MzhcMwricWlcJ2isw5ZJdd9gUmRq7l+Hbj1cIwql3+ZHK04Yi0VJVhmr6iY5VQnRj3
         eTKD4U+B5fUCZR5gVIr3mJ/lelq9BCgGmcWQoCZYb6URjXV/8UFSCv3hNnnFqOpSuuW8
         3aX8ETFcpcpT51gDbomQQLRYdniQBRPMo4TWLRfSIuRpmO1OARvCEneFAL1RKdsZ3NlP
         Ep5JE4ApRyNMQtFGs9HjzcDnPHPIooVnjc4r9HIindDkeJS1y04p3wrg5cnz0CyRGFYW
         27DefzFZIH6M2vHbFJnI2H5cue3RTFv1r6pr+i8wjGzDSkHsKRRbIQm+j8+3Ny7VTjRQ
         UM5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Matt Wilson" <msw@amazon.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.166253897@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 017/140] serial: 8250_pci: Add Amazon PCI serial device ID
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658662858664424?=
X-GMAIL-MSGID: =?utf-8?q?1593658662858664424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Wilson <msw@amazon.com>

commit 3bfd1300abfe3adb18e84a89d97a0e82a22124bb upstream.

This device will be used in future Amazon EC2 instances as the primary
serial port (i.e., data sent to this port will be available via the
GetConsoleOuput [1] EC2 API).

[1] http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetConsoleOutput.html

Signed-off-by: Matt Wilson <msw@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/8250_pci.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -4175,6 +4175,9 @@ static struct pci_device_id serial_pci_t
 	{ PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000 },
 	{ PCI_DEVICE(0x1601, 0xa801), .driver_data = pbn_b0_4_1250000 },
 
+	/* Amazon PCI serial device */
+	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200 },
+
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
