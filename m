Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3098C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4C52098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NOA5H3/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4C52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeJLWT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:19:28 -0400
Received: from mail-eopbgr20109.outbound.protection.outlook.com ([40.107.2.109]:53180
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727834AbeJLWT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhYClegBMLksT41taNM9DZDraCw819ar4hzsF8wovRs=;
 b=NOA5H3/6R0B4AbB9bM+U6UF667rkUrNfh/9FgLm6lA9oMdOTr2daqKAal+C2RrzuJZocesCBW4PYuq6j8aRfxhoqP3Ui45OQC7FMuq2JRDbKkWdvtUFJu+m7RI43sk35FpKVkGPNYMlYK3M5aMtUavcFh/2XMOTYBqBY6CnWywc=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2320.eurprd02.prod.outlook.com (10.168.63.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 14:46:34 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 14:46:34 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mux: small fixes for 4.20-rc1
Thread-Topic: [PATCH 0/2] mux: small fixes for 4.20-rc1
Thread-Index: AQHUYjpfautU7GTdhkmJ5MasjRqhpA==
Date:   Fri, 12 Oct 2018 14:46:34 +0000
Message-ID: <20181012144625.9345-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0216.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::16) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2320;6:2YD+cjhW3gbxc9n1SuKvWcBI26LsOCCUi6Ye6QtByesMQj1iG4g1jCK/fQho9AAqvqKLl3vWH7JwelXie5pMJOn4OT/T1eFaIM1uQlbz+9neVgt9ykHiH0epxzSVPAtv8TDx/MhRE3Xdj5pxOpj1F4KmfSp1OOwj9QJM4oH+mJpitCnOhwpKvNic0/MsbWI3XGyXOMwRT5asu97utjqIAg3p+sXq1CgZ9ong9k7ORinxhb+QKnGRkMWCsDabKSDTsJoBkdUa6Z/G2I2MmmlCn5Lz7peutPZPZrajwSkT4zOZnMCa2gSyyUvA43/SZ+PPPa9RW5EqvrYK/HlHOBd6OC246/5R4ilbmrvrMi7vFK+hr/LTkAJClweV1m4tCr92lEJpdZXG9F837xnFrsVw9OrfSsLBAbsdLWKJnRzyDN6whwTgrA8/e7mUdtEWDRrRUcdywe3V8fG9SQMKLZE5yg==;5:DnpGV/SmJVHsBcZfomLlkO3j5hd7bkcwMV8sMf+F4lJ+zI3ZYjO3aJDp2GSAye81sX5h6A+aRjn+KhFsGMysxvAdIj6bGewMiSNqgvXLF/GbRiE6wVKeGCVqAOgCUv4QQJX0JFAC8TzL4UCQ4/xLiYLNxr4oKZCFtgqEofNtmts=;7:sfO2FDjYV3Jjrol66euC1J41blT4bjWvJ9qk5Wa0laU6x78ZNtFVAzgvo/+jJetsGzQ5m0KJKOmJZQwvNDHlNkrN22lt1n1cfulAfN0UpijcKWeoxKNchGSS80Od7h9Boi442Gi8xDWqE4RAuk5AOibkfNdA4OHPSVbdYJ2O0bv0ygBBfhuvQv6XowFqymlJqYWtQt6hv4zmRkltz3ia3mz7FJd4yKcZ73mOTO+NBOsfRtndeNpMeYHRJPPs6znI
x-ms-office365-filtering-correlation-id: 2d7d90df-b33a-4f51-c89e-08d630518137
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2320;
x-ms-traffictypediagnostic: VI1PR0201MB2320:
x-microsoft-antispam-prvs: <VI1PR0201MB23208C72B23EE560AED78117BCE20@VI1PR0201MB2320.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991067);SRVR:VI1PR0201MB2320;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2320;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39830400003)(376002)(396003)(199004)(189003)(316002)(99286004)(4326008)(8936002)(97736004)(53936002)(68736007)(5660300001)(81156014)(71190400001)(71200400001)(81166006)(26005)(5250100002)(54906003)(305945005)(14454004)(52116002)(2900100001)(66066001)(256004)(386003)(6506007)(8676002)(7736002)(102836004)(508600001)(50226002)(6436002)(186003)(6512007)(6486002)(86362001)(6116002)(3846002)(6916009)(2616005)(476003)(105586002)(106356001)(486006)(1076002)(36756003)(2906002)(74482002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2320;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hynwtyIdhCe1gHreCGmqPGxh1xA6sInzGtGtA5YXga1mLiqr8/YPdBldkRFFbN6Nqr+exP0shoyigAA1ziOSAvtoW5gQD6u3tHYMbDsM2LadEy/BcIs0yMp/4BHGSTBppdX9h94aQM0kIUMWZnn8guH4/LDEP7RANodTKrLDB2zOz9C7kTbi1iDnuYrqEk31MJ31jWGTZqfJepKJIhvK0E6WTa/aWYqafd9SVVSuTw9Z56RUOiaLhzD/CNr5dgMKuIVPYAv+/pJDTcBwiCPj2HuDC10H74GR9lXKb8elVinpvqqO/ADN2L9xr/8sBv8Le/PVn8u2tba8y+lXXzhabpJmlQ5gDArBOER1+Zi7ENQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7d90df-b33a-4f51-c89e-08d630518137
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 14:46:34.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

A couple of tiny fixlets for the mux subsystem. Please pick them up
for 4.20.

Cheers,
Peter

Peter Rosin (2):
  mux: adgs1408: use the correct MODULE_LICENSE
  MAINTAINERS: use the correct location for dt-bindings includes for mux

 MAINTAINERS            | 2 +-
 drivers/mux/adgs1408.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.11.0

