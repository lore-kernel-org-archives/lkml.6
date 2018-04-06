Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx481AeEvXeMiXuiCYIB7H8aFhzuaDdZ/n9cXoDszLeec5c0QR8V03EDo9fJn8nWZBKVDuY3r
ARC-Seal: i=1; a=rsa-sha256; t=1523021286; cv=none;
        d=google.com; s=arc-20160816;
        b=rgmmKmMovh1ZP2VajCyRNpDYCbSZNj9e1nvQqRypmksCmN1yeAO/dyjIBh5RbtU7U+
         X6EAvARmzi6cRbrS4J5JWrfx2KeJaagFvP6ikYeWwTA9XJ5xPjKhWO8UT+GLha5Cq4fF
         hxjIIsYiK0jKN6D5jV296IZE95IBggWFSF6BQ0tzh9Ao/M6S6+Ob61dv3FV2qKez5ERd
         CAkroGel+xDxr54jgRoy2EJCRwEGgIVoFUNX4wFPvXN7A05Gi1KqyCXGMCqNlxWpAb+W
         cq+a2zFPqW/42tjLEAAhLUfZje81DO6rVx5QnwEnoNl0FFud/sN8EPrkoR4lzDPuDtQh
         Rgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mz1XT3AhOjVP5NUpjsvjEG7agbd7lBGC8bHPMXzFueU=;
        b=QY2LjGD6ryxELzEa6c1V6Jz+AM9o3yrd5E0lnW4ou7cyWbbzK/0VOu3uzJkTDcM5dr
         pER0U0GeTIGnIjBaBmEFOnf9SrJRLSc/iXOp844oK6FQo5FBznQh30TKcwkQrc8qX828
         gjSWWHdeHwfziFwdLanfyDs19ZTZqzuz2TgyapVebCalchDP0qnWMXUqaOGPMMEtPAae
         vCJ3ffMX5BLA/ssOXw/P8E+kDClgFTFG9Rh2BJsVapU7yekkjFZnsEeB8BdIelK4ns4d
         Aanc/2DIMxz6rr0VNhLwRiw7KYVhEmuCEB4JC5RWr480y20OeAKmOIsXaGXJ1LQuRztt
         GbHQ==
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
Subject: [PATCH 3.18 75/93] USB: serial: ftdi_sio: add RT Systems VX-8 cable
Date: Fri,  6 Apr 2018 15:23:44 +0200
Message-Id: <20180406084228.356593854@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003568499355891?=
X-GMAIL-MSGID: =?utf-8?q?1597003568499355891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -903,6 +903,9 @@
 /*
  * RT Systems programming cables for various ham radios
  */
+/* This device uses the VID of FTDI */
+#define RTSYSTEMS_USB_VX8_PID   0x9e50  /* USB-VX8 USB to 7 pin modular plug for Yaesu VX-8 radio */
+
 #define RTSYSTEMS_VID		0x2100	/* Vendor ID */
 #define RTSYSTEMS_USB_S03_PID	0x9001	/* RTS-03 USB to Serial Adapter */
 #define RTSYSTEMS_USB_59_PID	0x9e50	/* USB-59 USB to 8 pin plug */
