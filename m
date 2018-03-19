Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481450-2-17883370121285787936
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
    t=1521481450; b=TFPNbTHF2KvJe67Jl4FaJnNlREWBWWBMrDUu+V9FsDR/OaD
    Mgb3rW/NbQ50XgI0eFRYDKSQsQyuUh+DIsdUEu04GO+SX1N0yIs6/tqNDzpwJVl/
    hWQi/3g4K0yiEIQnAJqOFrCfJd94R+r7oLq1+VryFJXdm2Uum8khZ+qp5DM/RRsA
    mRn+Xb4d7O0EWuqyRHMS+Hs7kwQNWM3se4KyiNC8J+63qiwlKQgIMsiY4QFZP86h
    IdBNNbKpB1dZ5e+gvI0FQJb5J7FgH6kk5Wjhbuqag9FfmqEj2OAM9yy2uXvdRJbY
    YX0g9AO4Ju9EptnsyjePSnBOnQma8531Mb7GPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481450; bh=bR7PiG
    A7nkCYZy9xu3EqFgxedtmucCBWqp7zufgxG1k=; b=wnzj/z+urUem+Ldz0KGrdX
    xzPDwt02y8lh7BoA6JYeNe8FTSXzN5lanoU2m+xYAIpfQh6hqznkIKGHFi46fNsp
    D5IbE+Vs3Krq+TlLo630ToG/CsAxYq7qMl6RFaQbMSle/Ub/GXzubNwDoeCpNq9A
    kUTO0hKykFO6TGEgChk8eNkgXka0NDReE4ddgPFAIi6Xj8qRI8MgCmHbqFYr9lyk
    t6IkirGYjG/2RgzsSBqiFOEmNXqtAJsm6RpaYSZdjyTmc+Od3NVnPd/CYeUrm1N1
    c6qnmMJP53FWE1SXfEFQblqjAcPFDRZqVZsXWh2EogffLwcAqXQX62XdVVShv43A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gu9y4gGZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefgeenucevlhhushhtvghrufhiiigvpeejhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gu9y4gGZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefgeenucevlhhushhtvghrufhiiigvpeejhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967426AbeCSRnr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:43:47 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:47286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965821AbeCSQFm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 248/281] net: ena: add missing return when
 ena_com_get_io_handlers() fails
Thread-Topic: [PATCH AUTOSEL for 4.9 248/281] net: ena: add missing return
 when ena_com_get_io_handlers() fails
Thread-Index: AQHTv5u5GfvDY5Ss0UqUl0Xri5dm1A==
Date: Mon, 19 Mar 2018 16:02:48 +0000
Message-ID: <20180319155742.13731-248-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:jE06EVbfNnVgh7yJxX1pVCiIqOjK/BlENsJOgCmQG7asMX//FSOgBA53WXzYbsLLwOXjx9BJ3IUT9e6pcv2P70xifnuBi4YWWkkxis3T6d23yy69PB57ozCfIxmu6ZaO9mK+I/XM+tKspsGvBCo4YZmbCLgKOEurIiKzNlwOmMjf1kD3RhKC7nTMCMeNWQR0z4Ti02DYQJbq7VAa9So/3TjOWH9T69R/SwF+w0F3+St7OW56oyd9R+jBjx/IQXCg;20:utpUrdeGsLCVsEGM80FnABZVCXgb3fTp836jXmOnb48rRQf1Vn+ITyn4nvBRlKSsAmidJyRDrcFZhSLgcK23d+g2/bGw4x5qCeMjNNncir50elPUT+3/tx6+/KgS5D/HNUrWNQRw2zOQkyGo3r0o/a+ihTAWpINXWYP8FbdmjFg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fac6588-09e3-4020-8715-08d58db33d04
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07278FE5E630140D1D26169FFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: we0md/NS2sB2HpN5/em6BP/1wrIKkLpR5HiZHzDDlttYBGeXVleCv1yNp77eE9Oj5DcHk1DEJZ2HSACDTHWecdvxmStE6K4dnoQOy5bSXuYltrx5wzFgYNDPuXiIG7I+uxQCplB4pDD9dtzyd9JnJHfPpMql5eZOAns7FsjUZF60W5qk3VgV0hX45zGmFjz1bAQzrVUfPhfHG66mCJcNm9SUPhw8d4d6P7gmNZTlSm8zUGZiF2nrALfoIKVaoWcnj9heutBsJ224+hbbHbhVQf6qYj0t3byZRBZOdSH0jcZynlAsEP/r8uBYRxkWnd5ZOSEuDL2jszFchEG6RDlKNA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fac6588-09e3-4020-8715-08d58db33d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:48.0523
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

[ Upstream commit 2d2c600a917127f16f179d5a88fc44ba3ed263ed ]

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index bfeaec5bd7b9..fe691017d5aa 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1542,6 +1542,7 @@ static int ena_create_io_tx_queue(struct ena_adapter =
*adapter, int qid)
 			  "Failed to get TX queue handlers. TX queue num %d rc: %d\n",
 			  qid, rc);
 		ena_com_destroy_io_queue(ena_dev, ena_qid);
+		return rc;
 	}
=20
 	ena_com_update_numa_node(tx_ring->ena_com_io_cq, ctx.numa_node);
@@ -1606,6 +1607,7 @@ static int ena_create_io_rx_queue(struct ena_adapter =
*adapter, int qid)
 			  "Failed to get RX queue handlers. RX queue num %d rc: %d\n",
 			  qid, rc);
 		ena_com_destroy_io_queue(ena_dev, ena_qid);
+		return rc;
 	}
=20
 	ena_com_update_numa_node(rx_ring->ena_com_io_cq, ctx.numa_node);
--=20
2.14.1
