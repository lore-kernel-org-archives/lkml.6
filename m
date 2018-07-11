Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4323AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD94820883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h0Cu58ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD94820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbeGKIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:19:29 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:35213
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbeGKIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1ohOd2TiCvkGD4qzWUzbW0b6K9o9qNw/a1z+70BPFM=;
 b=h0Cu58ie6D3pWoUtpypjK+mN328tF2Oktam8CsvkSJvqwJAnrBNFwpGK6Q905azNecScGORdA2lJ6gCijUY+HsXNmCN2fAddPg6H5g55iECIgVJXTBVzw/MjC5Y2kGblsWhKWoebRULaKvMrhbj7G0KkEv7NIFJi/x2rWP4t8hI=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3110.eurprd04.prod.outlook.com (10.170.214.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 08:16:15 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 08:16:15 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod <vkoul@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
Thread-Index: AQHUGCdtKxI/TRPiJk21nKgSpY3ZgaSIlmEAgADzhiCAAA2UAIAABxyAgAAM86A=
Date:   Wed, 11 Jul 2018 08:16:15 +0000
Message-ID: <DB6PR04MB3223D27E2BCA6A235733CEA5895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
 <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
 <20180711071905.GN3219@vkoul-mobl>
In-Reply-To: <20180711071905.GN3219@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3110;7:+AtnP+rqkLGRXLgfqzFo5AdcUOjPtQ8CbZVYnRprPqh4OrYFBOESNleiaslktRKZvroSiUN52XpWI63sSm6OLU/6AZUdXDM6XnjCiC+dlScf6wUzarhZWsIfHdOmqM3pFv9+z6XqvnfYz0RQNOCOnayD2aVHUV+XpQrgu5JDV9T9aFzWnMfb+L27A+8/HHNNPi8T1tSf/cN4901t2PI0FsvofXY1gjgfHGftuLZ96qmjNcXaZ8mgE+dj7i50AnUg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5ddfa412-4989-4fb5-7f57-08d5e706928a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3110;
x-ms-traffictypediagnostic: DB6PR04MB3110:
x-microsoft-antispam-prvs: <DB6PR04MB31101992030CEE7852C1DDA7895A0@DB6PR04MB3110.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3110;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3110;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(13464003)(14444005)(93886005)(105586002)(106356001)(478600001)(2900100001)(6436002)(229853002)(55016002)(9686003)(97736004)(5250100002)(66066001)(2501003)(6116002)(53546011)(68736007)(25786009)(8936002)(7696005)(6506007)(8676002)(2906002)(76176011)(81156014)(446003)(99286004)(86362001)(7736002)(486006)(102836004)(54906003)(256004)(11346002)(476003)(4326008)(551934003)(53936002)(14454004)(316002)(26005)(5660300001)(33656002)(186003)(305945005)(110136005)(74316002)(81166006)(6246003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3110;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gp4mUp1xMO13i+q83wxl1DsoH4Vl1dRCRfpf9AHNmKUS7JxEeNrzKyAc1xFyGsDkA140dSiyUQIvYkh7OAUzDX3M4/3mwcweQqSn2hwLPQQk7QndcNyMXLJtAuz2ofx7uuLjXWbOgJXIoKkpiVs9PzsSOFUytWWAj9f5qMY0a7Zs+D5nrEqh2L2gAb/tShMenStpGaQGMCzi8WnQ/qRGlaabf5XumwAxsZIX9v8wNo2Om7O0TBhJpxx8SpjVA28O/C8Lv8ldeQyu80CeANzcUFmk4ADubiBV7TI5Pe10BT5VYLyQwhvbGZ7PI7eLXxkz5WK8wurZIsYhWir3pZCKsxwXlpfHBsWe2VooxqH88rc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddfa412-4989-4fb5-7f57-08d5e706928a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 08:16:15.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlub2QgW21haWx0bzp2
a291bEBrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE45bm0N+aciDEx5pelIDE1OjE5DQo+IFRvOiBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5j
b20+OyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IEZh
YmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47DQo+IGxpbnV4QGFybWxpbnV4Lm9y
Zy51azsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEgMy80XSBkbWFlbmdpbmU6IGlteC1zZG1hOiBzdXBwb3J0IGRtYXRl
c3QNCj4gDQo+IE9uIDExLTA3LTE4LCAwODo1Mywgcy5oYXVlckBwZW5ndXRyb25peC5kZSB3cm90
ZToNCj4gPiBPbiBXZWQsIEp1bCAxMSwgMjAxOCBhdCAwNjozNzowMkFNICswMDAwLCBSb2JpbiBH
b25nIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+ID4gRnJvbTogVmlub2QgW21haWx0bzp2a291bEBrZXJuZWwub3JnXQ0KPiA+ID4gPiBTZW50
OiAyMDE45bm0N+aciDEw5pelIDIzOjMzDQo+ID4gPiA+IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5n
b25nQG54cC5jb20+DQo+ID4gPiA+IENjOiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+ID4gPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IEZhYmlvIEVz
dGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47DQo+ID4gPiA+IGxpbnV4QGFybWxpbnV4Lm9y
Zy51azsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy80XSBkbWFlbmdpbmU6IGlteC1z
ZG1hOiBzdXBwb3J0IGRtYXRlc3QNCj4gPiA+ID4NCj4gPiA+ID4gT24gMTEtMDctMTgsIDAwOjIz
LCBSb2JpbiBHb25nIHdyb3RlOg0KPiA+ID4gPiA+IGRtYXRlc3QobWVtY3B5KSB3aWxsIG5ldmVy
IGNhbGwgZG1hZW5naW5lX3NsYXZlX2NvbmZpZyBiZWZvcmUNCj4gPiA+ID4gPiBwcmVwLA0KPiA+
ID4gPg0KPiA+ID4gPiBhbmQgdGhhdCBzaG91bGQgaGF2ZSBiZWVuIGEgaGludCB0byB5b3UgdGhh
dCB5b3Ugc2hvdWxkIG5vdCBleHBlY3QNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPg0KPiA+ID4gPiA+
IHNvIGpvYnMgaW4gZG1hZW5naW5lX3NsYXZlX2NvbmZpZyBuZWVkIHRvIGJlIG1vdmVkIGludG8N
Cj4gPiA+ID4gPiBzb21ld2hlcmUgYmVmb3JlIGRldmljZV9wcmVwX2RtYV9tZW1jcHkuIEJlc2lk
ZXMsIGRtYXRlc3QgbmV2ZXINCj4gPiA+ID4gPiBzZXR1cCBjaGFuDQo+ID4gPiA+ID4gLT5wcml2
YXRlIGFzIG90aGVyIGNvbW1vbiBjYXNlIGxpa2UgdWFydC9hdWRpby9zcGkgd2lsbCBhbHdheXMN
Cj4gPiA+ID4gPiAtPnNldHVwDQo+ID4gPiA+ID4gY2hhbi0+cHJpdmF0ZS4gSGVyZSBjaGVjayBp
dCB0byBqdWRnZSBpZiBpdCdzIGRtYXRlc3QgY2FzZSBhbmQNCj4gPiA+ID4gPiBjaGFuLT5kbw0K
PiA+ID4gPiA+IGpvYnMgaW4gc2xhdmVfY29uZmlnLg0KPiA+ID4gPg0KPiA+ID4gPiBhbmQgeW91
IHNob3VsZCBub3QgZG8gYW55dGhpbmcgZm9yIGRtYXRlc3QuIFN1cHBvcnRpbmcgaXQgbWVhbnMN
Cj4gPiA+ID4gbWVtY3B5IGltcGxlbWVudGF0aW9uIGlzIG5vdCBjb3JyZWN0IDopDQo+ID4gPiBP
a2F5LCBJIHdpbGwgYW55IHdvcmQgYWJvdXQgZG1hdGVzdCBoZXJlIHNpbmNlIG1lbWNweSBhc3N1
bWUgbm8NCj4gPiA+IGNhbGxpbmcgc2xhdmVfY29uZmlnLg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0K
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMzcNCj4g
PiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2
ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ID4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gPiBlZDIyNjdkLi40
OGYzNzQ5IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4g
PiA+ID4gPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ID4gPiA+ID4gQEAgLTEyMjIs
MTAgKzEyMjIsMzYgQEAgc3RhdGljIGludA0KPiA+ID4gPiA+IHNkbWFfYWxsb2NfY2hhbl9yZXNv
dXJjZXMoc3RydWN0IGRtYV9jaGFuICpjaGFuKSAgew0KPiA+ID4gPiA+ICAJc3RydWN0IHNkbWFf
Y2hhbm5lbCAqc2RtYWMgPSB0b19zZG1hX2NoYW4oY2hhbik7DQo+ID4gPiA+ID4gIAlzdHJ1Y3Qg
aW14X2RtYV9kYXRhICpkYXRhID0gY2hhbi0+cHJpdmF0ZTsNCj4gPiA+ID4gPiArCXN0cnVjdCBp
bXhfZG1hX2RhdGEgZGVmYXVsdF9kYXRhOw0KPiA+ID4gPiA+ICAJaW50IHByaW8sIHJldDsNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IC0JaWYgKCFkYXRhKQ0KPiA+ID4gPiA+IC0JCXJldHVybiAtRUlO
VkFMOw0KPiA+ID4gPiA+ICsJcmV0ID0gY2xrX2VuYWJsZShzZG1hYy0+c2RtYS0+Y2xrX2lwZyk7
DQo+ID4gPiA+ID4gKwlpZiAocmV0KQ0KPiA+ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiA+
ID4gKwlyZXQgPSBjbGtfZW5hYmxlKHNkbWFjLT5zZG1hLT5jbGtfYWhiKTsNCj4gPiA+ID4gPiAr
CWlmIChyZXQpDQo+ID4gPiA+ID4gKwkJZ290byBkaXNhYmxlX2Nsa19pcGc7DQo+ID4gPiA+ID4g
KwkvKg0KPiA+ID4gPiA+ICsJICogZG1hdGVzdChtZW1jcHkpIHdpbGwgbmV2ZXIgY2FsbCBkbWFl
bmdpbmVfc2xhdmVfY29uZmlnIGJlZm9yZQ0KPiBwcmVwLA0KPiA+ID4gPiA+ICsJICogc28gam9i
cyBpbiBkbWFlbmdpbmVfc2xhdmVfY29uZmlnIG5lZWQgdG8gYmUgbW92ZWQgaW50bw0KPiBzb21l
d2hlcmUNCj4gPiA+ID4gPiArCSAqIGJlZm9yZSBkZXZpY2VfcHJlcF9kbWFfbWVtY3B5LiBCZXNp
ZGVzLCBkbWF0ZXN0IG5ldmVyIHNldHVwDQo+IGNoYW4NCj4gPiA+ID4gPiArCSAqIC0+cHJpdmF0
ZSBhcyBvdGhlciBjb21tb24gY2FzZXMgbGlrZSB1YXJ0L2F1ZGlvL3NwaSB3aWxsIHNldHVwDQo+
ID4gPiA+ID4gKwkgKiBjaGFuLT5wcml2YXRlIGFsd2F5cy4gSGVyZSBjaGVjayBpdCB0byBqdWRn
ZSBpZiBpdCdzIGRtYXRlc3QgY2FzZQ0KPiA+ID4gPiA+ICsJICogYW5kIGRvIGpvYnMgaW4gc2xh
dmVfY29uZmlnLg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gKwlpZiAoIWRhdGEpIHsNCj4g
PiA+ID4gPiArCQlkZXZfd2FybihzZG1hYy0+c2RtYS0+ZGV2LCAiZG1hdGVzdCBpcyBydW5uaW5n
P1xuIik7DQo+ID4gPiA+DQo+ID4gPiA+IHdoeSBpcyB0aGF0IGEgd2FybmluZyENCj4gPiA+IEN1
cnJlbnQgU0RNQSBkcml2ZXIgYXNzdW1lIGZpbHRlciBmdW5jdGlvbiB0byBzZXQgY2hhbi0+cHJp
dmF0ZSB3aXRoDQo+ID4gPiBzcGVjaWZpYyBkYXRhIChzdHJ1Y3QgaW14X2RtYV9kYXRhIGRtYV9k
YXRhKWxpa2UgYmVsb3cNCj4gKHNvdW5kL3NvYy9mc2wvZnNsX2FzcmNfZG1hLmMpOg0KPiA+ID4g
c3RhdGljIGJvb2wgZmlsdGVyKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgdm9pZCAqcGFyYW0pIHsN
Cj4gPiA+ICAgICAgICAgaWYgKCFpbXhfZG1hX2lzX2dlbmVyYWxfcHVycG9zZShjaGFuKSkNCj4g
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiAgICAgICAgIGNoYW4tPnBy
aXZhdGUgPSBwYXJhbTsNCj4gPiA+ICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gPiB9DQo+ID4g
Pg0KPiA+ID4gQnV0IGluIG1lbWNweSBjYXNlLCBhdCBsZWFzZSBkbWF0ZXN0IGNhc2UsIG5vIGNo
YW4tPnByaXZhdGUgc2V0IGluIGl0cyBmaWx0ZXINCj4gZnVuY3Rpb24uDQo+ID4gPiBTbyBoZXJl
IHRha2UgZG1hdGVzdCBhIHNwZWNpYWwgY2FzZSBhbmQgZG8gc29tZSBwcmVwYXJlIGpvYnMgZm9y
DQo+ID4gPiBtZW1jcHkuIEJ1dCBpZiB0aGUgVXBwZXIgZGV2aWNlIGRyaXZlciBjYWxsIGRtYV9y
ZXF1ZXN0X2NoYW5uZWwoKQ0KPiA+ID4gd2l0aCB0aGVpciBzcGVjaWZpYyBmaWx0ZXIgd2l0aG91
dCAnY2hhbi0+cHJpdmF0ZScgc2V0dGluZyBpbiB0aGUNCj4gPiA+IGZ1dHVyZS4gVGhlIHdhcm5p
bmcgbWVzc2FnZSBpcyBhIHVzZWZ1bCBoaW50IHRvIHRoZW0gdG8gQWRkICdjaGFuLT5wcml2YXRl
Jw0KPiBpbiBmaWx0ZXIgZnVuY3Rpb24uICBPciBkb2MgaXQgc29tZXdoZXJlPw0KPiA+DQo+ID4g
SW5zdGVhZCBvZiBkb2luZyBoZXVyaXN0aWNzIHRvIGd1ZXNzIHdoZXRoZXIgd2UgYXJlIGRvaW5n
IG1lbWNweSB5b3UNCj4gPiBjb3VsZCBpbnN0ZWFkIG1ha2UgbWVtY3B5IHRoZSBkZWZhdWx0IHdo
ZW4gc2xhdmVfY29uZmlnIGlzIG5vdCBjYWxsZWQsDQo+ID4gaS5lLiBkcm9wIHRoZSBpZiAoIWRh
dGEpIGNoZWNrIGNvbXBsZXRlbHkuDQo+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiArCQlzZG1hYy0+
d29yZF9zaXplICA9DQo+IHNkbWFjLT5zZG1hLT5kbWFfZGV2aWNlLmNvcHlfYWxpZ247DQo+ID4g
PiA+ID4gKwkJZGVmYXVsdF9kYXRhLnByaW9yaXR5ID0gMjsNCj4gPiA+ID4gPiArCQlkZWZhdWx0
X2RhdGEucGVyaXBoZXJhbF90eXBlID0gSU1YX0RNQVRZUEVfTUVNT1JZOw0KPiA+ID4gPiA+ICsJ
CWRlZmF1bHRfZGF0YS5kbWFfcmVxdWVzdCA9IDA7DQo+ID4gPiA+ID4gKwkJZGVmYXVsdF9kYXRh
LmRtYV9yZXF1ZXN0MiA9IDA7DQo+ID4gPiA+ID4gKwkJZGF0YSA9ICZkZWZhdWx0X2RhdGE7DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJCXNkbWFfY29uZmlnX293bmVyc2hpcChzZG1hYywgZmFs
c2UsIHRydWUsIGZhbHNlKTsNCj4gPiA+ID4gPiArCQlzZG1hX2dldF9wYyhzZG1hYywgSU1YX0RN
QVRZUEVfTUVNT1JZKTsNCj4gPiA+ID4gPiArCQlzZG1hX2xvYWRfY29udGV4dChzZG1hYyk7DQo+
ID4gPiA+ID4gKwl9DQo+ID4gPiA+DQo+ID4gPiA+IHRoaXMgbmVlZHMgdG8gYmUgZGVmYXVsdCBm
b3IgbWVtY3B5DQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBzZWVtcyB0byBiZSB0aGF0IHdlIGRvIG5v
dCBrbm93IHdoZXRoZXIgd2UgYXJlIGRvaW5nDQo+ID4gbWVtY3B5IG9yIG5vdC4gTm9ybWFsbHkg
d2UgZ2V0IHRoZSBpbmZvcm1hdGlvbiBob3cgYSBjaGFubmVsIGlzIHRvIGJlDQo+ID4gY29uZmln
dXJlZCBpbiBkbWFfZGV2aWNlLT5kZXZpY2VfY29uZmlnLCBidXQgdGhpcyBmdW5jdGlvbiBpcyBu
b3QNCj4gPiBjYWxsZWQgaW4gdGhlIG1lbWNweSBjYXNlLg0KPiANCj4gTm90IHJlYWxseSB0cnVl
LCBkZXZpY2VfY29uZmlnIG9ubHkgcHJvdmlkZXMgcGFyYW1ldGVycyB0byBiZSBjb25maWd1cmVk
IGZvcg0KPiBuZXh0IHNsYXZlIHRyYW5zYWN0aW9uDQo+IA0KPiA+IEFuIGFsdGVybmF0aXZlIG1p
Z2h0IGFsc28gYmUgdG8gZG8gdGhlIHNldHVwIGluDQo+IGRtYV9kZXZpY2UtPmRldmljZV9wcmVw
X2RtYV9tZW1jcHkuDQo+IA0KPiBQcmVjaXNlbHksIHNlZSBob3cgb3RoZXIgZHJpdmVycyBkbyB0
aGlzDQo+IA0KPiBMZXQncyByb2xsIGJhY2sgYSBiaXQgYW5kIGZvcmVzZWUgd2h5IGlzIHRoaXMg
cmVxdWlyZWQuDQo+IA0KPiBJbiBjYXNlIG9mIG1lbWNweSwgeW91IG5lZWQgdG8gdGVsbCBETUEg
dG8gZG8gdHJhbnNmZXIgZnJvbSBzcmMgdG8gZHN0biBhbmQNCj4gc2l6ZS4gQWRkaXRpb25hbCBw
YXJhbWV0ZXJzIGxpa2UgYnVzd2lkdGggZXRjIHNob3VsZCBiZSBkZXJpdmVkIGZvciBtYXhpbXVt
DQo+IHRocm91Z2hwdXQgKGFmdGVyIGFsbCB3ZSBhcmUgZG1hLCBwZW9wbGUgd2FudCBpdCB0byBi
ZSBkb25lDQo+IGZhc3Rlc3QpDQo+IA0KPiBOb3cgZm9yIHNsYXZlLCB5b3UgYXJlIGludGVyZmFj
aW5nIHdpdGggYSBwZXJpcGhlcmFsIGFuZCBkb24ndCBrbm93IGhvdyB0aGF0IGlzDQo+IHNldHVw
LiBTbyB5b3UgbmVlZCB0byBtYXRjaCB0aGUgcGFyYW1ldGVycywgb3RoZXJ3aXNlIHlvdSBnZXQg
b3ZlcmZsb3cgb3INCj4gdW5kZXJmbG93IGFuZCBoZW5jZSBuZWVkIGZvciBkZXZpY2VfY29uZmln
DQo+IA0KPiBQbGVhc2UgZG8gbm90IGRlcml2ZSBhZGRpdGlvbmFsIG5vdGlvbnMgZnJvbSB0aGVz
ZSwgcGxlYXNlIGRvIG5vdCBhc3N1bWUNCj4gYW55dGhpbmcgZWxzZSwgdW5sZXNzIHByb3ZpZGVk
IGluIGRvY3VtZW50YXRpb24gOikNCkkgd2lsbCBtb3ZlIHN1Y2ggcHJlcGFyZSBqb2JzIGZyb20g
c2xhdmVfY29uZmlnIHRvIGRldmljZV9wcmVwX2RtYV9tZW1jcHkNCkluc3RlYWQgb2YgZGV2aWNl
X2FsbG9jX2NoYW5fcmVzb3VyY2VzIGFzIEkgZGlkIGluIHYxLCB0aHVzIHdlIGhhdmUgbm8gJ2No
YW4tPnByaXZhdGUnDQppc3N1ZSwganVzdCBsaWtlIGRyaXZlcnMvZG1hL3N0bTMyLW1kbWEuYy4g
VGhlIG9ubHkgbGltaXRhdGlvbiBpcyB0aG9zZSBwcmVwYXJlIGpvYnMNCihzb21lIHJlZ2lzdGVy
IHNldHRpbmcpIHdpbGwgYmUgZG9uZSBldmVyeSB0aW1lIG1lbWNweSBpbnN0ZWFkIG9mIG9ubHkg
b25lIHRpbWUgaW4gc2xhdmVfY29uZmlnDQpvciB2MSBjYXNlLiBJcyB0aGF0IG9rPw0KPiANCj4g
SW4gZG91YnQsIGp1c3QgYXNrIQ0KPiANCj4gSFRIDQo+IC0tDQo+IH5WaW5vZA0K
