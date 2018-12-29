Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C81C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A422146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WOJeVWFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeL2HHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:07:15 -0500
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:13691
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeL2HHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6ZvvYlPX8t6S2oZxxM+AVF0rE3uH2agUd4Nik8z9Q4=;
 b=WOJeVWFKUArQRvskAQl552pAU0be8lvQQlWTfUtAq5rbOmH/xWVHVkfGRCRyBMnyXzUU709w8ezCchbTizks22jJQx+l/EoALafkQBb6YP9m4Kawo5Q1RCYhjCb5P+ES4GVZ6TkIROIY86e2eSS2fH7ffnFTKfKqjbFuNUeGuoo=
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com (52.133.34.148) by
 AM0PR0202MB3459.eurprd02.prod.outlook.com (52.133.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 07:07:10 +0000
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422]) by AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422%5]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 07:07:10 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/5] drm/bridge: various small lvds-encoder things
Thread-Topic: [PATCH v3 0/5] drm/bridge: various small lvds-encoder things
Thread-Index: AQHUn0UdB/yPp/FWpkKlL+vabEDGvA==
Date:   Sat, 29 Dec 2018 07:07:09 +0000
Message-ID: <20181229070649.21308-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To AM0PR0202MB3267.eurprd02.prod.outlook.com
 (2603:10a6:208:5::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0202MB3459;6:Mu4IBP0bcFZgkKztkJ7anvmLn3vAS4l80ct5H/5Y7bT7Tl6VQgy7BsTwcE6LKm+qCp9PdKGRl116dzSI8UAe8lI5A6kDZ17HA7dYxSEWzK6HYxfd7NWgMKaZFSIrZU8eNhN+6HTpxmA5OZEn64zPKpOrdY4gCxwWuUoDt+qSldC/uoVV7Hi1TE2WsmhbSCZu+8HqIcYayN9RLE0qH6qH159kKvbR1M1IWc8i8B0eNR+OB8L6UPNhnLi0Fq2dIxx/JjvV9uR1rSGBM4TTVgonpaC6HLFgP9kqAx1I/OKjKAmopkhkYR8Z2CNfIyg7nc3JtVhvNKw2sne8Ua37owHzWBi0ZRjKfaMmJGgU3MboGAGG+Zga6Cnf25/cJtJLI1S7OCIX4KEjiT7xpW3Gp4jULhvZ5DWRF2zsD3m0arYNfSUzjJUmCu6p6PBf+v14lKrD5Yl4yfU3yNcPsZKLawg03w==;5:oIc0cBIjQkIxTn/qE1eZ4rXiiTe7pOJDCWbYGKj46YvXdJCIKRx1aSZHtF4i6AISQ8unwkEhxTlO5uz8bSTp29RWx8az/doaVCpxojuGNcBLLpDLoWYsCK2Z7ZRwcsDQlH411qerzeCK2Le/edXbQr18GLNx+6QEktH/rGpeVR4=;7:mgele/ScGIJzj/+J932N4Lsn/o6GvE1tunlEIl+gzJi2ykIUYP2QbBouNp83RdWQTh2rbKe7MSeXMCapsHBOY+lc4KvyZOx65MNS95o2v/HVMzx1c4UnqsjGTzqZ1MW0UaPJhHYzS8kXVpElWGXPDQ==
x-ms-office365-filtering-correlation-id: 4100e8cb-5f3f-42aa-f5e1-08d66d5c3f92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3459;
x-ms-traffictypediagnostic: AM0PR0202MB3459:
x-microsoft-antispam-prvs: <AM0PR0202MB3459B7593DB856CC2DC0C407BCB00@AM0PR0202MB3459.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR0202MB3459;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3459;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(71200400001)(71190400001)(66066001)(6916009)(305945005)(99286004)(8676002)(81166006)(106356001)(6116002)(6436002)(81156014)(14444005)(7736002)(2616005)(1076003)(86362001)(2906002)(6486002)(8936002)(476003)(74482002)(54906003)(3846002)(256004)(486006)(68736007)(50226002)(186003)(5660300001)(316002)(36756003)(14454004)(6506007)(6512007)(508600001)(2351001)(52116002)(97736004)(26005)(4326008)(5640700003)(386003)(25786009)(53936002)(102836004)(105586002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3459;H:AM0PR0202MB3267.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /nEClEklv3K6BPTPjgaLgUvFJcX4NMr0Cpfti9L9yXhOmHV+nfIDa7e5UMxUmKbOJXmjLLvfJ4Qla9obp3JQDsnQyC+ZqdQ+RNljP8KL4p0FtDWsVhXryVplLBSl0rbzvYdOyK4gXgb5pC4vjLo2fVvDPpYOZ+0JwkicjQ4xm7iYSLECk+m4AnuYlz7tesnjoGGOWJxnKI/QKXNvQi9Gk3QwYN+lXaM53vS1BWXSma5juTFeBSiD70KlyROjOpzcNlM8nc+fc9n74A84Je5X3+ZOXsOpe+h57O7H5rqWUo/PaSWLIMEY/WjE2MCFL+WQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4100e8cb-5f3f-42aa-f5e1-08d66d5c3f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 07:07:10.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm not sure if I should have added the texas chips to the lvds_encoder_mat=
ch
list in the driver, right next to the thine,thc63lvdm83d entry, but ended
up not doing that. That can always be added later, if needed...

Changes since v2:
- changed from pwdn-gpios to powerdown-gpios after discussion with Rob with
  new patch 3/5 updating the thine,thc63lvdm83d binding as well as a
  consequence
- added patch 4/5 which helps keep lines shorter in the lvds-encoder driver
- added tag from Rob on patch 2/5

Changes since v1:
- fork out the bindings for the texas chips into their own file in order
  to avoid clutter in the generic lvds-transmitter binding.
- added a patch to remove some surplus stuff in the generic lvds-transmitte=
r
  binding.

Cheers,
Peter

Peter Rosin (5):
  dt-bindings: display: bridge: fork out ti,ds90c185 from
    lvds-transmitter
  dt-bindings: display: bridge: lvds-transmitter: cleanup example
  dt-bindings: display: bridge: thc63lvdm83d: use standard
    powerdown-gpios
  drm/bridge: lvds-encoder: add dev helper variable in .probe()
  drm/bridge: lvds-encoder: add powerdown-gpios support

 .../bindings/display/bridge/lvds-transmitter.txt   | 10 +---
 .../bindings/display/bridge/thine,thc63lvdm83d.txt |  2 +-
 .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++=
++++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 53 +++++++++++++++++-=
---
 4 files changed, 100 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds9=
0c185.txt

--=20
2.11.0

