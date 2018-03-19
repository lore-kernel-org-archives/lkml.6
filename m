Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480542-2-6724421552910361817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480541; b=N8Z6xdl51cijGzrwUXxSISzdFKpFDLjKyB0iYFHIlC2wmob
    smeb1xLnIJTnvO8kIOHlOSfOkNqra6Osm1VVr+PewYe5v8WAe6rdHcTwc7HQapFb
    HiXrvBmwehus85BYMmdI7oFsBIdoysv89EjEMB979CKa6UEBCQ0LDvezWsaycEP9
    Ns+4WDiSSD3avwy+F5m46RQzKukviGCgTA0ItlSyqbV06unHb/rfj47wv7gjKGsI
    B5idhYRwEKOIz0marktFGxSwBsSMHZ18fZ0PINaMKVe9cz6He2UsFG8foNorWIi2
    8sLBNUFffytoTQlta2qlNJ9oMa3G5Z0DHhSYwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480541; bh=cJPTv0
    USxHctaF5nMvIsuq0Z4lX8Av2z9p65lVsp/yQ=; b=D1pR2ce3YayeK3pPB1GdVU
    A3miXeUTvcJ1hV5cLX/aLw4HCIskRsnfhK7/i7+hlmDCHnKvAof6SKyBxzY0AIJN
    n7PsXUHYFUJIsz12NuG0D1mrhaspL+ptX4yXghHDPCrOSH4YReZKyoarSSESiX+f
    EL8Qr1pgvFoJAGmuJOq5mO8FkJMqljBhblccNtTjDmNW+YWjaifnfZ7DIWoc3uP8
    wXNDEYjmb3l3oALbcbN/0u0j3XXjaHyvRIqzDVxofG7vHhnvRfVqDc44nSxZLdns
    E6gwqZ7VA2NyeoMcq8/EMz9AlL2FycgeINNP7vZUO4ugim0oNEWgrXYGb61GIVbQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eGX4hcKq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudefheenucevlhhushhtvghrufhiiigvpeeiud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eGX4hcKq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudefheenucevlhhushhtvghrufhiiigvpeeiud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeCSR25 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:28:57 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:27616
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966182AbeCSQHj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 039/167] usb: dwc3: keystone: check return
 value
Thread-Topic: [PATCH AUTOSEL for 4.4 039/167] usb: dwc3: keystone: check
 return value
Thread-Index: AQHTv5wycaWNzuzjNUikBCh91pmPAw==
Date: Mon, 19 Mar 2018 16:06:10 +0000
Message-ID: <20180319160513.16384-39-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:gczdGY9L+tXm0d5JFEUT8nYG+BW8v+qEsjmFtrvd0psAHA/KmtMj5tZ6Ka8Us7MGPx3luDhYcCllH7QFgyPmkFjbqoI8ezxszOHkhL29mc+2VM7I3opVJtbdMwB6UGVbLaYLOqlMB9AWcZmeA317hacvJoK2dTtxArjlBFQ/nVldlpVIxxrz9meYP1SSwJLMMt4JCyObsMSiX8mFefRxUuh3ICiMZUO2KUzkeyxKSYBxjplBnoE/rptFwjZn8LRK;20:0TxgKSmDk3p15TekzXuOKEA26FvjRIX1RmwULY9j4rMU0ek+TKjJNBe/AvfyXlcTKWW10/R9hO43+J8bSzvD55xSKH2omp03YQOcn+qj+uHJ+Tr7F9/HUzecQZEsRzOcUUtPBDgJ7YifbhlxuyNP0Zhis4S6e8/PEmlK1EaoczE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e80191df-6b12-4194-7371-08d58db38937
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08054B9245CE26DBD93E0A34FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1UDwp1Yt7XY1q5mPIaQPcaYhykcmzwIjOtXE8j7c5zlXklMvtix3Bk3w/lusHrWuPA8eI2QnsnCoHi/eLKj9vCACvlj3tDZgIQauai8SGj4d0lLy2R0glA7hpBwJ5MFsZ2uia3L5Ov6jpnSH+kSpWzfKvW2ZRsx6kwHKQqYGtQ2J9w1zVSXhGC46OlXPQiDHR29UkOj8EHYTd/ZUdFDrvzTYLweAFvDTDtSL4PR5E8+TCEzHlAeg6zNVZolfnWbOr6wDX4j3+z2Af4VYXC64urqYdutgZqE+IJJ+4QmDCNKkfi/5DQuPXtZ4nuKFExTuo7Y429sZtZsaVUNAiTLaRQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80191df-6b12-4194-7371-08d58db38937
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:10.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 018047a1dba7636e1f7fdae2cc290a528991d648 ]

Function devm_clk_get() returns an ERR_PTR when it fails. However, in
function kdwc3_probe(), its return value is not checked, which may
result in a bad memory access bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keyst=
one.c
index 2be268d2423d..03a926ebf34b 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -112,6 +112,10 @@ static int kdwc3_probe(struct platform_device *pdev)
 	dev->dma_mask =3D &kdwc3_dma_mask;
=20
 	kdwc->clk =3D devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get usb clock\n");
+		return PTR_ERR(kdwc->clk);
+	}
=20
 	error =3D clk_prepare_enable(kdwc->clk);
 	if (error < 0) {
--=20
2.14.1
