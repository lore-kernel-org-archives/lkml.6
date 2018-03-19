Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481469-2-16569190660096756640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481469; b=TT28KtmFEdf+CqqPNyrfkAM/Vyzqi0S9G3FaCu5ak+I54vr
    s2wCMZ86inZQH/LpTnI1QF9WaMe6QeHKzJ7Pzc/LujXEnXTzoh3VAg2tM0ex0Xmd
    Bfb4cUoqejKP0q43A3sR7ekUYH3bC0gyziH3ysxCVqKkboFXU4KTJQX2E+jx8Bd6
    PldulEtRaMZ4fuGfxStrnSMYeMYN9NjybAdtOuXfylsrNe9mFaHyMb7wIdv6XyJk
    6xQnmuhatL5yiAoAyJy6SlWQGzvX0RiS4dTMr8AFD+MdDQLmCs5I2OGl1QGl3rD7
    q04ig+hRjjJLvJ7FbSQ/Ex7Tq1s0VYyxu5cT6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481469; bh=gbrNu8
    BJ2WnjiHLPs4MR9I5qLx/3p+F2HReKgbTQqe0=; b=PqiQK0d1qVjHNDpfxH0Ty4
    kbo5pDFSrMh3mkduo+g4HiawZCjD38rX/1xfyNGFpLxnpPXcfPtQrW7BVc5w/Xeh
    Wncsrzac8oJAkWuyYAMYXfbLlksjG7lyGAHWTgzv+DHiywTZf6OKv/BlvrTkFJur
    TGqxZ3VcmrrPY/8thEKmK05rjCfzm0IUSFujjFVWc243Jm9q3PKlZ1NF9wxrX5/r
    H2sfxJ1xjo/Q4yEbb5iLnsbOrncBn+S56F+9+VVqsjSHmo9VA5mcTsxK3k9roSaQ
    nKqkb320X6mHoQ8zdymzJuoPdDkAqL7oMGqBzXPQt+5N+lZmeMjLPcZBMxu9ZjMA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n51AJLVB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvleenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n51AJLVB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvleenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965924AbeCSRnm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:43:42 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2671
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965826AbeCSQFn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 249/281] net: ena: add missing unmap bars on
 device removal
Thread-Topic: [PATCH AUTOSEL for 4.9 249/281] net: ena: add missing unmap bars
 on device removal
Thread-Index: AQHTv5u6Ab7Tj7hDAEK/0XRPK4o3aA==
Date: Mon, 19 Mar 2018 16:02:49 +0000
Message-ID: <20180319155742.13731-249-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:NRfaygMIGnJpe9bCYgzu98u7B69mvIwIzMDCKHIuw1Kod/WtKWvVeE6XWKMvl4NimZ5G8EYdQEua7jjgrZ7WoYajT+bi24IvxqNMAn44GAtExMXrL+o9SHe/XlEE6Lny23Sxz0eecTiqE2E2oHQ9w3doOICYjImqn5jBHevvSDKQ/MY2twQGRnIHxocqE029ZeJlD6iBYJiTCMYWCt6pEZMse8kp0IqsfTPBxdGp0pB3XCTUa0i1+lpkBNy0FyqN;20:2DE4Od7VoySISucgEH+4ECLxhNi7lEy/dl09GLbNz4EhOilXzynXxO4NO5ah7nN2CNYJuRttv1mtM0oqaHC4Iai2AQWa34YplyVAw4NJAP56u3CMxDOOIhWk5xGxMoCLDEusL0f62NA4c7VHF2gzQKPmI7z5MpKRB5CTHcJ3OsE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2316d22-53ed-4814-aa7c-08d58db33d6c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07272F0312F9C4F3F9F18B28FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hL+AyDz4YNwwYATm6UDIHuVrgA6Ok1IqoskYqGTik2+GZEceYVm38FvAgX7R5rf931Pg7oO+FkR7wgqL8srruiJMla21fX/GtCyxi/Kvl0vNU6xLX22NdXFkkWk16WGkaWRaLaayk9j+7N2cdQzrInzixlUIweRgk0nBv7pLsYh5WId+Mc4kC0w8pilZF/K7hQQ33GT3gB9uKvAq4rl0rafeor1Jhn0cY7J5zvwvWEY3N+LgeoEpalwt3yMcPdKAidyIrmcf1y19s9791XtXkFrM7qu7FW4+L6qrzcW5I7KXff0EkDz3o7OIDKrxpQuGXM0DiOUgX82y08/xOYt9Vg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2316d22-53ed-4814-aa7c-08d58db33d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:49.1961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 0857d92f71b6cb75281fde913554b2d5436c394b ]

This patch also change the mapping functions to devm_ functions

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index fe691017d5aa..0d9ce08ee3a9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2808,6 +2808,11 @@ static void ena_release_bars(struct ena_com_dev *ena=
_dev, struct pci_dev *pdev)
 {
 	int release_bars;
=20
+	if (ena_dev->mem_bar)
+		devm_iounmap(&pdev->dev, ena_dev->mem_bar);
+
+	devm_iounmap(&pdev->dev, ena_dev->reg_bar);
+
 	release_bars =3D pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 	pci_release_selected_regions(pdev, release_bars);
 }
@@ -2895,8 +2900,9 @@ static int ena_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 		goto err_free_ena_dev;
 	}
=20
-	ena_dev->reg_bar =3D ioremap(pci_resource_start(pdev, ENA_REG_BAR),
-				   pci_resource_len(pdev, ENA_REG_BAR));
+	ena_dev->reg_bar =3D devm_ioremap(&pdev->dev,
+					pci_resource_start(pdev, ENA_REG_BAR),
+					pci_resource_len(pdev, ENA_REG_BAR));
 	if (!ena_dev->reg_bar) {
 		dev_err(&pdev->dev, "failed to remap regs bar\n");
 		rc =3D -EFAULT;
@@ -2916,8 +2922,9 @@ static int ena_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 	ena_set_push_mode(pdev, ena_dev, &get_feat_ctx);
=20
 	if (ena_dev->tx_mem_queue_type =3D=3D ENA_ADMIN_PLACEMENT_POLICY_DEV) {
-		ena_dev->mem_bar =3D ioremap_wc(pci_resource_start(pdev, ENA_MEM_BAR),
-					      pci_resource_len(pdev, ENA_MEM_BAR));
+		ena_dev->mem_bar =3D devm_ioremap_wc(&pdev->dev,
+						   pci_resource_start(pdev, ENA_MEM_BAR),
+						   pci_resource_len(pdev, ENA_MEM_BAR));
 		if (!ena_dev->mem_bar) {
 			rc =3D -EFAULT;
 			goto err_device_destroy;
--=20
2.14.1
