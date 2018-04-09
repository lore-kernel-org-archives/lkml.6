Return-Path: <prvs=36372c2ef6=kyle.roeschley@ni.com>
X-Google-Smtp-Source: AIpwx4+JfhR2kz51BORhU6P9o1qLO0SyehKM6fTWeO/XfRQ8RRoONjTy/+pYQPQQtKOUS9XPsazC
ARC-Seal: i=1; a=rsa-sha256; t=1523287454; cv=none;
        d=google.com; s=arc-20160816;
        b=JUmN/Dmy5JWrSjt7JKsZ8zPZ6iHG6M6uHZoYdWFRkYquai1ZZkFZ25rMwC5TrcL7mS
         Fs51ZU19oJGNU6kvwWV/Pa/a7xLB5a/6cqxHIkhZ0O6d6/FAvhHZCKjtEHLwa4UCpOeO
         VILIxX+MvOksfI8IFtTnIS3mVPvNgWIE0y+4L7FddIi3wc9uFPtjFHsTdsB6RAYiIcBh
         yWDy9sX0zj/vdEKabZ3cNlPNjFje1/jSkqhJn2608AJGqKgS8Q7aGztkWSN0fZ0ReaXp
         LcfzfAVwv6TV+W88/2mKNlyG+e4dJGG+0OUANZCA5nVmSd7XHq7GJ3cluG1GK6Q0cOoh
         8awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Ia8Pl/BgpI1bZc9bacWxQYZHCu90lZcr1HQxy4XtDVI=;
        b=UoycBJ9OjHlnIoEanomDhvyMQur3oUDnk2QHA7446tw162i0rznQ6Q4wNVeNSdMNHF
         rUiaZkMd+9C7SeDt9Lgw5+KkuLXI3OsxC5qly4lm6pKWTAuXMDgPXCeL4dZ/MmEZqTJM
         zVoNG2ScRp4wfsPCWUyEkyrBKaEu4qTg2IMGHNE4EKPQ/klKwvaFkqkH/pngFrOm4cij
         TWGWevreKsCFC5Y/WwM5REWhXJ4Bd5vTt8TaNCuzrNFYst0Wu38iecDkxCiDmZxdXl1E
         kl6k38psyFO+x2Nf/qOw6ouQByX9eXop7gnRXTDkf2pFFbhVAeEY0zT0C6Eubpv5QNoQ
         JQIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=36372c2ef6=kyle.roeschley@ni.com designates 148.163.156.75 as permitted sender) smtp.mailfrom=prvs=36372c2ef6=kyle.roeschley@ni.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=36372c2ef6=kyle.roeschley@ni.com designates 148.163.156.75 as permitted sender) smtp.mailfrom=prvs=36372c2ef6=kyle.roeschley@ni.com
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kyle Roeschley
	<kyle.roeschley@ni.com>
Subject: [PATCH] USB: serial: cp210x: Add ID for NI USB serial console
Date: Mon, 9 Apr 2018 10:23:55 -0500
Message-ID: <20180409152355.7774-1-kyle.roeschley@ni.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597282665739196263?=
X-GMAIL-MSGID: =?utf-8?q?1597282665739196263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added the USB VID and PID for the USB serial console on some National
Instruments devices.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 06d502b3e913..cc5b2d0d340d 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -213,6 +213,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
-- 
2.16.2
