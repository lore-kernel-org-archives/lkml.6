Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A535C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA322089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YWx6lq91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA322089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbeKTMDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:03:44 -0500
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:48112
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbeKTMDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zOFVRrYL7HxD0aoDOdcuDF6r8wDbaDXWNWSnpthq/c=;
 b=YWx6lq91Wtz24o8h53l1Ub6QNcfqkrQor2XxkSG3Bsc5FsM7doy0u3XBLRgFcKKH2aKGvJ1Cj8shZHPdXAZD3fDaPb4JU5qG2ybjbOkYxAbubV0AhTq8R2qCNStnaSmywKFw9n8Q1KPTMT4XYXrSuNLxaNOaLUppJYruuEI/yrg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 20 Nov 2018 01:37:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 01:37:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Topic: [PATCH V2] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Index: AQHUd8tW10PZEKvl502/f9j+OWw2K6VXLPEAgADGJTA=
Date:   Tue, 20 Nov 2018 01:37:01 +0000
Message-ID: <DB3PR0402MB3916DCD69EE46A6F1341F95EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541726525-19544-1-git-send-email-Anson.Huang@nxp.com>
 <20181119134624.GT5829@dragon>
In-Reply-To: <20181119134624.GT5829@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3817;6:ixp52jurmJ8jrQyuQakOkb2t7Jn2+fT6sJu08wrRcp7RXiQ5tNIJV9VPrSEvwRHETYvOcvhXF+R8qdEuiYF3aJ+0/oowvHK3LPEUCS0axZAa8hxay6EfHu48ahO7OqZThiPi/01T9ruRXyQotzeesE0OagcZkNFBIFL+xpgAL3IJyvYwbN14E0HOU4i+Lbe4NpowdcLG6Bu/ODmcedph2l2SYy9RL6vPfKYJsjyB8OkXYinByoOLjKzPlO/6EnlXv5Bq/WvWjJuNXIQq2BIsQBlfaVmQPwn9vndikzSeobrPCiqdfiTq25goC+OgntezLjQphIz8g7K6WkdlxyVNHcvcwG7X1sVusF8/42gYmYbSUHTaBsFP6ILwLOBevRNyhJvO4wUUx/dUhw00Mxh7s51hgj1Fe6/IKpQ2AelWLijHkQwlbWOoSAlY98IUK4IVVwsg8fqIpoceLsyhm6oTNA==;5:CMpCAoVDLxjltY6iMd5TvCd/T5Qn4U+oxLA1SpYh+s5UsitDaItnRifx/5FxKrs0UaVvDCC9EI8Vbij2nSyfxpN2VyEBne0mhvcizSxU9IChdngot76CepqmDGOgq3io1CAxAGuyn9Ik1gJCaJdJmHNfuL9lMIIJI1gHQPO2vKs=;7:oj/1tJ4YDthpd3R5OLPjEXxcozE/Y+3y1XD8ahb7U719wx4uv0S29iCTLksROMrRjsnmGbhA65NtPlPV1+CjYrFjCqEg798zEk7TSDhJXzp5C/8OYFzqdyVCww6wrHAenzZGA3/N083woqFzyv7cuQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 245dcec6-0f03-4472-b777-08d64e88ab17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3817;
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-microsoft-antispam-prvs: <DB3PR0402MB3817159BBDA8E49C7F0E6C9EF5D90@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3817;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3817;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(376002)(346002)(136003)(396003)(13464003)(189003)(199004)(305945005)(81166006)(81156014)(66066001)(9686003)(55016002)(7696005)(74316002)(53936002)(76176011)(33656002)(99286004)(54906003)(105586002)(106356001)(476003)(486006)(8676002)(5660300001)(4326008)(316002)(11346002)(446003)(6506007)(6436002)(7736002)(6246003)(8936002)(68736007)(44832011)(575784001)(25786009)(3846002)(478600001)(86362001)(102836004)(97736004)(14444005)(71190400001)(2906002)(26005)(6116002)(53546011)(256004)(71200400001)(6916009)(186003)(14454004)(2900100001)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rWPDNjFhiQjJROObJczFmIiYLLhM+lH06w74vAGb0fLTL4GjgelP2VYycq/YV0trfazffU2THvKkjI22gCdQdocLtlkkRYQ+OIO3jL78Wxzdq3USWWkmnwiAcbDyqkWLygwmQ99Azjcsda26Cdnvl5mN0m9vk/p1pRScbmCONNDre++wKT9RX8gosaFWGOt3wzXn6Hae+3bHMQVUc+eGOh3Yb27QS5yhXnyTscJcECXqBXM+2n628qkISjM4b9mMAgPFsGMct2C454F/wW/fs+k872WtAzy4U08jqngOUqO/QftB9uCdznQ4/zbmuTLexVbuUh8fDQxnNu1HMJcwycqUkmczMQ+zBhfYeeU0p+8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245dcec6-0f03-4472-b777-08d64e88ab17
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 01:37:01.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVs
Lm9yZ10NCj4gU2VudDogMjAxOMTqMTHUwjE5yNUgMjE6NDYNCj4gVG86IEFuc29uIEh1YW5nIDxh
bnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBBUk06IGR0czogaW14N2Qtc2RiOiBh
ZGQgcmV2LWEgYm9hcmQgc3VwcG9ydA0KPiANCj4gT24gRnJpLCBOb3YgMDksIDIwMTggYXQgMDE6
Mjc6MTBBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQ3VycmVudCBpbXg3ZC1zZGIu
ZHRzIGhhcyBzb21lIGluY29ycmVjdCBzZXR0aW5ncyBhYm91dCBSZXYtQSBhbmQNCj4gPiBSZXYt
QiBib2FyZHMsIHNvbWUgb2YgdGhlIHNldHRpbmdzIGFyZSBiYXNlZCBvbiBSZXYtQSBib2FyZCBi
dXQgc29tZQ0KPiA+IGFyZSBiYXNlZCBvbiBSZXYtQiBib2FyZCwgY2xlYW4gdXAgaXQgYnkgYWRk
aW5nIGkuTVg3RCBTREIgUmV2LUEgYm9hcmQNCj4gPiBzdXBwb3J0LCBtYWtlIGRlZmF1bHQgaW14
N2Qtc2RiLmR0cyBmb3IgUmV2LUIgYm9hcmQgYXMgdXN1YWwsIGFuZA0KPiA+IGludHJvZHVjZSBp
bXg3ZC1zZGItcmV2YS5kdHMgZm9yIFJldi1BIGJvYXJkLiBCZWxvdyBhcmUgdGhlIGFmZmVjdGVk
DQo+ID4gZGlmZmVyZW5jZXMgb2YgUmV2LUEgYW5kIFJldi1CIGJvYXJkOg0KPiA+DQo+ID4gICAg
ICAgICAgICAgICAgIFJldi1BICAgICAgICAgICBSZXYtQg0KPiA+IFVTQl9PVEcyX1BXUjogICBV
QVJUM19DVFNfQiAgICAgR1BJTzFfSU8wNw0KPiA+IEVORVRfRU5fQjogICAgICBOb25lICAgICAg
ICAgICAgR1BJTzFfSU8wNA0KPiA+IFRQX0lOVF9COiAgICAgICBFUERDX0RBVEExMyAgICAgRVBE
Q19CRFIxDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2Ugc2luY2UgVjE6DQo+ID4gCXJlbW92ZSAicGlu
Y3RybC1hc3NlcnQtZ3Bpb3MiIHdoaWNoIGlzIHVudXNlZCBpbiB1cHN0cmVhbSwgYW5kIHVzZQ0K
PiA+IHBoeS1zdXBwbHkgdG8gY29udHJvbCBmZWMyJ3MgZW5hYmxlIHBpbiwgbW9kZWwgdGhlIGVu
YWJsZSBwaW4gYXMgR1BJTw0KPiByZWd1bGF0b3IuDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL01h
a2VmaWxlICAgICAgICAgICB8ICAxICsNCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14N2Qtc2Ri
LXJldmEuZHRzIHwgMzkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLXNkYi5kdHMgICAgICB8IDI5DQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKystLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBhcmNoL2FybS9ib290
L2R0cy9pbXg3ZC1zZGItcmV2YS5kdHMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZSBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+ID4gaW5kZXgg
ZWY5ZmZhNC4uNmQxMzNiOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9NYWtl
ZmlsZQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+ID4gQEAgLTU3Miw2
ICs1NzIsNyBAQCBkdGItJChDT05GSUdfU09DX0lNWDdEKSArPSBcDQo+ID4gIAlpbXg3ZC1waWNv
LXBpLmR0YiBcDQo+ID4gIAlpbXg3ZC1zYmMtaW14Ny5kdGIgXA0KPiA+ICAJaW14N2Qtc2RiLmR0
YiBcDQo+ID4gKwlpbXg3ZC1zZGItcmV2YS5kdGIgXA0KPiA+ICAJaW14N2Qtc2RiLXNodDExLmR0
YiBcDQo+ID4gIAlpbXg3cy1jb2xpYnJpLWV2YWwtdjMuZHRiIFwNCj4gPiAgCWlteDdzLXdhcnAu
ZHRiDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLXNkYi1yZXZhLmR0
cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2Qtc2RiLXJldmEuZHRzDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi43NzQxZWFhDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLXNkYi1yZXZhLmR0cw0KPiA+
IEBAIC0wLDAgKzEsMzkgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjArIE9SIE1JVCAvLyAvLyBDb3B5cmlnaHQgKEMpIDIwMTUNCj4gPiArRnJlZXNjYWxlIFNlbWlj
b25kdWN0b3IsIEluYy4NCj4gPiArDQo+ID4gKy9kdHMtdjEvOw0KPiA+ICsNCj4gPiArI2luY2x1
ZGUgImlteDdkLXNkYi5kdHMiDQo+ID4gKw0KPiA+ICsvIHsNCj4gPiArCXJlZ191c2Jfb3RnMl92
YnVzOiByZWd1bGF0b3ItdXNiLW90ZzItdmJ1cyB7DQo+ID4gKwkJZ3BpbyA9IDwmZ3BpbzQgNyBH
UElPX0FDVElWRV9ISUdIPjsNCj4gPiArCX07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmZmVjMiB7
DQo+ID4gKwkvZGVsZXRlLXByb3BlcnR5L3BoeS1zdXBwbHk7DQo+ID4gK307DQo+ID4gKw0KPiA+
ICsmaW9tdXhjIHsNCj4gPiArCWlteDdkLXNkYiB7DQo+ID4gKwkJcGluY3RybF90c2MyMDQ2X3Bl
bmRvd246IHRzYzIwNDZfcGVuZG93biB7DQo+ID4gKwkJCWZzbCxwaW5zID0gPA0KPiA+ICsJCQkJ
TVg3RF9QQURfRVBEQ19EQVRBMTNfX0dQSU8yX0lPMTMJMHg1OQ0KPiA+ICsJCQk+Ow0KPiA+ICsJ
CX07DQo+ID4gKw0KPiA+ICsJCXBpbmN0cmxfaG9nOiBob2dncnAgew0KPiA+ICsJCQlmc2wscGlu
cyA9IDwNCj4gPiArCQkJCU1YN0RfUEFEX1VBUlQzX0NUU19CX19HUElPNF9JTzcJCTB4MTQNCj4g
PiArCQkJCU1YN0RfUEFEX0VDU1BJMl9TUzBfX0dQSU80X0lPMjMJCTB4MzQgIC8qIGJ0DQo+IHJl
ZyBvbiAqLw0KPiA+ICsJCQk+Ow0KPiA+ICsJCX07DQo+ID4gKwl9Ow0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArJmlvbXV4Y19scHNyIHsNCj4gPiArCS9kZWxldGUtcHJvcGVydHkvcGluY3RybC1uYW1l
czsNCj4gPiArCS9kZWxldGUtcHJvcGVydHkvcGluY3RybC0wOw0KPiA+ICt9Ow0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg3ZC1zZGIuZHRzDQo+ID4gYi9hcmNoL2FybS9i
b290L2R0cy9pbXg3ZC1zZGIuZHRzIGluZGV4IGYxYmFmZGEuLjgzODViOWIgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2Qtc2RiLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDdkLXNkYi5kdHMNCj4gPiBAQCAtNzMsNyArNzMsNyBAQA0KPiA+ICAJCXJl
Z3VsYXRvci1uYW1lID0gInVzYl9vdGcyX3ZidXMiOw0KPiA+ICAJCXJlZ3VsYXRvci1taW4tbWlj
cm92b2x0ID0gPDUwMDAwMDA+Ow0KPiA+ICAJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUw
MDAwMDA+Ow0KPiA+IC0JCWdwaW8gPSA8JmdwaW80IDcgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4g
KwkJZ3BpbyA9IDwmZ3BpbzEgNyBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiAgCQllbmFibGUtYWN0
aXZlLWhpZ2g7DQo+ID4gIAl9Ow0KPiA+DQo+ID4gQEAgLTExNCw2ICsxMTQsMTYgQEANCj4gPiAg
CQlncGlvID0gPCZncGlvMiAxNCBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ICAJfTsNCj4gPg0KPiA+
ICsJcmVnX2ZlYzJfM3YzOiByZWd1bGF0b3ItZmVjMi0zdjMgew0KPiA+ICsJCWNvbXBhdGlibGUg
PSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJmZWMyLTN2MyI7
DQo+ID4gKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArCQlwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfZW5ldDJfcmVnPjsNCj4gPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwz
MzAwMDAwPjsNCj4gPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4g
PiArCQlncGlvID0gPCZncGlvMSA0IEdQSU9fQUNUSVZFX0xPVz47DQo+ID4gKwl9Ow0KPiA+ICsN
Cj4gPiAgCWJhY2tsaWdodDogYmFja2xpZ2h0IHsNCj4gPiAgCQljb21wYXRpYmxlID0gInB3bS1i
YWNrbGlnaHQiOw0KPiA+ICAJCXB3bXMgPSA8JnB3bTEgMCA1MDAwMDAwIDA+Ow0KPiA+IEBAIC0y
MTAsNiArMjIwLDcgQEANCj4gPiAgCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDA+LCA8MTAwMDAw
MDAwPjsNCj4gPiAgCXBoeS1tb2RlID0gInJnbWlpIjsNCj4gPiAgCXBoeS1oYW5kbGUgPSA8JmV0
aHBoeTE+Ow0KPiA+ICsJcGh5LXN1cHBseSA9IDwmcmVnX2ZlYzJfM3YzPjsNCj4gPiAgCWZzbCxt
YWdpYy1wYWNrZXQ7DQo+ID4gIAlzdGF0dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4gQEAgLTQ5
MSw2ICs1MDIsMTIgQEANCj4gPiAgCQkJPjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gKwkJcGluY3Ry
bF9lbmV0Ml9yZWc6IGVuZXQycmVnZ3JwIHsNCj4gPiArCQkJZnNsLHBpbnMgPSA8DQo+ID4gKwkJ
CQlNWDdEX1BBRF9MUFNSX0dQSU8xX0lPMDRfX0dQSU8xX0lPNAkweDE0DQo+ID4gKwkJCT47DQo+
ID4gKwkJfTsNCj4gPiArDQo+ID4gIAkJcGluY3RybF9mbGV4Y2FuMjogZmxleGNhbjJncnAgew0K
PiA+ICAJCQlmc2wscGlucyA9IDwNCj4gPiAgCQkJCU1YN0RfUEFEX0dQSU8xX0lPMTRfX0ZMRVhD
QU4yX1JYCTB4NTkNCj4gPiBAQCAtNTEzLDcgKzUzMCw2IEBADQo+ID4NCj4gPiAgCQlwaW5jdHJs
X2hvZzogaG9nZ3JwIHsNCj4gPiAgCQkJZnNsLHBpbnMgPSA8DQo+ID4gLQkJCQlNWDdEX1BBRF9V
QVJUM19DVFNfQl9fR1BJTzRfSU83CQkweDE0DQo+ID4gIAkJCQlNWDdEX1BBRF9FQ1NQSTJfU1Mw
X19HUElPNF9JTzIzCQkweDM0ICAvKiBidA0KPiByZWcgb24gKi8NCj4gPiAgCQkJPjsNCj4gPiAg
CQl9Ow0KPiA+IEBAIC03MjQsNiArNzQwLDkgQEANCj4gPiAgfTsNCj4gPg0KPiA+ICAmaW9tdXhj
X2xwc3Igew0KPiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArCXBpbmN0cmwt
MCA9IDwmcGluY3RybF9ob2dfMj47DQo+ID4gKw0KPiA+ICAJcGluY3RybF93ZG9nOiB3ZG9nZ3Jw
IHsNCj4gPiAgCQlmc2wscGlucyA9IDwNCj4gPiAgCQkJTVg3RF9QQURfTFBTUl9HUElPMV9JTzAw
X19XRE9HMV9XRE9HX0IJCTB4NzQNCj4gPiBAQCAtNzM1LDQgKzc1NCwxMCBAQA0KPiA+ICAJCQlN
WDdEX1BBRF9MUFNSX0dQSU8xX0lPMDFfX1BXTTFfT1VUCQkweDMwDQo+ID4gIAkJPjsNCj4gPiAg
CX07DQo+ID4gKw0KPiA+ICsJcGluY3RybF9ob2dfMjogaG9nZ3JwLTIgew0KPiA+ICsJCWZzbCxw
aW5zID0gPA0KPiA+ICsJCQlNWDdEX1BBRF9MUFNSX0dQSU8xX0lPMDdfX0dQSU8xX0lPNwkgIDB4
MTQNCj4gDQo+IEluc3RlYWQgb2YgdXNpbmcgaG9nIGdyb3VwLCB0aGlzIHNob3VsZCBiZSBkZWZp
bmVkIGJ5IHBpbmN0cmwgZW50cnkgdG8gYmUNCj4gcmVmZXJyZWQgYnkgdGhlIGZpeGVkIHJlZ3Vs
YXRvciB0aGF0IHVzZXMgdGhpcyBHUElPPw0KDQpBZ3JlZWQsIEkgcmVtb3ZlIHRoZSBob2dfMiBh
bmQgYWRkIHVzYl9vdGcyX3ZidXNfcmVnIHBpbmN0cmwgZW50cnkgZm9yIHJlZ3VsYXRvcg0KdG8g
cmVmZXJlbmNlLCBwbGVhc2UgaGVscCByZXZpZXcgVjMgcGF0Y2gsIHRoYW5rcy4NCg0KQW5zb24u
DQoNCj4gDQo+IFNoYXduDQo+IA0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICB9Ow0KPiA+IC0t
DQo+ID4gMi43LjQNCj4gPg0K
