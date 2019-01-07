Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780252070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LscdUF7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfAGRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:48:05 -0500
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:30688
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfAGRsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ercNEHFUL1D3/MHSc/w5m/uSE6MGACc+W9470zhaIwU=;
 b=LscdUF7zd0wDQr6VPIdRW+Xhhwp5sUY3miW8WJaDRpIx6f6mepVJUUhyuBnBoscyDBZ1AHXRKYC8D9EiBEBLK7s1YTaZG5RLXxGXx1+bF0/2HE4znNcLQWNn3QJngPM7YL4N8W4C7eimJwuxQ0gCBJkVgliTPIm16go7NZZaDFo=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB4745.eurprd05.prod.outlook.com (20.176.164.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 17:48:01 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 17:48:01 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH] phy: ti: Fix compilation failures without REGMAP
Thread-Topic: [PATCH] phy: ti: Fix compilation failures without REGMAP
Thread-Index: AQHUprEhzJKmBSAO6UCD50bOEXRT1g==
Date:   Mon, 7 Jan 2019 17:48:00 +0000
Message-ID: <20190107174753.GA4051@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB4745;6:6NWAMb4gjmxxWVdRbTHIKPPzv91VFob/BX+rIKFc5A5ZrjI8InQU6DWeQL9t+U6xWAM0A6G0xUN3e976RD3/xRkExo12Hv3sOE420f6zokiSDYzLsBxVKStr6bJ9mh5RsPx1AIE5EvGb9ub60yBePH9KIUIpMFQ3AA5GBdpyKq5tcwwQbCVU+Ers+5BZYVj2s2acAdtpkENz86+/NK881wLXMb9qi9lHzkY5nPbDoOQSAWa/8BDbBRCZLV+TI9byDAv0sdcmggVqtn+4XisWXTW/VaKhp7eZmFA70U+EhIOLObmWkR/DFeNintfVkwYg0NatJclWd+BRb8gRqosvx7tq1HQ61KxAJlLtWUVNHfI8gPgrN1RyKar9I/V8y5aZ0LX1IreL5C4uLUah/js/2icjkvQUD2vzqEz226Ed5mfh6h6K8lJn/nxDYjHpz4xzAVNE2DgpBPOR6UHrbuQ01g==;5:5mZ1JcRQAMLrpoYvE+rdCzjKSB0EZat/uDtagqB39ZxWfWTa3MA5A9vi0FqbKfzEBMWTA1FqJpoPEBFHSX2/cyDtR6lzXHQut/cO3p6RrkL3MtiutON20VAdf9ZgmxVSoBCKEw/AAzBCch/IYIEIgKcQ74UW76vD8ffN1+fd6wBQybVEr43qL+FDt4WMsPIZ2C3BNqjU8/W8yQfJyBVnkQ==;7:FRuZyfkXYlGZB5rEUJLI3LsnBH87VJ5MHGr1iidVUc+HIIqvG2st+Qe44Zh1IoBKG73DimEvvHhC8JkbjD0BfmBsm24+fDMEEOeGacfN4owBjAI9y9XPGSLFWN4MPCU/En/BxF87ucrBKqBES7dOhg==
x-ms-office365-filtering-correlation-id: 868794f6-c1bc-4f2d-94c2-08d674c84447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4745;
x-ms-traffictypediagnostic: HE1PR05MB4745:
x-microsoft-antispam-prvs: <HE1PR05MB4745891A29C6441415217E34CF890@HE1PR05MB4745.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR05MB4745;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4745;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(6486002)(476003)(478600001)(81166006)(14454004)(81156014)(256004)(8676002)(33656002)(8936002)(9686003)(6512007)(4326008)(53936002)(25786009)(26005)(106356001)(305945005)(36756003)(486006)(7736002)(105586002)(2906002)(66066001)(6116002)(186003)(386003)(3846002)(52116002)(5660300001)(6506007)(102836004)(1076003)(97736004)(110136005)(54906003)(316002)(33896004)(575784001)(71200400001)(71190400001)(99286004)(6436002)(68736007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4745;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rsB7wAC1MLiW3mAh2YhuodNMcRh5IP0wHfwWdhX3RNnkMAQv1YxzLNwoDwaWhap06dgE4VoRPdxsGstX4SD8CClMGKZL3TQgcLARZazcwLOZ7qhAykNejoWbWCPKH0QUBBhR0YlG7YCfaOSwuFxfb2A10K4wrRuk1YRQpMmpiiO68hpHngeatVDwEpw58aC5RzDQLlr6dA8l336sNcxx1GiTThoHzXjsiN1tQd/7EDN2BZ6pQhQbrOAWbFdA9X+a6tuMz+r4WE15RPj7t9gYPSELyaruOzI9lGczK1Z04zoAVfjBy+kvZcuN9rAtfuWH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <22D2EC8C8A1B924C933213BB93657527@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868794f6-c1bc-4f2d-94c2-08d674c84447
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 17:48:00.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBkcml2ZXIgcmVxdWlyZXMgcmVnbWFwIG9yIHRoZSBjb21waWxlIGZhaWxzOg0KDQpkcml2
ZXJzL3BoeS90aS9waHktZ21paS1zZWwuYzo0MzoyNzogZXJyb3I6IGFycmF5IHR5cGUgaGFzIGlu
Y29tcGxldGUgZWxlbWVudCB0eXBlIOKAmHN0cnVjdCByZWdfZmllbGTigJkNCiAgY29uc3Qgc3Ry
dWN0IHJlZ19maWVsZCAoKnJlZ2ZpZWxkcylbUEhZX0dNSUlfU0VMX0xBU1RdOw0KDQpBZGQgaXQg
dG8ga2NvbmZpZy4NCg0KU2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFu
b3guY29tPg0KLS0tDQogZHJpdmVycy9waHkvdGkvS2NvbmZpZyB8IDEgKw0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvdGkvS2NvbmZp
ZyBiL2RyaXZlcnMvcGh5L3RpL0tjb25maWcNCmluZGV4IGYxMzdlMDEwNzc2NDYzLi5jNDcwOWVk
N2ZiMGU3MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGh5L3RpL0tjb25maWcNCisrKyBiL2RyaXZl
cnMvcGh5L3RpL0tjb25maWcNCkBAIC04Miw2ICs4Miw3IEBAIGNvbmZpZyBQSFlfVElfR01JSV9T
RUwNCiAJZGVmYXVsdCB5IGlmIFRJX0NQU1c9eQ0KIAlkZXBlbmRzIG9uIFRJX0NQU1cgfHwgQ09N
UElMRV9URVNUDQogCXNlbGVjdCBHRU5FUklDX1BIWQ0KKwlzZWxlY3QgUkVHTUFQDQogCWRlZmF1
bHQgbQ0KIAloZWxwDQogCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgY29uZmlndXJpbmcgb2YgdGhl
IFRJIENQU1cgUG9ydCBtb2RlIGRlcGVuZGluZyBvbg0KLS0gDQoyLjIwLjENCg0K
