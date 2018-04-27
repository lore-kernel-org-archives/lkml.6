Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrmJ625Y3Vv7ClNwv89Ty8uPetsj/YwVbjoDWxDlXXYDWcm76v16DSOoXuykxUd64Gr3/R4
ARC-Seal: i=1; a=rsa-sha256; t=1524838200; cv=none;
        d=google.com; s=arc-20160816;
        b=sjSGk5iSHqP3Cbt/6txRMWy15zoIybR0sPJX/YSZxQHcx9JKNRwVqMFDu27SjtAi9D
         d0/TZG4Ju77hmWh671vgzSRsKNwWafuKrW2AcuQ8cc8Y1c//WObobHEn111oXSTkD9qU
         9voESz4Y+DEWxrVXFPZXZlL7qHqtmVOk+RAQzuN7T1PukEi9m/BcRApi+3ELKsKiE7pK
         yLXe8P8cXxVohMAEN4gVzB1mXqJg45PkG4Gj+Hmvk5uteBLxeQvXGc2IbdmWbxITXap7
         JMM1GhpipHo/P0+3c5/ykceJix6Dw8BDdAQFQz2FtkLhUmWQ1b3m+vJYhgxos3nrK7gl
         WLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=OIuwOwhOX7roM17XDgLOLPl/QCdbW3fgRDdITgi4Qrs=;
        b=S39AVu0xMqMvSX0FEg5Na44vi3E8Jvg9JgiMikpY1FfXY0aA003k1Yy4lMKNQ5Ebb2
         K/ZLUwmSngyaTAP1Tg9QtTneYd7q01xTx5Dl1XuCYOazBBbcznnOIrswK+HfYE34klgM
         K4OohsbmBs22unz5X5Pg2s73q3ZunOP6KfoqFgnUah1D53q+wFAjZHFCETUooxIVjmfI
         xDhXo9Nc+Bj68KuiVQuc4B2NHGEteZnti2/wM1EYCTlAnWXSVxHI1vmOSMBzpp9CDm+C
         puhm6Wvrxc+w+BLMctd+B/sZb6fOYLjbz1krZ/DTXjgXeQldFI7wGN8qU2xwdjF+ISW6
         jd0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF54421895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 18/81] net: qmi_wwan: add Wistron Neweb D19Q1
Date: Fri, 27 Apr 2018 15:58:20 +0200
Message-Id: <20180427135744.339106273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908741129468811?=
X-GMAIL-MSGID: =?utf-8?q?1598908741129468811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Dembicki <paweldembicki@gmail.com>


[ Upstream commit 4ec7eb3ff6eb5c9af3a84288a8d808a857fbc22b ]

This modem is embedded on dlink dwr-960 router.
The oem configuration states:

T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 2 Spd=480 MxCh= 0
D: Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
P: Vendor=1435 ProdID=d191 Rev=ff.ff
S: Manufacturer=Android
S: Product=Android
S: SerialNumber=0123456789ABCDEF
C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E: Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E: Ad=84(I) Atr=03(Int.) MxPS= 10 Ivl=32ms
E: Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E: Ad=86(I) Atr=03(Int.) MxPS= 10 Ivl=32ms
E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E: Ad=88(I) Atr=03(Int.) MxPS= 8 Ivl=32ms
E: Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E: Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Tested on openwrt distribution

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1107,6 +1107,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
+	{QMI_FIXED_INTF(0x1435, 0xd191, 4)},	/* Wistron NeWeb D19Q1 */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */
