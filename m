Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+2dXts9OuBUTrZAWlzsoIokQLRrwl3fX3pEm46XbnsDAe6V9jGPWATRlV+YdvBnNqXKQRs
ARC-Seal: i=1; a=rsa-sha256; t=1523021292; cv=none;
        d=google.com; s=arc-20160816;
        b=StSNTgaRlMAeVaYsKpoOoK32kWwgBQ/yjzs0CPLxU1ebuuMvYy8zX6UA5vBSLw6NCS
         C4gMBw1DLSVIcjRoMIvpc1X49ddMIE9C5NliaqtXrN+AH9ilPHPcEJgSJWBWzgMmeTqs
         FEUH19zNhVhmo9qr0RdPXkadq5JnwbfIERO55Rv7b1+44zI2Q3N61PDqbFJpDcLjxlO8
         Jb6NvL1O0Y9WGN4M4E/hecclXsHd2TIUZTax66Y1bpYrDiaYux+fXMdO2ytvgQS/T4FN
         qiscvELo8EsV0qtSgsLmcPXJDKACVz1rWFzXJ8rSxMYFfJbMZkT5Cfamm5G9JliB1KqK
         18bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LazBoD0YaxKmKVGLNh3v1LR6HTx3B+hz2sRB29cBRgE=;
        b=mJXhBjq+LWqBU0gCotXeUHeUgF2wDU28ZIXDXNTo28u9UHXgF6ehBl2VA2f0UzTPwp
         QN6thseZQ6oNGYk6jRR/zQhkWgSuGfIWicVRQxqJh7G9EzPkO/gm668h8IZkB21B0KDT
         M61g5NF5Vb8VZGcMgXV6qfmalNcCy/v5rEtFvYt+HFon9sTM0zUKwCBFnfyDYFOoXqzJ
         IaaHsTwhswPASIY6jRl4c2aqarIOWeoO/ZjL2Hdik+no4iz4Uno9jfcgF7EBdTfufuyp
         OXAjYRZ5rNhPLQWGA4hZaJOxh+C8AdOJoiYVbqXKb6Xlo/NN8Z5cPIzqiUdDHmDEH+ci
         oANQ==
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
Subject: [PATCH 3.18 76/93] USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator
Date: Fri,  6 Apr 2018 15:23:45 +0200
Message-Id: <20180406084228.407304757@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003574666935694?=
X-GMAIL-MSGID: =?utf-8?q?1597003574666935694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1425,6 +1425,12 @@
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
