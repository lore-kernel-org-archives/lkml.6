Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227IGuP7oAHkiyfcJlq4KDDFkgIgQ3MwMhGbofwXnYI6/JdCnSFV5wfmO2cm3kUjnGfMg8fv
ARC-Seal: i=1; a=rsa-sha256; t=1518323622; cv=none;
        d=google.com; s=arc-20160816;
        b=Ya1dzmClKk8Wei7LbFRWd4jeM4Zkgj9xUxYJJ38jiv64a4RK6R7Ds2iG4zQLW85Rdm
         V+pzbHDtI/CWgxnqF/ZtFZa4nlolHk5u2vRzBNeP2aUMGJlpfOza5/FWXGLefvqLypXs
         v18KsZAHRwOUBk/57oYqvfjdieDZOtY3kTlMMv6LBLJZZ+eNIWDUOZ+qX/Z4Fnt/IqRV
         RCQ4Iky6u2L8a85zz2jxVVR4bQPCFIaJdR9qWmjFRni6d54Sv53WmtpMcejSzZ217WbK
         SIrDvyXjS+hrPaSBlolEvtcWObK3zLGojAzPbhk+FNi+uBfVhthlAKRVCF4hB3upsF3z
         VWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=13XYPQd3GGzJb1q6eRVka1vBOSvba1fV5EPhb+fdays=;
        b=W+6BywDOzgYfzauF161Vxp4cKZJpYtz/SLVpT6LgshvicHNqFMzwiGtaM0FhZayMke
         C5aJwtKmYZZ0klpQN9dQ9mccnuNouCBe/vQJK0syf/ICGKRez2YuXDczAKMou0eGIKR4
         o3JeLAmQXfGJoMKxfSsA93Gfp2j3VnYnQeHp5JQmoVDUXOOl6XWvFv+uFF5a9J0up+/S
         iLMs+wxy/GYul32wPRyW+4SO1FAPFquJwEwkdZQVuo4ItIxYOKJqF1il00m3Jdxw1Hjr
         I+kvaPuI6Xkm5TSkhuTTwsg6IoWyTEr6H6K3g1XjakctJlXENWbZ1Vob1oZaAwMbKF3v
         NwEg==
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
 "Bernhard Rosenkraenzer" <bernhard.rosenkranzer@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bernhard Rosenkraenzer" <Bernhard.Rosenkranzer@linaro.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.959137166@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 25/79] USB: Add delay-init quirk for Corsair K70 LUX
 keyboards
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710773842199?=
X-GMAIL-MSGID: =?utf-8?q?1592077710773842199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bernhard Rosenkraenzer <bernhard.rosenkranzer@linaro.org>

commit a0fea6027f19c62727315aba1a7fae75a9caa842 upstream.

Without this patch, K70 LUX keyboards don't work, saying
usb 3-3: unable to read config index 0 descriptor/all
usb 3-3: can't read configurations, error -110
usb usb3-port3: unable to enumerate USB device

Signed-off-by: Bernhard Rosenkraenzer <Bernhard.Rosenkranzer@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -205,6 +205,9 @@ static const struct usb_device_id usb_qu
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Corsair K70 LUX */
+	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
