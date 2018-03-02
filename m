Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyqLlQye3ROdTOkTQL+keVZDzGu0bnJEDKe8N9Jp1KW9qUDdrDMgz4TmqVgf+8Cdh5499w
ARC-Seal: i=1; a=rsa-sha256; t=1519981158; cv=none;
        d=google.com; s=arc-20160816;
        b=iYb/lAKJ7ZqIy7k7knlLx6USSyIrK9oYgiF9G6988yrvoq9V+T0mvVrULdRQyXH8J/
         LyRRc+tzy9LqTNriNUnMTQJwHYxrWE+JDS8meKFsZMxEct1YV+JRtg85X9NP6ul6DAnj
         dQQbCmWzr9W6O8cZQjDSarWRoGNSuunLlfA5cEb/NA31t1oQiu3+G2xJxKfGcjYukeZ9
         Cd2dqyYivcKSJz0G/V2fNNywkWbqhP85/G9kqjyTZyIeH6VREcQgFpAZcVH84ESHt1hf
         OfljD+y4rUUblvewLVgOjQkhi5lFP6pWE8pgEQ34X5uOiOBdNadQQ2qpIPRCOfseyPcG
         QMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qAMMRObhQXomvKCFSg2LpVo/TWupW3dcq7FMPqJ3WBI=;
        b=aNj6v4RFV+xp9BzE6BeQY4WKgRbVQ/Xz45zjPxcopvZudy73XqtJo85+mz7jLsxAIy
         ZHNILvzP03SNT+CcBd2Tov2tnHbOjQbA7o1eMEmQsZYjeBqxXIcBviUcJuXZfQkcu6CC
         4WBfvu1xFs7hzzG5QbDfJYAkxcGgmk1JkvQif0ckyrVsseSo/N5nrp36XfuRe5+C2owc
         ckmHJw4oCOB4IlewH8zpY/YOjCTy73rMe+/VL4MYv0rPT4XhUfn8B0J6EyQ+IlNkqiLK
         a+J7wHzUHnNiHUgAfVOCO8xwSRsWrHwdt6v+XPOH0D1WjnRiQNc66K99ZLw55hdQCKtg
         El5g==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 011/115] net: usb: qmi_wwan: add Telit ME910 PID 0x1101 support
Date: Fri,  2 Mar 2018 09:50:14 +0100
Message-Id: <20180302084504.320719492@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815575492391881?=
X-GMAIL-MSGID: =?utf-8?q?1593815763584666868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>


[ Upstream commit c647c0d62c82eb3ddf78a0d8b3d58819d9f552aa ]

This patch adds support for Telit ME910 PID 0x1101.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1211,6 +1211,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
+	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
