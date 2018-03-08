Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487242-5-11389672329197629408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487242; b=koO9o8o5DNJk68d54K3ZPNcObwt8iMf31Yo31hvokK72FiQ
    CcN1fpvUvEY+OS3fdUeP6Z8BkxhOOjUXX5W8EPm9sO9vUBq75IWRDAzOPMn+Sr5i
    vBiJV/3y8kTdONv5d2Yu4ISURzs9zw1h06LyuKiH7kOjkOhvjuyNVaf2CSHP/aev
    YrSGe4/ttGaeaN4P5yl5nZ1vRdY+YukgfoTmlmsHbwJhjJUOq/+FimXnGM6nu9MK
    ePfTktAYfo1CMrinuiXB7ir9eDr3O08Avbp2ro6xqWQZskMrIrVvxgIe92Ct7Mea
    teKMV0iRCqFBZ9zYqsjimE0Rm0zOyJMwg9mnc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487242; bh=l+L0xi
    AwpgkeS+/2Ze4EIcGZWZiqIo8IXP8wV2AFLZc=; b=DuWcm3zlI4zLgvjob6Ccxn
    O5syWJoOXohMeX7yTLJaHupzOu9zVMkYCmfbtiOguh24EzkquBT0Pq9D3ttipAhi
    MbAk+Cy/vkeD0T9Pt58cRdSPGVfIHgc+OoK026f9R3UYmI2ZLeiijaNj/+5tesrA
    GcCBQSHAqaacfA8xt2y+rwRgZJ/KLrm+Q+8ASHhiV67UO804y6mO0VsELnBmXqNp
    4dCwqziCSdfvJGok/DSWer48Lt5xc1yNWYRKUFHlQ507Npfetz+HPyUAWXHTgaz+
    NcCvQ0QQ8YznptALazKFoxcY4fXS5rqWbZaaqzQvhP5My+lI3mHVKuMKzomCsm5A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eu294C2r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eu294C2r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965771AbeCHFdp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:33:45 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966376AbeCHFGP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 052/101] mt7601u: check return value of
 alloc_skb
Thread-Topic: [PATCH AUTOSEL for 4.4 052/101] mt7601u: check return value of
 alloc_skb
Thread-Index: AQHTtpqTzvTjHfhxVESCtGV7HqZ+rw==
Date: Thu, 8 Mar 2018 05:01:53 +0000
Message-ID: <20180308050023.8548-52-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:niHUG70Qf0YYBgac71PAVMxg/uMQ0DMC0EP/gqPvng5fjnDWts9eh6uHpZl1p/7TKhAHmvEVcGzUSltwaJ5Wom7lnMOvym8ZTZj6dBobMeuM/6duSGdpFROS9PQh1xlbckTcVKLiGKLKGltn544tBsRSTAp9jQtluo+EC80YerQ6XuJd+M7MhEI3CykwDWKYcC0T8x13mcTcBzz31OhMkOW4Aa9K/oUvbNpFUzgJYs1q904BJOrAlBh5R1tJSamD;20:0NszOnvx6Ai7wClJNISlOTPblrKAV+Ws6mpIdkiywyj/WiAjEM/B++772kgrcxpur/MgY4XE6q8uBLy4Q2LqUA29kzaG5T4srFj+4CWN1p6c3VLH8ocGaXTcWLLPvT8HR7CKjduEwA2LkLcgCmR090R03GZbw2RApIOa4fcRUFw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 256ea83f-82b1-4dba-a4a8-08d584b25034
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09171CAF8B1CE539D5DF4626FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MENJY+6ao8GUMoNGM4dYlspKlJ9jOmT0RUvJlgayvl705A+GiY2Y70ki5ijqCG1nfABL5HOUWo+mMS/QBVNH8+YMKuU4OlYra7znR8md5go4v1T5je+hPUu+T+UnIzy9Nab93o7aZKvKg9wKNyK/+nQYJ6aabJNxEbShaEW4Fn+ikXiD0+cqZhbKUHSZPR3VKdmkVvIZuzYyvRHJKgq+xBipdrNOU4jjXFs+Nqr799Ps+p7AqVy+HcrTWY/OKX/Tu5intPuoubNo9bf46XT4t8XfC7LTTyqPj/Ls/aKMhR7rVUYHmslpg5E4sJw7PNU2Fwxkb4feXIF7DIkylMaYrA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ea83f-82b1-4dba-a4a8-08d584b25034
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:53.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 5fb01e91daf84ad1e50edfcf63116ecbe31e7ba7 ]

Function alloc_skb() will return a NULL pointer if there is no enough
memory. However, in function mt7601u_mcu_msg_alloc(), its return value
is not validated before it is used. This patch fixes it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mediatek/mt7601u/mcu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wire=
less/mediatek/mt7601u/mcu.c
index fbb1986eda3c..686b1b5dd394 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -66,8 +66,10 @@ mt7601u_mcu_msg_alloc(struct mt7601u_dev *dev, const voi=
d *data, int len)
 	WARN_ON(len % 4); /* if length is not divisible by 4 we need to pad */
=20
 	skb =3D alloc_skb(len + MT_DMA_HDR_LEN + 4, GFP_KERNEL);
-	skb_reserve(skb, MT_DMA_HDR_LEN);
-	memcpy(skb_put(skb, len), data, len);
+	if (skb) {
+		skb_reserve(skb, MT_DMA_HDR_LEN);
+		memcpy(skb_put(skb, len), data, len);
+	}
=20
 	return skb;
 }
@@ -170,6 +172,8 @@ static int mt7601u_mcu_function_select(struct mt7601u_d=
ev *dev,
 	};
=20
 	skb =3D mt7601u_mcu_msg_alloc(dev, &msg, sizeof(msg));
+	if (!skb)
+		return -ENOMEM;
 	return mt7601u_mcu_msg_send(dev, skb, CMD_FUN_SET_OP, func =3D=3D 5);
 }
=20
@@ -205,6 +209,8 @@ mt7601u_mcu_calibrate(struct mt7601u_dev *dev, enum mcu=
_calibrate cal, u32 val)
 	};
=20
 	skb =3D mt7601u_mcu_msg_alloc(dev, &msg, sizeof(msg));
+	if (!skb)
+		return -ENOMEM;
 	return mt7601u_mcu_msg_send(dev, skb, CMD_CALIBRATION_OP, true);
 }
=20
--=20
2.14.1
