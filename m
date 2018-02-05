Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/2VrGju246N/CaYWmtZSFLTzfJr+jm1WjmC9iCZG5uZXxKQDj0iAuHk6ARuUqgUpUyLck
ARC-Seal: i=1; a=rsa-sha256; t=1517855201; cv=none;
        d=google.com; s=arc-20160816;
        b=GC5Mg+eEPsIcXfZKo70HosRSlH1STVNcS8TOGB4651ePzGe1TZKXlAwnQD96I9y7y7
         Xy8hezUALeQe9+nWAalT6kssdRtUuldsZPu5aaQRMyqDjztgvTHr5ZMHt6omPLelGcTM
         bzuT11mkGD5hm0hEr5wumlVK8xO0BPSK6LT9uJ9sTnXXkwaX6OOb5744BAxYqWyt4gg5
         q8og+vfm0nzY4xCL4LIjRA2wJG7DQv2Z737eA8V/CMuBXD3IEfI+Q+9vE9qcPBfLWFEH
         aUciDsX6DqCNXxr13ostOsheYXxUE0J2rsL1ojaqLYRenw0EiPedE/bUuil2TIzsu9WI
         ZysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LB8eLrBSVjlassscluMwBXPQGTxkVNd0tzVW6sUgNyU=;
        b=NS+0JP6gVy349FI48Q2xNOL5s13JOs+g/gXPS//dsVFVXN5XxI8sBPkL43oaKmnxnE
         0L8POGzclKPndySN51xHdbypTbp2AtVpj/08W7aYU+kh0dRkwVFNU0BIp+7MHN54XRBT
         xvoGsFt6IsQeBWIn0pFKqmjCIKD6KbAqNnK4sXLBqcKlwOWit70M08lzCKQ8FqqzdLhe
         4DX8w7JnlO7FNcj2DB8NR3Mb249ZBOMFQPuQtga5CdJ279T2rXbalpynhV2oKdOwQoDD
         H+8xmGla0cv/D3p8VPhEouT/h4T0x46QDhPDbIn+3dzLEwVrlEeQW23NtcXbzAMJSzQK
         LOdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3.18 27/36] CDC-ACM: apply quirk for card reader
Date: Mon,  5 Feb 2018 10:23:55 -0800
Message-Id: <20180205182352.889258576@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586536083805102?=
X-GMAIL-MSGID: =?utf-8?q?1591586536083805102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit df1cc78a52491f71d8170d513d0f6f114faa1bda upstream.

This devices drops random bytes from messages if you talk to it
too fast.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1712,6 +1712,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0ace, 0x1611), /* ZyDAS 56K USB MODEM - new version */
 	.driver_info = SINGLE_RX_URB, /* firmware bug */
 	},
+	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
+	.driver_info = SINGLE_RX_URB,
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
