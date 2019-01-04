Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E786218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pRZ47rVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfADQ1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:27:10 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:14624
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfADQ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qqs5SEhvES9DpGaUQDQSK3/8k2PDHsp5AsNHj48q/cE=;
 b=pRZ47rVt70eKHrUGSY/ELb61/pNa+QMQCaN5Tqjm1g8RrcIVE1DmPZ3mkqftZfsCYBWKZx8CZ15uGXK57bgecpDOhRlGO/EZOIck6e/SN49PFnw0W/lpxZ6zQAG9zHmK/3gS5z0YgehVChIy9xpid7f3fewMTPFqzoo7loxJQ2E=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3759.eurprd04.prod.outlook.com (52.134.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 16:27:03 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 16:27:03 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Cosmin Samoila <cosmin.samoila@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Subject: [PATCH 0/2]  Add support for AK4497 codec
Thread-Topic: [PATCH 0/2]  Add support for AK4497 codec
Thread-Index: AQHUpEpTwJLCevZ2LESBKgU4ogXMqg==
Date:   Fri, 4 Jan 2019 16:27:03 +0000
Message-ID: <20190104162649.13103-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3759;6:R5kXXA9ziO6Jyt+Fbj+F0QZB0r9cHVDGx3wFwv4x+wujIR6aZYIsL0Zu8QvBpizPsHYYDy/otgr6VIopBhwZWO9ue5v59z/4sdGG2njuOIJFL68Kyr+qWQ2hGOsosXGn8AmrDTRrJBI4fMtHqFaYeylZ0LkOcB5JJiL/BtsyDfMh0mqGP7im/9sjfO2/J45Sez9epVXRVNju5xRxmNqUF3KytZRwwjXTvJYTwf1/aMLFqSjYBC7KBnBYXIhSe6Oqg8ttpp1ZVWqjvaUVMaAJWk7w22aT6mIvWRs5W0cBlD1HNghjmGH6I8oGchvQrubpIWW6Uq3yidL5Vbu/VkIzuHDCYPO4HA4FcRbbxy5rVfTTpD455iPRZI8xuk7d2EMS+gcTYVpHn8JphfjuO+6D3eYLUsDa7wYUXiyd9uyctE8yH/FllDeZfGrXM4/cDh9KabX1mJQwg7bqNQKIVPk4jg==;5:fwdnLz2dLCXc8mscYYgJZHASYpjeIpSKfBNWMb0YhMnqzwmDmndelIvNPjKWb8uYA7mDp022xnCCqszkr9iWYGJbRZtROo7qbeM9scUPlBy2ZzdBTH+V89Eg2crcn/q9UBDC8uJiTD1WeSOFL7PLHIKK6zqfNYO1epPn5rtFORw=;7:mqTYzP0VRz4OnZ9NieOMHFNjo9ZsipxG19NFK6n/FF9b0T//ZJ6xne9CXqsacqDk5zndBtp4EIgHYAYkzBnAUiIycRHLKqyQ9NVI6aZPQwDLf+JHNiQ3N5w+v0CepTfdzuSXKZWDDx7eqfZN7DB9qA==
x-ms-office365-filtering-correlation-id: c29b5b8a-1dde-48a5-a756-08d67261756f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3759;
x-ms-traffictypediagnostic: VI1PR0402MB3759:
x-microsoft-antispam-prvs: <VI1PR0402MB3759AFE68AAEC28C89F22C6EF98E0@VI1PR0402MB3759.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3759;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3759;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(8676002)(4326008)(54906003)(316002)(44832011)(305945005)(8936002)(99286004)(81156014)(2906002)(486006)(81166006)(53936002)(1076003)(25786009)(110136005)(105586002)(2501003)(36756003)(7736002)(52116002)(476003)(39060400002)(2616005)(71200400001)(71190400001)(256004)(6116002)(3846002)(68736007)(106356001)(6512007)(14454004)(6436002)(86362001)(6506007)(478600001)(186003)(50226002)(386003)(5660300001)(66066001)(6486002)(102836004)(26005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3759;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MjTeeBljqRwxSK7tp2c4knqtCJGYYgukooI3JUIGfDdI/ef3Xo/VRgQ3rrgkru1fih+gH5Za/etpiV2XYRhY1GT7nLfHWPfTry6N/bqO7CNsH5JaGHiWMbM7i9z1dKpY+WXIq9iqlDkjklfIm5z3K9+7jmtMaNtU3gJdBhCLBN4zlSV8kWm4eZNKgl4/XeEqwIl8xXnu53BpnEq2J2ZpLgyLmDGXBjfInljattOtuks44BKu0/QhR1SHxO58EkiZg+mWD6flPv1yhd80XJ04WogUNjzOGntKNAo+upahTzo0gpcoHCi/V09U29JH/1DL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29b5b8a-1dde-48a5-a756-08d67261756f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 16:27:02.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AK4497 is almost register compatible with AK4458. Almost means that
AK4497 has an extra "debug" register that we currently do not use.

Daniel Baluta (2):
  ASoC: ak4458: Add support for AK4497
  ASoC: dt-bindings: Document support for ak4497

 .../devicetree/bindings/sound/ak4458.txt      |  2 +-
 sound/soc/codecs/ak4458.c                     | 79 ++++++++++++++++++-
 2 files changed, 77 insertions(+), 4 deletions(-)

--=20
2.17.1

