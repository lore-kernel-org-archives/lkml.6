Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7477F2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qT3Xxpc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfACKJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:09:46 -0500
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:33358
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfACKJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/zFGc+Jff/pO3PsuxLgdHEyg7YNjLjlN/IobwtprS4=;
 b=qT3Xxpc0yMNL09pL7S1y7bHQy29vs3iYTEFa1IhjR0Wk6zY2QfqYjYKT+gGF0ZsDhqJxLR/lWv/++3U1E95JaiIZp7Ztb5K1Bz+EhNkUV6OJa/tDDN0CszKLnl0nMeWbhQhlJ6sH7TMMGabBn69tOsW+KVg2VNAkVuQT1acDGMQ=
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.50.160) by
 VI1PR04MB4992.eurprd04.prod.outlook.com (20.177.49.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 10:09:39 +0000
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::c5c:ec01:4a6b:5f4b]) by VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::c5c:ec01:4a6b:5f4b%3]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 10:09:39 +0000
From:   Po Liu <po.liu@nxp.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "haustad@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Topic: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Index: AQHUnl7Q0OQhsXkvlE2k4BYXbHWC16WTgwIAgAAAzoCAAQbfAIAAXHywgAd3SICAAO63gIAACTaw
Date:   Thu, 3 Jan 2019 10:09:39 +0000
Message-ID: <VI1PR04MB51351DDF26EB43FEDC9094B6928D0@VI1PR04MB5135.eurprd04.prod.outlook.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com> <87r2e14fgr.fsf@intel.com>
 <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <87k1jm51ey.fsf@intel.com> <20190103091605.GA4597@apalos>
In-Reply-To: <20190103091605.GA4597@apalos>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=po.liu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4992;6:NHe/0Ga45tpBGP7Sh3gDXpRC1bTuPC6wwOR02YgZNPxB6q+AL9V8R9s8vuuK7/FVF8ebOhYJc9GrBsAp6oSpkYi/Bfpr4mGZ84HDjhhOLp9H1ssq7vNw/SepiRAKHIsW2DbW6eHaNsTMUSV5iwrePVcSTG5yQQiVJuDsU+HS++DhE+XBTtaqUfVwYPk7jUi6/c7TeQ5J05/Dam7NRsFPrxTeE0wI5+WdoI1WR63yaFr+/2q6m1UKI2t5xyPL1Azh/Y3arpZRrYNGw5zj+yKHnR8RWhWeXTgTgb3C8QmKE08/8fGV/NsVIuHDJpyKK1HdXYbExSM6WsPesufvOjBvvHQJd9G/YJ1f78xUbQoNFSoXTa9a/fgLFwX0W8OsJftmxrS1ZIwBvfx80tsaSGNqiFjMOQgD5s4D0ZYdoYTqPc1VOGmdl3Ejj6H7S5z+f2jkGytV1FhaTA0R72ymODNAUg==;5:VxUoIxRRsxGu8gd8E9lguCmN1KeuvnwXhZxl9KShLROHCljj2EjSElU4FvfBttvJzuSLFXxEU1yk22ZUDQ1DihdVj3Z4T8vxhYPDoB/tnPCvsACzL19EdF5Rd8cHaTmejaEbp5ILOOrXCxJ9UHOZAi2se9jFH0Lx8PkqVJs8iINTT4ZNU1Odi+owdvLy01ahgQRmbBb16O7XmR+89Fwf+w==;7:9OUBJe6BskSoj8MJZi+25WmY8SWtHEh7bxof31+HF3g8927l7cqf90qQAB7n9bCCWs42K3+iC1XPV2nA8y06E/HyQVf3EmtDyQKjigo+laCOe1O5vAhgpVpvKClB3ShF0xTArPCtGUp61qhb63jzdA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7348774b-ea32-41e2-f49b-08d67163928a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4992;
x-ms-traffictypediagnostic: VI1PR04MB4992:
x-microsoft-antispam-prvs: <VI1PR04MB4992502740D64364C746D5DD928D0@VI1PR04MB4992.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4992;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4992;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(13464003)(199004)(189003)(486006)(105586002)(66066001)(44832011)(6116002)(3846002)(186003)(26005)(106356001)(93886005)(476003)(11346002)(478600001)(446003)(86362001)(33656002)(14454004)(53936002)(55016002)(9686003)(7736002)(81156014)(305945005)(68736007)(81166006)(6436002)(8676002)(8936002)(229853002)(97736004)(2906002)(74316002)(14444005)(256004)(54906003)(102836004)(5660300001)(6246003)(53546011)(110136005)(25786009)(4326008)(6506007)(71200400001)(99286004)(71190400001)(76176011)(7696005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4992;H:VI1PR04MB5135.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MsnQb0xaHT2n8QaUJg+6NEF1ETCM22l9hgVvOgQd53uvqFoyiexBPGdUkPeY8MTS/GloN3qkUd6n/TWeRtEOBS4JDBO45r7Or/9GD2CiJlSoBJWckkYkvN2RxHELIXikxsXGd2f/t3xG8aYBneh1KhR2Kb/p28W2TV2RwLT5+0W/nMytbE9oQjg9GCo44PgJJ6EbSXl9fZazLeimnW7s5j7KD5MOvEqQkZcUO+EI3knORp1Wp8CTorVX+BVjakDBVnNgbp5e2OxNRSc1qtDxAKtwM1U1/sOV67XbIvFarSovZC39kCFgV8UCn3nhxZJS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7348774b-ea32-41e2-f49b-08d67163928a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 10:09:39.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWxpYXMsDQoNCg0KQnIsDQpQbyBMaXUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBJbGlhcyBBcGFsb2RpbWFzIFttYWlsdG86aWxpYXMuYXBhbG9kaW1hc0BsaW5h
cm8ub3JnXQ0KPiBTZW50OiAyMDE5xOox1MIzyNUgMTc6MTYNCj4gVG86IFZpbmljaXVzIENvc3Rh
IEdvbWVzIDx2aW5pY2l1cy5nb21lc0BpbnRlbC5jb20+DQo+IENjOiBQbyBMaXUgPHBvLmxpdUBu
eHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGhhdXN0YWRAY2lzY28uY29tOw0KPiBuaWNv
bGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBNaW5n
a2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbmV0OiB0c246IGFkZCBhbiBuZXRsaW5rIGludGVy
ZmFjZSBiZXR3ZWVuIGtlcm5lbCBhbmQNCj4gYXBwbGljYXRpb24gbGF5ZXINCj4gDQo+IEhpIFBv
LA0KPiANCj4gPiA+IEhpIFZpbmljaXVzLA0KPiA+ID4NCj4gPiA+IFRoYW5rIHlvdSB2ZXJ5IG11
Y2ggZm9yIHlvdXIgZmVlZGJhY2suDQo+ID4gPg0KPiA+ID4gSSBrbm93IHRoZSBDQlMgaXMgdXNl
ZCB0byBiZSBtb3N0IGltcG9ydGFudCBwYXJ0IG9mIEFWQi4gQW5kIHFkaXNjcyBpcyBnb29kDQo+
IHRvb2wgdG8gY29uZmlndXJlIHFvcy4NCj4gPiA+DQo+ID4gPiBCdXQgYXMgeW91IGtub3csIHRo
ZSBUU04gZmFtaWx5IGlzIGEgY2x1c3RlciBvZiBwcm90b2NvbHMgYW5kIG11Y2gNCj4gZXh0ZW5k
aW5nIHRoZSBBVkIuIFRoZSBwcm90b2NvbHMgaGF2ZSBkaWZmZXJlbnQgIGZ1bmN0aW9uYWxpdGll
cyBhbmQgdGhleSBtYXkNCj4gaGF2ZSBtb3JlIHRoYW4gaHVuZHJlZCAgcGFyYW1ldGVycy4gRm9y
IGV4YW1wbGUgTlhQIGxzMTAyOGEgc3VwcG9ydA0KPiBRYnYvUWNpL1FidS9RYXYgYW5kIGFsc28g
dGhlIDgwMjFDQiAobm90IGluY2x1ZGVkIGluIHRoaXMgcGF0Y2ggeWV0KS4NCj4gPiA+DQo+ID4g
PiBTb21lIHByb3RvY29scyB0YXJnZXQgdG8gY29uZmlndXJlIHRoZSB0cmFmZmljIGNsYXNzKGxp
a2UgUWF2IENCUykuDQo+ID4gPiBTb21lIHRvIGNvbmZpZyB0aGUgcG9ydChsaWtlIFFidikuIEJ1
dCBzb21lIGZvciB0aGUgd2hvbGUgZXRoZXJuZXQNCj4gPiA+IGNvbnRyb2xsZXIobGlrZSBRY2ks
IHRoZSBjb250cm9sIGVudHJpZXMgZm9yIHRoZSB3aG9sZSBjb250cm9sbGVyLA0KPiA+ID4gd2hp
Y2ggaW5wdXQgcG9ydHMgYW5kIHdoaWNoIG91dHB1dCBwb3J0cykuDQo+ID4NCj4gPiBSZWFkaW5n
IHlvdXIgZW1haWwsIG5vdyBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCBhIGxpdHRsZSBiZXR0ZXIu
IFlvdQ0KPiA+IGFyZSBpbnRlcmVzdGVkIGluIG11bHRpLXBvcnQgZGV2aWNlcy4gSSBhZG1pdCB0
aGF0IEkgYW0gbm90IHRvbw0KPiA+IGZhbWlsaWFyIHdpdGggaG93IG11bHRpLXBvcnQgZGV2aWNl
cyBhcmUgZXhwb3NlZCBpbiBMaW51eCwgSSB3YXMgb25seQ0KPiA+IGZvY3VzZWQgb24gdGhlIGVu
ZC1zdGF0aW9uIHVzZSBjYXNlcywgdW50aWwgbm93Lg0KPiANCj4gSGF2ZSB5b3UgY29uc2lkZXJl
ZCBhIHN3aXRjaGRldi1iYXNlZCBkcml2ZXIgZm9yIG11bHRpLXBvcnQgZGV2aWNlcz8NCltQb10g
WWVzLCB0aGUgcGF0Y2ggaXMgaW5jbHVkaW5nIHRoZSBzd2l0Y2hkZXYtYmFzZWQgZHJpdmVyLiBJ
biBmYWN0LCB3ZSBoYXZlIGRyaXZlciBleGFtcGxlcyBmb3IgIGxzMTAyOCB3aGljaCBpbmNsdWRl
IGVuZC1zdGF0aW9uIElQIGFuZCBzd2l0Y2ggcG9ydHMgSVAsIHdpdGggdGhpcyBpbnRlcmZhY2Ug
ZHJpdmVyLCBpdCBpcyB3b3JraW5nLiBCdXQgd2UgbmVlZCB0byBhZGQgYmFzZSBldGhlcm5ldCBk
cml2ZXIgb2YgRU5FVEMoZW5kIHN0YXRpb24pIGFuZCBGRUxJWChzd2l0Y2gpIHVwc3RyZWFtIGZp
cnN0LCB0aGVuIGFkZCB0aGUgVFNOIGRyaXZlciB1cHN0cmVhbS4NCg0KPiBXaGF0IHlvdSBhc2sg
b2YgVFNOIGNvbmZpZ3VyYXRpb24gaXMgY3VycmVudGx5IGRvYWJsZSB3aXRoIHN3aXRjaCBzd2l0
Y2hkZXYNCj4gZm9yIFZMQU5zIGFuZCBvdGhlciBzaW1pbGFyIG5ldHdvcmtpbmcgZnVuY3Rpb25h
bGl0eS4NCltQb10gSSB0aGluayB0aGUgVkxBTiBjb25maWd1cmUgaXMgbm90IGNvbmZsaWN0IHdp
dGggdGhlIFRTTi4gVFNOIGlzIGV4dGVuZGluZyB0aGUgODAyMVEuIFRTTiBjb25maWd1cmUgdGhl
IHNldHRpbmcgb2YgZmlsdGVyIGZyYW1lIG9yIHNjaGVkdWxpbmcgYmV0d2VlbiBUQy4gQnV0IG1h
eWJlIG5lZWQgdG8gY29uc2lkZXIgYXMgd2hvbGUgYXMgeW91IHNhaWQuICANCj4gDQo+IEluc3Rl
YWQgb2YgcmV3cml0aW5nIHRoaXMgZnJvbSBzY3JhdGNoLCB3ZSBub3QgZXh0ZW5kIHRoZSBjdXJy
ZWN0IFRDIGFuZA0KPiBzd2l0Y2hkZXYgZnVuY3Rpb25hbGl0eSBmb3IgdGhhdCA/DQoNCltQb10g
WWEsIHRoZXJlIGFyZSBvcGVyYXRpb25zIG9mIHN3aXRjaGRldi4gWW91IG1heSB0aGluayB0aGF0
IHRvIGFkZCB0aGUgVFNOIGNvbmZpZ3VyYXRpb25zIG9wcyBpbnRvIHN3aXRjaGRldiBvcGVyYXRp
b25zLiBCdXQgIHdlIG5lZWQgdG8gY29uc2lkZXIgdGhlIGVuZC1zdGF0aW9uIGRldmljZXMgYW5k
IHN3aXRjaCBhbGwgaW4gdGhlIGRldmljZXMgb3IgaW4gdGhlIFRTTiBkb21haW4uIFRoZSBUU04g
ZG9tYWluIGlzIHRoZSBkZXZpY2VzIGluY2x1ZGUgVFNOIGNhcGFiaWxpdGllcyBwb3J0cywgZm9y
IHVwIGxheWVyLCB3ZSBuZWVkIHRvIHByb3ZpZGUgYSBmb3JtYWwgaW50ZXJmYWNlLiBTbyB0c24g
Y29uZmlndXJlIGNhbiBiZSBzdGFuZGFsb25lLiAgDQpJbiB0aGlzIHBhdGNoLCB3ZSB0cmVhdCB0
d28ga2luZHMgb2YgcG9ydHMgd2hlbiByZWdpc3RlcmluZyB0aGUgcG9ydHMsIGVuZC1zdGF0aW9u
IG9yIHN3aXRjaC4gVGhpcyBtYXkgdHJlYXQgdGhlbSBpbiBzb21lIG1pbm9yIGRpZmZlcmVuY2Vz
IGluIFRTTiBzcGVjIGFuZCBkcml2ZXJzLg0KDQo+IA0KPiANCj4gUmVnYXJkcw0KPiAvSWxpYXMN
Cg==
