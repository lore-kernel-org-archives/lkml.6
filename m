Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv5lY4LxCyrzVLTEaBoXSbw3CXFpqMkR7NSVdWwNjevfuxk06zbz8Plg8Ps4PRRVltHRpno
ARC-Seal: i=1; a=rsa-sha256; t=1519980979; cv=none;
        d=google.com; s=arc-20160816;
        b=N4UJjN1JGCiA/oNXBTpzwC/GtYdgu3nlfw9sc1juPEPj6GpyDGI4RuThqbv3gDpwYr
         pP2LjPtXbagykarYoa+6hrjhVjwpkY8Nx6s16+zYxdCtJJXiKEwEMj7Uf+kjZbE5hleM
         48r8vfNHnJH/wBm6LGnWWM8W1ov2YAo5Ped8rs+XBp+2VS7/nKI6PBpOZwvRlp6X9boh
         Whovm5wcQE6CQPefsPKtff2onOct11So+WdR/RgmnYihowtgCbrVw4oPhmJTgOnB+aB6
         1KJ9gWMZJfCIXrL4BBsdQHb96thoxsQNOg0FaBs1kfeavzlwGkToPd0BYlkQUzcZ/J7f
         f+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dTDxnlwx6WTEDhvupkTVPTLfWPv/+nutcC9ShKh94hg=;
        b=POX1nVXaluf2tv6cTr+2ZjJhXDvHtShCHuhGyShhjNdns65w1tCN8zKjRvz8/mnOfV
         udw/UmkKTPjXvOU3UMS3kqK4zF6yHAOmLoE52y056YyvuQzRM19yOKIGLd5vqphp/RFh
         p8Fl4ww5UqCs66VJsMNbZD7v8GrnxvuL8wd77VaVpoM/AG+7k13kzkXZnw7QdMLWQs5B
         I4AnJQxmVQMsi7dcTGWYy1l1cjEerc1bQLD9QbUYe/qHclgqOP09nrB6OZ03fFkp1Xqp
         /ZEsy6/bh0RT6bYP239IgAxpCTQiEVTZk0hSEJKSpK6N5eNa4xaid4fZgUjCfT16uQQW
         sOBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 06/56] net: usb: qmi_wwan: add Telit ME910 PID 0x1101 support
Date: Fri,  2 Mar 2018 09:50:52 +0100
Message-Id: <20180302084449.963512275@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815575492391881?=
X-GMAIL-MSGID: =?utf-8?q?1593815575492391881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>


[ Upstream commit c647c0d62c82eb3ddf78a0d8b3d58819d9f552aa ]

This patch adds support for Telit ME910 PID 0x1101.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -914,6 +914,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
+	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1201, 2)},	/* Telit LE920 */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
