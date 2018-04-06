Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/vextCK1w0GyHqE4Hn7g/uvSk5vcBJR+4Np8Ee51VXUxqwB/jp3pBODoq800AIMxqhk06h
ARC-Seal: i=1; a=rsa-sha256; t=1523021466; cv=none;
        d=google.com; s=arc-20160816;
        b=gVn5TkhcQ/irqOGtiil6CWBwDV99eYiSnNDOzt/jvqr3t/BDSU7JdqfI+irzx/slU7
         RTL4ZfaeHRuteQhhXety3yAx2cixVhhQh9SoYPJFwx02bvPCyYQzCpve2f1Yi3yyU9QT
         FT99jhRgh9tLzTChQF1inWtrTT94LPg+zs6lZzvLFiYWPjiI5DIRqUJ8fBTGCbIvOibf
         3oSzbAnfsW5OB7iTO2szwxJIYeGqWHt7N4k3OI+mPb3kkP5x5TtNQ6zRQNfHcdD1Bvr9
         /McLgJti0nxQw87WpHGA/pi/4rBdEpld0oKCJNN1SH9hqtTHrbEtl39n9QJWqdupK1Xf
         xs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W+Yt//Kt30ND89ZN0MAQH+vb8rHUntiixQDuf0dvneE=;
        b=yPAYAcQCKYEigPDsYkduVMluXm+ngYLwWAPsdaG5vNJr0HNxL0rDwngFyF0eCYXI+Z
         UixAB9FVjGSzy51/Vl4Objnom9YSxcO5iqsIkb8ILwm+ZBJv46gL6v7U0kyQkjQePhSZ
         hXW+M2RPAH1lEX7DFxirm0tz2nwAL1+M6WLcHDZLokCBd53ePHjSkAaGlsUfeQSK5Let
         tDUO3hMgMlg3j0viSQhbH/XJxUr71JB8vNbCyfxnnxr2jIm4E+opdxTflCOBucdOe8Sh
         rgRM5g7n0HKCwupShK5mhJQ4bxhklqt0pn+tRf6RyNNf0ojZBcPcc87C7wr9fT0JkJXl
         ZhcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Major Hayden <major@mhtx.net>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 45/72] USB: serial: ftdi_sio: add RT Systems VX-8 cable
Date: Fri,  6 Apr 2018 15:23:46 +0200
Message-Id: <20180406084309.007202941@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003568499355891?=
X-GMAIL-MSGID: =?utf-8?q?1597003757586522582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Major Hayden <major@mhtx.net>

commit 9608e5c0f079390473b484ef92334dfd3431bb89 upstream.

This patch adds a device ID for the RT Systems cable used to
program Yaesu VX-8R/VX-8DR handheld radios. It uses the main
FTDI VID instead of the common RT Systems VID.

Signed-off-by: Major Hayden <major@mhtx.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    1 +
 drivers/usb/serial/ftdi_sio_ids.h |    3 +++
 2 files changed, 4 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -773,6 +773,7 @@ static const struct usb_device_id id_tab
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
+	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_S03_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_59_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_57A_PID) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -922,6 +922,9 @@
 /*
  * RT Systems programming cables for various ham radios
  */
+/* This device uses the VID of FTDI */
+#define RTSYSTEMS_USB_VX8_PID   0x9e50  /* USB-VX8 USB to 7 pin modular plug for Yaesu VX-8 radio */
+
 #define RTSYSTEMS_VID		0x2100	/* Vendor ID */
 #define RTSYSTEMS_USB_S03_PID	0x9001	/* RTS-03 USB to Serial Adapter */
 #define RTSYSTEMS_USB_59_PID	0x9e50	/* USB-59 USB to 8 pin plug */
