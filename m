Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117235-2-4587343862789551024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117234; b=TpBgJFeljcvqc7KEDLirdOWIPzEcFnwW8Dn3huk0xJnK2Br
    lWWFwE1RM1FmX//hKdhBypWEh+QFQNV8MISRX8+ic3KfuWQ3yJU7csASlsXbrPR8
    LPK8kaJq+12nF7sWF8EhuUGJ3uirP1szGBWF8LZ+GWtJoccHTyf/EaeCJt/6ikpL
    nPfDCCLED0Qm8kjFp7QBHhYHlmXTdT790hzNXWyLYMBPqE8Xyc0su97Wk1UPv0W/
    wrePw6980fP9sFlv+vVwmpUT339/jWVq3lnG0P2NK3qUoXsinuUzbUCIZ17o9y/G
    h0G7PdXQtUQS0gSJEtBW5a0AGjvJd1lxRV/TR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117234; bh=ApryG7
    7PrGvHmmLXvTgjzgebfZmdYCVyxtyJ8tPTHFU=; b=R4ncK8jmaIbEy8X17czk8x
    ZpkEwDhoWVM/tQoofkg9O1Nn9kKSEnaNtzrtaqF/UOu1pR2q51JOkdGSsLTpx6qH
    Rm1fBWCCycLRI1mS30wcN4xndmZ0fjalD6b3a727mJ+8XhPbVmWvpeduN7tPOo9p
    k7/uoBHyBIPM1/D6+3rhZaeXaj9prBmyr1uFBhDN/N1YY3b9HQ47RWj6TASL/2DP
    j+hwpnnyK0coINF6XxXd4ekCkXdKasxs+dEKZ7Kv5/4blu7LFB41XbOfuC1soNLu
    qf6+BD3BDMlXysrNT+zG1QkAIfu7ohF5l9oLpA4LnphiUT8+oUhlmyTl9MTz8DXQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T0IOXo4u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T0IOXo4u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935575AbeCCWl7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:59 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935544AbeCCWlz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dedy Lansky <qca_dlansky@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 46/63] wil6210: fix memory access violation
 in wil_memcpy_from/toio_32
Thread-Topic: [PATCH AUTOSEL for 3.18 46/63] wil6210: fix memory access
 violation in wil_memcpy_from/toio_32
Thread-Index: AQHTsz+sH3XvRF6c0UqTtGn+RMFGeg==
Date: Sat, 3 Mar 2018 22:33:38 +0000
Message-ID: <20180303223228.27323-46-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:ai/HlWVVRrfrqIy/V1j8pL8Ocgpw8UT2OtCNCKDpBdrlbP4wHGLRz3TuvJKyPC5guA9UNCuObGD3GWXmd+hDXEAzWrl1u9CzkUo/0KYTIBraUHKcnQoSVPdApjkc3s3SLMGU5yT2qnkyzTNWFr/aUajGVKLmUHdVgHWIbJLP8kCqeQnDNQCGM0pGb/6QGFQzXfJAfqMYAME7zaKUuW48ab5h44zBMti13pCFoNvJ+lWgFibrIrunonjmwcctcXf7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b37d3581-7e1c-4ee5-1a88-08d58157f63b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018C8C754186F9594089208FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: nsaQas+Vp9O1EhLmFgUzt+Z1xZ5Y1ryww5cdJg737OQbEATC/HGAyNmlGdFyYlXqMiOpakXe+zQdZw38l90zlUeNbz13KpbBSdvDHUsr//6bqCaVM5dhT3Qv37iUUUuUJgjVrKnT4vS9e/geXBUUB4B/JN1b8mNwgt5URwOsNCw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37d3581-7e1c-4ee5-1a88-08d58157f63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:38.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
