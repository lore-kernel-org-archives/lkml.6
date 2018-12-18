Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9D218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="jYaxuTTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeLRXTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:19:34 -0500
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:15504
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeLRXTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5Tyf3a4uptAfSKqErNyzkvY2WjR816jxk4AkzyG9QY=;
 b=jYaxuTTssJMMdbbnHw/gv/NMOXTT4pXjMxLX32XKgx9Rg/1C6tnaviRePGJW2d/adzZIJi1ThunUMW51mXjIlksGsiLtlUqyHBVIZFUg0Y+wJ5E5r+XFAuM6VrGsEW7uyIPaBLHCYWfwnMVEHwjMA3cFZmJAmyssKQV9zXURBqE=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1293.eurprd02.prod.outlook.com (10.165.231.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 23:19:28 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 23:19:28 +0000
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
Subject: [PATCH 2/3] dt-bindings: display: bridge: lvds-transmitter: add
 pwdn-gpios
Thread-Topic: [PATCH 2/3] dt-bindings: display: bridge: lvds-transmitter: add
 pwdn-gpios
Thread-Index: AQHUlygfLqQfa5yGMUGP6qbZiqP5Eg==
Date:   Tue, 18 Dec 2018 23:19:28 +0000
Message-ID: <20181218231850.3572-3-peda@axentia.se>
References: <20181218231850.3572-1-peda@axentia.se>
In-Reply-To: <20181218231850.3572-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::15) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1293;6:FlEGi10TpGorpCrum8PbS3BRXiEYGwqhpXQLQK0D/K+8tbijZ2Xj4ldv508Ltbd1ko5cjr6sVmtQNeZ2qVoosLg3pYy/HYUOcKDlkEQBAp8FMQUGIu1gBt0jXArqT+huuk3i7l9lUPqEg246+QH/YAK7Tx2iJZat3A/KjD8ZS+KI9mk/kv1jz5StOG0u+FfRre7OD8kA15/ibwrp5+0D9/OgUVMc1NK6CssRmsZcd5bxXYzzCT1SeInQs7Gj8Su42ZnPTxQwgEI0pKC5A+wRl0dUOFp6+1w6lrYKxi6yRBFCWuJczowzdy4lrUcvYgsJHxMMxqFHlzenIKBZunF6odrHXnHhGmQlKoKky37BWU06EJmfLzluZ069pjknC4lxKE48NwrNV4acAEig0wQEAHGxmZBDGej8J7IVh71Q+FuTSwqjf7BdnjTudKy2/YPczY8DmyiS3UdWUNpiYJL7lVFdNZiPqEsd+hLxf2q4oeA=;5:N2hQKMKwFNGuXW/p5CYRvm77UAysgu64NgshjC8hxOYjBHtjUu8FqYXpLaKlvDsiiLe6N5DjoaEEq0jEqlzp0LWDO99JnQ8RYRNeqFDOrQ2MG32gkhmdk16Ddly48av9510HBCO44YBa5XOBDpSUXSnL26gKMNWGxWYRtt8MYHk=;7:fHADJxA7wUQRbKwg2LocZI9iMCCijbV7Af0nVU1bHR8BNjbo4vzGd8KnMsK4iwgv6cNt3739IKvp+um4mvrgz59F+arlvgQYknX6OUHHKzLYLUbO295RdfCezytIi4MMMaTl1cs+Yj51Dni3OM4g3g==
x-ms-office365-filtering-correlation-id: 87580118-c153-467e-9492-08d6653f41ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1293;
x-ms-traffictypediagnostic: VI1PR02MB1293:
x-microsoft-antispam-prvs: <VI1PR02MB1293DC6A8E4E3E917471FDACBCBD0@VI1PR02MB1293.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1293;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1293;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39830400003)(376002)(199004)(189003)(2351001)(305945005)(2906002)(105586002)(106356001)(7736002)(71190400001)(486006)(71200400001)(66066001)(54906003)(446003)(14454004)(50226002)(508600001)(5660300001)(81156014)(6512007)(8936002)(25786009)(476003)(11346002)(6916009)(86362001)(53936002)(386003)(26005)(52116002)(102836004)(256004)(1076003)(8676002)(81166006)(2616005)(68736007)(6506007)(186003)(4326008)(36756003)(5640700003)(316002)(6486002)(6436002)(74482002)(76176011)(99286004)(3846002)(97736004)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1293;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P2OOQXIxC4sALdVc2J6mNnKcIGWBgIAubjD/imjTym420umq/6FzZdiebcUPDvCrzJsABW5B/UIF2O2V2gdh9GvSsG0XDbXR7H1uxn0LrMOAb4xcEQ9iECpjiPtT1d5jIIeJzFsAasrPRttddeyhdYiwjJeRbi6NIPHAwpOTxXZ6CK/NGzcKcFtqOUJHaiNCjg6tc04s6dvKK938CpssrAOro3ZJ6dk+dKG6ZjqkcoJMlvT5iwzaznVFlRPjkchSShzsewxKMVpPVleY/6VTZ4hUst6d9CZpPZ034hBr0oUR6xgzzVXZdnzmLNMsApmH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 87580118-c153-467e-9492-08d6653f41ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 23:19:28.2276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional property to specify a power-down GPIO.
The pwdn-gpios name is already in use by the thine,thc63lvdm83d
binding, so go with that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 3 =
+++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmit=
ter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter=
.txt
index f9e7dd666f58..47941d39f92f 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -31,6 +31,9 @@ Required properties:
   device-specific version corresponding to the device first
   followed by the generic version.
=20
+Optional properties:
+- pwdn-gpios: Power-down control GPIO
+
 Required nodes:
=20
 This device has two video ports. Their connections are modeled using the O=
F
--=20
2.11.0

