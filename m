Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486471-2-5387134847389284608
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
    t=1520486470; b=nax8oMmtNT+7q5cUJ7BoiSzodPJjCkniP7hx1hoxWD+tLr2
    X0cDzOlPzGGa3oEzO2BC1kAxpLUitgahsbiVZf0aBSXkXS3dIv0i9Q2BO+eQOYRU
    9D3FMYFp3UoKvHp4SBxHUvF3V8tgx1snuppuQJN2S2yszJAeDangikpiwAXy7ToG
    x4c6pXxo85vVHNXGcxiabHDF33siCQIes2Cw7RY2BhC6NtTfD55PzZsZoY0KnMsi
    YbkngO1EZ76nT6vRA9OVai0q+9isfwUvU+niJgwkYRVlay4M6/Eulrqf6mJ8jEp1
    YUIbNEG+u2T/g+PlJVR8cqhS7hsgPv7wHpwvR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486470; bh=ApryG7
    7PrGvHmmLXvTgjzgebfZmdYCVyxtyJ8tPTHFU=; b=abVPjX8EGzjuU2w+yWtCLZ
    crb2/aFIfsCt6BdELBr27ryGIUnJoo5nMU6035pqh8JMJ5f9ZRyqJoZUAgkOC9gt
    IeYo6hh0BzMPjo37+jvmJo5ZEBoiHrBX6CItWaUfWyKGxYfnaWRPQH8feZpXMZH3
    iwFPcAXIB4StzBsIX4V1rp6Irc83FAE6eL490NmFju+FByBN1MATEYskqc8rPT5i
    xGFBLDNwY1sI8ZdhEqSkN1qZBi7BZQlKso2KXdTFxVc0bAY11wgXCP3ZwsZZ7EQ5
    +puJvpVA8AfxskuCfijtOgxsvyst1qI5ffoiYmAlzcK2D7xlA+LWkZFSzqCrm4Ww
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PM5obmlD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PM5obmlD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966765AbeCHFUp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:20:45 -0500
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:48480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966694AbeCHFIG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dedy Lansky <qca_dlansky@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 07/53] wil6210: fix memory access violation
 in wil_memcpy_from/toio_32
Thread-Topic: [PATCH AUTOSEL for 3.18 07/53] wil6210: fix memory access
 violation in wil_memcpy_from/toio_32
Thread-Index: AQHTtprA0vzgRF+f/0KRpBO6/yCyXw==
Date: Thu, 8 Mar 2018 05:03:08 +0000
Message-ID: <20180308050230.8876-7-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:IqkUKGdn8+JLkkvk6jqTIBJl/B6hqjE5PNw7j4xPQUb3SYbhWH5VCLlWTAJblmQWimngAksTtcRp3+IhGLljufPO82rkCvl7m672VxQrJzBGJI8QYzIiOjEbInnvd3uEKP8tObWaq2XilwliU2U7SJdaOmcyDfxJr5VvYb0HPzcMMCVTH3pZQr+b40ql3Fq+Q59dKiKzkNlhL8s1gfpS765/nK510m1WzI8XVFCS1CjG21PXvxueTIeRVz3HDRFV;20:IP/jhIYdJnSoZj1+1laVNhDuH0b4liw4vCx/Bk5OuxFshOOWH+isv7lZNI0Kieuva8RoFDGRCDj2XdKYkbfPeNjspG0Hud8b1f30rsB2sZbFrmWTSbyc0bG6RtS9Vnkj4x2rUdCwmNKb+JZdB45F4GW8AsMQZAzrwtcWubMwItM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a586d835-e397-446f-fa98-08d584b2924b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08719467CD37D3304EC7E7ECFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hdF60KptOnpW6UlDmSfL2ZERfOkQDssab4m8rG+oT/4cjGfpArKe07/Q2X6nl9Fwt2oiHr0Yd+ZSRdgTlGstT38SAAy3ZExtyx1F94b1f3keKL2oSQJR4LxsPnnT9UCW16xk2N6H0b2lSg9xuyYsMBhMmgT6s0W1XBDIRDJGpw1JDIKQNm29mK1DZVrVeDwI7JJ3qjLinCnsbn3cfL0hQTdTPIWmn6K7MfwLGY/bHeeG74D8N0OoTxfKSIXeUzEj1amS4icneJTPiDWHF/4DHCB6OaI1IesjOt787HJVimKAYjdGMX1VVMc5e6PIQj9DH1FXjSkYnzi25d+MqWLpQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a586d835-e397-446f-fa98-08d584b2924b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:08.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index c5676841fd12..e27dd5017218 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -59,9 +59,15 @@ void wil_memcpy_fromio_32(void *dst, const volatile void=
 __iomem *src,
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
@@ -70,8 +76,16 @@ void wil_memcpy_toio_32(volatile void __iomem *dst, cons=
t void *src,
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
 static void wil_disconnect_cid(struct wil6210_priv *wil, int cid)
--=20
2.14.1
