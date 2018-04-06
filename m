Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/R/Kqx8NKJcN7+QrP9jT0WiefrG+8ITnqCQWvo2vAbbrt19PFdNnb+2FhVWdE0BNj7g/fi
ARC-Seal: i=1; a=rsa-sha256; t=1523022142; cv=none;
        d=google.com; s=arc-20160816;
        b=EP9OTXKcJfrYkOOCzDhBDQOQpYcz1wIQEOcXjc+8s8NRDQRsLz3voizxDLCqkp0D8r
         Vbv0z+GhiQdVgKpE6c9gg/G1dpsE0H/moFkNw2A1X1tcilV7wLc6UAVvsERzlEhVuG6n
         8CUzwSI8r/6QlmmS9DjvYDi6HFTck9Kg6Hp7WN8eP6VldrBRfoaH96xUgiO/v+KIIN9f
         YFonBidNTxNAt2+VElE4rajjrtnLA/gjZDMr41npwS4+mgv7S1AbvGgn1N3A/oeM8gzB
         DXnUYvBPlxbkvIRB74B57VFfdrohKf73SSHEDWH7GTAFJrq6B2hqtgHd5lPjHK7QImMS
         xH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0w2FOL37MZ1DYj7DzTkWTvUm+fyeFcExgNmF5wLFvXg=;
        b=GhNo2d3HWg7Ko4YhS0yDRtZaIdwjd9u3bgS6xrRDsHZJ+eHoekOYxK6xwuwMmPFJqj
         k96/QetTQlU0SuyZzh54afjxhlkkU/nZ4Yk/MdIwANcRFodtK48xFos9okfRX+eIoUB6
         86ar5zRDcBlPw2fIcv2d1TkAIbhybmVaP181xFotXqrSopkxuTBu+fzGBBMRzgbxSgxm
         Xo8FZLOo3X71xpu/MM20sRQU3cdJUZxqHHGN8oF9AvXJfFZ96RwqSkqv8je+xJDxsiEP
         4Yd6/RNhDwRvdhrrTB8lNThKMkJCgcxfRiPe8cDU15t1gx3suiceAV6k75hVNvcLvRH/
         qccg==
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
Subject: [PATCH 4.15 42/72] USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator
Date: Fri,  6 Apr 2018 15:24:17 +0200
Message-Id: <20180406084352.587163704@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003574666935694?=
X-GMAIL-MSGID: =?utf-8?q?1597004466535451984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -932,6 +932,7 @@ static const struct usb_device_id id_tab
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
