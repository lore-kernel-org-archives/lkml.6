Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqDJPB3zUfYeHlPzD1qcBodMrDcKF9Nk9x3SSMG/fNdZMk6xBB565njqGQIzmsRTX6OZ4tu
ARC-Seal: i=1; a=rsa-sha256; t=1525767190; cv=none;
        d=google.com; s=arc-20160816;
        b=VlK+7b2KQTsr/T+CZlNy8u+yUCueW6xSznSHMYWBibPOgd07coKfpIBUymAux3jHML
         7nYqeTazOSeICaY/ZjYZp3F2nouQSiDa5gBio2SEYMcpkWVqViYfiKBC1OFSyGAhczSL
         S1U1cUz+8VXaDNHQxlxkChtgHyz6IfBUwqrYY+WSpKqnwyFlGoR/B8ZE1XP0ro7BN+UE
         NnlRira1UsRX5QOVWg0YYdmDKCwfOFLJ5//dS0IvyiA9f+Sn2oen2MLMbMhhx33ByQzU
         KnX1rqLge/GmiQMzc52MkS4fx7g7ySDCqzgbyOcEe8eWJB7hBbjkklz75EEbP5t7Df7O
         yq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tvspD70jZjqAKiNNfRf7HzJalQJ/NMXX2/bkYI5zct0=;
        b=OtuSu37NyUnTwcOB/xdX4kzHSQ3Bf3PMXJ2AjLH2mDTobBdi/ANgSreGviVUafSXjZ
         7uDByMAMGdT4IPREALeoMNSJcqTc3iIcCdSkN0vh3fS1fJpJ5JIYswtFgBgseqELaEcA
         Yw9MM7jMPB9TxBdFWVRsdEhjw0nyQxyHGghqFV2ZszpaqxRv2i5chI5FT8z5InkhtiV5
         dp5rpPGL+tQ+qjd5A69j+/mtpA+XxoQdv+wDNYGLCEomZBAN1NzwDAtxfyd7E9KbiML6
         m4KPIJ/BcbeFryzZW/RpWqggQaWk9TxawcnjUeTBWhkz+OJ1mi3v2lQF8NU+yHIFCRmd
         UPQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LQFGZsjG;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LQFGZsjG;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 23/52] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Date: Tue,  8 May 2018 10:10:21 +0200
Message-Id: <20180508073931.146727628@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882858035853957?=
X-GMAIL-MSGID: =?utf-8?q?1599882858035853957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1098,6 +1098,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
