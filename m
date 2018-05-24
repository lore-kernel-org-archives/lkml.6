Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr8zp6a8/U2wgNUsaaC7I6h6v0QNVSfjw+6x0JttNIcrC+OBoeyrSpSged3HjPNpPW+q7T1
ARC-Seal: i=1; a=rsa-sha256; t=1527156152; cv=none;
        d=google.com; s=arc-20160816;
        b=eLqO66j1efyVbFr8u/1BrqasTZHt9N15Ro58jmMdDHILfHUdoo11U3vs8mHiQu3nBa
         UxOYvDamYPkeZ6MsUEOGhD39zVoWtWLIKiawiKMcLzI0d1tXUlHUh47UM/ROCbmbJn5N
         bZCG1v1MJuhx8zB6tUBY68slzn7do+c9bU/ehYwbI+bFAyvSy6T+x1Or0c/KZBw6W0/1
         MHUx0u0yIXfy86xuRtOFPePH4Kk5klTxHoBWra90wYp7LtFgwIsVvo4CsL84fivoM2tz
         t6blYZJ9oEomfTebM2ysRJuMsZ+U2yaYH2wKGFH8RTHymw3yYV1dBr0HSV+3tcK7oL5V
         oJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eGWrcWGpb5u42nm7f13ChXxusykTFEL2mkEgjxfsV0c=;
        b=t55KK5h39Q0vXNLwYENtmMY8R2B9f5LBMHSmZgMnTFMq/UzsKpc1rkwWlWGOcDey8Y
         0TcqEuX6zKvwHSkq7CMugmVNZdwqO4NrkEH6bewP68R2d88xOoDHsPPz0UxBadQiVrdp
         EW1NcmBb++xc6+u5SfCFoAjUsyOiJI2uNYwUcV9WsaaPKdHXy7vTHo+6GRz8pApVEO/1
         zRvMaqyHLPQw/x3dNazUzw3EnmtFFsncQF7GW42l8pG+GmQfRkrAOt8FNQfGTl1UeRpb
         QolEX4iC6TNRcstf3zyJd6IAzQNyXTyrA6DoBdbH5U/OnYdEPeBvIbA2+vW7cPxG+0bc
         WCvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rkerjsrT;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rkerjsrT;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hon Weng Chong <honwchong@gmail.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 082/161] Bluetooth: btusb: Add device ID for RTL8822BE
Date: Thu, 24 May 2018 11:38:27 +0200
Message-Id: <20180524093028.358986286@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338426796685500?=
X-GMAIL-MSGID: =?utf-8?q?1601339289579232565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit fed03fe7e55b7dc16077f672bd9d7bbe92b3a691 ]

The Asus Z370-I contains a Realtek RTL8822BE device with an associated
BT chip using a USB ID of 0b05:185c. This device is added to the driver.

Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -377,6 +377,9 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
