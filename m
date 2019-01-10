Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E90C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5021738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/+BmORh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfAJFNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:13:43 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:34472
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfAJFNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJYWTp2UF1IlrJokz/5918ZkaA4eG/Iv6Q16lVC5o9Y=;
 b=R/+BmORhRp16KmM5EirhlKU/h16clwlf/rjuzA7UFTEsjz7Syw2WQ3eUKTQTFg+WTiNu/aQMm2y4ooy9Qpb/s9cIIdZE3n/XuEX2Oc+AgDCTQzJCg5YW2U8jb8fl628hLELpQhLP88CxE8xfdP7BbJuislNF28XBLxEvP1DnBgM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5278.eurprd04.prod.outlook.com (20.177.51.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 05:12:45 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 05:12:45 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP4PV9+XjynmUWrRoOqEAtjTqWm7WUAgAEJsCA=
Date:   Thu, 10 Jan 2019 05:12:45 +0000
Message-ID: <VI1PR04MB5726A7CD5886403774D870B999840@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
In-Reply-To: <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5278;6:58c6C41vz3Mr781BXe1yX5GODpmOC/InU3q0+e4yQi9tNEU0kOPtuHWx9rHf/2FP/dkOd4l+QNzXjFGGSjggTUl0nvZza8k4NQYp2a2vKNB/9MEb7q450mEYT35G84+ZJ9zjmQL3/ansk5WslCgsLJgHm7C+57yZJB1DveOwJ4be7H2luqQA2E3yvbX0Opy+xNN5ClFyGpzDmCeVhpTCGGtvGBTTieuzQdoLxuTCqeUsdkVKVdOz48XDjJxaeY4FHbf8ydVZbMNtCpfNtBB1/8Hr1MQZp6rL+u+a7afPrqSYQcVsS8VnNjqeNGNrkOyeufc8mx/IDGHe5wYjIV3+I1BabQZ8uK5eZfhlvgK50VVuAFSSRnmsOGcn94eY80fOybU9O/rq41m1Yr+M1kTSsWcyLyEAe9JMQw6GvytSSWj9kFtHjz/zs0Gsw8M9S+E1tT9NPXkJSIDMECDuVsDq6Q==;5:4i81Vne2LX07Tru8HgVaxzId89GkRKoGumDNI6mfw/bJ6cKwt5v2Tq9odI9Ysl1Z1HK7dDjylK8I57SF6V6ZuLyFHd6uB5H5fE2BSvLwTRQ1/vPaUEK7C+PJpj+PjaAgem6HPfi4b9bNDXoLKqj3rDJF0kfUiIKOQKOrTMMpHKWEiWValWVLFmKdl9eQsDRJzuygRsT0SEfDChAhAstjNw==;7:jcIBV0FNJwJOf0fTmuJ/yEYhl8gPzTT1GllDG7ZWbOg5PlSST29f2drd0dKzU/qhesP0hi4l5Rhgm2sQuewSD9moDMh7BNg2aOsXeIoO8T7uvAhMRx0gd80arh/hFAsJ1UPrfSpjj9mFtAXSfJue9w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50f51b9d-2608-4adc-8de0-08d676ba4178
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5278;
x-ms-traffictypediagnostic: VI1PR04MB5278:
x-microsoft-antispam-prvs: <VI1PR04MB527890D03E8873F3D07CBB3799840@VI1PR04MB5278.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5278;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(13464003)(8936002)(256004)(99286004)(575784001)(86362001)(478600001)(53936002)(14454004)(6306002)(9686003)(486006)(966005)(76176011)(2906002)(55236004)(6506007)(7696005)(53546011)(6246003)(102836004)(186003)(26005)(106356001)(105586002)(7736002)(305945005)(2201001)(39060400002)(45080400002)(66066001)(4326008)(74316002)(476003)(446003)(11346002)(25786009)(5660300001)(7416002)(68736007)(78486014)(2501003)(33656002)(316002)(97736004)(81156014)(54906003)(55016002)(110136005)(81166006)(6436002)(6116002)(229853002)(3846002)(8676002)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5278;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PefqD0tMh1Pb0SUNiVPu6bbwrYYEdydl0zQOk508aiH9C4PM2YDNPayjAkZ+ePddENb94cjaXAkjEmgXQimyHJKmQJAmxW0DHErHSH1peIFwGLHuiwSja95MHZAOzubbC/jkI+BbVrqquqn+LQam2STmYJUtnET0HuJpTMxMawS3MkR8aTpJUw9mbvpaGZY/YeJLLTY3L7SXm3psv7E+PtgHV2om4ST7EXpQjHvNbz1qk3stXJsPrQiGI4jWD7xGqasDiyA9hZy0cG8m3id7Ed9beBY60+in5PLR7nq81w3tdu5/vat8wyBvhaNl1Ko7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f51b9d-2608-4adc-8de0-08d676ba4178
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 05:12:45.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTY2hy
ZW1wZiBGcmllZGVyIFttYWlsdG86ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlXQ0KPiBTZW50
OiBXZWRuZXNkYXksIEphbnVhcnkgOSwgMjAxOSA3OjQ5IFBNDQo+IFRvOiBZb2dlc2ggTmFyYXlh
biBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IGxpbnV4LQ0KPiBtdGRAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgYm9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tOyBtYXJlay52YXN1dEBn
bWFpbC5jb207DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAw
LzVdIHNwaTogc3BpLW1lbTogQWRkIGRyaXZlciBmb3IgTlhQIEZsZXhTUEkgY29udHJvbGxlcg0K
PiANCj4gT24gMDguMDEuMTkgMTA6MjQsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+ID4g
LSBBZGQgZHJpdmVyIGZvciBOWFAgRmxleFNQSSBob3N0IGNvbnRyb2xsZXINCj4gPg0KPiA+ICAg
RmxleFNQSSBpcyBhIGZsZXhzaWJsZSBTUEkgaG9zdCBjb250cm9sbGVyIFsxXSwgQ2hhcHRlciAz
MCBwYWdlIDE0NzUsDQo+ID4gICB3aGljaCBzdXBwb3J0cyB0d28gU1BJIGNoYW5uZWxzIGFuZCB1
cCB0byA0IGV4dGVybmFsIGRldmljZXMuDQo+ID4gICBFYWNoIGNoYW5uZWwgc3VwcG9ydHMgU2lu
Z2xlL0R1YWwvUXVhZC9PY3RhbCBtb2RlIGRhdGEgdHJhbnNmZXIgKDEvMi80LzgNCj4gYmlkaXJl
Y3Rpb25hbCBkYXRhIGxpbmVzKQ0KPiA+ICAgaS5lLiBGbGV4U1BJIGFjdHMgYXMgYW4gaW50ZXJm
YWNlIHRvIGV4dGVybmFsIGRldmljZXMsIG1heGltdW0gNCwgZWFjaCB3aXRoIHVwDQo+IHRvIDgN
Cj4gPiAgIGJpZGlyZWN0aW9uYWwgZGF0YSBsaW5lcy4NCj4gPg0KPiA+IC0gVGVzdGVkIHRoaXMg
ZHJpdmVyIHdpdGggbXRkX2RlYnVnKEVyYXNlL1dyaXRlL1JlYWQpIHV0aWxpdHkgYW5kIEpGRlMy
DQo+ID4gICBmaWxlc3lzdGVtIG1vdW50aW5nIGFuZCBib290aW5nIG9uIE5YUCBMWDIxNjBBUkRC
WzJdIGFuZCBMWDIxNjBBUURTDQo+IHRhcmdldHMuDQo+ID4gICBMWDIxNjBBUkRCIGlzIGhhdmlu
ZyB0d28gTk9SIHNsYXZlIGRldmljZSBjb25uZWN0ZWQgb24gc2luZ2xlIGJ1cyBBDQo+ID4gICBp
LmUuIEEwIGFuZCBBMSAoQ1MwIGFuZCBDUzEpLg0KPiA+ICAgTFgyMTYwQVFEUyBpcyBoYXZpbmcg
dHdvIE5PUiBzbGF2ZSBkZXZpY2UgY29ubmVjdGVkIG9uIHNlcGFyYXRlIGJ1c2VzDQo+ID4gICBv
bmUgZmxhc2ggb24gQTAgYW5kIHNlY29uZCBvbiBCMSBpLmUuIChDUzAgYW5kIENTMykuDQo+ID4g
ICBWZXJpZmllZCB0aGlzIGRyaXZlciBvbiBmb2xsb3dpbmcgU1BJIE5PUiBmbGFzaGVzOg0KPiA+
ICAgICBNaWNyb24sIG10MzV4dTUxMmFiYSwgW1JlYWQgLSAxIGJpdCBtb2RlXQ0KPiA+ICAgICBD
eXByZXNzLCBzMjVmbDUxMnMsIFtSZWFkIC0gMS8yLzQgYml0IG1vZGVdDQo+ID4NCj4gPiBbMV0N
Cj4gPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGd3d3DQo+ID4gLm54cC5jb20lMkZkb2NzJTJGZW4lMkZyZWZlcmVuY2Ut
DQo+IG1hbnVhbCUyRklNWFJUMTA1MFJNLnBkZiZhbXA7ZGF0YT0wMiUNCj4gPg0KPiA3QzAxJTdD
eW9nZXNobmFyYXlhbi5nYXVyJTQwbnhwLmNvbSU3Qzc5MTU3MGVkNmQ5MTRmOTIyYTZjMDhkNjc2
Mw0KPiBkNmM5Ng0KPiA+ICU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzElN0M2MzY4MjY0MDM1MjQyOTQ0DQo+IDMwJmFtcDtzDQo+ID4NCj4gZGF0YT1XVFBkZDFXNFRu
NGc2T09WZVZWUXlsWjFZNzJLVW9oV1E1UU14Q2x3Y2djJTNEJmFtcDtyZXNlcg0KPiB2ZWQ9MA0K
PiA+IFsyXQ0KPiA+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXQNCj4gPiBjaHdvcmsua2VybmVsLm9yZyUyRnByb2pl
Y3QlMkZsaW51eC1hcm0ta2VybmVsJTJGbGlzdCUyRiUzRnN1Ym1pdHRlciUzDQo+ID4NCj4gRDE4
MjA5NyZhbXA7ZGF0YT0wMiU3QzAxJTdDeW9nZXNobmFyYXlhbi5nYXVyJTQwbnhwLmNvbSU3Qzc5
MTU3MA0KPiBlZDZkOTENCj4gPg0KPiA0ZjkyMmE2YzA4ZDY3NjNkNmM5NiU3QzY4NmVhMWQzYmMy
YjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzElDQo+IDdDNjM2OA0KPiA+DQo+IDI2NDAzNTI0
Mjk0NDMwJmFtcDtzZGF0YT1Rb0FONEh0aVRURDZVbVRvVndENkNmUHlXTjBDOW5TUVRCTzMNCj4g
YllTWEp0WSUzDQo+ID4gRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gWW9nZXNoIE5hcmF5YW4g
R2F1ciAoNSk6DQo+ID4gICAgc3BpOiBzcGktbWVtOiBBZGQgZHJpdmVyIGZvciBOWFAgRmxleFNQ
SSBjb250cm9sbGVyDQo+ID4gICAgZHQtYmluZGluZ3M6IHNwaTogYWRkIGJpbmRpbmcgZmlsZSBm
b3IgTlhQIEZsZXhTUEkgY29udHJvbGxlcg0KPiA+ICAgIGFybTY0OiBkdHM6IGx4MjE2MGE6IGFk
ZCBGbGV4U1BJIG5vZGUgcHJvcGVydHkNCj4gPiAgICBhcm02NDogZGVmY29uZmlnOiBlbmFibGUg
TlhQIEZsZXhTUEkgZHJpdmVyDQo+ID4gICAgTUFJTlRBSU5FUlM6IGFkZCBtYWludGFpbmVycyBm
b3IgdGhlIE5YUCBGbGV4U1BJIGRyaXZlcg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjY6DQo+ID4g
LSBSZWJhc2Ugb24gdG9wIG9mIHY1LjAtcmMxLg0KPiANCj4gWW91ciBwYXRjaGVzIGRvbid0IGFw
cGx5IHRvIHY1LjAtcmMxLiBJdCBzZWVtcyBsaWtlIHlvdSBoYXZlIGluc3RlYWQgcmViYXNlZA0K
PiBvbnRvIHRoZSBmb3ItNS4xIG9yIGZvci1uZXh0IGJyYW5jaCBvZiB0aGUgU1BJIHRyZWUuIEkg
Z3Vlc3MgdGhpcyBpcyBva2F5LCBidXQgeW91DQo+IHNob3VsZCBoYXZlIHBvaW50ZWQgdGhhdCBv
dXQgY29ycmVjdGx5IGhlcmUuDQo+IA0KWWVzLCB0aGFua3MgZm9yIHBvaW50aW5nIG91dC4NClRo
aXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9uICdmb3ItbmV4dCcgYnJhbmNoIG9mIFNQSSB0cmVl
IHJlcG8gWzFdLg0KQWN0dWFsbHksIEkgZ290IGNvbmZ1c2VkIHdpdGggdGhlIE1ha2VmaWxlIGNv
bnRlbnQgYW5kIHRoYXQncyB3aHkgbWVudGlvbmVkIGluIGNvbW1lbnQgYXMgIlJlYmFzZSBvbiB0
b3Agb2YgdjUuMC1yYzEiLCBzb3JyeSBmb3IgY29uZnVzaW9uLg0KCVZFUlNJT04gPSA1DQoJUEFU
Q0hMRVZFTCA9IDANCglTVUJMRVZFTCA9IDANCglFWFRSQVZFUlNJT04gPSAtcmMxDQoNCi0tDQpS
ZWdhcmRzDQpZb2dlc2ggR2F1cg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2Jyb29uaWUvc3BpLmdpdC8NCg0KPiA+IC0gSW5jb3Jwb3JhdGVkIHJl
dmlldyBjb21tZW50cyBmb3INCj4gPiAgICBwYXRjaCAnc3BpOiBzcGktbWVtOiBBZGQgZHJpdmVy
IGZvciBOWFAgRmxleFNQSSBjb250cm9sbGVyJy4NCj4gPiAtIFVwZGF0ZWQgcy1iIHRhZyBpbiBh
bGwgcGF0Y2hlcy4NCj4gPiBDaGFuZ2VzIGZvciB2NToNCj4gPiAtIFJlYmFzZSBvbiB0b3Agb2Yg
djQuMjAtcmMyDQo+ID4gLSBJbmNvcnBvcmF0ZWQgcmV2aWV3IGNvbW1lbnRzIGZvcg0KPiA+ICAg
IHBhdGNoICdzcGk6IHNwaS1tZW06IEFkZCBkcml2ZXIgZm9yIE5YUCBGbGV4U1BJIGNvbnRyb2xs
ZXInLg0KPiA+IENoYW5nZXMgZm9yIHY0Og0KPiA+IC0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21t
ZW50cyBmb3INCj4gPiAgICBwYXRjaCAnc3BpOiBzcGktbWVtOiBBZGQgZHJpdmVyIGZvciBOWFAg
RmxleFNQSSBjb250cm9sbGVyJy4NCj4gPiAtIEluY29ycG9yYXRlZCBiaW5kaW5nIGZpbGUgcmV2
aWV3IGNvbW1lbnRzLg0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+IC0gSW5jb3Jwb3JhdGVkIHJl
dmlldyBjb21tZW50cyBmb3INCj4gPiAgICBwYXRjaCAnc3BpOiBzcGktbWVtOiBBZGQgZHJpdmVy
IGZvciBOWFAgRmxleFNQSSBjb250cm9sbGVyJy4NCj4gPiBDaGFuZ2VzIGZvciB2MjoNCj4gPiAt
IEluY29ycG9yYXRlZCBCb3JpcyByZXZpZXcgY29tbWVudHMgYW5kIGRyb3AgYmVsb3cgcGF0Y2hl
cyBhcyBwZXIgdGhlDQo+IGNvbW1lbnRzLg0KPiA+ICAgLSBQYXRjaCAnc3BpOiBhZGQgc2xhdmUg
ZGV2aWNlIHNpemUgaW4gc3BpX2RldmljZSBzdHJ1Y3QnDQo+ID4gICAtIFBhdGNoICdzcGk6IGFk
ZCBmbGFncyBmb3Igb2N0YWwgSS9PIGRhdGEgdHJhbnNmZXInDQo+ID4gLSBJbmNvcnBvcmF0ZWQg
RFRTIGFuZCBCaW5kaW5nIGZpbGUgcmV2aWV3IGNvbW1lbnRzIG9mIFNoYXduIEd1byBhbmQgUm9i
DQo+IEhlcnJpbmcuDQo+ID4NCj4gPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGkt
bnhwLWZzcGkudHh0ICB8ICAgMzkgKw0KPiA+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgNyArDQo+ID4gICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLXJkYi5kdHMgICAgfCAgIDIyICsNCj4gPiAgIC4uLi9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8ICAgMTMgKw0KPiA+ICAgYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gICBkcml2ZXJz
L3NwaS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEwICsNCj4gPiAgIGRy
aXZlcnMvc3BpL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+
ICAgZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgICAgICAgICAgICAgICAgICAgIHwgMTA5NSAr
KysrKysrKysrKysrKysrKw0KPiA+ICAgOCBmaWxlcyBjaGFuZ2VkLCAxMTg4IGluc2VydGlvbnMo
KykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc3BpL3NwaS1ueHAtZnNwaS50eHQNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0KPiA+DQo=
