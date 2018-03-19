Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496565-2-10639320841621324640
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
    t=1521496565; b=Q74QqzlDCBPw0CsNLe2lcWWL89Vnra33BUPMPCp3M1K1szj
    589HzpT1zwKswOIXTIbZLMQhaLQgzB9EPYJ0F+0nXPWlIVWIcZWrcRFJ63lMsJ/P
    EBdDdLeZ44leeYPQWyR+rHflIOP8zcFWpwGAd8K35xYB0lIeBUM5E3+av9Oi09FC
    gMyF4m/Qw25cVoEHW7fqY7/MPHXxvVtLFVeOtHGu5P0ZsmNttkDgIsyvkViQyV7s
    eEsNOOZznty+AangueynRyOqz6KY8GR4Z6vOkduquK00qi2r13IPjP90epto6R1C
    cmDcZOYE5FJpeAXD4sYqDSbIAouE++pa2x+Psog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496565; bh=uFP5jw
    pJMFPkVjcfPTEsdEawu7yQO3/yp5oBs7tBRJ8=; b=H4leAuj8W9UPaMfrjvc29p
    NyWYHJBj9UQ3kVsuZp9kPMtk1pur+ZN/waq3WiGdYRLzRnvmTZ+fpA1v0cSge8GT
    4OwVO+o0Kfq24/y0VFooRKvcTybqbTMvIui8vT9dHl/OdbM1QyByYLs43d3E7NUv
    ZicHH5gaagrplOa796VGB1A5zFvZv4UPqViiGK2Nxp2uzxhrsyO6r0stmmpbSZYE
    qnJqkdOYTv1/YUFD9gz7GzeqsTISHAzOTWwpWo0yS2G4Va6ivDdyGOjCa2RmDzqA
    5SxxMQ/VBu1RsG+xcy6Tq4tutFAWaC0RRF83VLiyuvte21rSP5pcq4zRKfiztoVA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zu0VgxLz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedvudenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zu0VgxLz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedvudenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934292AbeCSP45 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:57 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934606AbeCSP4p (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 82/97] gpio: thunderx: fix error return code
 in thunderx_gpio_probe()
Thread-Topic: [PATCH AUTOSEL for 4.14 82/97] gpio: thunderx: fix error return
 code in thunderx_gpio_probe()
Thread-Index: AQHTv5rRRg4bAzUG3UCejdXBg5IYwA==
Date: Mon, 19 Mar 2018 15:56:19 +0000
Message-ID: <20180319155411.12348-82-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:b22844EFjdCamwqat00W6IyWk48AWKzxSHFcij3RJbkVBVGXYpkx9NrJngPjySnI1Gtj3LmbtZirXiVbvU4k97LbMHwgI28akYz09aeoi3P7vZt2W+NmJGmyvLqFoNnN2jNXyBL4tc2s5l09IB1y59MPH7sD4NTa1/762iLxaXV1mRoANAbhsJLRVVJh7AeeMDXyl0/UAbnCAxxyBkxRo9PEKtxEVZtPguSvxNRsfgMK8QLqR+SqjyQzAsv2JsdU;20:xukKPhwejHjKsEMPPBFBxx9mMSzLeUpMT11m37Ywk3pzaBHuvZj53v13kyc7y5BmTvkHk7mf1M6yZnmXEW3w3w7vDJ40YSV76sxW25ocvE3GphLyU47I5j0Ch9NTB9OlCmDbqKFfjRd+4Re6EYSYvg8MQcswH0z+OPDhcwXyPmg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 233f8f1f-a580-4bd7-1c1f-08d58db201bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064A465A957E0DBC4FF5F31FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: i3tFsjKuDTRJ7G4ypod4wTOAFMSesgZv8PsQMPPSayRaHkWTK9lux3exIgbt72m3O6cRXvc5XD9YW+dYmXJsQ20kWHJU/xnUoj19YBk2Dr7PlCU6D2BxtkKywgi3Y4slzsPAUSfCE5euINFVZpre5UXn7iThVwDdqXD2yLmgBOAbRht9wBXrVuX0oRNMLZgtdGt8pkUS5EJnHuAmfYT3j1dmD4YuymLcU/zcmts4j7S3o7guLjhsAvIOBDzXCLV6iy6MkSDokEx5EQVq5/Ea2wnJ08d1uoiWaDLA3P/MH0OwKmX11B9HrEwi+gcDWbyzQB+QT/cit2zS47jENQJBeA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f8f1f-a580-4bd7-1c1f-08d58db201bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:19.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 76e28f5ffed82b1e81a86c4eb8d0420515765620 ]

Fix to return error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 5a2a30024d8c ("gpio: Add gpio driver support for ThunderX and OCTEON=
-TX")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-thunderx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 57efb251f9c4..10523ce00c38 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -566,8 +566,10 @@ static int thunderx_gpio_probe(struct pci_dev *pdev,
 	txgpio->irqd =3D irq_domain_create_hierarchy(irq_get_irq_data(txgpio->msi=
x_entries[0].vector)->domain,
 						   0, 0, of_node_to_fwnode(dev->of_node),
 						   &thunderx_gpio_irqd_ops, txgpio);
-	if (!txgpio->irqd)
+	if (!txgpio->irqd) {
+		err =3D -ENOMEM;
 		goto out;
+	}
=20
 	/* Push on irq_data and the domain for each line. */
 	for (i =3D 0; i < ngpio; i++) {
--=20
2.14.1
