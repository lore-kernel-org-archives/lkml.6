Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoX38GxFBS5LQbZIP4AimSPlPFWFjjCashiO1QUcWNcmoH8zFG/bZlDvXiYs69U7y3+lXwC
ARC-Seal: i=1; a=rsa-sha256; t=1525116478; cv=none;
        d=google.com; s=arc-20160816;
        b=QR7mvOMFrVOwwwhAoa9rVHksK4d+6aIAlAbh8YCA7uN5rNkTh0KM1DJRZ49T6fk2qn
         PI0DwZEG5ySDap7cna5RHianEQG3plfvB9b18B3giCy6PwhY3B5b/ZnMjCcyAPW38TLU
         dRTsJX+CK7wPrMMmU2kz4MpDMPc5HWl23cS/TFA5bQYKv2O3RklFjgdFAuv36uBRoaxZ
         eU+TzY/MqyCrFtuV9zNtOLSMzKHZ4LGcu2DzRqXvpPTUiehfx/dB9UPaaJVnRFWhxwWW
         ebLw9vLPYEJONHk07x9UpoQ5DozsMzMdMqosjB4K1oqRsfGwq5/8Od8xS9tBJoQpJDAS
         oU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=mc14XPVBaKvmw0J8K7286Xlcon7bGxMralXPNZR+hr8=;
        b=WgW4HVJMfkrHWITvwxsMPDHx4oSEHMtK5Dqag60smRfUywAiFTh6wherUSxn5aybZ9
         ROpF6E5TduCb72bYt9fzAA+JGyACD/EiVPEzpVZ41JPpp2W18KiG/GUeKdIlN4x7VonU
         uZ4+XCkJiRDCcIEn3y9rJ73y5Ig8+elKnDCq22+jJzIUp4pzsN6mICjS9/xjPJgJuP8H
         NWm4MzDn0hqdfApTIFw5xqeFcc7HKSC5odsc1P5e+SZzmBXJmEnnf9wedJxhXv3X90ML
         En0ff7ctUgBB0c2LEsADAgc5oYR8dBLDBRg7tGy1+vG6WBjNS2EnojzPJGaZdwzwHGns
         pWVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADF622DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.16 018/113] USB: serial: cp210x: add ID for NI USB serial console
Date: Mon, 30 Apr 2018 12:23:49 -0700
Message-Id: <20180430184015.851073002@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291501783641?=
X-GMAIL-MSGID: =?utf-8?q?1599200536263234036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -214,6 +214,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
