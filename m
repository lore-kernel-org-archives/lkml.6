Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76B120869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vj7d3K+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76B120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeKEStY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:49:24 -0500
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:44208
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeKEStX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO2kAsv+E3H8qIgK4CZPHMcrDUZGXZctTvm3oB8ZG04=;
 b=vj7d3K+GF6+TYHrEzBYicxLWDHDA8DT9w9ZKcdHNxMqN/ncIoEpNWmbQDqh8F6o1pU1WFwJ0HXgNf3CllIs3QvHblLPAHz1jYPtACITneNwciLB2Bk279rcIc9AKoaVYkNd1nyBAqUEoVbtxwTOWKEZihBh0iQzq2OjsZjtjK1s=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3421.eurprd04.prod.outlook.com (52.134.3.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 09:30:32 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 09:30:32 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Topic: [PATCH 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Index: AQHUdOoyw508LA/2JU+iwo1j5rjn1Q==
Date:   Mon, 5 Nov 2018 09:30:32 +0000
Message-ID: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0167.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::15) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3421;6:rmfsiS7JBotYXOHVruufF5Gx/mIwnwqorqw2pSAItN1wVAz2EmZNzaZZ4gFuWmpK39voqppteY3nqGIwDe/F0sY2mbxxBw1/PxI/qoDyvjbd8NahDRVsIgigsEUiaqOOYhlkgpXOGNIWHlcU4E34tGEVW7Wb4ioW+e0DwYFGOVTaIe7jkEjgIUJ6n7AJUVcz3nTmXuBmpuo4199IllKqbcfKr02JN+NxWbKlfcX3DZ4UdqfUYuI/I8VgONkeXFehTHgKcpC1wBwprNTBT239Qu/djm74LvsrspEWr8mAUWdZSiqGMAleqGqRWx9/8TmytBmhBamG8iqB1/tjBt5CDF9n/fbFufWxsqSf9q0G301LdVJIkFX2KOMh7QnrqT1CEc9+nqtb3AlUu58GZr0MN7iwjyzrCWXfhQAqK8XUTDak06yXV6apq2ZROU14c8sy4csvwFEictf2LHnOVd2Wsw==;5:FubljVh9fAVpzAmBIcmtx8YUhcNV9Zcp7H1dN7fyqYIRu+lLbtSdVpFyS0z938uVYvgs8Nf1WW9mJGIin8HI6uY3txp99hqQFnuelpyjSZSS6cHE1Igp6iKesr6NGCRaKg82cSRwgd4G4vhU7zmtU/1D+n99L2fQXlToprDWa0U=;7:J8SeJmrZ9qcaS3mIjA32BT5hSgqMMGqA+HF+Uxn9zj9FBzXIJFTUVRmUyHOTQKjHaEjQGK81o4ij/DWTkd3P4AhHU/xNgSQpZRo0VjnRMr9sh42+Ffd8ibdEVQTExDqkSSxYwK5QOnuRYSWV/o0+Vg==
x-ms-office365-filtering-correlation-id: b8c6b194-1305-4a03-8439-08d6430154f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3421;
x-ms-traffictypediagnostic: VI1PR0402MB3421:
x-microsoft-antispam-prvs: <VI1PR0402MB3421D5899B7D45734846D864E0CA0@VI1PR0402MB3421.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3421;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3421;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(66066001)(106356001)(25786009)(97736004)(256004)(14454004)(2501003)(105586002)(68736007)(6512007)(53936002)(2900100001)(2906002)(3846002)(6116002)(6506007)(386003)(52116002)(99286004)(36756003)(7736002)(305945005)(6486002)(316002)(6436002)(110136005)(54906003)(186003)(4326008)(102836004)(86362001)(71190400001)(71200400001)(81166006)(81156014)(486006)(8676002)(2201001)(478600001)(5660300001)(476003)(2616005)(8936002)(44832011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3421;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wNZBpUAUXjFCtwH97kp/sqmqQcTbgI4gqkoni56Nbgyn5jPvHZZ7mjCuDcir+3iCGFcp6FTMauF3S+Kmlw3Dq24dB3jpQxsDZqf/iPci2mx8YOSmyLSyIFRcEOcF6zoMjgPjI6dSXkVnwClAHK5D6IzD81Zswc9/F5v/ha0Vm4QYFyZTrDm8pPz9C2Q6LmtGXrfTRb7p9hh0ikJv0+zIFZS4coUP0p6wiHSnPl+ToKj2TvcEfv/rHAZFrwaG5QHt3ToeSz8SPKOsbQR1h8iKC1fxcyFBXd3XZgSN8RsRpA9CsxgQVt/G8vEGStzT1Bh9kzwcjMV8lOP9NL4LDtSngJQMHDMui5CiAVw989ZvXPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c6b194-1305-4a03-8439-08d6430154f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 09:30:32.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the remove path in the dpio driver so that
successive bind/unbind commands behave properly.

Ioana Ciornei (2):
  soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
  soc: fsl: dpio: use a cpumask to identify which cpus are unused

 drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c | 11 +++++++++++
 include/soc/fsl/dpaa2-io.h          |  2 ++
 3 files changed, 29 insertions(+), 9 deletions(-)

--=20
1.9.1

