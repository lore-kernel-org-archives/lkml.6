Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7231CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD512184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rWnE2nJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeLRXT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:19:26 -0500
Received: from mail-eopbgr50119.outbound.protection.outlook.com ([40.107.5.119]:9056
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeLRXTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxRyt13jy3f37Hz9AWpY6Vqa5JlR0CArLfAV2r/yB0M=;
 b=rWnE2nJJoqiQNnTs079jRO0sIrsqSVpVzGVQsA3M2y9H3vcUs42xsHyrJABvBE9hPSbU3fKdu9Fprv8FS5mSoDQGRi3wSJybepQ50Cy+myd2YSBqwH34DNpZdgf4PYmxyYQAPgM5zJucXKoqZSLFlbuSmD7+ynsUcaFrPF6iqjY=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1293.eurprd02.prod.outlook.com (10.165.231.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 23:19:18 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 23:19:18 +0000
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
Subject: [PATCH 1/3] dt-bindings: display: bridge: lvds-transmitter: add
 ti,ds90c187
Thread-Topic: [PATCH 1/3] dt-bindings: display: bridge: lvds-transmitter: add
 ti,ds90c187
Thread-Index: AQHUlygZ9G3giRlBO0exF0/ReoAvig==
Date:   Tue, 18 Dec 2018 23:19:18 +0000
Message-ID: <20181218231850.3572-2-peda@axentia.se>
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
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1293;6:VrA0HyxtgcsbN1+748En2ULJQerWLSM0HzkEO3ocJaac0M1MaArigbCrfYHzODzoX22Z8pnJGYIMaes+LjSS70F8uPqlMcTHypnvIgZasUwdZehETAEgNrJKdrtWexrKXVXvOtN0zmWtMUIs+J2oxjHLiXyhbjbMBspjYyYTeRvNWaa4o12V8pmSNRtvDkZicKQ1+lkcmpyw9v1u4C+XuJvgC9ik5MxFB0h2eVC0ZaARg4t9aRvtVF5BiNaSuuoJRY94uF96eUPgQrfnYt9wSrn6FK8MjGz9zhzig6Ydx0lCceY2+a23kSKQ1IhacR8w4kU6TLRQ5ZiGI1oJzFdE2CjirfgI3WepiXt27ULnFwAdWrOA3llzgHjmTOYdM73czsnfaYp9hwtVAHo8YRWaBlSPyvd7PR4/cmcEhcM9gV4F80LcC5ZAv8t5HiycKLTJ2fBf55v9E9OlsxkAensRyEaVfL5P9zreGq3UsO7aTVI=;5:040rtw9oYxpT+zsCb/gqoKs8Vh5EjXKPqyfD/mf30apWXN2g/iplaVMHvUuxo0pFXdw0tkc78xqL4tu2nW4CTcMKvJTEF2x6B1NBt8In3Px7gEk2FgfB6Pw+jDjdYnYG5vJREd1yyEEa2Kgy0l+KckSQWP5Q7Kt7MlMwMiS6Mcs=;7:DUPUqtAt9OoU2P49S3fXROQ5dSbg10neo91mizImrJJCTHjTC5UFz2yvsOCsN4m1DJNpFmXxilZ/aFXphU5GEaFc2XPBhXgV3wJJCVOiSpg6NDDD3+SXO0FVOY0V93ziueA+QGb7FKoSL2/PqPwKyQ==
x-ms-office365-filtering-correlation-id: b7c73c6c-7ceb-47b3-6cd4-08d6653f3bb1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1293;
x-ms-traffictypediagnostic: VI1PR02MB1293:
x-microsoft-antispam-prvs: <VI1PR02MB129306B732DB221AE89FC4DFBCBD0@VI1PR02MB1293.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1293;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1293;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39830400003)(376002)(199004)(189003)(2351001)(305945005)(2906002)(105586002)(106356001)(7736002)(71190400001)(486006)(71200400001)(66066001)(54906003)(446003)(14454004)(50226002)(508600001)(5660300001)(81156014)(6512007)(8936002)(25786009)(476003)(11346002)(6916009)(86362001)(53936002)(386003)(26005)(52116002)(102836004)(256004)(1076003)(8676002)(81166006)(2616005)(68736007)(6506007)(186003)(4326008)(36756003)(5640700003)(316002)(6486002)(6436002)(74482002)(76176011)(99286004)(3846002)(97736004)(6116002)(2501003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1293;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vXPSQPLluRdbf0zXufPiIel98SJVLKjPucf30adJ5CCsCppk2XN9nz6YgxOXGE9X97N+S4HFvPGBbKjG6DMCPItotzBLSZimAAYp3ATY64DRn8JL+0nrDyhDTC8u1vXn0lG4vVC5eMvoJxgRGvxhxSvlkbZf0SOQidb+BbNqfq2SU6uCY1Kmib/LVIHWg7u3xwJga1CUcdKyEm/lkyjRCz1GDvBlAOEY907I0neRQ07G+GGQl5AaEpbF8xsyWVt6QwkuBojOYY6+qHZheT036uT9S1aQAMOV57kX5IuCEGqk1OrNcZ29L9JP6h9bNrWy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c73c6c-7ceb-47b3-6cd4-08d6653f3bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 23:19:18.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is compatible with "lvds-encoder".

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 1 =
+
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmit=
ter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter=
.txt
index 50220190c203..f9e7dd666f58 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -24,6 +24,7 @@ Required properties:
=20
 - compatible: Must be one or more of the following
   - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "ti,ds90c187" for the TI DS90C187 Dual Pixel FPD-Link Serializer
   - "lvds-encoder" for a generic LVDS encoder device
=20
   When compatible with the generic version, nodes must list the
--=20
2.11.0

