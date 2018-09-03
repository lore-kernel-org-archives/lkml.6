Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5865FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD15120856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6A1dknA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD15120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeICJF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:05:57 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:33728
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbeICJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKKqQN/9b2jGYvXW6cjjSVDTZK6uyeYTzbflme+mZzw=;
 b=S6A1dknAa4XVCFxXOqGQfZi1oPRtiAGhp3IcMi+7SEkGbaQi3IFS6woAGPYqhEiY8QteLbN2NE0qmzMXq/XG5a+SccMTZGUCojjdhnQQTn5gg55opYqDuu1wPmERyxE6oZTev2rNgovqd/eEE176J7nF8CL4NXI3KnK5I2SaSHA=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB2160.eurprd04.prod.outlook.com (10.166.43.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 04:47:25 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5%6]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 04:47:25 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/7] spi: add slave device size in spi_device struct
Thread-Topic: [PATCH 1/7] spi: add slave device size in spi_device struct
Thread-Index: AQHUQRXZyJXdNsUzo06bGC/Lf/s7vaTZwZaAgAQ9r/A=
Date:   Mon, 3 Sep 2018 04:47:25 +0000
Message-ID: <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180831135807.22255bce@karo-electronics.de>
In-Reply-To: <20180831135807.22255bce@karo-electronics.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB2160;6:ZmGczIhP8YVZz3auiPmbBXca4TBGIVkkCd1ZE6xZQ+I5/8s/oAzlcJNQRT+hYdGupsrN+UIDtGSLPWIRJ3ohYGwziI5OOWoyJUI1ShwvrcuWnPUrMi4juL5oE2PC5jYJR0Eizm/PNN3Ew1HjLCgSujTasPZoJMphniVqiv4nfHIfDObO2hFUl84Qdsay10TxffeUtW5f9Oy/Un9psLI+0bXEXNBkVcHZRh7NqG0DlLOEyaGLTUWLp6eq17yPnJd9+y7rD+oleh6ex5nHemEFpV0vPLZc76k+HGsOxND0dJTF7UH23WuvWvZ0m0ckkLaMtu93CC4766sIh/eNjBF/T+XwMFOcXqHhkDOKygesUqx5uWsCEJHqcVq54XqBdVEA64Y39PVmkgoZ40JmtAC/M0PQnKNNxAZzL1yggQDK3vIwP/PKXAt5La7Rv9IC/63ZlTqDmNfwd79AlYKcrRpFJA==;5:MXpP54QfIGIk4SpZ4MpfVoyDPoVKhmF4JbTcvMildh6eNNsL/GASWRFScBasGrGJtMFzuVCXW0xjjZ98B1EjToyJfrVtIb72R5k9eNhwACAdcwWAeFNrLD+QdO0/+Ba2Vwj3rp6inYYVUJeTHuUASNdaU7zXd6j1Xq5A6m/x0go=;7:wxCF1LmrX1NNMBXZFmSXUlnozoG0cpwyz+B0rTMnW+1DwmAw0xrGJLRmeA0NCa+dnxOReKRm+TYoZ4Tbuvzd8u+QfNc14nu+JU731OQL1v5JFwAibPbQZAxo+CpDHim75yUjpOM8f2Qtolpeprob/vCe5uJEZgT/NlJ4DBnyf6TJc3BnHFIEaRqOso+NswcZinOsX5nj/SjpztO+UJZ3H6shR7RXTSG4XAg8kW2R7jdT7LSfd83GHBOitmDVQ1I3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 17f0b108-1077-4f97-5c09-08d61158587d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2160;
x-ms-traffictypediagnostic: VI1PR04MB2160:
x-microsoft-antispam-prvs: <VI1PR04MB216017221150A9881A22AA6D990C0@VI1PR04MB2160.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR04MB2160;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB2160;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(13464003)(305945005)(6916009)(74316002)(76176011)(97736004)(7736002)(53936002)(8676002)(55016002)(6246003)(25786009)(6436002)(4326008)(39060400002)(2906002)(99286004)(5660300001)(256004)(486006)(11346002)(446003)(7416002)(14444005)(2900100001)(8936002)(229853002)(6116002)(3846002)(476003)(33656002)(5250100002)(86362001)(68736007)(54906003)(14454004)(66066001)(7696005)(478600001)(81166006)(55236004)(186003)(6506007)(102836004)(316002)(53546011)(81156014)(9686003)(26005)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2160;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bzgrEUokperrSd+0ze3xLd6AXcewGso++6lPw5eGqtY6z0pzaycTHLFGQKoUUvuQarKPyQlDbFqEtjAc1iO2LyZTuDPvm51Qg7dUIznJULZr6nqoQpQQ2fL15AzisHBNJ0y9HEWXFLE0+e0VCoxmaUSjuYlGCJnumRgz5ZVc/jW27iEvbKh4Vl+q8ZYlqaLvpG5mzQIW4zGgmu0H8wPxZraLPIYddpPehjxkNZ1auy+j972SIsPJWnZo9earY/NMoYk5YYt2foyT4PcBqGxNAiLiLKjr3j+ZOSIY/hxKKBJVA8TpHmbXGenE6bxxux9EtENVxemN4YoFeFwQF7fS2RmBDGlV91GL3Awjx7ScFYI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f0b108-1077-4f97-5c09-08d61158587d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 04:47:25.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG90aGFyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvdGhh
ciBXYcOfbWFubiBbbWFpbHRvOkxXQEtBUk8tZWxlY3Ryb25pY3MuZGVdDQo+IFNlbnQ6IEZyaWRh
eSwgQXVndXN0IDMxLCAyMDE4IDU6MjggUE0NCj4gVG86IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlv
Z2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbTsNCj4gbWFyZWsudmFzdXRAZ21haWwu
Y29tOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHJvYmhAa2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGZyaWVkZXIuc2NocmVtcGZAZXhjZWV0LmRlOw0KPiBjb21w
dXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LWFybS0N
Cj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzdd
IHNwaTogYWRkIHNsYXZlIGRldmljZSBzaXplIGluIHNwaV9kZXZpY2Ugc3RydWN0DQo+IA0KPiBI
aSwNCj4gDQo+IE9uIEZyaSwgMzEgQXVnIDIwMTggMTU6NTk6NTggKzA1MzAgWW9nZXNoIEdhdXIg
d3JvdGU6DQo+ID4gQWRkICdzaXplJyBkYXRhIHZhcmlhYmxlIGluIHNwaV9kZXZpY2Ugc3RydWN0
Lg0KPiA+IFRoaXMgaXMgdG8gc2F2ZSB0aGUgc2l6ZSBvZiB0aGUgY29ubmVjdGVkIHNsYXZlIGRl
dmljZS4NCj4gPg0KPiA+IEFmdGVyIHNsYXZlIGRldmljZSBzY2FuLCBzcGlfbm9yX3NjYW4sIHNp
emUgYmVpbmcgYXNzaWduZWQgdG8gdGhpcw0KPiA+IGZyb20gTVREIGxheWVyLg0KPiA+DQo+ID4g
U0ZEUCByZWFkIGlzIGJlaW5nIHJlcXVlc3RlZCBiZWZvcmUgY29tcGxldGlvbiBvZiBzcGlfbm9y
X3NjYW4oKQ0KPiA+IHJvdXRpbmUsIHRodXMgcG9wdWxhdGUgZGV2aWNlIHNpemUgYmVmb3JlIG1h
a2luZyByZWFkIHJlcXVlc3QgdG8gdGhlDQo+ID4gU1BJIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgIHwgNiArKysrKysNCj4g
PiBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4gPiAgaW5jbHVkZS9saW51
eC9zcGkvc3BpLmggICAgICAgfCAyICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgw
LmMNCj4gPiBiL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgaW5kZXggZmUyNjBjYy4uNmM3
YWQ4NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jDQo+ID4g
KysrIGIvZHJpdmVycy9tdGQvZGV2aWNlcy9tMjVwODAuYw0KPiA+IEBAIC0xMjQsNiArMTI0LDEw
IEBAIHN0YXRpYyBzc2l6ZV90IG0yNXA4MF9yZWFkKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+IGxv
ZmZfdCBmcm9tLCBzaXplX3QgbGVuLA0KPiA+ICAJLyogY29udmVydCB0aGUgZHVtbXkgY3ljbGVz
IHRvIHRoZSBudW1iZXIgb2YgYnl0ZXMgKi8NCj4gPiAgCW9wLmR1bW15Lm5ieXRlcyA9IChub3It
PnJlYWRfZHVtbXkgKiBvcC5kdW1teS5idXN3aWR0aCkgLyA4Ow0KPiA+DQo+ID4gKwkvKiBmb3Ig
Y2FzZSBvZiBTRkRQIGhlYWRlciByZWFkIGNvbW1hbmRzLCBwb3B1bGF0ZSBzcGkgZGV2aWNlIHNp
emUgKi8NCj4gPiArCWlmIChmbGFzaC0+c3BpbWVtLT5zcGktPnNpemUgPT0gMCkNCj4gPiArCQlm
bGFzaC0+c3BpbWVtLT5zcGktPnNpemUgPSBub3ItPm10ZC5zaXplOw0KPiA+ICsNCj4gSWYgdGhl
ICdzaXplJyBpcyBhbiBzcGltZW0gc3BlY2lmaWMgdmFyaWFibGUgaXQgc2hvdWxkIGJlIGFkZGVk
IHRvIHRoZSBzcGlfbWVtDQo+IHN0cnVjdCByYXRoZXIgdGhhbiB0aGUgc3BpX2RldmljZSBzdHJ1
Y3QuDQoNClN1cmUsIHdvdWxkIG1vdmUgJ3NpemUnIGZyb20gc3RydWN0IHNwaV9kZXZpY2UgdG8g
dGhlIHN0cnVjdCBzcGlfbWVtLg0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXIuDQoNCj4gDQo+
IExvdGhhciBXYcOfbWFubg0K
