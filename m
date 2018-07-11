Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865DCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AAF208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CLnsdiw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AAF208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeGKHRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:17:32 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:62669
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbeGKHRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUOy05GM0p08nku6qFtefskA0cnrxoJ1Ra/Wr9TzTx4=;
 b=CLnsdiw/nbzNf1hcwb9D03rl7a1VCbb0ZLZog5WBXFPnIn1YWCRXZz9JlFDA5yc3n1zSMQFEoSsMonEdcqBadHW2PTGssjOwzOoGBWhFC6sW3Pw/kMp9r8nPpyhNJbR3NicIYCSw1Bch0wueBn42rwKWNLnWo4Th+aY8QExa8zY=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB2998.eurprd04.prod.outlook.com (10.170.213.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 07:14:35 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 07:14:35 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     Vinod <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Thread-Topic: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Thread-Index: AQHUGCdtKxI/TRPiJk21nKgSpY3ZgaSIlmEAgADzhiCAAA2UAIAABA+w
Date:   Wed, 11 Jul 2018 07:14:35 +0000
Message-ID: <DB6PR04MB3223B95A627770601587A02A895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
 <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
In-Reply-To: <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB2998;7:aU8CLWZpDKeKCyNpZWBLgILXk/4CL5ZOTIQGpcfykO1NDyqpi2x83wZsOv1oYI2arEGT6M0F5A8vovikAb4xRU09/FFJUTS+xWZ1F2c3KiFPuNoflEJiuEB/G/fMJIMFtL9Xm5HDdRgsW8jQt5SeSmJiBoRs+euXIFuYEFddcEFxSJcIHXoqAZ43BFBZ0MojPPwFrwZrR50diXDiLSc3hCUZ78PDl+5fG9bLzz0ZJW+bvDfeKPYAo2G1h009OZ1K
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f5754ce1-8681-406d-7f00-08d5e6fdf507
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2998;
x-ms-traffictypediagnostic: DB6PR04MB2998:
x-microsoft-antispam-prvs: <DB6PR04MB2998447B414763285EA24E8E895A0@DB6PR04MB2998.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB2998;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2998;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(13464003)(256004)(4326008)(446003)(229853002)(76176011)(186003)(486006)(11346002)(476003)(53546011)(99286004)(6506007)(6116002)(53936002)(7696005)(102836004)(6436002)(33656002)(5640700003)(6916009)(54906003)(6306002)(106356001)(25786009)(14444005)(26005)(97736004)(316002)(2900100001)(105586002)(66066001)(2906002)(93886005)(478600001)(68736007)(2351001)(45080400002)(55016002)(74316002)(5660300001)(6246003)(305945005)(966005)(2501003)(8936002)(14454004)(3846002)(81156014)(5250100002)(86362001)(81166006)(575784001)(7736002)(8676002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2998;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L49stxXgKzundZNLytnrt2LJTLEUQ4KZDMAfc4k80w7/c5AxkQ/lrxBse2ehr9DxF/5ngDfeBcqh7yhh29aWMcC5nrYQOuH6nKIpzEYXJecZDXwcXxFBkCnyEhhP68ZrqPhsQQHNHD2fd1RHD6AurNMVSD+TTdsuwKxarc3xUU7jygd5TVw7d9W2R5xrQ5ZE0C+aJ3U9C+m0S0xW0dtnjex4yLZoxSh7Rs93IX3gqjHGzR3bEl3oYw8+LE+sQrD6msYIb0nwye7p35A8qXIyrtcsCHllYhxyQ0tTA487Ld8OzFaJm5YllHn/d1eKnOUWkQOEPtQqcF8UnSbnBN4fA4DAKDO02duFzAnYaM+6f4A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5754ce1-8681-406d-7f00-08d5e6fdf507
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 07:14:35.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGUgW21haWx0bzpzLmhhdWVyQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE45bm0N+ac
iDEx5pelIDE0OjU0DQo+IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+IENj
OiBWaW5vZCA8dmtvdWxAa2VybmVsLm9yZz47IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsNCj4g
c2hhd25ndW9Aa2VybmVsLm9yZzsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29t
PjsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZG1hZW5naW5lQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAzLzRdIGRtYWVuZ2luZTog
aW14LXNkbWE6IHN1cHBvcnQgZG1hdGVzdA0KPiANCj4gT24gV2VkLCBKdWwgMTEsIDIwMTggYXQg
MDY6Mzc6MDJBTSArMDAwMCwgUm9iaW4gR29uZyB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFZpbm9kIFttYWlsdG86dmtvdWxAa2VybmVs
Lm9yZ10NCj4gPiA+IFNlbnQ6IDIwMTjlubQ35pyIMTDml6UgMjM6MzMNCj4gPiA+IFRvOiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4gPiBDYzogZGFuLmoud2lsbGlhbXNAaW50
ZWwuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+ID4gcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsNCj4gPiA+IGxpbnV4QGFy
bWxpbnV4Lm9yZy51azsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+
ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy80XSBkbWFlbmdpbmU6IGlt
eC1zZG1hOiBzdXBwb3J0IGRtYXRlc3QNCj4gPiA+DQo+ID4gPiBPbiAxMS0wNy0xOCwgMDA6MjMs
IFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiA+IGRtYXRlc3QobWVtY3B5KSB3aWxsIG5ldmVyIGNh
bGwgZG1hZW5naW5lX3NsYXZlX2NvbmZpZyBiZWZvcmUNCj4gPiA+ID4gcHJlcCwNCj4gPiA+DQo+
ID4gPiBhbmQgdGhhdCBzaG91bGQgaGF2ZSBiZWVuIGEgaGludCB0byB5b3UgdGhhdCB5b3Ugc2hv
dWxkIG5vdCBleHBlY3QNCj4gPiA+IHRoYXQNCj4gPiA+DQo+ID4gPiA+IHNvIGpvYnMgaW4gZG1h
ZW5naW5lX3NsYXZlX2NvbmZpZyBuZWVkIHRvIGJlIG1vdmVkIGludG8gc29tZXdoZXJlDQo+ID4g
PiA+IGJlZm9yZSBkZXZpY2VfcHJlcF9kbWFfbWVtY3B5LiBCZXNpZGVzLCBkbWF0ZXN0IG5ldmVy
IHNldHVwIGNoYW4NCj4gPiA+ID4gLT5wcml2YXRlIGFzIG90aGVyIGNvbW1vbiBjYXNlIGxpa2Ug
dWFydC9hdWRpby9zcGkgd2lsbCBhbHdheXMNCj4gPiA+ID4gLT5zZXR1cA0KPiA+ID4gPiBjaGFu
LT5wcml2YXRlLiBIZXJlIGNoZWNrIGl0IHRvIGp1ZGdlIGlmIGl0J3MgZG1hdGVzdCBjYXNlIGFu
ZCBkbw0KPiA+ID4gPiBqb2JzIGluIHNsYXZlX2NvbmZpZy4NCj4gPiA+DQo+ID4gPiBhbmQgeW91
IHNob3VsZCBub3QgZG8gYW55dGhpbmcgZm9yIGRtYXRlc3QuIFN1cHBvcnRpbmcgaXQgbWVhbnMN
Cj4gPiA+IG1lbWNweSBpbXBsZW1lbnRhdGlvbiBpcyBub3QgY29ycmVjdCA6KQ0KPiA+IE9rYXks
IEkgd2lsbCBhbnkgd29yZCBhYm91dCBkbWF0ZXN0IGhlcmUgc2luY2UgbWVtY3B5IGFzc3VtZSBu
bw0KPiA+IGNhbGxpbmcgc2xhdmVfY29uZmlnLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCAzNyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGluZGV4DQo+ID4gPiA+
IGVkMjI2N2QuLjQ4ZjM3NDkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2lteC1z
ZG1hLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiA+ID4gPiBAQCAt
MTIyMiwxMCArMTIyMiwzNiBAQCBzdGF0aWMgaW50DQo+ID4gPiA+IHNkbWFfYWxsb2NfY2hhbl9y
ZXNvdXJjZXMoc3RydWN0IGRtYV9jaGFuICpjaGFuKSAgew0KPiA+ID4gPiAgCXN0cnVjdCBzZG1h
X2NoYW5uZWwgKnNkbWFjID0gdG9fc2RtYV9jaGFuKGNoYW4pOw0KPiA+ID4gPiAgCXN0cnVjdCBp
bXhfZG1hX2RhdGEgKmRhdGEgPSBjaGFuLT5wcml2YXRlOw0KPiA+ID4gPiArCXN0cnVjdCBpbXhf
ZG1hX2RhdGEgZGVmYXVsdF9kYXRhOw0KPiA+ID4gPiAgCWludCBwcmlvLCByZXQ7DQo+ID4gPiA+
DQo+ID4gPiA+IC0JaWYgKCFkYXRhKQ0KPiA+ID4gPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+
ID4gKwlyZXQgPSBjbGtfZW5hYmxlKHNkbWFjLT5zZG1hLT5jbGtfaXBnKTsNCj4gPiA+ID4gKwlp
ZiAocmV0KQ0KPiA+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArCXJldCA9IGNsa19lbmFi
bGUoc2RtYWMtPnNkbWEtPmNsa19haGIpOw0KPiA+ID4gPiArCWlmIChyZXQpDQo+ID4gPiA+ICsJ
CWdvdG8gZGlzYWJsZV9jbGtfaXBnOw0KPiA+ID4gPiArCS8qDQo+ID4gPiA+ICsJICogZG1hdGVz
dChtZW1jcHkpIHdpbGwgbmV2ZXIgY2FsbCBkbWFlbmdpbmVfc2xhdmVfY29uZmlnIGJlZm9yZQ0K
PiBwcmVwLA0KPiA+ID4gPiArCSAqIHNvIGpvYnMgaW4gZG1hZW5naW5lX3NsYXZlX2NvbmZpZyBu
ZWVkIHRvIGJlIG1vdmVkIGludG8NCj4gc29tZXdoZXJlDQo+ID4gPiA+ICsJICogYmVmb3JlIGRl
dmljZV9wcmVwX2RtYV9tZW1jcHkuIEJlc2lkZXMsIGRtYXRlc3QgbmV2ZXIgc2V0dXANCj4gY2hh
bg0KPiA+ID4gPiArCSAqIC0+cHJpdmF0ZSBhcyBvdGhlciBjb21tb24gY2FzZXMgbGlrZSB1YXJ0
L2F1ZGlvL3NwaSB3aWxsIHNldHVwDQo+ID4gPiA+ICsJICogY2hhbi0+cHJpdmF0ZSBhbHdheXMu
IEhlcmUgY2hlY2sgaXQgdG8ganVkZ2UgaWYgaXQncyBkbWF0ZXN0IGNhc2UNCj4gPiA+ID4gKwkg
KiBhbmQgZG8gam9icyBpbiBzbGF2ZV9jb25maWcuDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJ
aWYgKCFkYXRhKSB7DQo+ID4gPiA+ICsJCWRldl93YXJuKHNkbWFjLT5zZG1hLT5kZXYsICJkbWF0
ZXN0IGlzIHJ1bm5pbmc/XG4iKTsNCj4gPiA+DQo+ID4gPiB3aHkgaXMgdGhhdCBhIHdhcm5pbmch
DQo+ID4gQ3VycmVudCBTRE1BIGRyaXZlciBhc3N1bWUgZmlsdGVyIGZ1bmN0aW9uIHRvIHNldCBj
aGFuLT5wcml2YXRlIHdpdGgNCj4gPiBzcGVjaWZpYyBkYXRhIChzdHJ1Y3QgaW14X2RtYV9kYXRh
IGRtYV9kYXRhKWxpa2UgYmVsb3cNCj4gKHNvdW5kL3NvYy9mc2wvZnNsX2FzcmNfZG1hLmMpOg0K
PiA+IHN0YXRpYyBib29sIGZpbHRlcihzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sIHZvaWQgKnBhcmFt
KSB7DQo+ID4gICAgICAgICBpZiAoIWlteF9kbWFfaXNfZ2VuZXJhbF9wdXJwb3NlKGNoYW4pKQ0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgICBjaGFuLT5wcml2
YXRlID0gcGFyYW07DQo+ID4gICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiB9DQo+ID4NCj4gPiBC
dXQgaW4gbWVtY3B5IGNhc2UsIGF0IGxlYXNlIGRtYXRlc3QgY2FzZSwgbm8gY2hhbi0+cHJpdmF0
ZSBzZXQgaW4gaXRzIGZpbHRlcg0KPiBmdW5jdGlvbi4NCj4gPiBTbyBoZXJlIHRha2UgZG1hdGVz
dCBhIHNwZWNpYWwgY2FzZSBhbmQgZG8gc29tZSBwcmVwYXJlIGpvYnMgZm9yDQo+ID4gbWVtY3B5
LiBCdXQgaWYgdGhlIFVwcGVyIGRldmljZSBkcml2ZXIgY2FsbCBkbWFfcmVxdWVzdF9jaGFubmVs
KCkgd2l0aA0KPiA+IHRoZWlyIHNwZWNpZmljIGZpbHRlciB3aXRob3V0ICdjaGFuLT5wcml2YXRl
JyBzZXR0aW5nIGluIHRoZSBmdXR1cmUuDQo+ID4gVGhlIHdhcm5pbmcgbWVzc2FnZSBpcyBhIHVz
ZWZ1bCBoaW50IHRvIHRoZW0gdG8gQWRkICdjaGFuLT5wcml2YXRlJyBpbiBmaWx0ZXINCj4gZnVu
Y3Rpb24uICBPciBkb2MgaXQgc29tZXdoZXJlPw0KPiANCj4gSW5zdGVhZCBvZiBkb2luZyBoZXVy
aXN0aWNzIHRvIGd1ZXNzIHdoZXRoZXIgd2UgYXJlIGRvaW5nIG1lbWNweSB5b3UgY291bGQNCj4g
aW5zdGVhZCBtYWtlIG1lbWNweSB0aGUgZGVmYXVsdCB3aGVuIHNsYXZlX2NvbmZpZyBpcyBub3Qg
Y2FsbGVkLCBpLmUuIGRyb3AgdGhlDQo+IGlmICghZGF0YSkgY2hlY2sgY29tcGxldGVseS4NClll
cywgZm9yIG1lbWNweSBjYXNlLCB0aGF0J3MgYSBnb29kIHdheSwgYnV0IGhvdyB0byB3YXJuaW5n
IHRoZSBmdXR1cmUgY2FzZQ0KV2l0aG91dCBzZXR1cCAnY2hhbi0+cHJpdmF0ZScuLi4NCj4gDQo+
ID4gPg0KPiA+ID4gPiArCQlzZG1hYy0+d29yZF9zaXplICA9DQo+IHNkbWFjLT5zZG1hLT5kbWFf
ZGV2aWNlLmNvcHlfYWxpZ247DQo+ID4gPiA+ICsJCWRlZmF1bHRfZGF0YS5wcmlvcml0eSA9IDI7
DQo+ID4gPiA+ICsJCWRlZmF1bHRfZGF0YS5wZXJpcGhlcmFsX3R5cGUgPSBJTVhfRE1BVFlQRV9N
RU1PUlk7DQo+ID4gPiA+ICsJCWRlZmF1bHRfZGF0YS5kbWFfcmVxdWVzdCA9IDA7DQo+ID4gPiA+
ICsJCWRlZmF1bHRfZGF0YS5kbWFfcmVxdWVzdDIgPSAwOw0KPiA+ID4gPiArCQlkYXRhID0gJmRl
ZmF1bHRfZGF0YTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQlzZG1hX2NvbmZpZ19vd25lcnNoaXAo
c2RtYWMsIGZhbHNlLCB0cnVlLCBmYWxzZSk7DQo+ID4gPiA+ICsJCXNkbWFfZ2V0X3BjKHNkbWFj
LCBJTVhfRE1BVFlQRV9NRU1PUlkpOw0KPiA+ID4gPiArCQlzZG1hX2xvYWRfY29udGV4dChzZG1h
Yyk7DQo+ID4gPiA+ICsJfQ0KPiA+ID4NCj4gPiA+IHRoaXMgbmVlZHMgdG8gYmUgZGVmYXVsdCBm
b3IgbWVtY3B5DQo+IA0KPiBUaGUgcHJvYmxlbSBzZWVtcyB0byBiZSB0aGF0IHdlIGRvIG5vdCBr
bm93IHdoZXRoZXIgd2UgYXJlIGRvaW5nIG1lbWNweQ0KPiBvciBub3QuIE5vcm1hbGx5IHdlIGdl
dCB0aGUgaW5mb3JtYXRpb24gaG93IGEgY2hhbm5lbCBpcyB0byBiZSBjb25maWd1cmVkIGluDQo+
IGRtYV9kZXZpY2UtPmRldmljZV9jb25maWcsIGJ1dCB0aGlzIGZ1bmN0aW9uIGlzIG5vdCBjYWxs
ZWQgaW4gdGhlIG1lbWNweSBjYXNlLg0KPiANCj4gQW4gYWx0ZXJuYXRpdmUgbWlnaHQgYWxzbyBi
ZSB0byBkbyB0aGUgc2V0dXAgaW4NCj4gZG1hX2RldmljZS0+ZGV2aWNlX3ByZXBfZG1hX21lbWNw
eS4NClllcywgSSd2ZSB0aGluayBhYm91dCBpdCBiZWZvcmUsIGJ1dCBzdWNoIHByZXBhcmUgc3Rl
cHMgb25seSBuZWVkZWQgaW4gb25jZSB0aW1lLi4uDQo+IA0KPiBTYXNjaGENCj4gDQo+IC0tDQo+
IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+IHwNCj4gSW5k
dXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9lbWVh
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3
Lg0KPiBwZW5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDeWliaW4uZ29uZyU0MG54
cC5jb20lN0MzZmNmMDMNCj4gZGIxMmY0NDEzOThmYmIwOGQ1ZTZmYjE0MmIlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzANCj4gJTdDMCU3QzYzNjY2ODg4ODQxNjMyODk2MCZh
bXA7c2RhdGE9RTFEVDFCVzRiNVExVldna01OWnFBMjgNCj4gb0slMkZWVlF2aUM4cUYyJTJCcUcw
RmVvJTNEJmFtcDtyZXNlcnZlZD0wICB8DQo+IFBlaW5lciBTdHIuIDYtOCwgMzExMzcgSGlsZGVz
aGVpbSwgR2VybWFueSB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMCAgICB8DQo+IEFtdHNnZXJp
Y2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDoNCj4gKzQ5LTUxMjEtMjA2
OTE3LTU1NTUgfA0K
