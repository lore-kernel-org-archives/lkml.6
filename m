Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB549C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F93223F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jcs4XN8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F93223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeHJNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:41:26 -0400
Received: from mail-ve1eur01on0047.outbound.protection.outlook.com ([104.47.1.47]:41184
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbeHJNl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgErYSZdJTgYSovNQTkjIrw9frV9K0nrArQ03/iGZfA=;
 b=Jcs4XN8T65TJGoMQaShpJ4YAkeBqm/Of+bF56qzD7JGgQmRf+mN/k/CE1GC2G1YK7bClYQCa6axZsTvD+VcWuxJxuzKIXetidc1i4y1EFH+wkBNzSgFwWYJJJ44pAIhCeuiywRJAAOvdRobFLiYJNNsHBE1Axf/cufqcIKfuweo=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4417.eurprd04.prod.outlook.com (52.135.148.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 10 Aug 2018 11:11:55 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1038.019; Fri, 10 Aug 2018
 11:11:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUI2mAdxFCdwbsIEW0mCMYIbqjI6S1xVuAgAAFxICAAAZagIAALWEAgAAKyQCAAAg6gIAC3TMA
Date:   Fri, 10 Aug 2018 11:11:55 +0000
Message-ID: <52ee6376fa15d3a9a62bcfa5d87173e454ccc024.camel@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
         <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
         <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
         <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
         <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
         <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
         <20180808152741.GA31808@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180808152741.GA31808@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4417;6:+ZnfyV88aj+yz3fBShuq6eUd9dBT3DbP0tjBOD39xbaulNOwcRlLE2l87qKEOPYKthWr8KPu7trBuopu0kuzHY/wvrRoxC/V8eEqF6ClDrwnHPGnPaaFcNoWVsASwSFYYlGJ9Mt7EPa6QdoP+Pu8mAt95e/+WYE1T+z4eBZ/nJ4zOyLrNE5u7XzW7P1aW8b3kLVWxEwDPlEv/uAxI1+KqckgF4XhimS16zpb+hL0wqU8j2S1Zaa5uTK69VpQjwOpxYPXEjz8cmdL53vZvNWh+DkVnCg1SCEDZX0XLM6o52xuRhjtpRexpOM6G9JeUWZ+opt9DSxOjssG16TsDseJwFTUPE4wA3QKLOHZAF7T+oVnZOwTvLiEf3mHg8R3nAa/M4eCJTEsUHjGiE93WZyp1U9P4TvK85rvCbloG05rSYtEmvdvfV9HIcq/anhn9uT/iqdRjGVcweFmfZzlZUul2Q==;5:d4zshMGerCNoLeIEjoWpRXBpAuJ/NnhN/dpfOPz0I1zvJFOVgPXNwAByNjJkg9fhx4AJtCphFvlbI9I6LtbpIXZ2gpjy0sR5YME3XeNfDGRyEoDQaJVoYot1bPW98TrX1hBS/2XfUdcoI2ZvJezjfLaKchlqQ90F7wIUjL31AWo=;7:9EPv2YPWSGXNmMjmc57JpbLZtlFoLG6PuwLJx+JW9PvUeoCUhqSUmkpsswT/YVghEeW93yoF99QpSvpLRITrLyzR+7g3fQdyPVmbpfwgEeNIkoCj9FGhtC0oswyzzk7hse4HKidWdKCGHYhwdPK0dnejtOhDxz+WqOfxSguZkePRdwGmcJKc1YlRpLDtpvWbcHmCfJZG+0V/mwW32Jr/+DzJPM0xxYE/d3cufYclyW2A2jvL71lRRbxFyaVzpGFb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9ca41fc-9e35-4efb-28f7-08d5feb2151e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4417;
x-ms-traffictypediagnostic: AM0PR04MB4417:
x-microsoft-antispam-prvs: <AM0PR04MB441704ABCAB8DC1BD25EDAD6EE240@AM0PR04MB4417.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4417;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4417;
x-forefront-prvs: 07607ED19A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(6246003)(4326008)(39060400002)(81166006)(8676002)(118296001)(81156014)(53936002)(106356001)(229853002)(316002)(6436002)(6512007)(44832011)(478600001)(105586002)(476003)(68736007)(5660300001)(14454004)(486006)(2501003)(8936002)(25786009)(7416002)(2616005)(6486002)(14444005)(2906002)(36756003)(6116002)(97736004)(5250100002)(305945005)(54906003)(99286004)(7736002)(66066001)(50226002)(110136005)(26005)(256004)(76176011)(2201001)(11346002)(102836004)(186003)(446003)(6506007)(93886005)(86362001)(3846002)(2900100001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4417;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u93bnJLulu2EaJg1JRvPwbezNvtxaU1EJlz03QJFPxr4dwBvMshom1QZReTZliwbf23K1FjwilGaWP9MmFYBXUhol612dhNXwdLyGdD87SjpxG6pDqwM7N0yRnzTbfdF8G660AwRuQtO3wOcoZVMCa4HY7IzLNLynkh8D+uZ3gMXnBmTuTQ2Ea1VRL2l2QF/TbAVfSfS/wrAcJGiZC4JunovSC9X/s9oBa+V71sXMPNGQnb5b/oqlMN1P9IFt8mf5Qnz2BedaKJ8hwIfN8/WwfdHoorbjFma0kyP/xx/VxGaAwUVBIqGNZOTQGsja9YtWuZwsMf4BWq/dIYr9a71UFdPYYLMOzcYc+Xj1EatTQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B33ED57CA4CD14A80F852F8D095A070@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ca41fc-9e35-4efb-28f7-08d5feb2151e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2018 11:11:55.3203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTA4IGF0IDE2OjI3ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMDgsIDIwMTggYXQgMDI6NTg6MTVQTSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAxOC0wOC0wOCBhdCAxNToxOSArMDEwMCwgTG9y
ZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEF1ZyAwOCwgMjAxOCBhdCAxMToz
NzoxNEFNICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgMjAx
OC0wOC0wOCBhdCAxMjoxNCArMDEwMCwgTG9yZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiA+
ID4gT24gV2VkLCBBdWcgMDgsIDIwMTggYXQgMTA6NTM6NTJBTSArMDAwMCwgTGVvbmFyZCBDcmVz
dGV6IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gVHVlLCAyMDE4LTA3LTI0IGF0IDE5OjE0ICswMzAw
LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiA+ID4gPiA+IENoYW5nZXMgc2luY2UgdjI6
DQo+ID4gPiA+ID4gPiA+ICAqIFByaW50IHdpdGggZGV2X2luZm8gaWYgbGluayBmYWlscyBvbiBy
ZXN1bWUgKEx1Y2FzKQ0KPiA+ID4gPiA+ID4gPiAgKiBBZGQgYSBjb21tZW50IG9uIGlteDdkIHBj
aSBpcnEgbWFwcGluZ3MgKEFuZHJleSkNCj4gPiA+ID4gPiA+ID4gICogTWFrZSBpbXg2X3BjaWVf
bHRzc21fZGlzYWJsZSBwcmludCBhbiBlcnJvciBvbiBJTVg2USAoTHVjYXMpDQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgbHRzc21fZGlzYWJsZSBkb2VzIG5vdCByZXR1cm4gYW4g
ZXJyb3IgYmVjYXVzZSBpdCBjYW4ndCBiZSB1c2VmdWxseQ0KPiA+ID4gPiA+ID4gPiBoYW5kbGVk
LCByZXZlcnNpbmcgcGFydGlhbCBzdXNwZW5kIGlzIGEgbmlnaHRtYXJlIGFuZCB1bmxpa2VseSB0
byB3b3JrLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gICogRHJvcCAicmVzZXQ6IGlt
eDc6IEZpeCBhbHdheXMgd3JpdGluZyBiaXRzIGFzIDAgKGFjY2VwdGVkIGJ5IFBoaWxpcHApDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBTZXJpZXMgaXMgYWdhaW5zdCBsaW51eC1uZXh0
IHRhZyBuZXh0LTIwMTgwNzI0IHdoZXJlIHRoZSByZXNldCBwYXRjaCB3YXMNCj4gPiA+ID4gPiA+
ID4gYWxyZWFkeSBhY2NlcHRlZC4gVGhlIGlteDdkLmR0c2kgcGF0Y2ggaXMgYWxzbyB1c2VmdWwg
c3RhbmRhbG9uZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBpcyBhIGdlbnRsZSBy
ZW1pbmRlciB0aGF0IHRoaXMgc2VyaWVzIHdhcyByZXZpZXdlZCBieSBMdWNhcyB0d28NCj4gPiA+
ID4gPiA+IHdlZWtzIGFnbyBidXQgbm90IHlldCBpbmNsdWRlZC4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBEb2VzIHRoaXMgc2VyaWVzIGhhdmUgYSBmdW5jdGlvbmFsIGRlcGVuZGVuY3kgb24gdGhl
IHJlc2V0IGZpeCA/IElmIHllcw0KPiA+ID4gPiA+IHdlIGNhbiBoYXZlIGEgYmlzZWN0aW9uIHBy
b3BsZW0gZGVwZW5kaW5nIG9uIHdoaWNoIHRyZWUgZ2V0cyBtZXJnZWQNCj4gPiA+ID4gPiBmaXJz
dC4NCj4gPiA+ID4gDQo+ID4gPiA+IFllcywgd2l0aG91dCB0aGUgcmVzZXQgZml4IEkgZXhwZWN0
IGhhbmdzLg0KDQpUaGlzIG5lZWRzIGZ1cnRoZXIgY2xhcmlmaWNhdGlvbjogd2l0aG91dCB0aGUg
cmVzZXQgcGF0Y2ggdGhpcyB3aWxsDQpoYW5nIG9uIGlteDcgc3VzcGVuZC9yZXN1bWUgYnV0IHRo
aXMgaXMgdGhlIGN1cnJlbnQgYmVoYXZpb3IgYW55d2F5Lg0KDQpCb3RoIHBhdGNoZXMgYXJlIHJl
cXVpcmVkIGZvciBpbXg3IHBjaSBzdXNwZW5kIGFuZCBpbmNsdWRpbmcgdGhlbSBvdXQNCm9mIG9y
ZGVyIHNob3VsZG4ndCBicmVhayB1bnJlbGF0ZWQgZnVuY3Rpb25hbGl0eS4NCg0KU28gaXQgc2hv
dWxkIGFjdHVhbGx5IGJlIGZpbmUgdG8ganVzdCBpbmNsdWRlIHRoZSBwY2kgY2hhbmdlcyBub3cs
DQpyaWdodD8=
