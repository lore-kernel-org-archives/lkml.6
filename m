Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrAz2C6Fbtphss1zdEeGnzQd47BK6psll7zJlKtROdYsMreTJd9Mco3wMjhdecLHQowRmvI
ARC-Seal: i=1; a=rsa-sha256; t=1525116420; cv=none;
        d=google.com; s=arc-20160816;
        b=bBFE1cPaGDSB3B664kulKd4TMNrnzZsoPyJ0TmzR3P60RArtYUPA/4YTsIxIh7dg+e
         MzMDfaigmMBsHPdnQNiyL3VytjheFJ/6d2TEj/BOJC9tp4iCdZg99GJZ1zQJ/qFQHYms
         DbqkOppseAnrcMw/Ctw1QoPU7xOq+NgccQFFFTkDpbfBWUE2X6/uVr08U1TERk4m2rtE
         hmaLQhhgCEsTqsExMRXge6flh4sqgSbu6Z0ECDga6T2aNO+BRYbymrzdXWCtWh5JH1Qw
         s8MLyb5AC8WS73e3BuqycgN7fi6zF4oJim0J2Tra1djv5hBWgk5eSwRJMhB9GtmabFss
         BCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+xUQGpvgkD7MJTbcV6aFzZG1q88zaAxkSCvQS61M/5U=;
        b=0t9NvBes3hUVUurT0DigVm6rwz0Ac6qBVtZXL8KQSGsbWeumBWuCBt9+FEZ3aSQqu4
         EM2/QPn0PlSIQ3f399N77gdh0qHW9L9xtzmmD8eTocHgB1ARNPQ/7wiOMDsKRofeR3wR
         O00/nUx1lA8xXoKG8hxgHmDZn4/+O30x4u3NMpyluXHxUUBelka7lyfVrETREf0AoFMJ
         nIX/G2Fd4Yv8tFqZlEAulJCItnghRyrZj9deAJA9zA8dtpWHBJW/AGGyAOYuL3v2+riZ
         Luk2EAaPiUr4BWA0RRUv9DNW9Q9YFKjFT6Ec8Vmm2fh2iWddHdJ2KdULPcwCJ1SZBf3H
         q1Kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD3322DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 17/91] USB: serial: cp210x: add ID for NI USB serial console
Date: Mon, 30 Apr 2018 12:23:59 -0700
Message-Id: <20180430184005.117266568@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291501783641?=
X-GMAIL-MSGID: =?utf-8?q?1599200474914802175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -217,6 +217,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
