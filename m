Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4742089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uUvkbmvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4742089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeGJNSF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:18:05 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:26624
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932998AbeGJNSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lri9uFFKaQwwZP2pTm8c/SllSg7E6XoCvKATogp8u4U=;
 b=uUvkbmvdkZ3ESdBoAxI57p9rSm3WkeYw8TNm/s/AsBweoe6D3aG00rQn5B26vm4Rf6BFTp61O2+2DwcjfdPP8jaB0bXQEpun7UK1SiL+LzT3p9XwXCXj8Me9GtaRB7/s2gcvLu6BuRL+GEdzSKa/uUX5P+OlEldQl+mCq59eJb4=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5121.eurprd04.prod.outlook.com (20.177.40.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 13:18:00 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4%2]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 13:18:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>
CC:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
Thread-Topic: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
Thread-Index: AQHUF3+nliCqjbusPUWrVmjYKcysXKSHeq6AgAD3KoA=
Date:   Tue, 10 Jul 2018 13:18:00 +0000
Message-ID: <8aba202031bb222d9d78f8ac272757c930aff0c5.camel@nxp.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com>
         <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
         <CAPDyKFoELWSiZ4cfOByziPQzqW7Tx3m29qKu9uCKPHO1gXO4YA@mail.gmail.com>
In-Reply-To: <CAPDyKFoELWSiZ4cfOByziPQzqW7Tx3m29qKu9uCKPHO1gXO4YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5121;7:wvBuMC6cklz2FE5Ae217gqtqr10sL592zb/UIt9pCqjMoenI+zEJwlcJGo7c6iTx3xgfLwxAJfF7TgJ5h9yz0yiRDYJLqpoeyMkwhD/WVE+lV3ZOdvBTB9ZD7J+zg1efv+mAVx1DhPB7eeJnR96aMnd28Pr926Ff4IsQAWnfk9Ts5sfic0X+r9Wz02qCNkcK9JUORnVJRxB+O6wBvt9ky5yMfO/r/Gew3hN7DmKxEAynmACiMW3QbVmtCGGfL89D
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d87af28-56fd-40e1-911e-08d5e6678f3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5121;
x-ms-traffictypediagnostic: AM0PR04MB5121:
x-microsoft-antispam-prvs: <AM0PR04MB51211983C0D99690ACB783FDEE5B0@AM0PR04MB5121.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(185117386973197)(45079756050767)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5121;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5121;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(2501003)(36756003)(106356001)(105586002)(229853002)(54906003)(53936002)(86362001)(575784001)(316002)(256004)(6436002)(14444005)(25786009)(66066001)(2906002)(110136005)(5250100002)(6486002)(97736004)(99286004)(6116002)(3846002)(7736002)(118296001)(68736007)(81166006)(50226002)(2900100001)(8936002)(14454004)(186003)(6636002)(53546011)(478600001)(102836004)(45080400002)(81156014)(76176011)(2616005)(446003)(6506007)(305945005)(966005)(6246003)(6512007)(5660300001)(8676002)(476003)(4326008)(26005)(486006)(6306002)(11346002)(44832011)(523214003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5121;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bf+K1JwD9HCT9Ox1LdiKvh5xVauTSqqBrQ4cA1sA3OlmCs04rfwnU8OF+0P6Huh+3w8v7K3RyOaS9H/Patinllh0H53f5oqsOvVeyqxup+2ncfktZtNvemXpDYbIWfro/lm+ilckwFacomSyST3UKhBuh7nJ5s34Lq95XxSNrXeVsF7asNsoVoxAD4EQSm0PBS94yMbOBuPvH4XQs6G3CXnZtolk6ecwaacg+vuFAd97AZPAKzyVS8w8cdinK85MAB0rABuCZ0ltqmkmCpkxqJXiHIfRnsdGPnXyqcl914wTz0b7kf848X9cbmL6q71dQx+9AgFkOFHq2TheSG2an4luX7tEZpHw/LJZow9O3Z4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4745B48E10433C4BB79923384F93F493@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d87af28-56fd-40e1-911e-08d5e6678f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 13:18:00.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTEwIGF0IDAwOjMzICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gOSBKdWx5IDIwMTggYXQgMTQ6MjMsIExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6
QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+IFRoZSBpbXg2c2wgY2hpcCBlcnJhdGEgZG9jdW1lbnQg
ZGVzY3JpYmVzIEVSUjAwNjI4NyBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gIiIiDQo+ID4gVXBvbiBy
ZXN1bWluZyBmcm9tIHBvd2VyIGdhdGluZywgdGhlIG1vZHVsZXMgaW4gdGhlIGRpc3BsYXkgcG93
ZXINCj4gPiBkb21haW4NCj4gPiAoZUxDRElGLCBFUERDLCBQWFAgYW5kIFNQREMpIG1pZ2h0IGZh
aWwgdG8gcGVyZm9ybSByZWdpc3RlciByZWFkcw0KPiA+IGNvcnJlY3RseS4NCj4gPiANCj4gPiBX
aGVuIHRoZSBtb2R1bGVzIGxpc3RlZCBhYm92ZSBhcmUgdXNlZCwgZG8gbm90IHVzZSBwb3dlciBn
YXRpbmcgb24NCj4gPiB0aGUNCj4gPiBkaXNwbGF5IHBvd2VyIGRvbWFpbi4NCj4gPiAiIiINCj4g
PiANCj4gPiBMaW5rOiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBDQo+ID4gJTJGJTJGd3d3Lm54cC5jb20lMkZkb2NzJTJGZW4lMkZl
cnJhdGElMkZJTVg2U0xDRS5wZGYlMjNwYWdlJTNENjImYQ0KPiA+IG1wO2RhdGE9MDIlN0MwMSU3
Q2xlb25hcmQuY3Jlc3RleiU0MG54cC5jb20lN0NkYmM1YjAwYTk3YzU0OGM0NzAzMjANCj4gPiA4
ZDVlNWViZmIyNCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzElN0M2
MzY2Njc3MjQwDQo+ID4gNTA4MzMyNTYmYW1wO3NkYXRhPVZnWUlHR1RZUTBDaFIlMkZDRUJTWkox
RDFKeWZKUkRpOTZZSGElMkJ5dDRRcjVzJQ0KPiA+IDNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gDQo+
ID4gSGFuZGxlIHRoaXMgaW4gbGludXggaW4gdGhlIHNhbWUgd2F5IGFzIGlteDZxcCBFUlIwMDk2
MTk6IG1ha2UgdGhlDQo+ID4gRElTUA0KPiA+IGRvbWFpbiByZXR1cm4gLUVCVVNZIG9uIHBvd2Vy
X29mZi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQu
Y3Jlc3RlekBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9pbXgvZ3BjLmMgfCAx
MCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9ncGMuYyBiL2RyaXZlcnMvc29jL2lt
eC9ncGMuYw0KPiA+IGluZGV4IDUyNmYyZDAyZGM3OC4uNmI3MjZkYWRhNTYwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvc29jL2lteC9ncGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9n
cGMuYw0KPiA+IEBAIC0zMzksMzAgKzMzOSwzNSBAQCBzdGF0aWMgc3RydWN0IGlteF9wbV9kb21h
aW4gaW14X2dwY19kb21haW5zW10NCj4gPiA9IHsNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3RydWN0
IGlteF9ncGNfZHRfZGF0YSB7DQo+ID4gICAgICAgICBpbnQgbnVtX2RvbWFpbnM7DQo+ID4gICAg
ICAgICBib29sIGVycjAwOTYxOV9wcmVzZW50Ow0KPiA+ICsgICAgICAgYm9vbCBlcnIwMDYyODdf
cHJlc2VudDsNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfZ3Bj
X2R0X2RhdGEgaW14NnFfZHRfZGF0YSA9IHsNCj4gPiAgICAgICAgIC5udW1fZG9tYWlucyA9IDIs
DQo+ID4gICAgICAgICAuZXJyMDA5NjE5X3ByZXNlbnQgPSBmYWxzZSwNCj4gPiArICAgICAgIC5l
cnIwMDYyODdfcHJlc2VudCA9IGZhbHNlLA0KPiA+ICB9Ow0KPiA+IA0KPiA+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IGlteF9ncGNfZHRfZGF0YSBpbXg2cXBfZHRfZGF0YSA9IHsNCj4gPiAgICAgICAg
IC5udW1fZG9tYWlucyA9IDIsDQo+ID4gICAgICAgICAuZXJyMDA5NjE5X3ByZXNlbnQgPSB0cnVl
LA0KPiA+ICsgICAgICAgLmVycjAwNjI4N19wcmVzZW50ID0gZmFsc2UsDQo+ID4gIH07DQo+ID4g
DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X2dwY19kdF9kYXRhIGlteDZzbF9kdF9kYXRh
ID0gew0KPiA+ICAgICAgICAgLm51bV9kb21haW5zID0gMywNCj4gPiAgICAgICAgIC5lcnIwMDk2
MTlfcHJlc2VudCA9IGZhbHNlLA0KPiA+ICsgICAgICAgLmVycjAwNjI4N19wcmVzZW50ID0gdHJ1
ZSwNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfZ3BjX2R0X2Rh
dGEgaW14NnN4X2R0X2RhdGEgPSB7DQo+ID4gICAgICAgICAubnVtX2RvbWFpbnMgPSA0LA0KPiA+
ICAgICAgICAgLmVycjAwOTYxOV9wcmVzZW50ID0gZmFsc2UsDQo+ID4gKyAgICAgICAuZXJyMDA2
Mjg3X3ByZXNlbnQgPSBmYWxzZSwNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgaW14X2dwY19kdF9pZHNbXSA9IHsNCj4gPiAgICAgICAgIHsgLmNv
bXBhdGlibGUgPSAiZnNsLGlteDZxLWdwYyIsIC5kYXRhID0gJmlteDZxX2R0X2RhdGEgfSwNCj4g
PiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZxcC1ncGMiLCAuZGF0YSA9ICZpbXg2
cXBfZHRfZGF0YQ0KPiA+IH0sDQo+ID4gQEAgLTQ2NywxMCArNDcyLDE1IEBAIHN0YXRpYyBpbnQg
aW14X2dwY19wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAg
ICAgICAvKiBEaXNhYmxlIFBVIHBvd2VyIGRvd24gaW4gbm9ybWFsIG9wZXJhdGlvbiBpZiBFUlIw
MDk2MTkNCj4gPiBpcyBwcmVzZW50ICovDQo+ID4gICAgICAgICBpZiAob2ZfaWRfZGF0YS0+ZXJy
MDA5NjE5X3ByZXNlbnQpDQo+ID4gICAgICAgICAgICAgICAgIGlteF9ncGNfZG9tYWluc1tHUENf
UEdDX0RPTUFJTl9QVV0uZmxhZ3MgfD0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFBHQ19ET01BSU5fRkxBR19OT19QRDsNCj4gPiANCj4gPiArICAgICAgIC8qIERpc2FibGUg
RElTUCBwb3dlciBkb3duIGluIG5vcm1hbCBvcGVyYXRpb24gaWYgRVJSMDA2Mjg3DQo+ID4gaXMg
cHJlc2VudCAqLw0KPiA+ICsgICAgICAgaWYgKG9mX2lkX2RhdGEtPmVycjAwNjI4N19wcmVzZW50
KQ0KPiA+ICsgICAgICAgICAgICAgICBpbXhfZ3BjX2RvbWFpbnNbR1BDX1BHQ19ET01BSU5fRElT
UExBWV0uZmxhZ3MgfD0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBHQ19E
T01BSU5fRkxBR19OT19QRDsNCj4gPiArDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYSB1c2UtY2Fz
ZSBmb3IgYW4gYWx3YXlzIHBvd2VyZWQgb24gUE0gZG9tYWluPw0KPiANCj4gSWYgdGhhdCdzIHRo
ZSBjYXNlLCBHRU5QRF9GTEFHX0FMV0FZU19PTiBkb2VzIHRoZSB0cmljaywgYnV0IG1vcmUNCj4g
ZWZmaWNpZW50IGFzIGl0IGVuYWJsZXMgZ2VucGQgdG8gdGFrZSBhIGZldyBzaG9ydGN1dHMgd2hl
biB0cnlpbmcgdG8NCj4gcG93ZXIgb2YgYSBQTSBkb21haW4uDQoNCkdFTlBEX0ZMQUdfQUxXQVlT
X09OIHdvdWxkIGJlIGEgcmVhc29uYWJsZSBoZXJlLg0KDQpJIHNlYXJjaGVkIGJ1dCBJJ3ZlIGJl
ZW4gdW5hYmxlIHRvIGZpbmQgYSBnb29kIHJlZmVyZW5jZSBmb3Igc2NlbmFyaW9zDQp3aGVyZSBw
b3dlciBnYXRpbmcgRElTUCBvbiA2c2wgaXMgc3RpbGwgc3VwcG9ydGVkLiBJIHRoaW5rIGl0IHNo
b3VsZCBiZQ0Kc2FmZSB0byB0dXJuIG9mZiBpbiBzdXNwZW5kIGJ1dCB0aGlzIGlzIG9ubHkgYmFz
ZWQgYmFzZWQgb24gb2xkIGNvbW1pdHMNCmZyb20gdGhlIGlteCBpbnRlcm5hbCB0cmVlLg0KDQpS
aWdodCBub3cgZGlzcGxheXMgb24gaW14NnNsIGRvbid0IHdvcmsgYXQgYWxsIGJlY2F1c2Ugbm90
aGluZyBpcw0KaW5zaWRlIHRoZSBESVNQIGFuZCBpdCBnZXRzIHBvd2VyZWQgb2ZmLiBGaXhpbmcg
dGhpcyBpbiB0aGUgc2FmZXN0IGFuZA0KbW9zdCB1bmNvbnRyb3ZlcnNpYWwgd2F5IHdvdWxkIGJl
IHdvcnRod2hpbGUsIHllcz8=
