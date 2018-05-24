Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoVD/7Bs3ECU0ZfvOraOj9JJd9wHBYy8XZ+P3bkRJBj0U10PF0Vb2nWMOds4/0xmHh2cQ6Q
ARC-Seal: i=1; a=rsa-sha256; t=1527155647; cv=none;
        d=google.com; s=arc-20160816;
        b=PhxQyzOHIIYvgVyAFhHAtNo7jTkuHOQpCiNxxVUv97irG9B3T0MToXRqEbG/E+Hggx
         a7zKVB509NSi1b/aSLQhxw0PG22wAH/DM8Lp0LUglASoYs6Mtks+pztav+nIQPcF9y6Z
         1JzTpSx1whUeuANjxsxmYDupJ0DuNH/L7PFUyerNUnMPPPkLvgXLuZhLKHR5N6+zd6i9
         C+M3pOP1sn2gofzCrLzGmA3/XJTDlMaT5u6GKJr2iv4LeHEy1aiveJAuoBGKFns5DUvH
         NJZThqKXnDmhVCLnsqhlfy29ZzCMNy/tDaikOucm95yp6bu6dIqkroIBkjkTcT5q7vdB
         rrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WHV08FUM2rb3fkAQSIUIiJOGdHPUoPkLhegALU392cw=;
        b=CCyJdnYsDfnpFd55dvrsMOepbnCn+LBHqF2dRLbW2q4JICNj/ZVHS7nZV6eexdVG9L
         1Kb884VH1d7iIY+s14AZ48/kXCCkKeMj5GLcBo+y/gVv+Pn0QKg9Hf/9IxCZc1uQG1Ro
         gKjIsTYLK2BFFt29U3bzN73DjuTt+OMUDEfK8Iwbv7yInnDERHpsQ0485Vz8XbFojDn3
         f5MqS+uHfZbAGoJoP+6TsjFM97gvpGVgB6BRVhtDBZmNyPzZ3TxNYZZxqLSn8CEhcsKc
         q8PcQKKgt0MUUcE+Czv13/377lKrTE6OH9JX9ZuCrL0maukEpkPP1QJGnPouLTwc/epK
         Hy/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xD7gp9i5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xD7gp9i5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Torsten Hilbrich <torsten.hilbrich@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 065/165] net/usb/qmi_wwan.c: Add USB id for lt4120 modem
Date: Thu, 24 May 2018 11:37:51 +0200
Message-Id: <20180524093624.650946120@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338481714758794?=
X-GMAIL-MSGID: =?utf-8?q?1601338760031298985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Torsten Hilbrich <torsten.hilbrich@secunet.com>

[ Upstream commit f3d801baf118c9d452ee7c278df16880c892e669 ]

This is needed to support the modem found in HP EliteBook 820 G3.

Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1241,6 +1241,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x413c, 0x81b6, 8)},	/* Dell Wireless 5811e */
 	{QMI_FIXED_INTF(0x413c, 0x81b6, 10)},	/* Dell Wireless 5811e */
 	{QMI_FIXED_INTF(0x03f0, 0x4e1d, 8)},	/* HP lt4111 LTE/EV-DO/HSPA+ Gobi 4G Module */
+	{QMI_FIXED_INTF(0x03f0, 0x9d1d, 1)},	/* HP lt4120 Snapdragon X5 LTE */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_FIXED_INTF(0x1e0e, 0x9001, 5)},	/* SIMCom 7230E */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
