Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrDg0+aIkKmfq/ql0yGKYN5KKJ0oTmOY/V2CuC0BPuRLSRvzHQvBmxesbq0HLWBevc8jb3l
ARC-Seal: i=1; a=rsa-sha256; t=1525116354; cv=none;
        d=google.com; s=arc-20160816;
        b=a+5mHoQaxIQcQOmwuEFgOCPmrIVsGMWiUh4p+SNpTKOdjrjt8RmUzbnXR6i0V0nG+8
         mZLxKDs+ZTQ0KatRoHcoQUFumN+o3nCnFj7VUvwAf90Au3jxKUEykAeODJkdzWnbAe/q
         IrIT44nTrDo0GgXkLhJk1MtThhvPd5Jpu7f2QX0+l4K/PpmCWsPPvaAuZXgUL2E0i6NJ
         7xSSJY8HBISjVV3QDT4jXu/jNFrBTO7gs/0TN8SQjXd1VjzCzknZnQ7+6SeaXJ3MM+S6
         +nZvZ09KJidgD4YIQo2VWEMOYg3u4nVAB4uuvf4CnaWau9PcD6YGaETT6Tib8SzAE+Z2
         +Z3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=sz5a6TiqyR4Tdts4Y4eJaJ2rUsWatzIBEvNClzOLQEE=;
        b=An40i+ZRUiyD3aEjhvmSQG/6IbHZ/QQIvsIBxC8Ilkg+Wwxu4KZXlvGuPSuWjVnrLK
         fGLNZesU/BntktKVAGWzpILMgoYYsXBGheXIHODjyFx5u6M1vVGN6OUaTSnyvBinyUR1
         Qz1gdSkkzM10VVwWtZHauujXb8qn3RZrf2P9IKlEjSFPHOI1CPVM1Ctcshdt/iq7cwuC
         jmjhwH0EEXPDLE0o0zboEiPkjx4nT98ZO60q7h7HCpHNEFaXCLc3dFoFE/sC3IApaqCI
         5ednUIZ665UMRo3sEsoWM5DhfuW5UecfqKriwZeaBtiauQCHTR3E0gcUG6FfYkQ8EBz7
         RTPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E292921746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 09/44] USB: serial: cp210x: add ID for NI USB serial console
Date: Mon, 30 Apr 2018 12:24:20 -0700
Message-Id: <20180430190946.714048453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291501783641?=
X-GMAIL-MSGID: =?utf-8?q?1599200406572891178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Roeschley <kyle.roeschley@ni.com>

commit 1e23aace21515a8f7615a1de016c0ea8d4e0cc6e upstream.

Added the USB VID and PID for the USB serial console on some National
Instruments devices.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -210,6 +210,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
