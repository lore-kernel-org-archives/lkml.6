Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393321872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="BoMr4MuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfAKPSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:18:55 -0500
Received: from mail-eopbgr130105.outbound.protection.outlook.com ([40.107.13.105]:51490
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730170AbfAKPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdVjgqBAKb2LTB6mUAZoPn9np5g+Q/Z8qdGM19eYcWs=;
 b=BoMr4MuGVCtAFg3g3GN6cxYrbGQz3jFlkPlONFanTGZHK0v5nb4xTz4R61hMxaqUfZeI8bxeELn/A2GG/7+oO4w7YxhK4dx63uipO2hdV8cg6K5wcKjE4xn2ZcaaP534YwCUuZqSUJgVnZuZNSXHwThSwqJyChd8dxoMS6OLwxE=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4658.eurprd02.prod.outlook.com (20.177.117.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 15:18:50 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:18:50 +0000
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
Subject: [PATCH v4 0/5] drm/bridge: various small lvds-encoder things
Thread-Topic: [PATCH v4 0/5] drm/bridge: various small lvds-encoder things
Thread-Index: AQHUqcD0CoXRdWU6p0KJ3CgM18hMaw==
Date:   Fri, 11 Jan 2019 15:18:50 +0000
Message-ID: <20190111151843.11114-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4658;6:PrRA6uQBG8uuvbQvtJm7PHTbpczyFxgwwGoD0NkYKDw5JlwFf5OwsxcIg0J/7/TNInNqdNMx9MZzGdhP5grgvqLYlJm3Kq0P0mnNwxxJqO+OTVNkMUi1uwROWecK8WtbxUy34kFZOS+6BBBTVorXBwtEO2EOBxXBwforOQ7QPlhRib/UTcHOYRczYErK5Q8CZ41b9llrjkX2jt3qzLZc/VdZ4sQWqRQoq/uaVzT+Cl389y9vo+T58RHGBFsImQadtmEnTL1gyXkvlSG5XLZrc2Cy+aWcLc0dalvl3jCBIdU7KPHXq7AXXdP+qgA88CKjQJMTQct6E2M7jztt+4U0x1JqZdbMygta3U8CdZh7nXh71Fvgu4dQ8/JT4Rxyu5YzYbAp07W/bG+sbLMcJg3y1NYNJa2V/Hntas1z9p0ZYm9tdyiNIFdzqeKc4sbK7l1TMxk6f28UhTXb7Aucn2phwQ==;5:imaqYutrztAiCEMB4MCpuifBtenHD0KFllBPPEvikb4xYOL2NH6mZ2ljx02RqxSTDDweWXGa40cvn0IMISEwSqSs+wycyKLhKEIJ1lCAmOoo+9WjuW2wJZdq9nnNLXIXeZ7NG7kfIczig0gvcPCu2pngCDaQE1iyHDtfGHYrvOuSHgolJhu9LdIz+pnbuAWhAh9EQfEiRx0vX830OVOEzg==;7:CqgBklV1HTUIyLiyKGV2op3Yrl7aUVWgDX1EUV/hmIgi9DpoUNtrkJ08omMgQOfhu4UC1blN8trhB/P3HM4cWq46OF38k6NGoqZkzxiXlEasdcLtMn6S7ZXiW4No4wDzUhUcdAZM1/0QdUKlTiCtdg==
x-ms-office365-filtering-correlation-id: 9c7a704d-36bc-4cc8-92fd-08d677d816de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4658;
x-ms-traffictypediagnostic: AM6PR02MB4658:
x-microsoft-antispam-prvs: <AM6PR02MB46580E47AFE2A76E5CAE7FD8BC850@AM6PR02MB4658.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39830400003)(136003)(346002)(376002)(189003)(199004)(6116002)(3846002)(5660300001)(6486002)(86362001)(54906003)(74482002)(71200400001)(71190400001)(25786009)(305945005)(6512007)(7736002)(99286004)(52116002)(6506007)(102836004)(386003)(2501003)(2906002)(316002)(66066001)(186003)(26005)(14454004)(476003)(50226002)(36756003)(5640700003)(14444005)(486006)(6916009)(256004)(2616005)(97736004)(1076003)(2351001)(53936002)(68736007)(8676002)(81166006)(508600001)(81156014)(105586002)(6436002)(4326008)(8936002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4658;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XxNSpX4qiYG0r2nlN2RN7Pdz2xKBjvCM0cWhLNlW4Z99ysZPdOtcnOKW/hTNXVSh2bA1HT2f0EnOs5GFlReG7XWUT/xpYIQR9jhz148hSU2/uN1u5mVuiF/Z4+lMCMMXcv39p2rP/mvriGGWUqvFpVggdqLDl7082bAUOvovbFWCAsYOs0quccP48vveC5tsoVJ+My0m00UQFhL1HA1Nj4s5csY+LhcsN4V883Oubxm2MLiGbBUUfv7ZYBSSPW5aM6R+16jJUGlrkYcvMJ7pNbBq6nORytbufGTLdIV5n03/Hh63QflBVzEALWemS5RAfRmoT6mhBBvJB3GFbY1yhgTHBgcGnj0YByp6h90wUzW7wkOOVIvHFjwWPmRLbSr0wD82VcMpcl9XuRGXVf5eZZ5rZGyChGASk9vn2ag6C5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7a704d-36bc-4cc8-92fd-08d677d816de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:18:49.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm not sure if I should have added the texas chips to the lvds_encoder_mat=
ch
list in the driver, right next to the thine,thc63lvdm83d entry, but ended
up not doing that. That can always be added later, if needed...

Changes since v3:
- retained a (modified) note in lvds-transmitter.txt about encoders with
  additional device-specific properties
- added tag from Rob on patch 3/5

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

 .../bindings/display/bridge/lvds-transmitter.txt   | 12 ++---
 .../bindings/display/bridge/thine,thc63lvdm83d.txt |  2 +-
 .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++=
++++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 53 +++++++++++++++++-=
---
 4 files changed, 103 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds9=
0c185.txt

--=20
2.11.0

