Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499OdYwA9KYxlEZ02o280Irrw75DIn2pqgAHtha4tw61cS+EydyoI1A/wZ0touqHaF0lRIi
ARC-Seal: i=1; a=rsa-sha256; t=1523021750; cv=none;
        d=google.com; s=arc-20160816;
        b=u93Kdt46BmBKiG+cNVeNi7QskvEmrsGXay1u8sh4pFkmZSJhTylIMTj4AsJ9ahfxbW
         Z2nJrm+w1SH/acrbANVYHQLpnKq3zwBXVRfW5nRpAcuq6GwbS0lDt8aABzijBPb0qVW2
         twoGshHP9Buj5NNVuDuo+1jMMwSjajQNI2lWEwQXGg6rViEQbIhp8fw34z1myqaBfE4f
         QPQcJXn+AvIWfTwsH4njIqWNfnFZp6PMY6CXUuG5TYme2MmXn49iXFixulJ4gR/1KgQI
         s0/TesceifQe7Ryc55D1QgVj6C135GHuM8aduhsKaHw7sk50k//DJE2MEhZqy+r5SNKi
         2gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eKlK3rPG1IGE+kXIt0POCnft+QVGMwx7K+YkcLcekU4=;
        b=QlbDD3ksXYLff6J5rMTxt3xtiVqYat4ti0Nqea9+T73gspF0ffNbTezTHqHZmsQUeC
         jK9Th+ydLmFbrW+/SkEZ7bh5piFPh4IxFaoq8AG+59VrXPAarf/6MYYT3H8pHucCiQ10
         KBR4m4npx0X4B45lIVnW6On0EIyV66a4K9FFkKe2sya/OEHh0mvSP41UnRpnR848p8TG
         nWP6wj+OClsC96eJdhIbUzxZFGGeDPHRAclxwsQiWDUt7/lsC80H7r7hBmhe7i9GgST3
         0KyplaauuMpWRp1KQItDlPYDoCrp2Dffim3tNtJqo87gSRJVRFK44rp9FU+N+QTWDm4A
         retg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Clemens Werther <clemens.werther@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 078/102] USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator
Date: Fri,  6 Apr 2018 15:23:59 +0200
Message-Id: <20180406084342.519606390@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003574666935694?=
X-GMAIL-MSGID: =?utf-8?q?1597004054876775393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clemens Werther <clemens.werther@gmail.com>

commit 6555ad13a01952c16485c82a52ad1f3e07e34b3a upstream.

Add device id for Harman FirmwareHubEmulator to make the device
auto-detectable by the driver.

Signed-off-by: Clemens Werther <clemens.werther@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    1 +
 drivers/usb/serial/ftdi_sio_ids.h |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -936,6 +936,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_LS_LOGBOOK_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_HS_LOGBOOK_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CINTERION_MC55I_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FHE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_DOTEC_PID) },
 	{ USB_DEVICE(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1444,6 +1444,12 @@
 #define FTDI_CINTERION_MC55I_PID	0xA951
 
 /*
+ * Product: FirmwareHubEmulator
+ * Manufacturer: Harman Becker Automotive Systems
+ */
+#define FTDI_FHE_PID		0xA9A0
+
+/*
  * Product: Comet Caller ID decoder
  * Manufacturer: Crucible Technologies
  */
