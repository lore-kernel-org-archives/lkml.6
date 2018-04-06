Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/aNMvncedh1Iy20KN/oFIEaalR6oZ7mWnVSlXeq0QCLCi2uyBVYXgM+eXitJeupBQJcHPz
ARC-Seal: i=1; a=rsa-sha256; t=1523022028; cv=none;
        d=google.com; s=arc-20160816;
        b=U8IFoaZAI3wWTO3C11BPYN/yQ+oNjHgZhzqeHy4b31ehRpc0Z7zYxYKDJ9jeSRwMju
         06Wj9nwBCpWdMWbgm8Zfjf+Jt7Gu/0QubzHUcojTgYPBboylK84ZluNMzOBGYeBNNroW
         B5xfAN6zNlAVkcJAT7Yvt2q5BimEzCWw46CHhgQBbmpMNXO3EvVHn2UjVKfDRjbrvYlX
         PVkN7FysDHa8/M0LBPEmndAyXjE9V7eMUmStT15paaZtZvQQh8PWAhUNajfgYuyW88YD
         DhhpmkuIpdfRKkYMY9QWxdWHC53GKtcNqW6Cj/DEgSmxg/rAykV0jENmmOQKqNTbnvmf
         suKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4yijZ7ZW6KXn7VVm9bLEp54kQKVogltmlivm0CDtu6U=;
        b=LW161L010CJjxBiBt9FsunbNalvonAoQXs52u/yqTy3FcVoROFEjOv4adsuasii+zv
         zlNC1Dxb1T2yvyyipxLqMcste2fTqZy3UbSkJuNiXvqi73J6p3FDqPUKHtcRD5+iuGVS
         XL/z5qgR5Y+8N2mBraOTqqlY6Sceh6fhwwZ8c35+taEEn1D3TuRCd6xN+4X83RnwUPD3
         B1dTGweSoix7lyaHbGlO6G+k9WH2FDz1mBCZP1zU/OO4+K10l74XTjb/CMU5WcVlEBjW
         Rl5ZHsUOAFkhzJmbfmm7QXCx8OEbpm7y34NLNFQsmBdij0qijhgfRIusymtSXQAb+fLu
         E+kQ==
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
Subject: [PATCH 4.14 38/67] USB: serial: ftdi_sio: add RT Systems VX-8 cable
Date: Fri,  6 Apr 2018 15:24:08 +0200
Message-Id: <20180406084346.598426680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003568499355891?=
X-GMAIL-MSGID: =?utf-8?q?1597004347045380792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
