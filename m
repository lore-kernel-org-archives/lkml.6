Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A104A218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="SOAglPGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLRXTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:19:17 -0500
Received: from mail-eopbgr40104.outbound.protection.outlook.com ([40.107.4.104]:56959
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbeLRXTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCkfrtltdTtWCliPAR8KM6jF7hwxUDxGzpD+5Orz2ts=;
 b=SOAglPGUkqET3i9IjL5C4nQaNT03kPYKCWjGxYFOo10or2VLN8tD98v183nrDq8fOrWiVhcVtxzt+bWFANMEr4VZ+7lR1NOuAnbyGKrW+MwC2JFyH8j0PBp8BFwuaL0bp+fOy0Lczb82hHtmCEgBNNZOaodfEpfK6I9PO2URWKY=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1293.eurprd02.prod.outlook.com (10.165.231.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 23:19:11 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 23:19:11 +0000
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
Subject: [PATCH 0/3] drm/bridge: various small lvds-encoder things
Thread-Topic: [PATCH 0/3] drm/bridge: various small lvds-encoder things
Thread-Index: AQHUlygV9UN+ilxyfk+m5A20aVpiog==
Date:   Tue, 18 Dec 2018 23:19:11 +0000
Message-ID: <20181218231850.3572-1-peda@axentia.se>
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
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1293;6:/kbgKnE8G/bbbX45hHHzqyJX6eE5tIxblRcAXqMllg1dPJ95+An3PH0AgFuBM6Ww3UWtteLgp6waHje0abYyizrBcgQYTm3kfXIVosQvefG/CuYafnMAFAvl3l7TBsKQ3yt+tECjzElqNaXQMTV3eHWon/NiK3U40qF5FgAKeOEgxLY1x07owFmFrQ315vRN/P0ukQpOXcwMVA+92BsW2v41zISL5u8cqEVQr9j/yr0fnlViG0ULBHjHJj386umFs8z2zIK+Z6LWdqRcNIhW703dEDYiIGyccIuQ0rXICePo1RmVFKmkDqBg3hC/tnDQyacDdkvOsCns8FMUBHpJtkRdbtz6sbk0lSDFMUYnR3LPOmVuwfOHk6LxkuTUPcU8FRwSPsU6OzqJ127QbO91StlyzT2OtnzXh35lytl3poFYZlJTV9+nHSjjRtYv6oVS4Z9zAnHUZhMkql3dnzsDigL6Rss6TjkP8bWL5wUCBZA=;5:ES1n81W6P3R8wINyb5Yu6KGa796ocG1EpupunB7x1kXZaMaFP1KlcdeV2vBvYDIsv/sDQUF+OD5qTzZOGxO/yedapKnHqE3UHiegozAVyzB5muibubqsqhraBDLVgnScEkFR0YzPkS3SzgQ9v8TDJcPQ0f225wisBje9AX3HyWw=;7:5SlD5GI0MwtXxOxo3ITXUEW7UHPDs1kDfi5d3EZr3+HQXVGhck2SfMq4FH2ZnZJHzkgBvbIpWBflcphYcbkrY1FI4MRis+Yf8EkOYpMGWjtN5ugU0zh6bKekQcbVOySz4JDSL3IM6kBAZYXBKDdF+w==
x-ms-office365-filtering-correlation-id: 909a4716-9894-4753-1cbb-08d6653f3777
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1293;
x-ms-traffictypediagnostic: VI1PR02MB1293:
x-microsoft-antispam-prvs: <VI1PR02MB12939EEF7555B246D501DD68BCBD0@VI1PR02MB1293.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1293;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1293;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39830400003)(376002)(199004)(189003)(2351001)(305945005)(2906002)(105586002)(106356001)(7736002)(71190400001)(486006)(71200400001)(66066001)(54906003)(14454004)(50226002)(508600001)(5660300001)(81156014)(6512007)(8936002)(25786009)(476003)(6916009)(86362001)(53936002)(386003)(26005)(52116002)(102836004)(256004)(1076003)(8676002)(81166006)(2616005)(68736007)(6506007)(186003)(4326008)(36756003)(5640700003)(316002)(6486002)(6436002)(74482002)(99286004)(3846002)(97736004)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1293;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +M6lTUs6/uGjydf0EBVVOOzXgHqXRbfTyWzIDnwxc0OGdFnxUo8EoTxBJOrUE9C4RL0h3/q+yI5lOSSvHVgZjWaRMLnF1j/A12aoBCdSL55XTjwAOMIEvaf4Rv314QLYTLSdaMjDwdMT9rdGlEvPjEtZt6G1x4z8SUIs7CPI5rhKQ3pjzmHY0NQrewvCoWzySwJHkLIgoDGkySW1AoNjDBNuK5MPn4IPu5ojpnsQWBy4QKARtuLyrPXu3EshIG9Y8ARhzcHqIcu7HbVPG+clqdpjbgR6QScuw21B2rKbEtvPGvSwTf5HTumGmAjvLrRm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a4716-9894-4753-1cbb-08d6653f3777
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 23:19:11.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These patches are useful for me. Please consider merging.

Cheers,
Peter

Peter Rosin (3):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c187
  dt-bindings: display: bridge: lvds-transmitter: add pwdn-gpios
  drm/bridge: add pwdn-gpios support to the lvds-encoder

 .../bindings/display/bridge/lvds-transmitter.txt   |  4 +++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 34 ++++++++++++++++++=
++++
 2 files changed, 38 insertions(+)

--=20
2.11.0

