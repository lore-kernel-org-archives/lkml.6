Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7101121871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXI/hGPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfADJBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:01:18 -0500
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:36992
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfADJBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+T2ijkNz/iPKXMdpIqBDdiM2cFkpnPIpvG2bvsvOR0=;
 b=mXI/hGPipMuRb68MoUHHA1gyXAQ1V1cc14abe6GOSpQ4+Qh7zRra4piuqeizYoGbj9rNMAzbVpVOyaQ3De0uRYdkax2BKf5I3cYodF2QhV0dxcXsnWYp2mwyD/8PI7z2zOr7NLL7s+LX9fc+9jcnfC87GmHNEzcBLiXDWCHhN34=
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.50.160) by
 VI1PR04MB5247.eurprd04.prod.outlook.com (20.177.51.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 09:01:10 +0000
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::c5c:ec01:4a6b:5f4b]) by VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::c5c:ec01:4a6b:5f4b%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 09:01:10 +0000
From:   Po Liu <po.liu@nxp.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
Thread-Index: AQHUnl7Q0OQhsXkvlE2k4BYXbHWC16WTgwIAgAAAzoCAAQbfAIAAXHywgAd3SICAAO63gIAACTawgAAesQCAAWK3AA==
Date:   Fri, 4 Jan 2019 09:01:09 +0000
Message-ID: <VI1PR04MB51357307440F6B89831741F5928E0@VI1PR04MB5135.eurprd04.prod.outlook.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com> <87r2e14fgr.fsf@intel.com>
 <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <87k1jm51ey.fsf@intel.com> <20190103091605.GA4597@apalos>
 <VI1PR04MB51351DDF26EB43FEDC9094B6928D0@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <20190103113854.GA10968@apalos>
In-Reply-To: <20190103113854.GA10968@apalos>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=po.liu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5247;6:d4UxydyZZLZjTi7xY8oY9ZfAUYU8EBSZw8mNTDxo8c5hWvGg+XP9HK+8mrWc16ZjfmaHi5l7mmT8mF0roRov6PhZ6ph57PvUzTTDx2Bq5cHJKJ26crrG7OjbE06yA6CWhqRes5MCoVQ3Te/u3DCSZHJ2lJYIBZNG1y+c93BhGG4k+N04zxAXd28BPNdp4vP0akzZkW6bpXA6t82UgYDQMEwf6Bs9N7IDQjb3QbRKXnPZlJo6mcbN3H1TEa3sXt1JbRycilos0RhjFSqNQGmzJsASvgLzH4YBA0IUnWfCFQIPM7myvdwnRb+xvTpHgcIbF5L+TXS8fCQ+SU2m0d/hd8Gjz90SIUwfkN24UNc89edwX777xOVBPc5nVCFpbbpLTAJlY0Bcxu2S+2h/9R/zTPYeMgY9tRsLHWdN+7bAVkxQkfF+HBE26311ldYIMe8kvznCJ9yKKHVQHT0DsePY4w==;5:vEt7j1mydyE1WpymZGal4cNtreAFzIiwm6wmOP+28UzC6OvuDj7+lnXp1k467R32Ed4Wbtnp8BJn9ylMB1P9/a4dxebtbdHFR4CLWgCjSauTMSQPFsfAd/cCQhwdmdPrelDq3loeVJ0KVGWW6uFh6t44neB/vo/vx9R9Nc+GBwPLE04kKkUFfcmlaOvzPQ4W+mXUd4aM1KNaW6Tl09LVyw==;7:kzVi+wLokO28ATxlXm8TahWnZ9FVji4an7TDzGCn+xrNrgYYUlwU9l/oYt2v8Hm4k5ZXJlmSOUFlaKtYZjnPsAXuog6Q3umrA3I24pi943Kaox9DsImpTMMPhc3ezFxE8QxfDGsHo9aqup03bvQ8Tw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3dc728fd-5b32-4ec0-ab51-08d672232b93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5247;
x-ms-traffictypediagnostic: VI1PR04MB5247:
x-microsoft-antispam-prvs: <VI1PR04MB52473EE0C6017A0065981B44928E0@VI1PR04MB5247.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5247;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5247;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(13464003)(199004)(189003)(53546011)(44832011)(229853002)(105586002)(6916009)(2906002)(76176011)(102836004)(5660300001)(99286004)(66066001)(26005)(25786009)(8676002)(71200400001)(71190400001)(81166006)(8936002)(81156014)(7736002)(86362001)(68736007)(305945005)(6506007)(97736004)(186003)(93886005)(14454004)(478600001)(446003)(11346002)(476003)(55016002)(9686003)(53936002)(4326008)(33656002)(6246003)(316002)(256004)(6116002)(54906003)(486006)(6436002)(7696005)(3846002)(106356001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5247;H:VI1PR04MB5135.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kSRU74yTWz5+Ub/YvwzhnjI98QLa5RifUXCkod3+de1b9Kt06kqyxrCCYSf7Y1AptqWvHpi6w/PH2+FTqhpVXrvhN6GUU6nBLebn/75tTCf2dEGugpJ04X5sqqZQc7mGo0hIm/plgYIkH+3Eu4L7EBj5lVK8WArZ3mOqVCvrpV1PHLP/iC9tofn8wJjIbQ0T6QydsvlzwoUljb6gk4cNoHeZWp6Gqnq09ZqlVU/ogYhfj4DCF/k05rgFAA9LY57Xc/HvXC0GKVUgXuCJsAhDRGNtMp5KZKjwdP51A77GG1scavpXkNK9srJ6S3oJ1nIh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc728fd-5b32-4ec0-ab51-08d672232b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 09:01:09.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWxpYXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxpYXMg
QXBhbG9kaW1hcyBbbWFpbHRvOmlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZ10NCj4gU2VudDog
MjAxOcTqMdTCM8jVIDE5OjM5DQo+IFRvOiBQbyBMaXUgPHBvLmxpdUBueHAuY29tPg0KPiBDYzog
VmluaWNpdXMgQ29zdGEgR29tZXMgPHZpbmljaXVzLmdvbWVzQGludGVsLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IGhhdXN0YWRAY2lzY28uY29tOw0KPiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hp
cC5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBNaW5na2FpIEh1DQo+IDxtaW5na2Fp
Lmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gbmV0OiB0c246IGFkZCBhbiBuZXRsaW5rIGludGVyZmFjZSBiZXR3ZWVuIGtlcm5l
bCBhbmQNCj4gYXBwbGljYXRpb24gbGF5ZXINCj4gDQo+IEhpIFBvLA0KPiANCj4gPiA+ID4gPiBT
b21lIHByb3RvY29scyB0YXJnZXQgdG8gY29uZmlndXJlIHRoZSB0cmFmZmljIGNsYXNzKGxpa2Ug
UWF2IENCUykuDQo+ID4gPiA+ID4gU29tZSB0byBjb25maWcgdGhlIHBvcnQobGlrZSBRYnYpLiBC
dXQgc29tZSBmb3IgdGhlIHdob2xlDQo+ID4gPiA+ID4gZXRoZXJuZXQgY29udHJvbGxlcihsaWtl
IFFjaSwgdGhlIGNvbnRyb2wgZW50cmllcyBmb3IgdGhlIHdob2xlDQo+ID4gPiA+ID4gY29udHJv
bGxlciwgd2hpY2ggaW5wdXQgcG9ydHMgYW5kIHdoaWNoIG91dHB1dCBwb3J0cykuDQo+ID4gPiA+
DQo+ID4gPiA+IFJlYWRpbmcgeW91ciBlbWFpbCwgbm93IEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50
IGEgbGl0dGxlIGJldHRlci4NCj4gPiA+ID4gWW91IGFyZSBpbnRlcmVzdGVkIGluIG11bHRpLXBv
cnQgZGV2aWNlcy4gSSBhZG1pdCB0aGF0IEkgYW0gbm90DQo+ID4gPiA+IHRvbyBmYW1pbGlhciB3
aXRoIGhvdyBtdWx0aS1wb3J0IGRldmljZXMgYXJlIGV4cG9zZWQgaW4gTGludXgsIEkNCj4gPiA+
ID4gd2FzIG9ubHkgZm9jdXNlZCBvbiB0aGUgZW5kLXN0YXRpb24gdXNlIGNhc2VzLCB1bnRpbCBu
b3cuDQo+ID4gPg0KPiA+ID4gSGF2ZSB5b3UgY29uc2lkZXJlZCBhIHN3aXRjaGRldi1iYXNlZCBk
cml2ZXIgZm9yIG11bHRpLXBvcnQgZGV2aWNlcz8NCj4gPiBbUG9dIFllcywgdGhlIHBhdGNoIGlz
IGluY2x1ZGluZyB0aGUgc3dpdGNoZGV2LWJhc2VkIGRyaXZlci4gSW4gZmFjdCwgd2UgaGF2ZQ0K
PiBkcml2ZXIgZXhhbXBsZXMgZm9yICBsczEwMjggd2hpY2ggaW5jbHVkZSBlbmQtc3RhdGlvbiBJ
UCBhbmQgc3dpdGNoIHBvcnRzIElQLA0KPiB3aXRoIHRoaXMgaW50ZXJmYWNlIGRyaXZlciwgaXQg
aXMgd29ya2luZy4gQnV0IHdlIG5lZWQgdG8gYWRkIGJhc2UgZXRoZXJuZXQgZHJpdmVyDQo+IG9m
IEVORVRDKGVuZCBzdGF0aW9uKSBhbmQgRkVMSVgoc3dpdGNoKSB1cHN0cmVhbSBmaXJzdCwgdGhl
biBhZGQgdGhlIFRTTiBkcml2ZXINCj4gdXBzdHJlYW0uDQo+ID4NCj4gPiA+IFdoYXQgeW91IGFz
ayBvZiBUU04gY29uZmlndXJhdGlvbiBpcyBjdXJyZW50bHkgZG9hYmxlIHdpdGggc3dpdGNoDQo+
ID4gPiBzd2l0Y2hkZXYgZm9yIFZMQU5zIGFuZCBvdGhlciBzaW1pbGFyIG5ldHdvcmtpbmcgZnVu
Y3Rpb25hbGl0eS4NCj4gPiBbUG9dIEkgdGhpbmsgdGhlIFZMQU4gY29uZmlndXJlIGlzIG5vdCBj
b25mbGljdCB3aXRoIHRoZSBUU04uIFRTTiBpcyBleHRlbmRpbmcNCj4gdGhlIDgwMjFRLiBUU04g
Y29uZmlndXJlIHRoZSBzZXR0aW5nIG9mIGZpbHRlciBmcmFtZSBvciBzY2hlZHVsaW5nIGJldHdl
ZW4gVEMuDQo+IEJ1dCBtYXliZSBuZWVkIHRvIGNvbnNpZGVyIGFzIHdob2xlIGFzIHlvdSBzYWlk
Lg0KPiANCj4gVkxBTiB3YXMgYW4gZXhhbXBsZSBvZiBkZXZpY2VzIGFscmVhZHkgcGVyZm9ybWlu
ZyBjb21wbGV4IGNvbmZpZ3VyYXRpb24NCj4gdXNpbmcgc3dpdGNoZGV2IGFuZCBjb25maWd1cmF0
aW5nICdzd2l0Y2gnIHBvcnRzIGFuZCAnY3B1JyBwb3J0KHMpIGluZGl2aWR1YWxseS4NCj4gSXQg
d2Fzbid0IHJlbGF0ZWQgdG8gVFNOIG9yIGl0cyA4MDIuMVFidiBpbXBvcnRhbmNlIGluIGFueSB3
YXkuDQo+IA0KPiA+ID4NCj4gPiA+IEluc3RlYWQgb2YgcmV3cml0aW5nIHRoaXMgZnJvbSBzY3Jh
dGNoLCB3ZSBub3QgZXh0ZW5kIHRoZSBjdXJyZWN0IFRDDQo+ID4gPiBhbmQgc3dpdGNoZGV2IGZ1
bmN0aW9uYWxpdHkgZm9yIHRoYXQgPw0KPiA+DQo+ID4gW1BvXSBZYSwgdGhlcmUgYXJlIG9wZXJh
dGlvbnMgb2Ygc3dpdGNoZGV2LiBZb3UgbWF5IHRoaW5rIHRoYXQgdG8gYWRkIHRoZSBUU04NCj4g
Y29uZmlndXJhdGlvbnMgb3BzIGludG8gc3dpdGNoZGV2IG9wZXJhdGlvbnMuIEJ1dCAgd2UgbmVl
ZCB0byBjb25zaWRlciB0aGUgZW5kLQ0KPiBzdGF0aW9uIGRldmljZXMgYW5kIHN3aXRjaCBhbGwg
aW4gdGhlIGRldmljZXMgb3IgaW4gdGhlIFRTTiBkb21haW4uIFRoZSBUU04NCj4gZG9tYWluIGlz
IHRoZSBkZXZpY2VzIGluY2x1ZGUgVFNOIGNhcGFiaWxpdGllcyBwb3J0cywgZm9yIHVwIGxheWVy
LCB3ZSBuZWVkIHRvDQo+IHByb3ZpZGUgYSBmb3JtYWwgaW50ZXJmYWNlLiBTbyB0c24gY29uZmln
dXJlIGNhbiBiZSBzdGFuZGFsb25lLg0KPiA+IEluIHRoaXMgcGF0Y2gsIHdlIHRyZWF0IHR3byBr
aW5kcyBvZiBwb3J0cyB3aGVuIHJlZ2lzdGVyaW5nIHRoZSBwb3J0cywgZW5kLQ0KPiBzdGF0aW9u
IG9yIHN3aXRjaC4gVGhpcyBtYXkgdHJlYXQgdGhlbSBpbiBzb21lIG1pbm9yIGRpZmZlcmVuY2Vz
IGluIFRTTiBzcGVjDQo+IGFuZCBkcml2ZXJzLg0KPiA+DQo+IA0KPiBXaHkgYXJlIHN3aXRjaGVz
IGRpZmZlcmVudCB0aGFuIGVuZC1zdGF0aW9ucyBjb25maWd1cmF0aW9uIHdpc2U/DQoNCk1pbm9y
IGRpZmZlcmVuY2VzIGJ1dCBzdGlsbCBoYXZlIG1lbnRpb25lZCBpbiBzcGVjLg0KDQo+IEkgdW5k
ZXJzdGFuZCB0aGF0IHlvdSBtYXkgbmVlZCB0byBzdXBwb3J0IGRpZmZlcmVudCBUU04gSUVFRSBz
dGFuZGFyZHMgcGVyDQo+IGRldmljZSwgYnV0IGFkZGluZyBzdXBwb3J0IGZvciBkaWZmZXJlbnQg
Y2FwYWJpbGl0aWVzIHNob3VsZG4ndCBhZmZlY3QgYSAnY29tbW9uJw0KPiBjb25maWd1cmF0aW9u
IHBhdGguDQo+IFRoYXQncyB0aGUgYWN0dWFsIGFkdmFudGFnZSBvZiBzd2l0Y2hkZXYgYmFzZWQg
ZHJpdmVycy4gc3dpdGNoZXMgYW5kIGVuZA0KPiBzdGF0aW9ucyB3aWxsIGhhdmUgYSB2ZXJ5IHNp
bWlsYXIgd2F5IG9mIGNvbmZpcmF0aW9uIHZpYSBpcHJvdXRlMi9icmlkZ2UvdGMgdXRpbHMuDQo+
IEFtIGkgbWlzc2luZyBzb21ldGhpbmc/DQo+IA0KSSBndWVzcyBJIHN0YXJ0IHRvIGdldHRpbmcg
eW91ciBhZHZpc2UuIERvIHlvdSBtZWFuIHRvIGFkZCBvcGVyYXRpb25zIGluIHN0cnVjdCBzd2l0
Y2hkZXZfb3BzID8gSXMgaXQgcHJvcGVyIGluY2x1ZGUgZW5kIHN0YXRpb24/IEkgdXNlZCB0byBh
ZGQgc3RydWN0dXJlIHRzbl9vcHMgaW4gbmV0X2RldmljZS4gQnV0IEkgdGhpbmsgdGhlcmUgYXJl
IHNvbWUgaW5mb3JtYXRpb24gYW5kIHN0YXR1cyBvZiBkZXZpY2VzIG1haW50YWluIGluIHRoZSBr
ZXJuZWwgZnJvbSBkcml2ZXJzLiBTbyBJIGNyZWF0ZSBzdHJ1Y3R1cmUgdHNuX3BvcnQgc3RhbmRh
bG9uZS4gDQpZZXMsICBpcHJvdXRlMi9icmlkZ2UvdGMgaXMgb25lIGNob2ljZSBmb3IgdXNlciBz
cGFjZS4gSSB3b3VsZCB0aGluayBvZiB0aGUgcG9zc2libGUuIEJ1dCB0aGUgdG9vIG1hbnkgcGFy
YW1ldGVycyBhcmUgc3RpbGwgdGhlIHByb2JsZW0uIEZvciBleGFtcGxlIHRvIGNyZWF0ZSBRYnYg
Z2F0ZSBsaXN0Lg0KDQo+IC9JbGlhcw0K
