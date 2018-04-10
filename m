Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/RTVOeF2fCLcBc7tT7GJB8LiX47CLMPwslDjomWgW7PXDq8S9eyPfCeuA4Gvo/DGipK45q
ARC-Seal: i=1; a=rsa-sha256; t=1523399174; cv=none;
        d=google.com; s=arc-20160816;
        b=FJI/wQ0snmRmpbeEMGL2k9rhAAbS7zrrGxPKn9lKnnR5CkGtqtcaW/RAqU2bHSt8YE
         HK5w4ByjCT54g/g2aP6cqGTc623FCv2QFLAfiRnDac96JeEay7hV8HS/Am2O9yFFYxgC
         AQz4jzXMD8vYnPC2sT9TEKZouYp7whVQUFx9YbyoX/22i+MPGT7Yqceh5vFGwW76AiAz
         o/L+l9UqQ8vhTJbp5lg1LfTlOsNw66jesCqrKBIuXGunGfpM8TT3429EgWM8SrWhOVtX
         BAtFOWcQ2cZHXVocxU7Ikkdpo40seRq9w64Pus6eNODAu0WlT6vYUuN7nebdxrXdYXXM
         gZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kmiu03Asg6yie0aQEtNTLF+ZW4sPG56iCKJymyQ1wgA=;
        b=JV3e64QLGE8AUH3LTBVCb5XLZjgNtiVlwapBsGGZjk1LrJpYUzbN7uX/hyP8teIK2z
         s8RDop9yNIJgaroo4Ln1TeYJ7iFB2xdSnDQT9Keh51ohXCA9O7gKeDbhzN7FlLaXhXhy
         jXQfBf5WqrW9DVmapzpNroG90AqIc3TUQmWJzyTOOuabSkun29c0GHceY6Qz6v/eBV2u
         MGtcRPkPYIjSUNEhGCoJdEA8Xf40dVDwKEJ9Sugwi2cPXx4dZJB6rqI9Jbla4sD5kkvX
         m1MfNwa+/rk2HuujHc5p9RsTZLGLNTsxc4IPlqKWh8Uh61gh3jRjCpss31yBP41/6GEw
         zyww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ioan Moldovan <ioan.moldovan1999@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 006/168] Bluetooth: Add a new 04ca:3015 QCA_ROME device
Date: Wed, 11 Apr 2018 00:22:28 +0200
Message-Id: <20180410212800.505948675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399813394842159?=
X-GMAIL-MSGID: =?utf-8?q?1597399813394842159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioan Moldovan <ioan.moldovan1999@gmail.com>


[ Upstream commit 0a03f98b98c201191e3ba15a0e33f46d8660e1fd ]

This patch adds the 04ca:3015 (from a QCA9377 board) Bluetooth device
to the btusb blacklist and makes the kernel use the btqca module
instead of btusb. The patch is necessary because, without it the
04ca:3015 device defaults to using the btusb driver, which makes the
WIFI side of the QCA9377 board unusable (obtains 0 MBps in speedtest,
when the 04ca:3015 bluetooth is used with an audio headset).

/sys/kernel/debug/usb/devices:

    T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
    D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=04ca ProdID=3015 Rev= 0.01
    C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
    I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
    E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -272,6 +272,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
