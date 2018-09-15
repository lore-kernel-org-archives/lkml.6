Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD2E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ObgTWLg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD2E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbeIOGwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:19 -0400
Received: from mail-cys01nam02on0117.outbound.protection.outlook.com ([104.47.37.117]:43118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729215AbeIOGvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lm0Na7iWMDmyQQkmzs6UnNYlzsLP5EQDJ4PstSIkEg=;
 b=ObgTWLg4sx9J2/KW85E9CRRCWOvrIFvJp8ln/w1+b91We0qz82Qc64KXJgzVl7nkeANJLETfWk1ivq9K0K6FjrkBIh8lrczlfi6B7zkQ/BOh0cEBZBWDj5/vIo4/+/npBe6dNCEBUZNculxepucp+kMXra/c3LJRhfD6O6vi0qA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 26/34] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Topic: [PATCH AUTOSEL 4.9 26/34] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Index: AQHUTJRGboomSWOXfEmLWrCKdYChRw==
Date:   Sat, 15 Sep 2018 01:34:42 +0000
Message-ID: <20180915013422.180023-26-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:wtmMZfLdFFEvdnbvLH5BUtZ/l/kFbHjOS0ucn5RGXjxA7mYaN0BYh/8x/UxvQOveaeKS/rjWT13yJbhRJETX/noCgYOjQVQSbBurz9RoT9IKDdzAnLYJ2QwtturFJ9BVrHeThhziHz3Fcoe9PC3J59ZCCuy/A2mTj1cfRW8caD5h7WYUdildsj3jdYyreqq+viLaHg1+smZNt7DGIZXsCT2zfgMx/uj2uM26n5AlFkQMk26vfvkBGR486nQQ63yauTH5Jw8JYMTEUi+kl+uZHs+Ozf7xrtbgxFWKgA6RvBtvvF+UFCGk6hfFTkyubuZv4O/MHF9JQ1IBG9+FJCaMooNBDukYAM2JbhqttIe5VfyQCFmxR0AL3mw6gxqRSHIylmpbCULvx1PMNB+Sh+9NCXPxhF1FbSHVUuSiQtC1isuqGtm0BmdDPxwCvM7/mtk3aBQE6PsQR34JImvgPxVh3w==;5:ZBnuJX+lo8CSZB8UxqIb14Og1x30O3NbH6FP1hsIhYdV2lr8zV5XVF6Ul8em9Ktz0Rs9DAH9ye5EU9akegHfsqlXqni+VsyZyZmxW9qZh8fikzNxUjgaATzY4IinYzP5DfCFnnGZ35gWmyRYp118nKjLeaEY0H0aoKO6cgffaJc=;7:Q9BjeW+9VhbHiC9cdnGG1t/CoynMj+DrvfBajvoVraVuMAM6IvIF0+K/R0A/sRqJAtJAC75M/WFnX3JtojstNvzKrlVUPi3iijU+tp9g5/j4Vg7k7bpTU8o8NK4FSfH/l/4+ECI0RgarsQ0y4aUQTd97XNMPbMUi8qOIJQLqeDcFdu5A97KceqZGhH6iZ2GOSO5NGfpII6p6JumemDuzmaIj2fhKMkrpdwFZjYn3mthW5eO+BXoPE8/1j1LkmyCZ
x-ms-office365-filtering-correlation-id: 8d5cb4f3-e0c1-462c-fcc8-08d61aab6910
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08234B0CA34A52C1074131A5FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(39060400002)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cVOJGTUv0d6h+L8OPzEGxb3neD/cO3W8E5hYzF14Ut4GGAOTl7jRhEMPXI2r8a5gSSiKII3/6LaWB/0p751qwLEyQkihy0s6RcBesRI1ZevBhN62vymRCsAG8VCqrAHhtxyX+8VIRqx3BvOGxKbH9XyK4JaxiaephsR3CTagqK77r7vOw37BzGLIuwhzvsfX//GzKHlJXm4NuxMsS1lrjLYY7Q9naiNytRLXpyGWuNYCfSnHNUlcfyf1tS51mjla0JYV6ccwtGXDkcnB2tezbOGN1XR+DMyJGHcrB5Q1CeXO/m3uuOJ7e/z9YaOO6XCxis8qf/clk0haog+oyB+loduHStGAeO9qyQYyahtFl+A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5cb4f3-e0c1-462c-fcc8-08d61aab6910
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:42.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 7874b919866ba91bac253fa219d3d4c82bb944df ]

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-bq4802.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index bd170cb3361c..5747a54cbd42 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -164,6 +164,10 @@ static int bq4802_probe(struct platform_device *pdev)
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs =3D devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err =3D -ENOMEM;
+			goto out;
+		}
 		p->read =3D bq4802_read_mem;
 		p->write =3D bq4802_write_mem;
 	} else {
--=20
2.17.1
