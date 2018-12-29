Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B09320873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LxGRg6t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeL2CAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:00:06 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:17005
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbeL2CAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7kEP5+XAHhL7zD4vpvFzwTh7QuKv0K2e1jgFtIuUT4=;
 b=LxGRg6t8hiAHZzVWbfYzPsO0MeI3to/3cVb0wLUMGgySgRBFnRPZis/AW1dchbE07TtbVy1iNSKUPyibsaEYJLAmCfJAGVUhqGUICazUKEjCC1XXVqj6+EaPeEPStI8XY3sgCIN+G+VnZFRcIpetFJpHpnBt6mMkJ8wcNJqeZEA=
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.50.160) by
 VI1PR04MB4461.eurprd04.prod.outlook.com (20.177.53.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 01:59:58 +0000
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::8483:4806:c363:3c21]) by VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::8483:4806:c363:3c21%3]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 01:59:58 +0000
From:   PO LIU <po.liu@nxp.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "haustad@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Topic: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Index: AQHUnl7Q0OQhsXkvlE2k4BYXbHWC16WTgwIAgAAAzoCAAQbfAIAAXHyw
Date:   Sat, 29 Dec 2018 01:59:58 +0000
Message-ID: <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com> <87r2e14fgr.fsf@intel.com>
In-Reply-To: <87r2e14fgr.fsf@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=po.liu@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4461;6:y1bLYjS5e7kyanEXuhjtmBWYd9mHG558/psxyQzyvqAZk7mYrgTPOoPhYKBCG6xSBBFgptdgSwIqITb1oyeO85wYLL4nDLiJhv9Ssrc9OG2sPSYLAZG2vJJ9qBzK2l1uR03G5s5zTodUOs4kVA4zayojxDgP98vkLUeBsgrCY9q2hcrk9OHCg6dvBOm8SHVAAIHfMba5x1TD0Qje9+j5rfoegBX8+X8kO++zgAsGWXPHloH7sN03Z/AgQIhLKNuSElWTE767djWZGA1tCLvYLV+1dJV0L7a4Cxrhd4ICgqav2bsQDPn3T+ebhVxxSVj75yTNuSV/xcchr0xEOyOI0DzwP/hjCq9GWmfu/vgqDDq82jaYc/PsndL/K45C/0OvOiE+4iehsm4PXJ+DZv3bXt81zRIpfBmZNZGMFzv/q/UxBHWN4E1G/bNe451oEIMpR6JWwp/dLifA0CZzWwEvVw==;5:vtOIUsLzBzLpiDjFh8wy9HPB8Yp7UqqKhmuFkFaDpfgGyJb+v2xPPzS3fW7dcHo3j85/UEGWoQ8oDnnZk3Mx/4GaV2GFU3480odjDsG6dF5p8U1AmFANMNvN7zGRgOb7W6Iy1nU6D55UhFXswjQBglAWv/MRrcMaCNWmjLrU89o=;7:SYhJZ2yYpCd4xsvlLALb90tQR5jzFuX/S4lOBsZUlmbIOQ66iSTTq5lrmcR4+OPhmR+Gxz43yf/UTVgML6nzGKb9fZJCSLZZG5LRf7qS31rT0oQt7DcH/rVihVWKtpO7pYVADuyz00uj06ZWEfdmAA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c8318f2f-180f-43b7-135c-08d66d3155fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4461;
x-ms-traffictypediagnostic: VI1PR04MB4461:
x-microsoft-antispam-prvs: <VI1PR04MB446112BB1CDB7F943A6C142292B00@VI1PR04MB4461.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4461;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(13464003)(316002)(14454004)(105586002)(106356001)(478600001)(4326008)(2906002)(966005)(3846002)(74316002)(110136005)(25786009)(54906003)(6116002)(8936002)(14444005)(5660300001)(81156014)(486006)(81166006)(256004)(66066001)(561944003)(33656002)(71190400001)(6306002)(9686003)(71200400001)(2501003)(7696005)(53346004)(6506007)(6246003)(305945005)(229853002)(7736002)(76176011)(8676002)(45080400002)(6436002)(99286004)(55016002)(86362001)(446003)(68736007)(102836004)(97736004)(53936002)(575784001)(2201001)(11346002)(26005)(476003)(186003)(53546011)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4461;H:VI1PR04MB5135.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: giAh9+g4DVoVLaV6XhQKerIZb7ZRQL2jF0MPCShHPU0FGw3ttXoXtsYkF1pW1z9+OByhShy3qU4vPA4RqwbcmMCBxhdX6kadTXqj+PU53gGd758nQxFvMF2nAp3gcEFecgd1SHdvhlFhGhyZMzyovLO42ilWiP5BT5K7Ze6zZhu/HI0EZpzRCcJRDZzUqGPmnZaxAJK1FLJwiZB/FC67XVXiMU2P7ssuD0LLHM+7DYYqQ2E9NBZPnjyEFWc4J/CFWcbtd8lwuDiipwU71NhjkIUPNJ0xPsEStglyHwjtuhuKQHGPJoBrFGRMXex05h0Q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8318f2f-180f-43b7-135c-08d66d3155fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 01:59:58.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluaWNpdXMsDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZmVlZGJhY2suDQoN
Ckkga25vdyB0aGUgQ0JTIGlzIHVzZWQgdG8gYmUgbW9zdCBpbXBvcnRhbnQgcGFydCBvZiBBVkIu
IEFuZCBxZGlzY3MgaXMgZ29vZCB0b29sIHRvIGNvbmZpZ3VyZSBxb3MuIA0KDQpCdXQgYXMgeW91
IGtub3csIHRoZSBUU04gZmFtaWx5IGlzIGEgY2x1c3RlciBvZiBwcm90b2NvbHMgYW5kIG11Y2gg
ZXh0ZW5kaW5nIHRoZSBBVkIuIFRoZSBwcm90b2NvbHMgaGF2ZSBkaWZmZXJlbnQgIGZ1bmN0aW9u
YWxpdGllcyBhbmQgdGhleSBtYXkgaGF2ZSBtb3JlIHRoYW4gaHVuZHJlZCAgcGFyYW1ldGVycy4g
Rm9yIGV4YW1wbGUgTlhQIGxzMTAyOGEgc3VwcG9ydCBRYnYvUWNpL1FidS9RYXYgYW5kIGFsc28g
dGhlIDgwMjFDQiAobm90IGluY2x1ZGVkIGluIHRoaXMgcGF0Y2ggeWV0KS4NCg0KU29tZSBwcm90
b2NvbHMgdGFyZ2V0IHRvIGNvbmZpZ3VyZSB0aGUgdHJhZmZpYyBjbGFzcyhsaWtlIFFhdiBDQlMp
LiBTb21lIHRvIGNvbmZpZyB0aGUgcG9ydChsaWtlIFFidikuIEJ1dCBzb21lIGZvciB0aGUgd2hv
bGUgZXRoZXJuZXQgY29udHJvbGxlcihsaWtlIFFjaSwgdGhlIGNvbnRyb2wgZW50cmllcyBmb3Ig
dGhlIHdob2xlIGNvbnRyb2xsZXIsIHdoaWNoIGlucHV0IHBvcnRzIGFuZCB3aGljaCBvdXRwdXQg
cG9ydHMpLg0KDQpTbyBJIGRvIHRoaW5rIGFsbCB0aGUgVFNOIGNvbmZpZ3VyYXRpb24gc2hvdWxk
IG5vdCBtaXggaW4gdGhlIGV0aGVybmV0IGRyaXZlciBpdHNlbGYuIEkgbWVhbiB0aGUgZHJpdmVy
IHNob3VsZCBzZXBhcmF0ZSBhIHh4eF90c24uYyhmb3IgSTIxMCwgbWF5IGlnYl90c24uYykgdG8g
bWFpbnRhaW4gdGhlIHRzbiBvcGVyYXRpb25zLiANCg0KQXMgZmFyIGFzIHVzaW5nIHFkaXNjcyBv
ciB0aGUgaW50ZXJmYWNlIG9mIGdlbmVyaWMgbmV0bGluay4gSSB0aGluayBib3RoIGNvdWxkIGNv
bmZpZ3VyaW5nIHRoZSBUU04gcHJvdG9jb2xzIGludGVyZmFjZSBsYXllci4gSnVzdCB3aGF0IEkg
cHJvdmlkZWQgdGhlIHBhdGNoIG5ldC90c24vZ2VubF90c24uYy4gQnV0IEkgZG8gYmVsaWV2ZSBp
dCBpcyBiZXR0ZXIgdXNpbmcgYSBzdGFuZGFsb25lIFRTTiBtaWRkbGUgbGF5ZXIgdG8gbWFpbnRh
aW4gdGhlIFRTTiBjYXBhYmlsaXR5IHBvcnRzLiBCZWNhdXNlIHRoZSBUU04gcG9ydHMgaW5jbHVk
ZSBub3Qgb25seSB0aGUgZW5kIHN0YXRpb24gYW5kIGFsc28gdGhlIHN3aXRjaC4gTFMxMDI4IGlz
IHN1Y2ggYSBraW5kIG9mIGRldmljZS4NCg0KQW5kIHlvdXIgYWR2aXNlcyBhcmUgcHJlY2lvdXMg
Zm9yIHVzLiBMZXQncyBtYWtlIG91dCBhbiBlYXN5IGFuZCBmbGV4aWJsZSBpbnRlcmZhY2UgZm9y
IFRTTi4NCg0KQnIsDQpQbyBMaXUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBWaW5pY2l1cyBDb3N0YSBHb21lcyBbbWFpbHRvOnZpbmljaXVzLmdvbWVzQGludGVsLmNv
bV0NCj4gU2VudDogMjAxOMTqMTLUwjI5yNUgMzozMA0KPiBUbzogUE8gTElVIDxwby5saXVAbnhw
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBoYXVzdGFkQGNpc2NvLmNvbTsgbmlj
b2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
TWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFphbmcNCj4gPHJveS56YW5nQG54
cC5jb20+OyBQTyBMSVUgPHBvLmxpdUBueHAuY29tPjsgUE8gTElVIDxwby5saXVAbnhwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbmV0OiB0c246IGFkZCBhbiBuZXRsaW5rIGludGVyZmFj
ZSBiZXR3ZWVuIGtlcm5lbCBhbmQNCj4gYXBwbGljYXRpb24gbGF5ZXINCj4gDQo+IEhpLA0KPiAN
Cj4gUE8gTElVIDxwby5saXVAbnhwLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBUaGlzIHBhdGNoIHBy
b3ZpZHMgbmV0bGluayBtZXRob2QgdG8gY29uZmlndXJlIHRoZSBUU04gcHJvdG9jb2xzIGhhcmR3
YXJlcy4NCj4gPiBUU04gZ3VhcmFudGVlZCBwYWNrZXQgdHJhbnNwb3J0IHdpdGggYm91bmRlZCBs
b3cgbGF0ZW5jeSwgbG93IHBhY2tldA0KPiA+IGRlbGF5IHZhcmlhdGlvbiwgYW5kIGxvdyBwYWNr
ZXQgbG9zcyBieSBoYXJkd2FyZSBhbmQgc29mdHdhcmUgbWV0aG9kcy4NCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgaGF2aW5nIGFub3RoZXIgd2F5IHRvIGNvbmZpZ3VyZSBUU04gZmVhdHVyZXMgaXMgYSBn
b29kIGlkZWEuIFdlDQo+IGFscmVhZHkgaGF2ZSB0aGUgQ0JTL0VURi90YXByaW8gZmFtaWx5IG9m
IHFkaXNjcywgdGhhdCBwcm92aWRlIChvciB3aWxsIGluIHRoZQ0KPiBuZWFyIGZ1dHVyZSwgbW9y
ZSBvbiB0aGlzIGxhdGVyKSBhIHdheSB0byBjb25maWd1cmUgdGhlIGhhcmR3YXJlLg0KPiANCj4g
QSBsaXR0bGUgYmFja2dyb3VuZCBvbiB0aGUgY2hvaWNlIG9mIHFkaXNjcyBhcyBhbiBpbnRlcmZh
Y2UgKGFuZCB3aHkgd2UgY2FtZSB0bw0KPiBiZWxpZXZlIHRoZXkgYXJlIGEgZ29vZCBhYnN0cmFj
dGlvbiksIHRoZXkgYWxyZWFkeSBwcm92aWRlIGEgd2F5IHRvIG1hcA0KPiBwYWNrZXRzIGludG8g
dHJhZmZpYyBjbGFzc2VzIChpdCBpc24ndCBjbGVhciBpbiBvdXIgcHJvcG9zYWwgaG93IHlvdSBk
byB0aGF0LCBidXQgSQ0KPiB0aGluayB5b3UgYXJlIHVzaW5nIHNvbWV0aGluZyBsaWtlIG1xcHJp
byksIHRoZXkgcHJvdmlkZSBhIG5lYXQgd2F5IHRvDQo+ICJjb21wb3NlIiAoYnkgaW5zdGFsbGlu
ZyBvbmUgdW5kZXIgYW5vdGhlciksIHRoZXkgYWxyZWFkeSBoYXZlIGEgdXNlciBmYWNpbmcNCj4g
QVBJIHdpdGggdmFyaW91cyBjb3VudGVycywgYW5kIHZlcnkgaW1wb3J0YW50bHkgZm9yIFRTTiB0
aGV5IGhhdmUgbWVjYW5pc21zDQo+IHRvIG9mZmxvYWQgc29tZSBvZiB0aGVpciB3b3JrIHRvIHRo
ZSBoYXJkd2FyZS4NCj4gDQo+IEkgc3VnZ2VzdCBpcyBmb3IgeW91IHRvIHRha2UgYSBsb29rIGF0
IGhvdyBDQlMgb2ZmbG9hZGluZyB3YXMgaW1wbGVtZW50ZWQgZm9yDQo+IHRoZSBJbnRlbCBpMjEw
Og0KPiANCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRnBhdGNoDQo+IHdvcmsub3psYWJzLm9yZyUyRmNvdmVyJTJGODI0
NjI2JTJGJmFtcDtkYXRhPTAyJTdDMDElN0Nwby5saXUlNDBuDQo+IHhwLmNvbSU3QzEwN2U2OTMz
MjYyMTQ5MDBjZjA3MDhkNjZjZmFkYWNlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmMNCj4gZDk5YzVj
MzAxNjM1JTdDMCU3QzAlN0M2MzY4MTYyMjIwMDkzMTA0NDUmYW1wO3NkYXRhPTZPMXMlMkJkJQ0K
PiAyQmJOZWsxS283YTVldjB0eGl3OFM2VGlWZVVyVVdabE9YRG5BdyUzRCZhbXA7cmVzZXJ2ZWQ9
MA0KPiANCj4gUGF0Y2hlcyA0IGFuZCA1IHNob3VsZCBiZSB0aGUgaW50ZXJlc3Rpbmcgb25lcy4g
SSB0aGluayB5b3UgY2FuIHVzZSB0aGVtIGFzDQo+IGluc3BpcmF0aW9uIGZvciBlbmFibGluZyBD
QlMgb2ZmbG9hZCBpbiB5b3VyIGRyaXZlci4NCj4gDQo+IElmIHlvdSBkaWQgdGFrZSBhIGxvb2sg
YXQgdGhvc2UgcGF0Y2hlcyAoYW5kIHRoZSBjdXJyZW50IHdvcmsgdGhhdCBoYXMgYmVlbg0KPiB1
cHN0cmVhbWVkKSwgbXkgcXVlc3Rpb24gdGhlbiBiZWNvbWVzLCB3aGF0IGFyZSB0aGUgcmVhc29u
cyB0aGF0IGl0IG1pZ2h0DQo+IG5vdCB3b3JrIGZvciB5b3VyIHVzZSBjYXNlcz8NCj4gDQo+ID4N
Cj4gPiBUaGUgdGhyZWUgYmFzaWMgY29tcG9uZW50cyBvZiBUU04gYXJlOg0KPiA+DQo+ID4gMS4g
VGltZSBzeW5jaHJvbml6YXRpb246IFRoaXMgd2FzIGltcGxlbWVudCBieSA4MDIxQVMgd2hpY2gg
YmFzZSBvbiB0aGUNCj4gPiAgICBJRUVFMTU4OCBwcmVjaXNpb24gVGltZSBQcm90b2NvbC4gVGhp
cyBpcyBjb25maWd1cmVkIGJ5IHRoZSBvdGhlciB3YXkNCj4gPiAgICBpbiBrZXJuZWwuDQo+ID4g
ICAgODAyMUFTIG5vdCBpbmNsdWRlZCBpbiB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gMi4gU2NoZWR1
bGluZyBhbmQgdHJhZmZpYyBzaGFwaW5nIGFuZCBwZXItc3RyZWFtIGZpbHRlciBwb2xpY2luZzoN
Cj4gPiAgICBUaGlzIHBhdGNoIHN1cHBvcnQgUWJ2L1FjaS4NCj4gDQo+IEkgYW0gd29ya2luZyBv
biBhIHByb3Bvc2FsIGZvciB0aGUgQVBJIGZvciBRYnYgKGFuZCBRYnUpIG9mZmxvYWRpbmcgdXNp
bmcNCj4gdGFwcmlvLiBJIHNob3VsZCBzZW5kIGl0IHNvb24taXNoLiBZb3VyIGZlZWRiYWNrIHdv
dWxkIGJlIHZlcnkgd2VsY29tZS4NCj4gDQo+IEFsc28sIGhvdyB0byBleHBvc2UgaW4gdGhlIHFk
aXNjcyB0aGUgcGVyLXN0cmVhbSBmaWx0ZXJpbmcgYW5kIHBvbGljaW5nIHBhcnRzIChRY2kpDQo+
IGlzIHNvbWV0aGluZyB0aGF0IEkgZG9uJ3Qga25vdyBob3cgdG8gZG8gcmlnaHQgbm93LCBhbnkg
c3VnZ2VzdGlvbnMgd291bGQgYmUNCj4gbmljZS4NCj4gDQo+IEluIHNob3J0LCB0YWtlIGEgbG9v
ayBhdCB3aGF0J3MgdGhlcmUgYW5kIHNlZSB3aGF0J3MgbWlzc2luZyBmb3IgdGhlIHN0dWZmIHRo
YXQNCj4geW91IGNhcmUgYWJvdXQsIHRoZW4gd2UgY2FuIHdvcmsgb24gdGhhdC4NCj4gDQo+ID4N
Cj4gPiAzLiBTZWxlY3Rpb24gb2YgY29tbXVuaWNhdGlvbiBwYXRoczoNCj4gPiAgICBUaGlzIHBh
dGNoIG5vdCBzdXBwb3J0IHRoZSBwdXJlIHNvZnR3YXJlIG9ubHkgVFNOIHByb3RvY29scyhsaWtl
IFFjYykNCj4gPiAgICBidXQgaGFyZHdhcmUgcmVsYXRlZCBjb25maWd1cmF0aW9uLg0KPiA+DQo+
ID4gVFNOIFByb3RvY29scyBzdXBwb3J0cyBieSB0aGlzIHBhdGNoOiBRYnYvUWNpL1FidS9DcmVk
aXQtYmFzZSBTaGFwZXIoUWF2KS4NCj4gPiBUaGlzIHBhdGNoIHZlcmlmaWVkIG9uIE5YUCBsczEw
MjhhcmRiIGJvYXJkLg0KPiA+DQo+ID4gV2lsbCBhZGQgbW9yZSBwcm90b2NvbHMgaW4gdGhlIGZ1
dHVyZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBvIExpdSA8UG8uTGl1QG54cC5jb20+DQo+
IA0KPiANCj4gQ2hlZXJzLA0KPiAtLQ0KPiBWaW5pY2l1cw0K
