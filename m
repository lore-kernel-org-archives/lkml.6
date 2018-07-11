Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D73208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MkC9Di71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D73208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbeGKKUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:20:49 -0400
Received: from mail-he1eur01on0072.outbound.protection.outlook.com ([104.47.0.72]:52704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeGKKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0bA0DFRughGSDpCGyl/byRUS/AuYk9YwmCoHN8E/nk=;
 b=MkC9Di71M3z6xOhTKc7+IyHZ2FKYhRPXxSphDSl8gXzSw5UBOo6IAEu1DI1Klhe6XMzp77jfnZVPO+SSo96QV3lH/U0dK5TlaDJdEdgyA3cDc6voCqC7p76gK8MdvFV3616/FQJW1O5s+L94Ouohyt6GhnCIdqo3JdwNXOkdYh8=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5009.eurprd04.prod.outlook.com (20.177.40.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 10:17:11 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4%2]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 10:17:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cyndis@kapsi.fi" <cyndis@kapsi.fi>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: core: Potentially free connection id
Thread-Topic: [PATCH] clk: core: Potentially free connection id
Thread-Index: AQHUGPAtJXuJo+2v2Ui4sqqrL4HxSKSJzscA
Date:   Wed, 11 Jul 2018 10:17:10 +0000
Message-ID: <4b809427e9b922ba41efafb20a97e0698e9cd3d0.camel@nxp.com>
References: <20180711082104.27955-1-mperttunen@nvidia.com>
In-Reply-To: <20180711082104.27955-1-mperttunen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5009;7:j2nKMsHVHVUHvYGCm0E2B/KX3Yh5Id8oj/F1rX8+S9oA+th0SSVQAmz4mkqhjE5mf4TDAOLMj3sRRLGGTgCjE4HqSllYDOtxiHDA7KEe3oVT3/eVYngSV/AUWhgVr7UPPt8VuY0JSkZWMiZSWyQOvt06BZ2BZ69il5Q2iptvV44GOOo6JWo1A4/1qm7xfD4jghvqXUtpNYyddA7HX3s9VEW80GAA79l7JNORMp5WjADsM9dAL1Pk2+7t6seZ9Fil
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 59716cd2-af98-4dbe-406b-08d5e7177705
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5009;
x-ms-traffictypediagnostic: AM0PR04MB5009:
x-microsoft-antispam-prvs: <AM0PR04MB5009D1430B40BA5FBEC05F03EE5A0@AM0PR04MB5009.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5009;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5009;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(6506007)(68736007)(50226002)(118296001)(186003)(6246003)(76176011)(5250100002)(8936002)(102836004)(478600001)(5660300001)(2501003)(26005)(86362001)(2900100001)(229853002)(8676002)(6486002)(316002)(6116002)(6512007)(3846002)(105586002)(99286004)(53936002)(106356001)(2201001)(6436002)(110136005)(25786009)(36756003)(305945005)(14454004)(97736004)(66066001)(54906003)(4326008)(7736002)(44832011)(486006)(256004)(81156014)(81166006)(2906002)(11346002)(446003)(476003)(2616005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5009;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C6/Gh9d6plwzIBVBSUGZ2GSdZYQi96dZyvMTnFvNvOKyQfOjL/eAgBySrW2ArVLKj03Afh4x1U54wbFQIsO5L6DvIpuuey1+/cT3PvGGKVOtXPLAvRcRXvjj2OwEkbgmYMbk6GiGxTddjsQSxtoHAzXm9ubjhdmlKTXmoqqWO4ZBGHAIZH2+J+OVljoN8Yb3UitKFNrUfnhmryaIf2JoBhOXio7WCSRgsa6hZdREvjGCLQ7xsVMK8hLaqQfAJzQ2H97xOhHU0yRo+X1sVeUaVGPE9QuNuyxq+gRuQPEcmBiNztkUWBhXdEH6CxduwXhAaHKeeiFQZusSXpR9IYrBaKcOl2OBemAnRe345W2mBOw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5355474DE6AD9418ACA85E2D3AB4072@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59716cd2-af98-4dbe-406b-08d5e7177705
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 10:17:10.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTExIGF0IDExOjIxICswMzAwLCBNaWtrbyBQZXJ0dHVuZW4gd3JvdGU6
DQo+IFBhdGNoICJjbGs6IGNvcmU6IENvcHkgY29ubmVjdGlvbiBpZCIgbWFkZSBpdCBzbyB0aGF0
IHRoZSBjb25uZWN0b3INCj4gaWQgKGNvbl9pZCkgaXMga3N0cmR1cF9jb25zdCdlZCB0byBjYXRl
ciB0byBkcml2ZXJzIHRoYXQgcGFzcyBub24tDQo+IGNvbnN0YW50IGNvbm5lY3Rpb24gaWRzLiBU
aGUgcGF0Y2ggYWRkZWQgdGhlIGNvcnJlc3BvbmRpbmcNCj4ga2ZyZWVfY29uc3QNCj4gdG8gX19j
bGtfZnJlZV9jbGssIGJ1dCBzdHJ1Y3QgY2xrJ3MgY2FuIGJlIGZyZWVkIGFsc28gdmlhIF9fY2xr
X3B1dC4NCj4gQWRkIHRoZSBrZnJlZV9jb25zdCBjYWxsIHRvIF9fY2xrX3B1dCBhbmQgYWRkIGNv
bW1lbnRzIHRvIGJvdGgNCj4gZnVuY3Rpb25zIHRvIHJlbWluZCB0aGF0IHRoZSBsb2dpYyBpbiB0
aGVtIHNob3VsZCBiZSBrZXB0IGluIHN5bmMuDQo+IA0KPiBGaXhlczogMjUzMTYwYThhZDA2ICgi
Y2xrOiBjb3JlOiBDb3B5IGNvbm5lY3Rpb24gaWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtrbyBQ
ZXJ0dHVuZW4gPG1wZXJ0dHVuZW5AbnZpZGlhLmNvbT4NCg0KWWVzLCBzb3JyeSBJIG1pc3NlZCB0
aGlzLg0KDQpSZXZpZXdlZC1ieTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhw
LmNvbT4NCg0KTWF5YmUgYSBzdGF0aWMgX19jbGtfZnJlZV9tZW0gZnVuY3Rpb24gY291bGQgYmUg
Y3JlYXRlZCBpbnN0ZWFkIG9mDQpjb21tZW50cyBhc2tpbmcgdG8ga2VlcCB0aGluZ3MgaW4gc3lu
Yz8gQnV0IHRoZXJlIGFyZSBvbmx5IDIgbGluZXMgc28NCml0J3MgZmluZS4=
