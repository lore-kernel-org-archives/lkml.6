Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A58C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDD220831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="dM+WlUTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDD220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeKTBgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:36:44 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:52765
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729392AbeKTBgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJYCRvbUtnAIhJ5nb/XhNpWCEktxJtjqDUkOBaQqu1M=;
 b=dM+WlUTt1HyRzLFzYnXeTVNelUBfHRXmxkE/5DqcnIlm8M9i8GGFvU8lKjNMk5xbNx4yY0iVzCSfoOJeStTJb5myyJ2+8l7OSlDQC38ERShUCGmmvswl5xm/pe/YEylUPnIgCXoEgtI34/ZonO4Bhq5EdYSWVXagapAlF7NNYHk=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5452.eurprd04.prod.outlook.com (20.178.105.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Mon, 19 Nov 2018 15:12:46 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 15:12:46 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
Thread-Topic: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
Thread-Index: AQHUcrw/3qwIrYVC/Uy4SnGDDmELb6VMa6yAgArjgYA=
Date:   Mon, 19 Nov 2018 15:12:46 +0000
Message-ID: <db9537dc-2ba5-b8fc-ae3c-7d85841b0797@ysoft.com>
References: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
 <1541170556-75032-2-git-send-email-michal.vokac@ysoft.com>
 <5bea0e9c.1c69fb81.1f3c8.be5a@mx.google.com>
In-Reply-To: <5bea0e9c.1c69fb81.1f3c8.be5a@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0100.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::41) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5452;6:MkjRUWh6cPOt2yUZ9WccUyoAMlt+YtZ9A8Go3gOGfUSS4mQETLylnKlY32uE41tqAvgONUN/6qdU2Wi2VpT9lAF5BEUGMaJ7iBN7A8rd/3MXVAtVsuygQGx5XIjGHeW0mej5ZiMjifzBcDatynsW4nUluclqYc3/33tg7fPfAnIT3HHCimUTuEXmopATlgPzBY8Wbdvu/HGv0IaHKcWEhl7GslFsM/2wGxLrayOUwEYT2fd22srMKMuiO/Av3qIUy89slbYughuXctzN4QTkMGeCEOOOb6G2W5S1XM+K/2JfLERbXYXShGijbF7o5ot5dPIjXF0cuB7iUQ51qhVy7bADacWwhXt0ZN8SXjSS6gLaBDna07RNHRf+7NSPmIwXc/Xb9UhDuKEShSWoUKY23tJf0+f/N1foJQ+wYZvURO//0n6+uJktWpqItPoRz4RoHic7veP7lmL5JabbFSEYtw==;5:uwKIof1K6/gIV8RI8qwIw8D3ZW0OJB/tdYKg2wi+RJKhS+XwBpoqjmiUMaPhafIlP+pBP2ep7B84zlcsJx8/w4HLDsXz/ANJRsbsOXz709HLPdZF5jsQYu2L3iDU45KV8e9pUAhT9tTnoHAyuVpi1AmPLelHw4jJy65VzGEiB0I=;7:25Vm8b023lCw+mswkL7V1dF2g7N7+O3VeRvRGZb0/h4hMTN6aYSloNRqpgCaVGzZNqapu3EMw5xy+ZSvwBPsQXUr5nOi2iEme+bKsA6269Iii/x4WaBCbGRxIADSXVO84Z1Nn+3qzrAVFkcVU64OGA==
x-ms-office365-filtering-correlation-id: a7371050-c505-47b2-03a3-08d64e317603
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5452;
x-ms-traffictypediagnostic: DB7PR04MB5452:
x-microsoft-antispam-prvs: <DB7PR04MB5452CED5134D00AD0E9D687E9ED80@DB7PR04MB5452.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5452;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5452;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39850400004)(366004)(136003)(199004)(189003)(81166006)(4326008)(25786009)(66066001)(68736007)(71190400001)(14444005)(256004)(966005)(81156014)(8676002)(71200400001)(478600001)(8936002)(36756003)(102836004)(5660300001)(72206003)(76176011)(52116002)(54906003)(186003)(99286004)(316002)(26005)(386003)(53546011)(6506007)(6246003)(7736002)(11346002)(446003)(53936002)(2616005)(476003)(305945005)(6916009)(6306002)(97736004)(6486002)(6512007)(486006)(6436002)(2900100001)(105586002)(2906002)(106356001)(229853002)(14454004)(31686004)(85182001)(31696002)(3846002)(6116002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5452;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TDBQIacnxvxqvP+US7AtjbwSyJ6cHuygk+yQernH7gl20U3QWMroGke2J3ydMcZJWO188sWCgMk51qxy1LQSMZpJb9zTWrNtpCdA4R72zZHajeHKNJwGm99tD3szxU6llLwVjUOeOOCvLp9ubCUeW/AOI4z+pb8A9BviOanEzFHXrDTQNUkRmoDBMVjSKyepoliYYSKyOslBSN5f9d2TWJt+hFZiyqeRqFMY63qjduGYAzozT1X9G5COYdKieF2RjvL8c4fvwqV+yqZRnDdAV7l/7jx+KxItdwlunERhLmBFgX1FCv5Upm04vhWDL974/SrK4c/B4xUmVjPlvpEb0DiHOEyi7mVaa/3AeLxZbW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED471B8B9F2C5E41A9A6C3F9A075E83C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7371050-c505-47b2-03a3-08d64e317603
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 15:12:46.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMTEuMjAxOCAxNzo1NSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIEZyaSwgTm92IDAy
LCAyMDE4IGF0IDAyOjU2OjM1UE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPj4gVGhl
IFNTRDEzMHggT0xFRCBkaXNwbGF5IHJlc2V0IHNpZ25hbCBpcyBhY3RpdmUgbG93LiBOb3cgdGhl
IHJlc2V0DQo+PiBzZXF1ZW5jZSBpcyBpbXBsZW1lbnRlZCBpbiBzdWNoIGEgd2F5IHRoYXQgRFRT
IGF1dGhvcnMgYXJlIGZvcmNlZCB0bw0KPj4gZGVmaW5lIHRoZSByZXNldC1ncGlvcyBwcm9wZXJ0
eSB3aXRoIEdQSU9fQUNUSVZFX0hJR0ggdG8gbWFrZSB0aGUgcmVzZXQNCj4+IHdvcmsuDQo+Pg0K
Pj4gQWRkIHRoZSByZXNldC1hY3RpdmUtbG93IHByb3BlcnR5IHNvIHRoZSBzaWduYWwgaXMgaW52
ZXJ0ZWQgb25jZSBhZ2Fpbg0KPj4gYW5kIHRoZSBHUElPX0FDVElWRV9MT1cgd29yayBhcyBleHBl
Y3RlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2Fj
QHlzb2Z0LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5j
IHwgNiArKysrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3
ZmIuYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMNCj4+IGluZGV4IGU3YWUxMzUu
Ljc5MGYxYzQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5j
DQo+PiArKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jDQo+PiBAQCAtNjA4LDYg
KzYwOCw3IEBAIHN0YXRpYyBpbnQgc3NkMTMwN2ZiX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQsDQo+PiAgIAlzdHJ1Y3QgZmJfZGVmZXJyZWRfaW8gKnNzZDEzMDdmYl9kZWZpbzsNCj4+
ICAgCXUzMiB2bWVtX3NpemU7DQo+PiAgIAlzdHJ1Y3Qgc3NkMTMwN2ZiX3BhciAqcGFyOw0KPj4g
Kwlib29sIHJlc2V0X2FjdGl2ZV9sb3c7DQo+PiAgIAl1OCAqdm1lbTsNCj4+ICAgCWludCByZXQ7
DQo+PiAgIA0KPj4gQEAgLTY3MSw2ICs2NzIsNyBAQCBzdGF0aWMgaW50IHNzZDEzMDdmYl9wcm9i
ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KPj4gICAJcGFyLT5jb21fc2VxID0gb2ZfcHJv
cGVydHlfcmVhZF9ib29sKG5vZGUsICJzb2xvbW9uLGNvbS1zZXEiKTsNCj4+ICAgCXBhci0+Y29t
X2xycmVtYXAgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgInNvbG9tb24sY29tLWxycmVt
YXAiKTsNCj4+ICAgCXBhci0+Y29tX2ludmRpciA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2Rl
LCAic29sb21vbixjb20taW52ZGlyIik7DQo+PiArCXJlc2V0X2FjdGl2ZV9sb3cgPSBvZl9wcm9w
ZXJ0eV9yZWFkX2Jvb2wobm9kZSwgInJlc2V0LWFjdGl2ZS1sb3ciKTsNCj4+ICAgDQo+PiAgIAlw
YXItPmNvbnRyYXN0ID0gMTI3Ow0KPj4gICAJcGFyLT52Y29taCA9IHBhci0+ZGV2aWNlX2luZm8t
PmRlZmF1bHRfdmNvbWg7DQo+PiBAQCAtNzI4LDkgKzczMCw5IEBAIHN0YXRpYyBpbnQgc3NkMTMw
N2ZiX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+PiAgIA0KPj4gICAJaWYgKHBh
ci0+cmVzZXQpIHsNCj4+ICAgCQkvKiBSZXNldCB0aGUgc2NyZWVuICovDQo+PiAtCQlncGlvZF9z
ZXRfdmFsdWVfY2Fuc2xlZXAocGFyLT5yZXNldCwgMCk7DQo+PiArCQlncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAocGFyLT5yZXNldCwgcmVzZXRfYWN0aXZlX2xvdyk7DQo+PiAgIAkJdWRlbGF5KDQp
Ow0KPj4gLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBhci0+cmVzZXQsIDEpOw0KPj4gKwkJ
Z3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBhci0+cmVzZXQsICFyZXNldF9hY3RpdmVfbG93KTsN
Cj4gDQo+IEkgdGhpbmsgeW91IGFuZCB3aG9tZXZlciB3cm90ZSB0aGUgb3JpZ2luYWwgY29kZSBh
cmUgbWlzaW50ZXJwcmV0dGluZw0KPiBob3cgdGhlIGdwaW9kIEFQSSB3b3Jrcy4gMSBtZWFucyBt
YWtlIHRoZSBzaWduYWwgYWN0aXZlIGFuZCB0aGlzIGNhc2UNCj4gYWN0aXZlIGlzIGxvdy4NCg0K
SSB0b3RhbGx5IGFncmVlIGFuZCBJIHRoaW5rIEkgdW5kZXJzdGFuZCB0aGF0IGNvcnJlY3RseS4N
Cg0KPiBJdCBpcyBzdHJhbmdlLCBidXQgZG9lcyBtZWFuIGEgcmVzZXQgc2VxdWVuY2Ugc2hvdWxk
IGFsd2F5cyBiZSBzZXQgdG8gYQ0KPiAxIGFuZCB0aGVuIGEgMCBhbmQgaXQgd2lsbCB3b3JrIHdp
dGggZWl0aGVyIHBvbGFyaXR5IGluIHRoZSBEVC4NCg0KSSBhZ3JlZSB0aGUgcmVzZXQgc2hvdWxk
IGJlIGRvbmUgYXMgYSAwIC0+IDEgLT4gMCBzZXF1ZW5jZSBhbmQgdGhhdCBzaG91bGQNCmp1c3Qg
d29yay4gVGhlIHByb2JsZW0gaXMgaXQgaXMgaW1wbGVtZW50ZWQgdmljZSB2ZXJzYSBhbmQgc28g
aXQgd29ya3Mgb25seQ0KaWYgeW91IGhhdmUgR1BJT19BQ1RJVkVfSElHSCBpbiBEVCBmb3IgYSBz
aWduYWwgdGhhdCBpcyBhY3R1YWxseSBhY3RpdmUgbG93Lg0KDQpBbmQgd2hhdCBpdCBhY3R1YWxs
eSBkb2VzIGlzIHRoYXQgaXQgaG9sZHMgdGhlIGNvbnRyb2xsZXIgaW4gcmVzZXQgc2luY2UNCnRo
ZSBHUElPIGlzIHN1Y2Nlc3NmdWxseSBhY3F1aXJlZCAoYmVjYXVzZSBvZiBHUElPRF9PVVRfTE9X
IGhlcmUgWzFdKSBhbmQNCmxhdGVyIG9uIGl0IG9ubHkgcmVsZWFzZXMgdGhlIHJlc2V0Lg0KDQpB
cyBhIERUIGF1dGhvciBJIHdvdWxkIGxpa2UgdG8gc29tZWhvdyBjbGVhcmx5IHN0YXRlIHRoYXQg
dGhlIE9MRUQgZGlzcGxheQ0KdXNlcyBhY3RpdmUgbG93IHJlc2V0IGluIG15IERULg0KDQpNeSBm
aXJzdCBhdHRlbXB0IHRvIGZpeCB0aGlzIHdhcyB0byBjaGFuZ2UgdGhlIHJlc2V0IHNlcXVlbmNl
IFsyXS4NCkl0IHdhcyBhcHBsaWVkIGFuZCB0aGVuIHJldmVydGVkIGFzIGl0IGlzIG5vdCBiYWNr
d2FyZCBjb21wYXRpYmxlIHdpdGgNCmRlcGxveWVkIERUQiBmaWxlcyBbM10uDQoNClsxXSBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NC4yMC1yYzMvc291cmNlL2RyaXZlcnMvdmlk
ZW8vZmJkZXYvc3NkMTMwN2ZiLmMjTDU3MA0KWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMTA2MTc3MjkvDQpbM10gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDYxNzczMS8NCg0KTWljaGFsDQo=
