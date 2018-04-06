Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/l7utYFpcYgP08fw2Q3Fl4iHC8/g6zZx5PzckVWn2kRwm9MheknTC6N9HqMHXN1uVtb0h
ARC-Seal: i=1; a=rsa-sha256; t=1523022031; cv=none;
        d=google.com; s=arc-20160816;
        b=OvQF+iLAG6QRJB5Ywi+xhlcIthLghk6Jc0CGaLRVJIWMMHSdV4JjSKdpBMmV6P7Ojf
         YE75TTvDSrZq2k06Go6gArunZHrKSDXqt2yeOFCc79wpVi6VRlByYTinv6uQmJTs7sj/
         8PKDqQC4E0SzMoniyzPIHxAC97iqMe8pxWuJulU9NKXQLH+pTeLaix3EkDA3lPsCUjq7
         19HDCGb5jWcLDNGat//n83KcXTDRIuRlZjHmYdfrsHWGZP26KTj7KqyAITfAI2W17GEb
         o7dgE7bW8ILSReAwE8sZ2wRfawf+AX4/pARtgeCKbztITH0AMU2jTCImh6VGjwX1dMYJ
         FLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6ZZgwkaU6kJLHoqKbbFgy5OyOf9gsp5r5ErEn/mu8Ow=;
        b=bv4zujk26H/7Ly6uf8Vtdp/e/bhK44qFFSYnlbmefjISk6LjwXV//qxL5wHBHHBPZA
         C9SuB4axnya+1pqR3+Uxvmbdsr1NeJNcdPUFRvgJdNZ6iNzqevsSo5xb4oxlIRlbK/33
         Cf2x4kzOGGgcGqxbMlRBioipmilw6xspGyyGn+t21o0m3+E5KgRZh0CR2W1TZUdPSp12
         ILNMj0Hphm5I3asXf7JmcJNAWVOak0/BCobh7VM0/sLTynezCGMmioFZDRB4O82j0ujs
         fc4FGwPr6AIbXYEDtQDGsCzHNS5y3iybF5KprfLofhfxN3Il2VeomMW2cRxlH2hDNiFY
         rw1g==
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
Subject: [PATCH 4.14 39/67] USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator
Date: Fri,  6 Apr 2018 15:24:09 +0200
Message-Id: <20180406084346.751004068@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003574666935694?=
X-GMAIL-MSGID: =?utf-8?q?1597004350040934426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1445,6 +1445,12 @@
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
