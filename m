Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F387FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E9A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Ks8HpS9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbfAKPTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:19:33 -0500
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:61900
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730170AbfAKPTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3iu+VqmXxgfKQwEuynVJObJW2ndDe0luC1KPbfgV1E=;
 b=Ks8HpS9GS76z/pQZF1mhfO/xcFhksHl2qbbVmRXscaRDTqk2DpChMCiEcvgmyLVhNxySJpGM+C8lfIu8dTPe+poJUl+XTwB+YX7mc7a6sLD/ffkcNZ2hFd2bNhvK46j/yMUeB/T1g96pSt3BxZhJY4pMCoPFdiyadrtLtjISZRE=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3735.eurprd02.prod.outlook.com (52.134.113.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 15:19:05 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:19:05 +0000
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
Subject: [PATCH v4 3/5] dt-bindings: display: bridge: thc63lvdm83d: use
 standard powerdown-gpios
Thread-Topic: [PATCH v4 3/5] dt-bindings: display: bridge: thc63lvdm83d: use
 standard powerdown-gpios
Thread-Index: AQHUqcD93KdkRYBGCECdNd3Z0wxoTQ==
Date:   Fri, 11 Jan 2019 15:19:05 +0000
Message-ID: <20190111151843.11114-4-peda@axentia.se>
References: <20190111151843.11114-1-peda@axentia.se>
In-Reply-To: <20190111151843.11114-1-peda@axentia.se>
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
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3735;6:hCkcJWVX5n8tMQeX3FqhyDvA0WU10AtrOCXbYWH7sIUJHfdNen/bsTVIyi6psX9OOcZxXPPgM17kV60K1htQ/j6cIq4WkhBb8OfVTqP6pQgZKDkfnAXr6OcErct2kryHlXoVaK/Klb456d2jtbaU12jXX8CaIexkPVSIvPkxN3lbe0sS8DVSxWCOedNDj6GOlLJyHnm9jYxMLzY1Knd8HO9ccKyKbK7rsu8rmhJutVWXpg7/doEXPH6xnMuw1I9VTbKhlM5zS46sA1X/si3O0GT9kmIbEdzXMriZlMBWzXihGVTK18knkDlfkzEboFIuY3hXp06J8Cl8l0UJWrbnNMKsNEjSM9rG0wk/dncG4k0cSAPwRTW/35C9cpqAeuoFdSjJbUamrRfFnryC7ivTwRaAzqH7oiQpQSOSdRVk+LTnGi2bFMVZy8Xtd0LbUEYevhseZzm3023zWzzW3w8c9g==;5:O3gmnZGfXPHyTRDm0axSV8IayymVWnfh4VbkHjuvegUhka4pWUMrVPEmx50q5aasSjozB7dsf4tIJ9HP6f1l7rwZENJlVzf4ODATFpncZJLllaxAiBuRrHEkfMh8Rb5WvxL5p3hI+RqGObDW5AvL+4qAN/dNLXsF+36o1pEh4J+GNZfT6kOXxkYKX54iDvEvauhUlgfcZKJjGfM5/9ha7A==;7:NiN2w/co10VW9ZlzJEaY7kgiHvoL68woPp8s0aWxN+hKJ/otvFAe40Dw/+sB86E1G88w4Iur54OErDTTF+x/OfGSoGIpIqEPyit428GHQaNLIJnWQkhhr3gXeIPRwu2LRrjtCR1J7oE222SeFU7VFg==
x-ms-office365-filtering-correlation-id: 82f145fe-fdd5-4049-ddd6-08d677d81fd2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3735;
x-ms-traffictypediagnostic: AM6PR02MB3735:
x-microsoft-antispam-prvs: <AM6PR02MB37350865A4F40F73F7C21C82BC850@AM6PR02MB3735.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39830400003)(189003)(199004)(2501003)(1076003)(14454004)(99286004)(54906003)(508600001)(5640700003)(68736007)(6436002)(97736004)(2906002)(71190400001)(2351001)(106356001)(6486002)(316002)(105586002)(71200400001)(86362001)(386003)(6506007)(102836004)(66066001)(6116002)(52116002)(76176011)(3846002)(6512007)(53936002)(2616005)(11346002)(476003)(446003)(74482002)(8676002)(81156014)(81166006)(186003)(486006)(256004)(26005)(50226002)(8936002)(14444005)(305945005)(7736002)(5660300001)(6916009)(25786009)(4326008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3735;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d6CC/R0O8uLtdnSs5Qn2G5HzrRz3llfsf9NLzly93PmYHj+NhUcHR1e+CcxQ6QGCb3eruPTM3aJYpDLYKKpNDyfao07GzX2RwscwXPA3neS9wsf87xZXLd8WmHi2dXXEGh2rxMWUs4t9oJCFooIP4bd/jt0wGEGM39CKUuJZHeLCEfcpR1EzBheEsLiNyo9wiz/epEzINkCj5i5G4h0Pg9mrVkiN6d3lUIDN75cFWr8DJaVCdNKYImNOfOx9IkcjTa4WyiB30vBfLf4XvcT5gHWpB5oWXcb5X8usRVyfoaOpNnxBhjuxdizPvkdfUjgDTsE+dSj2guce/3oPn8B09XpULBg5Nz3X6wkxhK0i/IsOD5u4zBv9eOv1y4D5hjAn8v9XZ5/GMXqZK2WUcXOPHcsfUb+Fg43efPBUlp8lhI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f145fe-fdd5-4049-ddd6-08d677d81fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:19:04.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name powerdown-gpios is the standard property name for the
functionality covered by the previous pwdn-gpios name. This rename
should be safe to do since the linux driver supporting the binding
(lvds-encoder.c) never implemented the property, and no dts file
names it. At least not upstream.

Reviewed-by: Rob Herring <robh@kernel.org>
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

