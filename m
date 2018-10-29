Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EAF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="RpZOrGTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EAF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJ3AmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:42:01 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:63808
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbeJ3AmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wZmrDG/udE/r05JTnEkuR6wwID4LR8PR7xIr8f5sak=;
 b=RpZOrGTA+xhS64HQ2Vgg/NdwzI4FZaQ6VN2a8FNLq9fE43v2Q/xkBcWFDOAqjGbFn647SGNAlOEeHSctJl6RqOEGD6eTrF1/FS9jsOcaOR1en8Bet7oAZIc/foCLiSVNLzUMO9xkzWSJ0jQDXLLPPeAImetdSQh6/mcs/ziOfzQ=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4441.eurprd04.prod.outlook.com (52.135.137.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 15:52:43 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 15:52:43 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: =?utf-8?B?UmU6IFtSQ0bCoFBBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IHB3bTogaW14?=
 =?utf-8?B?OiBBbGxvdyBzd2l0Y2hpbmcgUFdNIG91dHB1dCBiZXR3ZWVuIFBXTSBhbmQg?=
 =?utf-8?Q?GPIO?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogcHdtOiBpbXg6IEFs?=
 =?utf-8?Q?low_switching_PWM_output_between_PWM_and_GPIO?=
Thread-Index: AQHUYHxLuuB1qoyy/USZ47x9z6qO2KUYfD8AgB4BnQA=
Date:   Mon, 29 Oct 2018 15:52:43 +0000
Message-ID: <67096945-36dc-5906-1a55-e0934d655311@ysoft.com>
References: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
 <1539163920-9442-2-git-send-email-michal.vokac@ysoft.com>
 <20181010133904.GB21134@ulmo>
In-Reply-To: <20181010133904.GB21134@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0005.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::18) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4441;6:NiDw3J/MlA+z4+tB2JkABPVEKWCGaT905e8BkcDPDA4haunUPp81I+DK4pp2oy5Rhk22UsBsS9mAFfPTbeanYt0T2fON1ByKS1UaUSbxnSRWZu9p/82B8lCt4Lztji+qPemxJCgueR9Ga6OvIzmDomcZanwQfNLSuyoTPbyuUmzrRVZpkdQdKWUcRu4DJ9SY56uvoWk8Z9wpzZuHtEcYAspb1/wVVSw0qpolE2qFMd3RxVY0qhZpmugC42hdNcyQq5o/4Sgdg9SKGqzUnNndAFhDBzSl/vS8wpxkBPPr0zpeudPaAiZRv88rDW99QHIGt5EJ5WiDvekNfOLn4McLX2n0P0zxpvyO0oolb0I0sOwI6zlgdGmGyqVY8UIKqNO9bGUQkeWFESH/JBKkGUofZoVk02B/T4HHgEBlv9AI1ZeKQGLG4YOMCCfVzWwemYMAa8vxRSOZGJvjtdSsRxfl1A==;5:yILs8nkKREqLDxZgRCC+/rMHCq5rgQZEw2e8eNFYHzg9eFAISa6aTGygTtETicJ/M9n6fO7n1FMf4CJTAwdjzUR1KQkfIR2z0yRO1nMVlGv+AibCbopv2RdYD3GVtnW7on/SqdzjHBNeiGA9YFptBrMYG0iui0IE5g6H9DZ2b0I=;7:rJ4mjUEI5Fkym+MJY/bSIc8XSnSqX1uhMq+p50QaTn/pSoINIH29bU7xKQzqd4LIYHQIIYdeh0BsTEXIAiqSCOJkSVbQndlvI3pDSk78vKkcJYVDUby2IdAVSAWeJyAc8ACGDPAdjUmP2sjDX64jXQ==
x-ms-office365-filtering-correlation-id: 38559224-d13e-4bc6-4e9d-08d63db69046
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4441;
x-ms-traffictypediagnostic: DB7PR04MB4441:
x-microsoft-antispam-prvs: <DB7PR04MB444132707570DA41E9BDF7B19EF30@DB7PR04MB4441.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4441;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4441;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(189003)(199004)(105586002)(36756003)(106356001)(66066001)(3846002)(6116002)(2906002)(31686004)(6246003)(186003)(39060400002)(446003)(486006)(8936002)(229853002)(11346002)(2616005)(476003)(478600001)(14444005)(5250100002)(68736007)(4326008)(386003)(72206003)(14454004)(6916009)(25786009)(256004)(26005)(76176011)(31696002)(97736004)(102836004)(52116002)(53546011)(6506007)(99286004)(5660300001)(6512007)(316002)(54906003)(6436002)(6486002)(53936002)(2900100001)(305945005)(7736002)(85182001)(71200400001)(81166006)(81156014)(86362001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4441;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7zimdaofaxZMbyzjogLJKURwJVIiIF6kBezsBojhOVwgmfxK4SQghRtbUxnmtws+DdYcJnzMjWCpZjWHqASKu7RiNXUrIDzVQe5pO7sabH2URX7hLHBFP9WteEI6dj/GQ2sSuT2Hcc1r5/AeI3nYvvvgDI4uoqh9kVkzcjbOjqV+CKd68EIkJX+5lK9rxphn4kX3BZQX6S2L0sodoA04IEhc8Wux3MhK0Y70L25o0/JsB2JMUsXTNaEhXlhPdKR+TfkYgQ3jJtxHKJt4/kDfKh5C7k7B9m2l1BgJ9KTeHrKwUwJ2yFcytrR4Wr7PNLv6RAJnL1l3dLIGVWgmbM39fywpyemsBb0Z7gD3R/U0dh4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E1FA5BBBF8F5149B11F609792CAFCB3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38559224-d13e-4bc6-4e9d-08d63db69046
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 15:52:43.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4441
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMTAuMjAxOCAxNTozOSwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDEwLCAyMDE4IGF0IDA5OjMzOjI1QU0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPj4g
T3V0cHV0IG9mIHRoZSBQV00gYmxvY2sgb24gaS5NWCBTb0NzIGlzIGFsd2F5cyBsb3cgd2hlbiB0
aGUgYmxvY2sgaXMNCj4+IGRpc2FibGVkLiBUaGlzIGNhbiBjYXVzZSBpc3N1ZXMgd2hlbiBpbnZl
cnRlZCBQV00gcG9sYXJpdHkgaXMgbmVlZGVkLg0KPj4gV2l0aCBpbnZlcnRlZCBwb2xhcml0eSBh
IGR1dHkgY3ljbGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIGxldmVsIG9uDQo+PiB0aGUgb3V0
cHV0LiBOb3csIHdoZW4gUFdNIGlzIGRpc2FibGVkIGl0cyBvdXRwdXQgaW5zdGFudGx5IGdvZXMg
bG93DQo+PiB3aGljaCBjb3JyZXNwb25kcyB0byBkdXR5IGN5Y2xlID0gMTAwJS4NCj4+DQo+PiBU
byBnZXQgYSB0cnVseSBpbnZlcnRlZCBQV00gb3V0cHV0IHR3byBwaW5jdHJsIHN0YXRlcyBvZiB0
aGUgUFdNIHBpbg0KPj4gY2FuIGJlIHVzZWQuIENvbmZpZ3VyZSB0aGUgcGluIHRvIEdQSU8gZnVu
Y3Rpb24gd2hlbiBQV00gaXMgZGlzYWJsZWQNCj4+IGFuZCBzd2l0Y2ggYmFjayB0byBQV00gZnVu
Y3Rpb24gd2hlbmV2ZXIgbm9uLXplcm8gZHV0eSBjeWNsZSBpcyBuZWVkZWQuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2thY0B5c29mdC5jb20+DQo+PiAt
LS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAgIC0gRG8gbm90IHVzZSB0aGUgImRlZmF1bHQiIHBp
bmN0cmwgc3RhdGUgZm9yIEdQSU8uDQo+PiAgIC0gVXNlIHR3byBuZXcgInB3bSIgYW5kICJncGlv
IiBwaW5jdHJsIHN0YXRlcy4NCj4+ICAgLSBBZGQgYSBuZXcgcHdtLWdwaW9zIHNpZ25hbC4NCj4+
DQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQg
fCA1MSArKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcHdtL2lteC1wd20udHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3B3bS9pbXgtcHdtLnR4dA0KPj4gaW5kZXggYzYxYmRmOC4uYmQ1YjZiZCAxMDA2NDQNCj4+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50
eHQNCj4+IEBAIC0xNCw2ICsxNCwxNyBAQCBTZWUgdGhlIGNsb2NrIGNvbnN1bWVyIGJpbmRpbmcs
DQo+PiAgIAlEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmlu
ZGluZ3MudHh0DQo+PiAgIC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBmb3IgdGhlIHB3bSBj
b250cm9sbGVyDQo+PiAgIA0KPj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+PiArLSBwaW5jdHJs
OiBGb3IgaS5NWDI3IGFuZCBuZXdlciBTb0NzLiBVc2UgInB3bSIgYW5kICJncGlvIiBzcGVjaWZp
YyBwaW5jdHJscw0KPj4gKyAgaW5zdGVhZCBvZiB0aGUgImRlZmF1bHQiIHRvIGNvbmZpZ3VyZSB0
aGUgUFdNIHBpbiB0byBHUElPIGFuZCBQV00gZnVuY3Rpb24uDQo+PiArICBJdCBhbGxvd3MgY29u
dHJvbCBvdmVyIHRoZSBwaW4gb3V0cHV0IGxldmVsIHdoZW4gdGhlIFBXTSBibG9jayBpcyBkaXNh
YmxlZC4NCj4+ICsgIFRoaXMgaXMgdXNlZnVsIGlmIHlvdSB1c2UgdGhlIFBXTSBmb3Igc2luZ2xl
IHB1cnBvc2UgYW5kIHlvdSBuZWVkIGludmVydGVkDQo+PiArICBwb2xhcml0eSBvZiB0aGUgUFdN
IHNpZ25hbC4gU2VlICJJbnZlcnRlZCBQV00gb3V0cHV0IiBzZWN0aW9uIGJlbGxvdy4NCj4+ICst
IHB3bS1ncGlvczogU3BlY2lmeSB0aGUgR1BJTyBwaW4gdGhhdCB3aWxsIGFjdCBhcyB0aGUgUFdN
IG91dHB1dC4gVGhpcyBzaG91bGQNCj4+ICsgIGJlIHRoZSBzYW1lIHBpbiBhcyBpcyB1c2VkIGZv
ciBub3JtYWwgUFdNIG91dHB1dC4gRGVmaW5lIHRoZSBwaW4gYXMNCj4+ICsgIEdQSU9fQUNUSVZF
X0xPVyB0byBnZXQgSElHSCBsZXZlbCBvbiB0aGUgb3V0cHV0IHdoZW4gUFdNIGlzIGRpc2FibGVk
LiBTZWUNCj4+ICsgICJJbnZlcnRlZCBQV00gb3V0cHV0IiBzZWN0aW9uIGJlbGxvdy4NCj4gDQo+
IEl0J3Mgc29tZXdoYXQgdW5mb3J0dW5hdGUgdGhhdCB3ZSBoYXZlIHRvIHNwZWNpZnkgdGhpcyBp
biBEVC4gRm9yIG9uZQ0KPiB0aGluZywgd2UgZG9uJ3QgcmVhbGx5IHdhbnQgdG8gdXNlIHRoZSBw
aW4gYXMgR1BJTywgd2UgcmVhbGx5IG9ubHkgY2FyZQ0KPiBhYm91dCB3aGV0aGVyIGl0IGlzICJh
Y3RpdmUiIG9yICJpbmFjdGl2ZSIuIFdlIGFsc28gYWxyZWFkeSBzcGVjaWZ5IHRoZQ0KPiBHUElP
IGluIHRoZSBwaW5jdHJsIG5vZGVzLCBhbGJlaXQgdmlhIGEgZGlmZmVyZW50IG5hbWUuIFNvIHdl
J3JlDQo+IGVmZmVjdGl2ZWx5IGR1cGxpY2F0aW5nIGluZm9ybWF0aW9uIGhlcmUuIEl0J2QgYmUg
bmljZSB0byBhdm9pZCB0aGF0Lg0KDQogRnJvbSByZWFkaW5nIHRoZSBwaW5jdHJsIGJpbmRpbmcg
ZG9jIEkgdW5kZXJzdGFuZCB0aGF0IHlvdSBjYW4gc3BlY2lmeQ0KYXMgbXVjaCBwaW5jdHJsIHN0
YXRlcyBhcyB5b3UgbmVlZCB0byBjb25maWd1cmUgYSBwaW4gYXBwcm9wcmlhdGVseSBmb3INCmRp
ZmZlcmVudCAidXNlIGNhc2VzIi4gRWcuIGluaXQsIHNsZWVwLCBkZWZhdWx0LCB0eCwgcnggLi4u
IGFzIGFsbCBtaWdodA0KbmVlZCBkaWZmZXJlbnQgcHVsbC11cC9kb3duIGFuZCBEU0UgY29uZmln
dXJhdGlvbi4NCg0KU28gSSBkaWQgbm90IHRoaW5rIHRoaXMgbWlnaHQgYmUgY29uc2lkZXJlZCAi
ZHVwbGljYXRpbmcgaW5mb3JtYXRpb24iLg0KDQo+IFR3byBwb3NzaWJpbGl0aWVzIHRoYXQgSSBj
b3VsZCB0aGluayBhYm91dCBhcmU6DQo+IA0KPiAgICAxKSBEbyBub3QgZXhwbGljaXRseSByZWx5
IG9uIGRyaXZpbmcgdGhlIEdQSU8gYXMgb3V0cHV0OiBJIGtub3cgdGhpcw0KPiAgICAgICB3YXMg
ZGlzY3Vzc2VkIGJlZm9yZSBhbmQgaXQgc291bmRzIGxpa2UgdGhpcyBpcyBub3QgYW4gb3B0aW9u
IGZvcg0KPiAgICAgICBQV00gYmVjYXVzZSB0aGUgR1BJTyBtYXkgYmUgY29uZmlndXJlZCBhcyBv
dXRwdXQgYnkgdGhlIGZpcm13YXJlLA0KPiAgICAgICBhbmQgaGVuY2Ugc3dpdGNoaW5nIHRvIEdQ
SU8gbW9kZSBtYXkgbm90IGdpdmUgdGhlIGV4cGVjdGVkIHJlc3VsdC4NCg0KSSB0aGluayBpdCBp
cyBhY3R1YWxseSBwb3NzaWJsZS4gUHJldmlvdXNseSBJIG9ubHkgc2F3IHR3byBleHRyZW1lcy4N
Ck5vIEdQSU8gYXQgYWxsIChvbmx5IHRoZSBwaW5jdHJsIHN0YXRlcykgb3IgZnVsbCBHUElPIGNv
bnRyb2wgaW5jbHVkaW5nDQpkcml2aW5nIHRoZSBvdXRwdXQuIEJ1dCBvbmNlIHdlIHJlcXVlc3Qg
dGhlIEdQSU8gYXMgYW4gaW5wdXQgd2l0aA0KDQoJZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoJnBk
ZXYtPmRldiwgInB3bSIsIEdQSU9EX0lOKTsNCg0KaXQgd2lsbCBiZSBjb25maWd1cmVkIGFzIGlu
cHV0IHJlZ2FyZGxlc3Mgd2hhdCBzdGF0ZSBpdCB3YXMgbGVmdCBpbiBmcm9tDQpib290bG9hZGVy
LiBBbmQgaGVuY2UgdGhlIHB1bGwtdXAvZG93biBzZXR0aW5nIGZyb20gRFRTIHdpbGwgYmUgYXBw
bGllZC4NCg0KPiAgICAgICBJIHN1cHBvc2Ugb25lIHdheSB0byBzb2x2ZSB0aGlzIGlzIGJ5IHVz
aW5nIGEgZ3Bpby1ob2cgZW50cnkgZm9yDQo+ICAgICAgIHRoZSBQV00gR1BJTyBzbyB0aGF0IGl0
IHdpbGwgYXV0b21hdGljYWxseSBnZXQgY29uZmlndXJlZCBhcyBhbg0KPiAgICAgICBpbnB1dCBh
bmQgYXQgdGhlIHNhbWUgdGltZSBtYXJrZWQgYXMgYnVzeSBzbyB0aGF0IG5vYm9keSBjYW4gZ28N
Cj4gICAgICAgYW5kIGp1c3QgcmVxdWVzdCBpdCBhZ2FpbiAodmlhIHN5c2ZzIGZvciBleGFtcGxl
KS4NCg0KSSB0aGluayB0aGlzIGlzIHN0aWxsIHZhbGlkIGluIHRoZSBjYXNlIEkgZGVzY3JpYmVk
IGFib3ZlIC0gbm9ib2R5IGVsc2UNCmNhbiByZXF1ZXN0IHRoYXQgcGluIG9uY2Ugd2UgYWNxdWly
ZSBpdCBpbiBwd20taW14Lg0KDQo+ICAgIDIpIERlcml2ZSB0aGUgR1BJTyBmcm9tIHRoZSBwaW4u
IEknbSBub3Qgc3VyZSB0aGVyZSdzIGFueXRoaW5nIGluIHRoZQ0KPiAgICAgICBwaW5jdHJsIGZy
YW1ld29yayB0byBkbyB0aGF0LiBUaGUgcmV2ZXJzZSAoR1BJTyAtPiBwaW4pIGNhbiBiZQ0KPiAg
ICAgICBkb25lLCBzbyBwZXJoYXBzIHRoaXMgaXMgc29tZXRoaW5nIHRoYXQgY291bGQgYmUgYWRk
ZWQ/DQoNCkkgY2FuIGxvb2sgYXQgdGhhdCBvcHRpb24gaWYgeW91IHJlYWxseSB3YW50IGJ1dCBJ
IHdvdWxkIGxpa2UgdG8gYXZvaWQNCmRvaW5nIHRoYXQuDQoNCj4gT3RoZXIgdGhhbiB0aGFuIEkg
dGhpbmsgdGhpcyBsb29rcyB2ZXJ5IG5pY2UuDQoNClRoYW5rcy4gV291bGQgeW91IHByZWZlciBS
RkMgdjMgb3Igbm9uLVJGQyB2MSB3aGVuIEkgcmVzcGluPw0KDQpCZXN0IHJlZ2FyZHMsDQpNaWNo
YWwNCg==
