Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvP6rkPSOunnrmJ8DW9EJAX2z/DAx0ytQN+fEf5erAgkakP7C7W51HWXfMQ56QnG48Ii60+
ARC-Seal: i=1; a=rsa-sha256; t=1519981386; cv=none;
        d=google.com; s=arc-20160816;
        b=wADjl2wRx2HIPcqzUB381+Id/5S+7ivy79NcO7C3E4A+UUUqMXxRCe7Cz8pux8gr2I
         IB2pd13I9gkmfCoS0GtjljGyutt45uo32pIFMvw1JgG2Ogi+9G3of7S6yqO7JqOQjJxQ
         v80CDam3c57R0tuihHSJ0AJ1DCqB3DIS4TFrSAPq0sy04uEMu4WKtLrtxIhE8Mt+Wknk
         QGTUb24Am5gRQgYHjgPCpwO3DEJqnJyCs4SHLQ9rfvhGsrRsSr6BryFvSZuiqtabzF2p
         VIJ6TW1FAi7Q3yClttotAY075K1iont3OjMrkBiotMbGSAAeMmw8sK1YHUayfW/cgHZw
         uu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ifw3eOfyIb9JnXRL8IeecL+EpDDljEHMwyRm2C+YYDE=;
        b=DXwc0k7bHaIxrNW4dtlkp9WZBRO3Z3/LLMJBAkBbBNmI5HflhB9Bnoct7thH3CIiG0
         tgXcXkW4aHrUmaJqD3m3o5FPeVY5NEbxn5bp/TKhZWQvGQgqHFyOIHh8R5GtUmjOcKvx
         Mlx9GFE9zP7SBF6oD3s3XL9xVtWc2VZL2kKwwkU4yxt42gGbs88HI9qb/62DqVSCcaEa
         sqvIMgYdgBOSsY5Q8fk3xTE4cffa0wVHJhBQz464TfxRVurcXGZNxgRjsa939bmyOkFU
         QkQb8Nf5N98nU94upSH7ILvj8FfPaNI9vs5BVVtgSM6QedDP4xhknTLZ8CQatSfgSny3
         3fug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 076/115] NET: usb: qmi_wwan: add support for YUGA CLM920-NC5 PID 0x9625
Date: Fri,  2 Mar 2018 09:51:19 +0100
Message-Id: <20180302084506.929356077@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815675430721667?=
X-GMAIL-MSGID: =?utf-8?q?1593816002111094943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "SZ Lin (林上智)" <sz.lin@moxa.com>


[ Upstream commit bd30ffc414e55194ed6149fad69a145550cb7c18 ]

This patch adds support for PID 0x9625 of YUGA CLM920-NC5.

YUGA CLM920-NC5 needs to enable QMI_WWAN_QUIRK_DTR before QMI operation.

qmicli -d /dev/cdc-wdm0 -p --dms-get-revision
[/dev/cdc-wdm0] Device revision retrieved:
        Revision: 'CLM920_NC5-V1  1  [Oct 23 2016 19:00:00]'

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1100,6 +1100,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
+	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
 	{QMI_FIXED_INTF(0x12d1, 0x140c, 1)},	/* Huawei E173 */
 	{QMI_FIXED_INTF(0x12d1, 0x14ac, 1)},	/* Huawei E1820 */
