Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsjcVpUiQsDcykKIqb5SzK+5ngub8PD65PE6f1VoZCNehsFcGPcUo3lh1m4uwQaRbFWxXtz
ARC-Seal: i=1; a=rsa-sha256; t=1519981074; cv=none;
        d=google.com; s=arc-20160816;
        b=aC3cE6FejXBQKL0VXpgK6ALJ94MPVXaSXi6YBfH6NO6yBUG769bwt9HnhOzTyrXPzo
         Gih4vhjjEJ09LNhu8YZPnanRXPLthsTYY1d18KgGZWG3u9eukOF4O+0WDubK9S/Hli6H
         vi1yikrwPEIeSorRC8bGJh+wYc2u4XpqBnOd+nnQ86xIA6W7b/TWmvHov2iGTxzq+PS5
         z2MrdiNxQ+bTYToIPNoAsXC3cJy37ejcEFLksi2feM9cslZVu+MECH5hEDT6gZqUmY44
         sDKE2Mazho476WlPQpz9GYuboqyZN+ND14XANb/EmRVEFBDTFvkP1Rxx+otgUoqYARzh
         70uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z1VXoeSS5ELPOeN0byEvWeBpBsdL7WOZVEAF/UcibRw=;
        b=xivaRF+cZy3BW1dVxCDv/ow3mz9e5lGe8jcuR/L/xi5OPCWGcuCX+UyoZ443cUdjRg
         zAgpHCnQvZmCvO6H3tRmgp/OLrmGsG6PZdMD9fN4mRJePyHF075rqeYtHmPL0dSrhFQx
         PuA+vP9tVusGLrofTEZrF7L7pTl6LktQ0bslS9BqL1imx/azXbPAifDXXCTS8fm5C67E
         h7OR/TYsbtYrj48vnDozuqA9n6vRkdY0z0NdZNv9kEycnLNCzyuqttVxyMMqRqFYMaLA
         c9N3/wEtZzfLDSUJUZAby6PR/H+IdAZq+45hePu0ZDb45FPrayGT5pebnqKfrM4vOnAb
         kc/A==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 40/56] NET: usb: qmi_wwan: add support for YUGA CLM920-NC5 PID 0x9625
Date: Fri,  2 Mar 2018 09:51:26 +0100
Message-Id: <20180302084451.598396742@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815675430721667?=
X-GMAIL-MSGID: =?utf-8?q?1593815675430721667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -805,6 +805,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
+	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
 	{QMI_FIXED_INTF(0x12d1, 0x140c, 1)},	/* Huawei E173 */
 	{QMI_FIXED_INTF(0x12d1, 0x14ac, 1)},	/* Huawei E1820 */
