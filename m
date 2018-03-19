Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494757-2-9295365210445051608
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
    t=1521494756; b=QDS2LES/xpknKHm7BT8o+5cSVteOBi94rFYkmVAgmVNh1W6
    uxgf43MJIOa0stqhPFwHIBQTUQBhCONwtDAY5GYK0v7t6cp3DkKTssk2uLoY4QOk
    wsBji6f54XWjjkvAlOZ32CUmCz56N5931Zjza2QRXoI0MpinlKYg60TxF/z1/xK1
    39pS6Ktd2OppzAcukxZ9EoA3/SMV9xOcBUEpSuHCxaDU0+4F/qinRKhT+huGEShL
    tJol2Ti6eWUux+w4UWvTYFQbkdsyCEGwNGQ4qjpH94cM+zqICXLOpCiIK24gu/Jj
    BbDc3ETA0HstXYrSZYw1p5aF3aFpiITquq3vBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494756; bh=WJ0eFe
    NEkBFqLQMQTr4B7uKbCwYcsmYV1c1BNr8ZGtY=; b=EyO7W3LiU/BM78qN90ZY75
    rY6tBCBl0fbg2zhgUkBmYTeZN6E4Wyr8/9wAO4qWmxA286RkYq2BXOfmW8towZSD
    JgfhqreU9lD0+zE2TPULI+X8iHIX/vuapJ6OKR/sn1w4hexw3wPpclHXWWp1q8zY
    QFSyumCHu5t2o6IUTp9ZNSGervKnAj2+15fVAR+zRaJ8R8+WcuaLuf4iTdhmWhDF
    XyRBwnVhMKYxbE4KhjVqWQchT9KIb2Q6bjDBaCx0ls3cIDGCEpqpTrpHYyau3cJ6
    wIAmiLlXNepf+zFx9K/sTlyRHMMvKf+toYET/lLsre8EuMRZzhihPoryuMu76s6g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AbcDBnq6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedugeenucevlhhushhtvghrufhiiigvpeeitd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AbcDBnq6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedugeenucevlhhushhtvghrufhiiigvpeeitd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969702AbeCSVZv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:25:51 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:54448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934782AbeCSQAV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 076/281] sh_eth: Use platform device for
 printing before register_netdev()
Thread-Topic: [PATCH AUTOSEL for 4.9 076/281] sh_eth: Use platform device for
 printing before register_netdev()
Thread-Index: AQHTv5s83aM1EWczck+KhYlXK6kncw==
Date: Mon, 19 Mar 2018 15:59:18 +0000
Message-ID: <20180319155742.13731-76-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:X8VUPUuNTan3bqjrZAMI2071jRwpdDD/luLoPPNufizgpdzkjLpO+Z95xKQLGXP9ohk4K5Wp0aOmbl7F+GxjAlkGiejpcaRfWcMixWNQuQHAR4lprurvcUQd79Z2bPzikLLbE8tPfFTKPiQlq2LfUjtou6YQPqOMErYpXJPc/PsS4lW//riDdpt3ebsAWdCeSM8glexneZVZr1E+aoyqb1oDU+1Ta+vR5LLc2InX9opm2CxfiMTHwWHI5Uj4CAKP;20:pFiBTo05+gwBrsLB299jbPWN9ff3YyziZm+KjJdmwDB03SQ/3K2UP161GGbPZ5cACdpNyKrGVUC3j4DJXcZ1nNYDU5j8kkr17auPh+mxOAH4IRpQVskRgsEUSGchO0dblyWchUOmnaJJknoNRmaIU0gLYeHvPZJRmh6phYhm0OE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0d37013-4a91-4281-869f-08d58db27956
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08694D48E185DA942A775DCEFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +B6KQo1VaKKS+TZzYrxQDqCmZ8dBlKsX0hoRcaCzGBCDn7HPTYRlpn4rlzoAG6Qzt5RgKGNGAidT2is65z9vrg2t4OUlj5gPg6UqSlv+2fjIWGqo/5HaHUlFO3cMNkW9tKhqW1S01NmOYeeha11kzKcD8liKlYlpXUVOXzQwD7cGYhuOER4arp5ydtMjF+f+SqS/+MccuZwTTGwyQ4fleqEOg+2qDvVxN9ONMbKs3cUEjnqUYQAMYcepKiVLH6htidfT6THbY/AiDzdYrQQ0fF+wDzCaeFvnafSL8UzS76i8y8gcJ33fNi9RxSc7duQcIrgopv+pjypY2tbIYElc4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d37013-4a91-4281-869f-08d58db27956
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:18.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5f5c5449acad0cd3322e53e1ac68c044483b0aa5 ]

The MDIO initialization failure message is printed using the network
device, before it has been registered, leading to:

     (null): failed to initialise MDIO

Use the platform device instead to fix this:

    sh-eth ee700000.ethernet: failed to initialise MDIO

Fixes: daacf03f0bbfefee ("sh_eth: Register MDIO bus before registering the =
network device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/r=
enesas/sh_eth.c
index b6816ae00b7a..c8fd99b3ca29 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3133,7 +3133,7 @@ static int sh_eth_drv_probe(struct platform_device *p=
dev)
 	/* MDIO bus init */
 	ret =3D sh_mdio_init(mdp, pd);
 	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		dev_err(&pdev->dev, "failed to initialise MDIO\n");
 		goto out_release;
 	}
=20
--=20
2.14.1
