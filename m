Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/D9v6nu48ds13rMOdMPVznpYRDsdNdWWMe6Y5238wQNCt/2icBuDSNJg/+1IRospdDBRDV
ARC-Seal: i=1; a=rsa-sha256; t=1523021559; cv=none;
        d=google.com; s=arc-20160816;
        b=aTuOI5CHq8JJHJKf+nyQUVKZK0op7eyGMicTpu879qKlyQnp2NmeA6TMwUwU1XwUOx
         augQ75QvYJNK10k8wa7hLf5P1w4DWxR5VDtHeAYSSAsFIDBoG1M0QctqVEwtUaM5myYJ
         8bNKeg8/O+cZZyL3FXxdldpqdQP4yecq4G2Epy2uhhxLRhdDUbzchasFjmU0NG9jXVc2
         eVYgoSlOaYEYOniYueFZdTFRlNDQhN9VF7nEpuxkvurdDkju84VI/GBvwQaz3NmQAylk
         hpERuMqGzbv68FYkJ4n7OSC++g447tafYAP6mcv67pKSwUdVUnvmGhvBZx2RfKnN5joG
         MRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9tsjq1fe2YNdxE8a+i2o0LLQuCFwl8KzmI0rQijeEEU=;
        b=CvWGjqpLjXw2ZsCGjftglLmXysFWrEc/ROt06QTfL0/UStfzZ0d+VSwIEC5wHV2bLA
         uv7FWLzrYno8G28bFsHr1DSrq/+oXicaclGWq039YqiypwzIbnIeTi0SKNkvkcATUDhF
         vOswr5huCheEcGAboM8XhmHnIvDQDg9dZgbN7bmfzVwg11Z8OrbqK8RGMZzdPMo941tn
         ii+56d4S32oAmlAk87fXpLJGVGmrKpsM2fI4LNPlSZcEHp/lYm+YCeEqWewS3wglzzh/
         8OH7r/kJWcqKMoHDPtY8k4eGUQgYXJElSDKuZ3NDcCGb2jhrpAFD+3t/fYgNW0PVsTF4
         WqmQ==
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
Subject: [PATCH 4.4 46/72] USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator
Date: Fri,  6 Apr 2018 15:23:47 +0200
Message-Id: <20180406084309.055398111@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003574666935694?=
X-GMAIL-MSGID: =?utf-8?q?1597003854680470325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
