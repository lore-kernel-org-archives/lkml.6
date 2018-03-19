Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482503-2-895709811532127823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482502; b=ADs6fidJVIGOqaT91A+118qW0YEH4xcWYjxktcanYFPqHf7
    xUgKvrDAAyztSNxdIfoZ/uuOnQWj8+7+PEYNhErgfwczn6JpmLqhXg+tXyTMTYGZ
    LF0xxsZeIlU2jDmKSjPci3F6ZOJGDzOdt6YRPpIEru69DsR4sZmqul1xFyHo+vc1
    25x7MKIchVjFYetoeADlTBOFsxwPqDwysJU0jSGm8NJRYx53w4TXbXDtU4q8pTNI
    whFW5OrYGEW0RE1Zoq7HFLEWEWvjdtOVEKpycRoRtTIzV1ehc2xdZa/kj7cMLk5l
    uTbQRLffbzURXGP+UWtOSI9oVWH728pYljSw5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482502; bh=S1xHif
    JsAzK0SMsrA+cox+Mgp0piQOoX105zoUwX3PQ=; b=ElENP7OVzR5pjg5bhdEtaG
    Z0WIPC2dIk25fKh/38Nw4HK4PfbaXJjXYDiB5bS6sGRMP3Q5YOUBTU8kWqIA5Xbe
    uqs6KPEezSN1KwBny+ccOpPGU78LLv1mU/km60c5TbNUxppnC8iHsLhXgTtGxpSs
    bPJqpI9EjF28aNeISQE69DAMAXqZeqyFL/Uc+ga4thMtiDFxhQrxZiPOIKjLkVAx
    fktQlfRbTmdScQsdHPGVukhjLGUPZ0EbWpW49WGnLlKfXSqwkN7ZKJGgZvsYIYS7
    mo7EpYdl8oEYP9oPK2OAdGGaTxTmUS2yeDHbKMafL6LcUQTNtsNOD90Vd9QICuqQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LRKkUcyF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdehgeenucevlhhushhtvghrufhiiigvpeeife;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LRKkUcyF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdehgeenucevlhhushhtvghrufhiiigvpeeife;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968501AbeCSSBf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:01:35 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:27376
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965631AbeCSQEB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 190/281] powerpc/8xx: fix mpc8xx_get_irq()
 return on no irq
Thread-Topic: [PATCH AUTOSEL for 4.9 190/281] powerpc/8xx: fix
 mpc8xx_get_irq() return on no irq
Thread-Index: AQHTv5uP71oc4OyDhUe+C0GPqBVZ0w==
Date: Mon, 19 Mar 2018 16:01:38 +0000
Message-ID: <20180319155742.13731-190-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:AYidZk95lqehUGh4DAjUTVA3cBK0JcgJ6JayvwNrzmd0WV6wXNHMldOD+qdlAuDHHKRkZ/KkGRyurkRgGVjqJiBYLeIHudVI69xrly13G4zvOnTu9Mc6A0v7nhmMR5dYtwT4+gWG+dVyG88/yFC9y7p7wxhSRzBsU7BAGtJkifIza0C2bhWudOqWcXMvxuyRmO68N4QJxT+zcOyO0R923tZD1FbqrNHT8n0ZNKqtaqVHW9mKVYvFshLaOXvGuQfF;20:9dEhMfMQ2ZJRO8AfXoozJEDJURbDsGoe2FV0U6q53s4FT8ep3ltCFOfY1GczRtbev+4lK/nJF5/4yot1B4nUaibpMmiZs3nlPQCn8+hfB1w2m9ljv+xdqe5mG6NTWqMks+PUgoGpC4uUa5+Zf6LE1XASzMPiIRA6MdBQDmdqxn0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ec9d844-de4a-4cf1-e0af-08d58db30296
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10770148AB52BA6A95A97FB4FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(575784001)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PqZS0K9rua+flHVB29ZOTZGl1Ug4mirB7uBfSoaBLS3NFeV7sn8z2DSM9MJWbN5q59ki5HZSygwE3D1mpuAUEWBUHYDkaKZEsCFPMv6F1P0eGmAlo0sJH+jaFzNxuoXaCytaH2LlOqLODx6eECBzthzmvCkbG3fu3128EN+dlu3s8IN2rxcdbKj1O55uDtU74AwpHl9TU764EqtYOCGgGqAAzLE3pYyt2YV2Y0rKkLra+HFcNGLohgCs+dWyvATex8CiNy06lG0fXH+km7bfLzb6d+4o80bY/nN3rN1mO7oiH4FCJ48n8tX898ClunI+QP3zDThJNQihYKpKLaSXBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec9d844-de4a-4cf1-e0af-08d58db30296
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:38.0760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 3c29b6038828c1f4c9ecbfec14d4fc5e25f1c947 ]

IRQ 0 is a valid HW interrupt. So get_irq() shall return 0 when
there is no irq, instead of returning irq_linear_revmap(... ,0)

Fixes: f2a0bd3753dad ("[POWERPC] 8xx: powerpc port of core CPM PIC")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/sysdev/mpc8xx_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_=
pic.c
index 3e828b20c21e..2842f9d63d21 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -79,7 +79,7 @@ unsigned int mpc8xx_get_irq(void)
 	irq =3D in_be32(&siu_reg->sc_sivec) >> 26;
=20
 	if (irq =3D=3D PIC_VEC_SPURRIOUS)
-		irq =3D 0;
+		return 0;
=20
         return irq_linear_revmap(mpc8xx_pic_host, irq);
=20
--=20
2.14.1
