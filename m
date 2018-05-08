Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpGUJtH8EawkXP1yZntAosWvSjqDYGAzwdXVpfdpmmzfCg6/vyoZ9je6kdVZCqM7pACA29g
ARC-Seal: i=1; a=rsa-sha256; t=1525767417; cv=none;
        d=google.com; s=arc-20160816;
        b=GULZfxCqfQ4GvTltNyUNN2KOoEBdKJOITVPhX5MtoiE8uBr49/9uw7ztpVoMflFXbf
         8CvxU1wnX+DHc9B7bBTHGw1Wot4YPkWXq+Z+N2c60bgzeIIZEmF82hcoCvtydp9HChfa
         g5jiWxJmEs1QqUd959U7bUbOTD9TzMEmguNlzDE1SZCougSy8ng/tMkqMTHTlyQBsqKb
         PNKOsW3u8Y+8cnPQnzBRVqmHkNv0e/+KpGZFJJWdzIPzN0mVHMPgCd53pJx8GW7vemK1
         rFTRYd20C2VEiJUT4sbrxpRlHKlz7fTp/gJ0xrXQpG8tx67O4BMuwQEaFn1UrtOU0DdZ
         0TOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+xyqq0nFSm3hoFBUCBqsmISXUZPz+dq5zfxrZqWnSno=;
        b=ouJZtgG5NtBLyD6Im/pItiX5CavsLQv+WzvhhsI6KwaYJdB/skciKKKmAchPM+9wuv
         yPJB2d7BcufqJlOeqU5zAzrIXu6nj1EKyezJjg46q35Vn/MYPBmUosg01bcCNd1J+m/6
         sogZ4TCwPY00TbktVv3zslMlNR8rSVFWgl5+h6s+aIRzwH7lPSL0Z7nDH78YTU7TykPI
         BkC1jMI+uNdr5jkeNyHppi/DNatnB5WNTt1K+qeNBIHnsnlLROgXi57C9r2QLYeLiTrR
         QBHfaZr1lKfgA1+KlWa3ZJAJMv5D/jGDviuZhuEMSyDmbFj2sMDQF83uueRcN8/ZRl+Q
         se+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nOJbfaPh;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nOJbfaPh;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 19/32] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Date: Tue,  8 May 2018 10:10:59 +0200
Message-Id: <20180508074012.023797885@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882858035853957?=
X-GMAIL-MSGID: =?utf-8?q?1599883096388731346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -803,6 +803,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
