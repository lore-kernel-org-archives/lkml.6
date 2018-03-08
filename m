Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490630-2-5501146167252376216
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
    t=1520490629; b=RNbO8pakF7qFKv86q8uUdvvnSxRjh52FNk5QQNgXiT8R6sl
    vurZxh6EG2sXkI/LCrr9C4rEm6zefSNiBdc9Ib1eJiwRllBVMzXzjA9P2DkXVxd5
    FRXSeHT2Pdwmzr+KVMqeDuW7yEv5/ywmn4puOWWfsygax9slnJloHGIUlrnKUE5k
    91n59t4dCraFrpjlov0aJUL9vN7lIg8p5rtd+KjPNLG43zxxjLYwRQ4sXTlBtJE4
    hWW/8i42juGMbIU1y9jHBX0tnLDWL44iwsHDa3WJz9eoV/oNgKrt5KFX+YuIHiER
    IDqywbytwlr3pABiKJmB+wGlGylN2dH2ARGDtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490629; bh=KEy8Ls
    Zc0LfdOfg2mVFc9OdXnFo0N43pB988qPjXfjc=; b=FbK5Bxhmfrmq6rMZhYJ5pp
    qP2sDOMFDbxZQWgAXK4ivo7iZD1j6h+yMmLdTzl6GUUxadxWj3JpcvF6I7oIIwyF
    kCqHidha4X8LDGiyZcMVFANigd1ocLk9/gUWg/+jYDrDPY3GllX6t1UzS/64sz1m
    P4ekKgsF87yE/itVxo2IfVWW0rTkpDSFDsIxJEJrHZc+fNS2dAsES0LuAGi9Amph
    sApKSY8FE/QxiiRyoNl+CgjTv9D/iC9ruK575GTyeT/aeX0cNZb/eimrmpLfdLPL
    C65iCGqkFaU5nTe3lcSmEzGMEvnfhS8ZFpjp3apaM8se8PO6V+ue4nwq9csmDrzQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bl/GOUBX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bl/GOUBX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeCHGaA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:30:00 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751297AbeCHFAN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dedy Lansky <qca_dlansky@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 022/190] wil6210: fix memory access violation
 in wil_memcpy_from/toio_32
Thread-Topic: [PATCH AUTOSEL for 4.9 022/190] wil6210: fix memory access
 violation in wil_memcpy_from/toio_32
Thread-Index: AQHTtporxnobCUkTAEmGFKLZQETjDw==
Date: Thu, 8 Mar 2018 04:58:59 +0000
Message-ID: <20180308045810.8041-22-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:PaObro86rSshYOicV0ZBdgsrPYOx5BOIG1eXxr9vuwSySF33gPWjWaCfAHagkL7Pt23ser2fp8tfFTSzjn3CJBoha2EG5CiBu0qUS5c2N+RSXHtBMA9yTjX8q84gS9tBKH3PHcHqKUXZjQUC1BR1L1hGsfQdHDSULIOeScg+UtHSziu8NjXKj8fNDZ/SYDoeW0FfEyggBwGP+npJ/0v/mYkWO0MZRyYh8bQIRLaJDevDuyBRStXGpAMYwuWjIXaA;20:M7DjOsFqeHWTfeGFPcaajOTozq8RxP2MWgBBOg9guTdjwRGwtWRHWhW8C3UxbiugG9OC6Jpkc1ZkyeJ+Tbg7XvCyHeN1oo6m4i32AvunrIT1tAm7fKvvezkPUYw304uX4+Ughel6RGzXvGYvufXCLcc2Ff6PDalunJ8+E2c7Eg8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 396a7178-485a-456e-e694-08d584b172ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983922515B38C63D5C2404FFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qpRocL0jnvSeH6wU9/l99VTmJ7cAfCgCVLiOVFfGFlb4Jvc/uTonh9wuYIVr7DkSaf0HqH4IMVmEuuHGA99JLkSSgt0w5ciDGFe7b4gTiy7Nftvq946HPC63xQ2twgdfyS2t8ATMQOIHhcyaBevtKpzhfKaXei2MRM4eptO6Cgwv1liBqFO0Jw6QgBVtR6prukkKpz98kmcpLXSPFlbAcBgAPVF2Xpj4NWLqSXR4iUyCOm35pQ2YLNwtdaUP4eY4OXXqf2XHuKLUTTVTObbaorKgofXUm4WyJg8s9Ulnls0lVtaPOdKEAFBtSQEm8pdpSqCRCyE6QdsArlFr4lUa8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396a7178-485a-456e-e694-08d584b172ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:59.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index 24b07a0ce6f7..f8bce58d48cc 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -129,9 +129,15 @@ void wil_memcpy_fromio_32(void *dst, const volatile vo=
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
 void wil_memcpy_fromio_halp_vote(struct wil6210_priv *wil, void *dst,
@@ -148,8 +154,16 @@ void wil_memcpy_toio_32(volatile void __iomem *dst, co=
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
 void wil_memcpy_toio_halp_vote(struct wil6210_priv *wil,
--=20
2.14.1
