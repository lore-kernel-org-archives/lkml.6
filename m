Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F628C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC62089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TOVEvNwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfAGKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:42:32 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:51172
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbfAGKmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMCNKdI6FSaOqggSUvYSeKfExKR3rHOSs7fWCGOeK7Y=;
 b=TOVEvNwM2hYh+Z1wDkEUdF4AInd/JlwkMADHnqvb6FsJjT7A1DAB+MwMpPtx/3mXPeYSmg1pKu9/kWYDAa52uUHcITvrkeQ8+1AMogCHrSrF9jnWLAcTClMMnU3+wUJPywkMd12vHZe3uHxAY7anqOtlkWaLVOcYCCw/zmX7ssY=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5407.eurprd04.prod.outlook.com (20.178.121.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 10:42:28 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::2872:e6e2:389:f304]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::2872:e6e2:389:f304%2]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 10:42:28 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>
CC:     "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sabyasachi.linux@gmail.com" <sabyasachi.linux@gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
Thread-Topic: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
Thread-Index: AQHUeBG9aOsNgY8inEO6CCK7LJbDS6Wj+zmA
Date:   Mon, 7 Jan 2019 10:42:27 +0000
Message-ID: <2429d30a-97f8-339e-2f80-03f38ae6f61b@nxp.com>
References: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5407;6:fOvhIhiVkjmONKounR1jTzi+35TxQnhKPbURot5fducUPplzKkVJvWYi9S3CWjjHs+Yuqg2KHWVK+W/D5KyJfqVmvKlsuY+QnIRVaVIUA3JqK7ts0GdimV+tYpPJdOHEMTRSGU1OkZU7Djc7d7Cz51oiUZv3AhleBjOqdWWdjlM31Iy7SEmvmIX7IrJIGWiZXTfV70x7Nz4P+vXobanaDg3ohs/PoXYUVSRd40L7DUsgSO143LKhjjmjRKZD1PwBb8YuQo6rsYUnnPOHn8S8zR9hSkVKgzLNfTFTyIzmmdXw87CcMe/VV9RJhthDtzPPltFt2mai0cjH4NPADTDQD9pgaq0CBsepI/zii5qXNT/TZdfVytiQ15oN8ehdtwCLRW6x6hLVv/ybpeS82XMMLFD0kjAgO5XBXr2WB832fzgmxovEBYPE92vbUsDHQftKGc81gcjgj3ohQmcmIdrBVQ==;5:D1zYfWqS82L5eJV99PZEb9YiQsI6Ul4EzQ1yhKpEHayWhcd4YTL+skjOeyfZtBAG3+GFnHY0rYP5ukis7wrQtTPX4cE2PnFCY3XtWyp73ukJCrd7241ck43V9xWfdfN3sYd5HEa3b/B7kVrz/mZcTXCTSN7kz7YbhUyEfQvJx8aRZmL0/ok+0QaeTTBC1OIBfkYnSlJSbtpZdCNrIXxC9Q==;7:P/ozqLbuQ40Os0nhELFaOsoxTtNqwasVRHkxxh2gtsJzhvzJyjngTg+SbtAyQIrFazUKEYe8e0R5bZy6m60Q2JTt4F/vTjiQA6iHAK3+kRcfOHDZ/DuEMRftNBjuODfe0WUgFdsyN4xR5kKxGQad/Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9ca1528-7eb7-427c-5335-08d6748cd1a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5407;
x-ms-traffictypediagnostic: VI1PR04MB5407:
x-microsoft-antispam-prvs: <VI1PR04MB5407E919B48C9F5FC80DADE3EC890@VI1PR04MB5407.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5407;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5407;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(476003)(446003)(11346002)(8676002)(81156014)(81166006)(66066001)(7736002)(14454004)(2906002)(2616005)(486006)(36756003)(229853002)(256004)(53936002)(31686004)(6246003)(44832011)(110136005)(26005)(6486002)(105586002)(6436002)(6512007)(97736004)(8936002)(106356001)(54906003)(25786009)(5660300001)(14444005)(2501003)(4326008)(53546011)(6506007)(68736007)(102836004)(99286004)(3846002)(316002)(71200400001)(71190400001)(39060400002)(186003)(478600001)(305945005)(86362001)(6116002)(31696002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5407;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0nn/dnq/Hj8005j52TxJdRPh4LHi9oolHxoGqD+ij7JD6Ij0Lps791CA4vrGKsoMQvlKqKjRJc1TarZw7l9IOPj5WAp1Hfjb0WOTSLfd/3OcqR8dMmuZuANQ9FnJL3fLGsNoU+Zqo4wvJpHdhp9z8fK3Uw+Q82A+lSBvWdu7JAgfcqAMsJg4qm+09TuVXyRokNb74G/Mgy4ZuPufixKf+UgRnC7Jnb4IbLvtiG13L6TafEqb/nJJPvqCQNtd1RTLRvfBCDDAlSxsU4oX2t6c+S/1w8PNLONzxuwVRMdr9sLiT9SjnTf8DMqV3hpsAYZb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A3EDD1FFF1B924DB34D5C4F0C544900@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ca1528-7eb7-427c-5335-08d6748cd1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 10:42:28.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LjExLjIwMTggMTE6NTEsIEJyYWplc3dhciBHaG9zaCB3cm90ZToNCj4gUmVtb3Zl
IGxpbnV4L2ZzbC9tYy5oIHdoaWNoIGlzIGluY2x1ZGVkIG1vcmUgdGhhbiBvbmNlDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCcmFqZXN3YXIgR2hvc2ggPGJyYWplc3dhci5saW51eEBnbWFpbC5jb20+
DQoNCkFja2VkLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0K
DQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9idXMv
ZnNsLW1jL2RwYnAuYyB8IDEgLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvZnNsLW1jL2RwYnAuYyBiL2RyaXZlcnMvYnVz
L2ZzbC1tYy9kcGJwLmMNCj4gaW5kZXggMTdlM2M1ZDJmMjJlLi45MDAzY2QzNjk4YTUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9kcGJwLmMNCj4gKysrIGIvZHJpdmVycy9idXMv
ZnNsLW1jL2RwYnAuYw0KPiBAQCAtNSw3ICs1LDYgQEANCj4gICAgKi8NCj4gICAjaW5jbHVkZSA8
bGludXgva2VybmVsLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2ZzbC9tYy5oPg0KPiAtI2luY2x1
ZGUgPGxpbnV4L2ZzbC9tYy5oPg0KPiAgIA0KPiAgICNpbmNsdWRlICJmc2wtbWMtcHJpdmF0ZS5o
Ig0KPiAgIA0KPiA=
