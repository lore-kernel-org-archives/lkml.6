Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/s0/IrLJKZz0jnWVjlvUK+vQYrF+TdS1IFvnJRddvQjBBObGfE7275v++N/7p6hhMv2RcG
ARC-Seal: i=1; a=rsa-sha256; t=1523022284; cv=none;
        d=google.com; s=arc-20160816;
        b=q34p3Zc9Q7swD2Ug8oNfRvAq7DlZ2Bxa9k7SjV1Uw41APhk2LTp0Rb6MVsg/4waLCQ
         NCheGZ8l2l5K9x7+Tsuyek2P+c2kRxmKn63NKSFMNlpJT8HKd/1N2o2QKbkKf7RFASb2
         OxvHlCV2TkQAfAryeUWCkS7U6AZ5YYCTZMUUsj3bvrCEf7QurIHcB90jee4YVkoLWFF4
         OFFMaWfYGPDx0zyINN58ph4vPllI9WFSZGzpHn5raWJhmQoEiP+SY+h6+lkQoqhGK6Lz
         L0MpNDwz+DrHxU9z0pENyUCctzk3xEkK7ok+FT4McXHv3K5rE5RguLQ04Btus570p/Xt
         tD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0Y92aYH3vDvHpiTfDutftsJzFPFwqV4HeoJpuJtvsVo=;
        b=nnyMuL5wuIK1+7PXqcrKxozhFbi0QqkS1/v3vYtnyIxYifCS6kacImoC8paNCZjk2c
         QhYKP0dlRfZgrfPIlLM1HnjoiokP/lMWYhYSEE5RMduAL1xWOqjFS8EkJr8lJugsp4JX
         STbEcm+S0KnYUx1IRmGl9AFBl88qLW/SS1Fm0cIYRXrK80j/w0voY8Tl9K15u6pn/XGg
         cM4wdJ/WO/KI/WHjmlMX3ZiySQnB70U3k7FMiQFWWzgNa/92RS/igBUOknqU4j0sRrRn
         Aor/LE+cD5H+IXTjnNAXleo+4Z8A9NM+iDrYcaZQ6PEj6ka1Mz1YSRreVXr8LFr9oM2s
         oUXg==
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
Subject: [PATCH 4.16 02/31] USB: serial: ftdi_sio: add RT Systems VX-8 cable
Date: Fri,  6 Apr 2018 15:24:27 +0200
Message-Id: <20180406084341.339246055@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003568499355891?=
X-GMAIL-MSGID: =?utf-8?q?1597004614920010310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -769,6 +769,7 @@ static const struct usb_device_id id_tab
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
+	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_S03_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_59_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_57A_PID) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -923,6 +923,9 @@
 /*
  * RT Systems programming cables for various ham radios
  */
+/* This device uses the VID of FTDI */
+#define RTSYSTEMS_USB_VX8_PID   0x9e50  /* USB-VX8 USB to 7 pin modular plug for Yaesu VX-8 radio */
+
 #define RTSYSTEMS_VID		0x2100	/* Vendor ID */
 #define RTSYSTEMS_USB_S03_PID	0x9001	/* RTS-03 USB to Serial Adapter */
 #define RTSYSTEMS_USB_59_PID	0x9e50	/* USB-59 USB to 8 pin plug */
