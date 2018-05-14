Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJQLMqCOB8bcLUxd0tHhawjXbxTq2QlYwG9PypaSPQvnnPjMCqZQIB2KqYSrkF/smkR4Aw
ARC-Seal: i=1; a=rsa-sha256; t=1526280695; cv=none;
        d=google.com; s=arc-20160816;
        b=fr93EB+brZqgdFCBL2ktHf7X+BvSU8Z+RwHaZB6LlUSZxwgT3bVR6mhwtg6vUaXiPm
         qvBGc9ok9qhHUgxbm3bYKTtVFlKIcGqXvtYYCj2nYnbi+Z0edKYkcVAjZNnOLWxzdPmb
         OviQyKwqjwOpbExHczleoz46ixLAe5pEs8eNTKJpGvlSsD0Ji7AGxzCLDUee3sgcOuvl
         VqvYtGoeV1hFSAZtRwselH7XtjrIw/TdxEeZDRbLBfOLX+lnQgAyXcCIKI5EX8inoSUn
         hbM6rvJBFk2MZgcjdNg5KPR6OQ+VPZD3Z+KkA+/DM1bbt2PiYxVnFgEtSTAtY2FJTt2v
         nHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5She2OEwJ9oWhMywDcN6xXv8ytMaJM9Z1hXv3PDLhhM=;
        b=JWZWZBKuWFIGyvkwVWTf/dP0DQxpRaCr/DQpR2LziK7Gg2Q4bxM7ak0ZhCWzruMH43
         w+cI9YHoOAbppacBflkJbTInxTNQlEWm+DUCnwjtbSBB9YCc6ZFg9HGkD4ZvDR332RD9
         ltjLOmvbwWdROAILg5q6TRxhbrCmjus1W4A0/aUhhE8Qvi662lTeMbwgXHlRcTAM7ITe
         rJTTufVGSCXLGX22jwLk1gdXwWyM2Zfj+jpxPgBwHeepoDg3Wz6YGD4dZz0XcQ4mrBBk
         5kBYKD0yZGidj/D7IWypAlWxnZW21DT156p9tUB96N1P85s89uxr5JrNdgE4FMh5SWXx
         9z/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=AHEiRbCO;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=AHEiRbCO;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 22/56] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Date: Mon, 14 May 2018 08:48:27 +0200
Message-Id: <20180514064757.032432645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421225592854044?=
X-GMAIL-MSGID: =?utf-8?q?1600421307382285083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SZ Lin (林上智) <sz.lin@moxa.com>

commit 9306b38e42cb266f98bff6f6f4c1c652aa79ba45 upstream.

This patch adds support for PID 0x90b2 of ublox R410M.

qmicli -d /dev/cdc-wdm0 --dms-get-manufacturer
[/dev/cdc-wdm0] Device manufacturer retrieved:
        Manufacturer: 'u-blox'

qmicli -d /dev/cdc-wdm0 --dms-get-model
[/dev/cdc-wdm0] Device model retrieved:
        Model: 'SARA-R410M-02B'

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -631,6 +631,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
