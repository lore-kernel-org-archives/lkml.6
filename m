Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrLUdhgoi2PsefWb0bGgamHzoAACLruM5U7sdGX4hiy8TTa7xOi9E2SIjIUS+XgzqjdSyHm
ARC-Seal: i=1; a=rsa-sha256; t=1526280618; cv=none;
        d=google.com; s=arc-20160816;
        b=0iOxEoXAAk6ivG2usaylzbIA+YKbVqAki3vhBKibtbFmBzzTcaY9ehZ0+kY/KwqWan
         lEGteGXPbtOYfUfW8ZHEe0x/KcbUggaWtd1QzJfY9ytOxJseH3/0Qm9zVcF878e3UauR
         Sf23FoIgdl6zDsCsbeZMenHijuU6V5MjrbTIuTugocmCQE28EFBmzDra9MySx5LaSO44
         0+AgoyYrg56gTfHpJ1uP34Go1AfsM+vtA3OqYArz4qVf1mM8JrebteYMTobHu8eqCkbg
         +NQ68qpL3GY7h54uG9jbKXtggQYkrQ7XuVpxMNgD7/yq7iMqX9qlZqIw66DdmDX/BKbv
         izhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=P0HqhBlUw8AAQqoxtylrkWXwaWnb/D+ePFT0Dzt/A84=;
        b=zZfm2FlStCtn3kWNlhC5r15K/bkNJRGbZeYnm+/mLbzQcjq1SBXecqAj5GZZmFFX0c
         jf0Td4LMY1HsDUxofAF3fvoGZ0GxUX5C46rBBVZw7OIBNhKhjDp+3Cpd+eFC6xXCOfmv
         OKX/RqLvc/4C93E/GOyiT4Yi28wbuGPVw9U1qd+7cRkE7Qhy+SfgG6HvI7qjOz7DaUdP
         Xxdawx2jMkFg/MPp8LMq9ZdX3CrP4W2CIbE+FuR9dJ3U/I5dRdOAia6nbrn9iyNM2Up1
         KazzsKHpxuW/v6M9l7hTMxN3we00NAB7SzrqLQTB6H5IDQhXOOM1VH7oz+2Nq8KABJG2
         gyPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tae8zZKK;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tae8zZKK;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 09/23] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Date: Mon, 14 May 2018 08:48:38 +0200
Message-Id: <20180514064704.444593626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421225592854044?=
X-GMAIL-MSGID: =?utf-8?q?1600421225592854044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -673,6 +673,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
