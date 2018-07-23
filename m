Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E384ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798FF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2URGSIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798FF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbeGWNih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:37 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:5696
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388494AbeGWNig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBCcJF/E8HVJyZPoJxYbxeTp7VgkKzncWMidMNKDOVk=;
 b=a2URGSIteVuFLMeSkiD9zkDRiRc89pmev3yAvNkESkMpMZVgucDOUcghcE27mWyv5JVhhkRRZ7diN874Bdb/k7to+HXmf9r3CaCmfByAhVgxeR+xaX5AomQDtC0+PYJEo/OLwGco8adNA08IcEzOwaTOHPXZHZ2RfX803pzIZ44=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4241.eurprd04.prod.outlook.com (52.134.126.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Mon, 23 Jul 2018 12:37:31 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 12:37:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUICflRr18LcyxG0i6IDU6xEAg0aSckWaAgAAyIIA=
Date:   Mon, 23 Jul 2018 12:37:31 +0000
Message-ID: <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
         <1532338685.3163.93.camel@pengutronix.de>
In-Reply-To: <1532338685.3163.93.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4241;6:3BWX7aQh59exhPyMSQFjGqV+wyzVaniVkIor/gCI8TA8hhFHpj0m26kBtuiaFkzn/9rzq3aDrNDBrvk42tVSkd15aOpD/3tMsMbLbR7MXBkhfDVRs1Q/Skdcm57hfUEGOo/qLoQsMcteUKZpOXF6V2I88fTU1QAQkiajTwpc36GXr99ut1zSufXxQc936WcPrYTj4z6BOlaAD/N4EoxdJqHB6HBNOtehP/DCoDbxBIboseAedZyA6KL2bh9YDFqAQLs88rk9ltJR7u96Fq2/HfrvBdw+fWx256ftaXiwqTEVTAykiRW6aVr/p4HQ5u4tuPrFFcHn94n0r6kHgE4OSEHLFSKwHyAYRVp4HbZdQqVXC/KE1bQ3F1hxqh38+Xd4NXQQoZgg4F/QiFFWL7aSO7lBbs13OuLXCYn5LxBbrWMdAHuGfQe6nalS6NFxO8eHLjPn/I81Izp+/bC1OcLVVA==;5:jjeWItmwLbYk4WGEY31hl4PxE8lXsv7cYWBwowURL9uUMGS9vZfGygxMmb2aREAp4XJXurF5lMGW57SwzrLDkekoTHoTANj5EU2Cxe71Y7XLP/Osp/kW66ZKqWQsb4w+NTlgJ9fniHY9AFdkwUtkWctYMrPKJIv54VmeVpt7p7A=;7:yB2H8XiZMBqCBZx6zRYJdXJxUa61LC1BdGLFB42LLeSMLjif9X8QYHlGYapTe+mebPjKDd/GexE3K7uUzx470RCuFDF3MF3N9KHqXkxVhm8I38WBHrSXiHpQ1H8vPgxgD+qLAFOPr7NkgNrnTr23JWDT13sgCKMtRr8Od0HwPRInSsVlsUp6A1ReK8JVB7oqmzrvAAzgjj/1L9CKdB3CIxvjL4zOIoCUeG6Il98re5t5ArEMuZIK8ojM0ov5GfqC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f94dafda-876b-49f7-a10c-08d5f0990efa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4241;
x-ms-traffictypediagnostic: AM0PR04MB4241:
x-microsoft-antispam-prvs: <AM0PR04MB4241376C94F7AF5DE23FC6B3EE560@AM0PR04MB4241.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4241;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4241;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(14454004)(66066001)(106356001)(105586002)(2906002)(5250100002)(2501003)(316002)(5660300001)(54906003)(14444005)(86362001)(110136005)(478600001)(99286004)(7736002)(36756003)(305945005)(6636002)(476003)(2616005)(256004)(6506007)(11346002)(68736007)(97736004)(76176011)(26005)(8676002)(81166006)(81156014)(44832011)(486006)(3846002)(6116002)(7416002)(186003)(8936002)(50226002)(102836004)(118296001)(6246003)(4326008)(229853002)(2900100001)(25786009)(39060400002)(446003)(6512007)(53936002)(6486002)(6436002)(99106002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4241;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sIxspjAcIJJpWM3DrVNPnZsqljBpaI33Sy4xrNutLzNBVoaloe/CTtgulKtF4LkojXLya/lREBXqr+qVIckdlCgg2Z9FJUEBYAXVKzKYdfZYR9w9YkrY9JGyHJpZVoQmBPkQtRUrdNhOskUx8F5wG63CodFF+Df8dX0npDTnHO9i26k/RZmxmTrLaEDDo333Vyr1Ek1zqLOyxlzuMBeEhl//FiFCPzZU0wDh3Zn1vf1UcfCZ8u8l/9MjnrRceLhTtwfzUeRpgz4BEVUGQ+Fcma4kz4tjzfcU0tmM0KsadhEiBL1f5Q6juHBXjdKby2rWZ6OvV5aSEQRPeKESPgjEYINr9gnhAPJ47m4bfbwVHWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6323682A8C467347BF1574F1AA7FF72E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94dafda-876b-49f7-a10c-08d5f0990efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 12:37:31.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDExOjM4ICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
SGkgTGVvbmFyZCwNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbiAyMC4wNy4yMDE4LCAxNTo0NyArMDMw
MCBzY2hyaWViIExlb25hcmQgQ3Jlc3RlejoNCj4gPiBPbiBpbXg3ZCB0aGUgcGNpZS1waHkgcG93
ZXIgZG9tYWluIGlzIHR1cm5lZCBvZmYgaW4gc3VzcGVuZCBhbmQgdGhpcyBjYW4NCj4gPiBtYWtl
IHRoZSBzeXN0ZW0gaGFuZyBhZnRlciByZXN1bWUgd2hlbiBhdHRlbXB0aW5nIGFueSByZWFkIGZy
b20gUENJLg0KPiA+IA0KPiA+IEZpeCB0aGlzIGJ5IGFkZGluZyBtaW5pbWFsIHN1c3BlbmQvcmVz
dW1lIGNvZGUgZnJvbSB0aGUgbnhwIGludGVybmFsDQo+ID4gdHJlZS4gVGhpcyB3aWxsIHByZXBh
cmUgZm9yIHBvd2VyaW5nIGRvd24gb24gc3VzcGVuZCBhbmQgcmVzZXQgdGhlIGJsb2NrDQo+ID4g
b24gcmVzdW1lLg0KPiA+IA0KPiA+IENvZGUgaXMgb25seSBmb3IgaW14N2QgYnV0IGEgdmVyeSBz
aW1pbGFyIHNlcXVlbmNlIGNhbiBiZSB1c2VkIGZvcg0KPiA+IG90aGVyIHNvY3MuDQo+ID4gDQo+
ID4gK3N0YXRpYyB2b2lkIGlteDZfcGNpZV9sdHNzbV9kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiArew0KPiA+ICsJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChpbXg2X3BjaWUtPnZhcmlhbnQpIHsN
Cj4gPiArCWNhc2UgSU1YNlE6DQo+ID4gKwljYXNlIElNWDZTWDoNCj4gPiArCWNhc2UgSU1YNlFQ
Og0KPiA+ICsJCXJlZ21hcF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElPTVVY
Q19HUFIxMiwNCj4gPiArCQkJCSAgIElNWDZRX0dQUjEyX1BDSUVfQ1RMXzIsIDApOw0KPiANCj4g
SGFzIHRoaXMgYmVlbiB0ZXN0ZWQgb24gaS5NWDY/IExUU1NNIGRpc2FibGUgcmVxdWlyZXMgYSBt
b3JlIGNvbXBsZXgNCj4gc2VxdWVuY2Ugb24gdGhpcyBTb0MgdG8gYXZvaWQgaGFuZ2luZyB0aGUg
c3lzdGVtLiBTZWUgY29tbWl0DQo+IDNlM2U0MDZlMzgwNyAiUENJOiBpbXg2OiBQdXQgTFRTU00g
aW4gIkRldGVjdCIgc3RhdGUgYmVmb3JlIGRpc2FibGluZw0KPiBpdCIuDQoNClRoaXMgcGF0Y2gg
b25seSBlbmFibGVzIHN1c3BlbmQvcmVzdW1lIGZvciBpbXg3ZCB3aXRoIG90aGVyIFNPQ3MgdG8N
CmZvbGxvdyBsYXRlci4gVGhlIGx0c3NtX2Rpc2FibGUgZnVuY3Rpb24gaXMganVzdCBzeW1tZXRy
aWMgd2l0aA0KbHRzc21fZW5hYmxlLg0KDQpUaGUgNlEgcGFydHMgYXJlIGFmZmVjdGVkIGJ5IGVy
cmF0YSAiRVJSMDA1NzIzIFBDSWU6IFBDSWUgZG9lcyBub3QNCnN1cHBvcnQgTDIgcG93ZXIgZG93
biBbaS5NWCA2RHVhbC82UXVhZCBPbmx5XSIuDQoNClRoaXMgZGVzaWduIGVycm9yIHNlZW1zIHRv
IGhhdmUgdGhlIHNhbWUgcm9vdCBjYXVzZSBhcyB5b3VyIHByb2JsZW0gKG5vDQpkZWRpY2F0ZWQg
cmVzZXQgY29udHJvbCkgc28gdGhpcyB3b3JrcyBvdXQgcXVpdGUgbmljZWx5OiB0aGUgc29sdXRp
b24NCmlzIHRvIG5ldmVyIHBvd2VyIGRvd24gcGNpIG9uIGFmZmVjdGVkIGNoaXBzLg0KDQo+ID4g
K3N0YXRpYyBpbnQgaW14Nl9wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ID4gK3sNCj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9w
Y2llID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlzdHJ1Y3QgcGNpZV9wb3J0ICpwcCA9
ICZpbXg2X3BjaWUtPnBjaS0+cHA7DQo+ID4gKw0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dmFyaWFu
dCAhPSBJTVg3RCkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlpbXg2X3BjaWVfYXNz
ZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiArCWlteDZfcGNpZV9pbml0X3BoeShpbXg2
X3BjaWUpOw0KPiA+ICsJaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsN
Cj4gPiArCWR3X3BjaWVfc2V0dXBfcmMocHApOw0KPiA+ICsNCj4gPiArCXJldCA9IGlteDZfcGNp
ZV9lc3RhYmxpc2hfbGluayhpbXg2X3BjaWUpOw0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJ
cHJfZXJyKCJwY2llIGxpbmsgaXMgZG93biBhZnRlciByZXN1bWUuXG4iKTsNCj4gDQo+IGRldl9l
cnIoKSwgcGxlYXNlLg0KDQpUaGUgaW14Nl9wY2llX2VzdGFibGlzaF9saW5rIGZ1bmN0aW9uIGFs
cmVhZHkgc2VlbXMgdG8gbGluayBlcnJvcg0KaW5mb3JtYXRpb24gc28gdGhlIG1lc3NhZ2UgY291
bGQgYmUgZHJvcHBlZC4gSG93ZXZlciBpdCdzIHN0aWxsIGhlbHBmdWwNCnRvIGtub3cgdGhhdCB0
aG9zZSBwY2kgbGluayBlcnJvcnMgYXJlIHNwZWNpZmljYWxseSByZWxhdGVkIHRvIHJlc3VtZS4N
Cg0KRmFiaW8gc3VnZ2VzdGVkIEkgcHJvcGFnYXRlIHRoZSByZXR1cm4gY29kZSBidXQgSSdtIG5v
dCBzdXJlIHRoYXQncw0KaGVscGZ1bCBzaW5jZSAibGluayBkb3duIiBpcyB3aGF0IGhhcHBlbnMg
d2hlbiB0aGUgc2xvdCBpcyBlbXB0eSBhbmQNCnRoaXMgaXMgY2xlYXJseSBub3QgYSAiZXJyb3Ii
IG9yICJmYWlsdXJlIi4gSXQncyBub3QgY2xlYXIgaWYgInNsb3QNCmVtcHR5IiBjYW4gYmUgZGlz
dGluZ3Vpc2hlZCBpbiBzb21lIHdheS4NCg0KSSdsbCBzd2l0Y2ggdG8gZGV2X2luZm8gYW5kIGRy
b3AgdGhlIGVycm9yIGNvZGUsIGlzIHRoaXMgT0s/DQoNCg0KT25lIGFzcGVjdCB0aGF0IEkgc2tp
cHBlZCBpcyBQTUVfVHVybl9PZmYgc3VwcG9ydDogVGhlIFBDSSBzdGFuZGFyZA0KbWFuZGF0ZXMg
dGhhdCB0aGlzIGlzIHNlbnQgYmVmb3JlIGVudGVyaW5nIEwyL0wzIGFuZCB0aGUgZGVzaWdud2Fy
ZQ0KY29yZSBzdXBwb3J0cyB0aGlzIGJ1dCBpdCdzIG5vdCBwYXJ0IG9mIHRoaXMgcGF0Y2guDQoN
CklzIGl0IGZpbmUgaWYgSSBwb3N0IHRoaXMgc2VwYXJhdGVseSBvciBzaG91bGQgaXQgYmUgcGFy
dCBvZiB0aGUgc2FtZQ0Kc2VyaWVzPyBUaGUgdHVybm9mZiBiaXQgaXMgaW4gSU9NVVggZ3ByIGZv
ciBpbXg2IGJ1dCBTUkMgZm9yIGlteDcgc28gaXQNCndvdWxkIHJlcXVpcmUgYWRkaXRpb25hbCBw
YXRjaGVzIGluIHJlc2V0LCBkdHMgYW5kIHRoZW4gcGNpLg==
