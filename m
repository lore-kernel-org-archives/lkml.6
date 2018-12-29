Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D3AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB512146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="oHDpFTZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeL2HIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:08:21 -0500
Received: from mail-eopbgr40105.outbound.protection.outlook.com ([40.107.4.105]:18848
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727845AbeL2HIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgH1WBYqWa5lvo3eM0ugpM53jyRNLiC6s4U8+V5zlkA=;
 b=oHDpFTZOqYUK+5nh2sptKnQboYoRdFPP2xz+z5mFwW/FD9MhsuPuct0T6gCSQJ8JSYk2LY/iZ+cbQquHDovr5TP5M81zigr5lIolofs/gkYrlDw7CbDpL6Bo4vzsBH+8cBMzvF8wcrRaZl0AZlBVm1DVOXOyXOR/kYowuc6zn6A=
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com (52.133.34.148) by
 AM0PR0202MB3459.eurprd02.prod.outlook.com (52.133.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 07:07:31 +0000
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422]) by AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422%5]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 07:07:31 +0000
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
Subject: [PATCH v3 3/5] dt-bindings: display: bridge: thc63lvdm83d: use
 standard powerdown-gpios
Thread-Topic: [PATCH v3 3/5] dt-bindings: display: bridge: thc63lvdm83d: use
 standard powerdown-gpios
Thread-Index: AQHUn0Uqfa9DUMI0ckWlBr9Ht0/qGA==
Date:   Sat, 29 Dec 2018 07:07:31 +0000
Message-ID: <20181229070649.21308-4-peda@axentia.se>
References: <20181229070649.21308-1-peda@axentia.se>
In-Reply-To: <20181229070649.21308-1-peda@axentia.se>
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
x-microsoft-exchange-diagnostics: 1;AM0PR0202MB3459;6:0P1Ma9iktOcXcyJXnji8JDM0KMzBV9GIrTNOKGoW01tsctxpL59FBDUvaPxS12VRafjxDS5WY6LmQ591BkOduq2WysrC+Fqv0C3LeJtbZnnTrQH0Y4PdclIiZaYsZyyUvmeH/GhLQ/OLgXaOdMVj/8JwZqj0gBKj4TKVE4Cd0kl5bPht9nn1XjjFre/cCHm+RkdwfW1Kevfk5GOvp0QDRZBNh27TWqNxMcsOEwxCt0xXK5Oxr4kjbfmdTDzDHKTmjDOuRHM3r6WPBuDBIOgBWOBA2/LTz9z4s0mjZ3aEL2aGkdgjHLnpokb31JrP2zVVTk3YNOpdCLlFbZntdqpUEjn46ugLH22wdwQ69FE+qqJvd36GWVOB1wUrj9aTLeVFtjSrnGzsDuwbuaaKUh9lDNMc7kRhVS5YnHmX9BupbIyKgAsicCtfhJI9gL9E1cACJkiL8OjkKROcHIwy3gZxkQ==;5:sGddzClNouvCdyK97rSiVbBu0IRulBIS5WLZ4qJ5c8wmQgNCDGEGShroA1ccPnpT559OM4BRbubdFqg6im1Qm7ccYAbnewYTgQjQWaaIlMuqfyHHgVdoKARyxt+mBpnQ+mOvmjqls4DtaLJyGKPpVuFA2jwFH20TBfXHqvDES58=;7:s1EPBE3//koqgKjlq4Uceghq7JPnnT9KA1z95cJi6BtyqHkVJrF4LjjDVur+lOF3W2Gp13gx18y57vn4BQZgpWp/SgzajpMDssAWBU0QxGUyHWPOyHHGhPB+EdgYLhnoQ4zwl/c+ozQcq1Eyjd+ouA==
x-ms-office365-filtering-correlation-id: 4dc5473c-bf53-4367-cabd-08d66d5c4c8b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3459;
x-ms-traffictypediagnostic: AM0PR0202MB3459:
x-microsoft-antispam-prvs: <AM0PR0202MB3459B744F31F46352F103616BCB00@AM0PR0202MB3459.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR0202MB3459;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3459;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(71200400001)(71190400001)(66066001)(6916009)(305945005)(99286004)(8676002)(81166006)(106356001)(6116002)(6436002)(81156014)(14444005)(7736002)(2616005)(1076003)(86362001)(2906002)(6486002)(8936002)(476003)(74482002)(54906003)(3846002)(256004)(446003)(11346002)(486006)(68736007)(50226002)(186003)(5660300001)(316002)(36756003)(14454004)(6506007)(6512007)(508600001)(76176011)(2351001)(52116002)(97736004)(26005)(4326008)(5640700003)(386003)(25786009)(53936002)(102836004)(105586002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3459;H:AM0PR0202MB3267.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hl7ipg8EJV2zG7rLTEYfHNGr79MVOVfSi41pIpLxFV89GEr1eivOFijZ/JADGmQK/u5UYAlP2tWsmusHco2FRUxHDqegnuwaqz9s6ueeeHaO5CvwKPBUuKkONYS9YC99v72ywzYlHq36JtNYzAvg0rhnYUw7giIc9oGQAl/pMh1EuM9UIChctA4rKvJQZaM9VXP1W+v1UjAgg2OmM+koJ2aS3SL/1W/0GUpB/t2KuyYwI9Td/X0vFCkmQEAJSquPrZwhOCcVz2GCYC26oWEHCw71qcfS9qlfB3dTnVLDkBJ25v+vKWx3wkY7X6SpWf3B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc5473c-bf53-4367-cabd-08d66d5c4c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 07:07:31.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name powerdown-gpios is the standard property name for the
functionality covered by the previous pwdn-gpios name. This rename
should be safe to do since the linux driver supporting the binding
(lvds-encoder.c) never implemented the property, and no dts file
names it. At least not upstream.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt | =
2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lv=
dm83d.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd=
m83d.txt
index 527e236e9a2a..fee3c88e1a17 100644
--- a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.t=
xt
+++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.t=
xt
@@ -10,7 +10,7 @@ Required properties:
=20
 Optional properties:
=20
-- pwdn-gpios: Power down control GPIO
+- powerdown-gpios: Power down control GPIO (the /PWDN pin, active low).
=20
 Required nodes:
=20
--=20
2.11.0

