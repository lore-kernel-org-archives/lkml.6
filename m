Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487919-2-9923365462867424780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487918; b=ZsRS0bERfpnDZCrislYK7EhIJM79X3JVBAwMNIDX2b+TyYa
    TRfxaVbNgJW/J0ONDGOYxvUCbjYv2x29IqBBd92di/BSSqmuB7u541D2YlUQnBx4
    UbBXhV/6TbR7P4j+KkoR++aNjk4ibr9KX4RWX02RhNVJGTW+XcEn/5f+HyGCHixP
    5ImEtk2aVzGvcoPIBfZS36TyFusEyVL9mEqJmibx6+suW/PotA0opCqsg/FTTGwK
    oK0shJxw8sGQOfmrJQMuG/Sa7xj0MUeubPH9bHyN8UOVUmUmNDjXb1klVOzcWfmp
    RucowYYpBKVCH0U8FrW4SFukK3hfYwLz7ySxqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487918; bh=x32ets
    5zdnfBU2g/8Fpv9YXi36nQl7lbHot7jH1Jh6Q=; b=LUuTNjn/JOuBEyOogAPIYd
    s/9y06sOYs6fxV5CXpU+SSz9EHjCbmWrsYFye7lwHyo9i71iMNdCX/Ovw5PIXFlU
    9HRkZihtsUDmiEXw24IblTbnr6z1LjHGhI1QAU4nYvQkbLy9FbAnTlpSR/mfxr2K
    l4yxLpZz6J+2pXzQSlmJAq82disJMAsLD/wM2axpnYEm1Y01EIHcBnaVvqHzD7FY
    mVr0Ro9SoB8EKRjVkK27ydweuahYPYm8gNqHl6Xagj7ZcpQGjpsvoFly9u7z7WsU
    6CDs6MbZ9cZtELlLX5l4w8hGFiNMQUmV8j5YITDiXBlWptf80USrX7pIfJ7+gmoA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jJLY9jVy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jJLY9jVy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966278AbeCHFpP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:45:15 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:10302
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966174AbeCHFFM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dedy Lansky <qca_dlansky@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 010/101] wil6210: fix memory access violation
 in wil_memcpy_from/toio_32
Thread-Topic: [PATCH AUTOSEL for 4.4 010/101] wil6210: fix memory access
 violation in wil_memcpy_from/toio_32
Thread-Index: AQHTtpp6gvGO88BaCkW8t13glEiV3A==
Date: Thu, 8 Mar 2018 05:01:12 +0000
Message-ID: <20180308050023.8548-10-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:ydPXhlyeiuBenUXd7yVRfG2ahJ7Q7IGyDp0NjiSVZhCBV4qikVb4/WiGy8FlxO5/DsYmi/blcN4Ej1JKemjBQjpzzm2up7fO/rKhMd4MeI1JDF1DDenRdjDv+KIRqpmoUSQGY+hpOEhIpF084cySphAOA7g3R3MCaO5tv6RTxnPSawjYzjV1ZgwECULzO5JxiOrleaIzzMJ0K0H42wB0Kf3g2LWqV3cPB3m/oPg2hTzd5zhpQB392jYmy0njUf23;20:MiWAlztuTF5y6MfS3108RwMTRByzujpsK9R9CYfYkAEHm6qB8AXmFeRWlwMqXIFkmG7n3nWei84IOAjeWTUZhpBZP1vH/5u1bmohY3RRxAJcxb1mxo7NPDLHOXZur42lYGJwH5gOUww2O2DVVXy7vi+AiVvuuMBfqBuKEiPXG48=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e70bdc7-f193-4d33-b311-08d584b22968
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727D63674B939ABA1780D24FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uijYjrMdD3ryxllU9XZumItoj6QCPN5MYaBf1vNL3TEDsJrkN8SeXzQhlvNVZLmSAVd3aCwU3cHemKUFlXx6Ydl8psm8jJkAMoK8D9tB1vS0pJs6S0rQrcdNbYPoWaDTdROpbi+YkXlZLC+vmre0R4NJENVyBvP06kRKKDONfpOgJskz58vDW29Z9no5vx0+W6nJie/Vc13OZ5GhnXd0HuE1klHOj4H3OiH2g+tzuLp0pXgzDYT3NjAG03SgpA4rv35RFHRUw/ivERZxeVjLdwtwjpVXTmE9/V0acupuLPFhhHUsQgEPS3dqTFnbWMP67t403cRj/OxpvUJ1tlYO/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e70bdc7-f193-4d33-b311-08d584b22968
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:12.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dedy Lansky <qca_dlansky@qca.qualcomm.com>

[ Upstream commit 0f6edfe2bbbb59d161580cb4870fcc46f5490f85 ]

In case count is not multiple of 4, there is a read access in
wil_memcpy_toio_32() from outside src buffer boundary.
In wil_memcpy_fromio_32(), in case count is not multiple of 4, there is
a write access to outside dst io memory boundary.

Fix these issues with proper handling of the last 1 to 4 copied bytes.

Signed-off-by: Dedy Lansky <qca_dlansky@qca.qualcomm.com>
Signed-off-by: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/wil6210/main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless=
/ath/wil6210/main.c
index 85bca557a339..f09fafaaaf1a 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -125,9 +125,15 @@ void wil_memcpy_fromio_32(void *dst, const volatile vo=
id __iomem *src,
 	u32 *d =3D dst;
 	const volatile u32 __iomem *s =3D src;
=20
-	/* size_t is unsigned, if (count%4 !=3D 0) it will wrap */
-	for (count +=3D 4; count > 4; count -=3D 4)
+	for (; count >=3D 4; count -=3D 4)
 		*d++ =3D __raw_readl(s++);
+
+	if (unlikely(count)) {
+		/* count can be 1..3 */
+		u32 tmp =3D __raw_readl(s);
+
+		memcpy(d, &tmp, count);
+	}
 }
=20
 void wil_memcpy_toio_32(volatile void __iomem *dst, const void *src,
@@ -136,8 +142,16 @@ void wil_memcpy_toio_32(volatile void __iomem *dst, co=
nst void *src,
 	volatile u32 __iomem *d =3D dst;
 	const u32 *s =3D src;
=20
-	for (count +=3D 4; count > 4; count -=3D 4)
+	for (; count >=3D 4; count -=3D 4)
 		__raw_writel(*s++, d++);
+
+	if (unlikely(count)) {
+		/* count can be 1..3 */
+		u32 tmp =3D 0;
+
+		memcpy(&tmp, s, count);
+		__raw_writel(tmp, d);
+	}
 }
=20
 static void wil_disconnect_cid(struct wil6210_priv *wil, int cid,
--=20
2.14.1
