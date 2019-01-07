Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A997DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6567C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rR09EKwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfAGSSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:18:00 -0500
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:10976
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728266AbfAGSR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Eob/t91LTbVaeNI8JhC6952Zk3TW1EwJhlanHUc2s=;
 b=rR09EKwTIMwZQLvdLDBcG5wam4UqPVey8NIM3b2h1wnzkun0HO4Sqp/6mVZVL9lYketEloIYtuOtCLDwhulh58aIWlaUCWvYXdkTAYa/7PRs3D3CCmx2vCi83VUPmcvWC9ABzKxdUJ5LGzf5MiWlAOa8Z4Jv+sXxVF1RrsSetik=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB3196.eurprd05.prod.outlook.com (10.170.242.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 18:17:46 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 18:17:46 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] phy: ti: Fix compilation failures without REGMAP
Thread-Topic: [PATCH] phy: ti: Fix compilation failures without REGMAP
Thread-Index: AQHUprEhzJKmBSAO6UCD50bOEXRT1qWkG9wAgAABTYA=
Date:   Mon, 7 Jan 2019 18:17:46 +0000
Message-ID: <20190107181739.GA27929@mellanox.com>
References: <20190107174753.GA4051@ziepe.ca> <20190107181300.GB27783@lunn.ch>
In-Reply-To: <20190107181300.GB27783@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:300:ef::20) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3196;6:DyLo1EcLEWtZTJ+BevUfMCHRota94H8+3YIUxENgrm9NJFjS+f1V8j/pD05iBp8aDCOVwgDNfmA2sTled4WNMm6a0tkNGV9UhIcQUmhwARp3myG7l7M/CSbN04yzDZLQF2Xxkj2j93Lm4BZQV+XLHvwNm0FL9oPIHG9fTn4S5URcQDuBesJhPj9SZMEjVLPC+Zf+wZh96y4hTXs7QQzRd0LnDH17qi4lPLyHu0w+FdDP1uLdBUxg+ZnB8XTLlVYAlFQYTy+n0h01BvgVJqGWL7N0XyICROSO/uijTIf9YhxxXGBzMoqRdc9XpiudooJ4lW6JJtoch24YOPDwm23CbZ6OCaMryeGbleT2aeAFOkdVdzbqgdqvPX78qD1ywZQoGLXJqjRzsKDYw8jJGAjLJYZig6chu13v0a7qamiRcbEJGz/o/gdEDLhYCd/KYfOB7DOtusvf6/YFEbiGcLkG6A==;5:UMkaJp5TR5RrxFyG0+eUdTshFPiZfs6kUTNySMqQbKHFcwCb+8EzNYp0IJyOr3aDzLZNi//ZZ3a37RhgRPkjz8CQTqC8U7lFqtZZa8efKz0c3ah8p3XZMYqcdPJuDPe3smc5Us0XXUi+4pComaNxjzhnfKAFCQN8a6GQrxqVYsv8p69zgpELFPyIRuldoTB2YAn9h3xi1WU3sXfZdaOoXg==;7:J8C2FzOPEb1Yi39ZbQ2c77sc8864Mrfvsa8utxEsmA4RqoxjcBfJM6ox+PU3ZbtDOmcRKx2htiMU7m5znLp+w+KMcxQS9hy7n/pYAsAgwL0zRMqa91sQblRS/81Ox/Z2Rmh0BenXN2CJXBi5TQ4o0A==
x-ms-office365-filtering-correlation-id: 3af45088-f5cc-4b2b-9382-08d674cc6c88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3196;
x-ms-traffictypediagnostic: HE1PR05MB3196:
x-microsoft-antispam-prvs: <HE1PR05MB3196C6DBC5615C5D8B92602CCF890@HE1PR05MB3196.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:HE1PR05MB3196;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3196;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(6436002)(25786009)(6486002)(105586002)(71190400001)(71200400001)(6916009)(97736004)(229853002)(5660300001)(2906002)(68736007)(66066001)(7736002)(305945005)(386003)(2616005)(446003)(76176011)(102836004)(52116002)(26005)(476003)(81166006)(81156014)(6506007)(33656002)(1076003)(478600001)(99286004)(14454004)(186003)(11346002)(486006)(86362001)(8676002)(8936002)(106356001)(256004)(3846002)(316002)(54906003)(6116002)(4326008)(6512007)(6246003)(36756003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3196;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BuOK1rY+QNHbVkrMR+tD0UvCEOxaj8429jXzj1Y7rXzCwYftcFclQQQBZZVVPtdaf/ugWEqhvV67PAqWnTUSBe3d9djzp+RN/VjaCgX6XqDeDC1xt4AhODEFhK/imWxT3NVPCEJT24Jn2v4kx5+P+Na5aZOBm+yD4XJBpeMi2A0gtGwJ+YNtd/a8ixP2DzfGODBBKBCSrzIKpup1CUwvizB+MHSgO5akh9LWjfu87t7o3hoPqZeFjOFGAqNpaB7sh6sv9KGin2E9KL1Z5qLCRW/1/eDHETGuoITR0PTf/RbPMgPSlvmiQ/2Fm62x/AOi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <08032C4DFCABE748AB6390B771F89860@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af45088-f5cc-4b2b-9382-08d674cc6c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 18:17:46.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMDcsIDIwMTkgYXQgMDc6MTM6MDBQTSArMDEwMCwgQW5kcmV3IEx1bm4gd3Jv
dGU6DQo+IE9uIE1vbiwgSmFuIDA3LCAyMDE5IGF0IDA1OjQ4OjAwUE0gKzAwMDAsIEphc29uIEd1
bnRob3JwZSB3cm90ZToNCj4gPiBUaGlzIGRyaXZlciByZXF1aXJlcyByZWdtYXAgb3IgdGhlIGNv
bXBpbGUgZmFpbHM6DQo+ID4gDQo+ID4gZHJpdmVycy9waHkvdGkvcGh5LWdtaWktc2VsLmM6NDM6
Mjc6IGVycm9yOiBhcnJheSB0eXBlIGhhcyBpbmNvbXBsZXRlIGVsZW1lbnQgdHlwZSDigJhzdHJ1
Y3QgcmVnX2ZpZWxk4oCZDQo+ID4gICBjb25zdCBzdHJ1Y3QgcmVnX2ZpZWxkICgqcmVnZmllbGRz
KVtQSFlfR01JSV9TRUxfTEFTVF07DQo+ID4gDQo+ID4gQWRkIGl0IHRvIGtjb25maWcuDQo+IA0K
PiBIaSBKYXNvbg0KPiANCj4gSXQgbG9va3MgbGlrZSBtb3JlIG9mIHRoZSBUSSBkcml2ZXJzIG5l
ZWQgUkVHTUFQLCBidXQgZG9uJ3Qgc2VsZWN0IGl0Lg0KPiBJIGFzc3VtZSB5b3UgYXJlIHVzaW5n
IENPTVBJTEVfVEVTVCwgc2luY2UgVElfQ1BTVyBzZWxlY3RzIFJFR01BUD8NCg0KWWVzLCB0aGlz
IGNhdXNlcyBDT01QSUxFX1RFU1Qga2VybmVscyB0byBmYWlsLg0KDQpKYXNvbg0K
