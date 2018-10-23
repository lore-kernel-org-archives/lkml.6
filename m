Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6010EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD120652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YL5a4sdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CD120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeJWSVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:21:01 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58570 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:21:01 -0400
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="22888063"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Oct 2018 02:58:19 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 23 Oct 2018 02:58:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRt3/ERnmukAr98rCvmbK0tA3OQNMOJe769vh9brGxU=;
 b=YL5a4sdMr9RHIkIQ2EU9T5/cphIO1BQkMpVfQopMG3SfByU8nesL4bYy09a62Z6pJ7lpgu38tIQeNu8zoai7g6yyaR1lYq+kZEDgab+00KAtpT3nioyegz1oAJGm3J7p0TTMe/OyjSoqUmrIUpj3PkIWVce4VbQuc+IN39eTc20=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1940.namprd11.prod.outlook.com (10.175.100.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 23 Oct 2018 09:58:16 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 09:58:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yogeshnarayan.gaur@nxp.com>, <boris.brezillon@bootlin.com>,
        <broonie@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <marek.vasut@gmail.com>, <cyrille.pitchen@wedev4u.fr>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Index: AQHUYdKPNq/svDKsvkGpAAT3eZGk/KUbIC2AgAAGsoCAEX4NgIAABT0A
Date:   Tue, 23 Oct 2018 09:58:16 +0000
Message-ID: <45727de4-8cf0-7176-674f-3e3ed622bdf1@microchip.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181012080753.2a59b75c@bbrezillon>
 <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.7.230.215]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1940;6:1klZms+3Dg0E0FjdRosjpIRMlX9nGcZW+JMM5mQklD+5RZitUM2/zATzCD27mjtuWX7m3mO9A+NBKRSTV0JytBX4leBnHHvQZYfZEcn27GIh/Ow5jKA14AoSGhSjh7cNaAWzXvU0kaeNFZCdzZ7pl0lrJ7w4UePMuYz5fGVnN/SikNjEuDH40KMgxhQ2gFT4IRI83CPWzuQ7/v9vOYJZkL/hus851mtRFkVOan7I9xOt7XeM6uL25WW1kC6Y3MMJqH8Lx3RYD2vA//cZg5/9XqHSG4kC3mgQ0ZiLslVxjos+lrCVyLXyLXrVMnmYF6J8HGHq807GafMwjvwpAW5OAEiAcKdjk+Eu/U/fIQdHHbXzHZ1Jqg8YmP/uGAp5jov5bRHhOV5dmLyWlXBRcJ8/wfqMtVgnaLlASmettzUQcd/LlrWGGIqv9pHaaPMQOAGlzUi1F1BXAbO5qPDCcJqg+w==;5:MFbC+h8lM+voEmvsLnJQqCnAbOAUVYV2ClxvkPItOcGmxvbzbgvH3p++M9e7BTOfSFn6kL9Kwlnlu43gqtOhoeXHHD+cR0EFMrM5N9Gxl0PcnM6uBjBxOBiAeW6KnVY2wo4+FjvdOm8tJWyDYECq2Doib7MaUor3OJS7nMvC4uU=;7:RvmyAEA8phf4jBezDGJGrZuBY1TQjxJ2l9Kv74XTgqSccZ1fuWZVW+fPQpGlv5KKy0nxHg13iERr+THrRcH9CX5cjXRopUQ5B9S1Yyp2e463x02uWnQKRovaF+gWxTfWast9+qXxfvLcTCl82mO6yblk56otaDj4XKqM7HDgdQuwsYX//vzzjlCjKGc3L06Xdqv/E3rvc9GQXScvDpII960GUrTdU5o6mylT1AU9c71bk9GyockI83SsxzmcWDKX
x-ms-office365-filtering-correlation-id: c47a7d9d-cc06-458d-1901-08d638ce0d48
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1940;
x-ms-traffictypediagnostic: BN6PR11MB1940:
x-microsoft-antispam-prvs: <BN6PR11MB19409A7E835B79DDA01A1529F0F50@BN6PR11MB1940.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(85827821059158)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1940;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1940;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(13464003)(5660300001)(446003)(6246003)(11346002)(2616005)(26005)(476003)(81156014)(81166006)(8936002)(105586002)(106356001)(478600001)(76176011)(52116002)(97736004)(102836004)(6486002)(6512007)(36756003)(6436002)(2906002)(99286004)(6116002)(5250100002)(93886005)(3846002)(71190400001)(186003)(86362001)(7736002)(53936002)(2900100001)(14444005)(305945005)(6506007)(386003)(316002)(53546011)(575784001)(71200400001)(31696002)(25786009)(39060400002)(486006)(4326008)(54906003)(110136005)(68736007)(31686004)(66066001)(72206003)(8676002)(14454004)(229853002)(256004)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1940;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cwl0hr7E+vqOb/yjLurrrZ548EeSYA96BgrfRZcar7YRePDmw97zE2UW+ct1/A0eYEjYF3YLwYSkBlPIuplhdrwzPc2lcrCw2mjzfpWdgCgGK0uE2lTkqiZ6LAUtpEUD2K94MnGZ27A8owTaR9c0fr6QCT1+ZSNSmnUJvVV3y9vVw0sA8a9tItQTLNq/8+tUWQIDPFWuT3DqqbV8HCvhQqdob4wds+0uH5X0mn46/elnZkTfARTPUgpWa6igIstMf2BkJY/9hqHhnk/WhlIGnj20biDEiZ1PQp1o3DGWHkm1Gu9qF+4wKWV0R01uxklU40eaR5Dyo/Ah90BzFIwWNitdIov96+kyoZK0YFrVTX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9919F2533CB4B4081900EE26DAF13CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c47a7d9d-cc06-458d-1901-08d638ce0d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:58:16.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1940
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDEwLzIzLzIwMTggMTI6MzkgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6
DQo+IEhpLA0KPiANCj4gRGlkIHdlIGhhdmUgaGF2ZSBhbnkgY29tbWVudHMgb3IgcmVtYXJrcyBh
Ym91dCB0aGlzIHBhdGNoLXNlcmllcywgIGlmIG5vdCBwbGVhc2UgYXBwbHkuDQoNCk5vdyB0aGF0
IHRoZSBvY3RhbCBtb2RlIGlzIGNsb3NlIHRvIGFuIGVuZCwgaXQgd291bGQgbWFrZSBzZW5zZSB0
byB3YWl0IGZvciBpdCwNCnNvIHRoYXQgeW91IGNhbiBhZGQgdGhlIG9jdGFsIGZsYWcgZm9yIHRo
aXMgbWVtb3J5IHdoZW4gaW50cm9kdWNlZC4gT2YgY291cnNlLA0Kbm90IGEgc2hvdyBzdG9wcGVy
Lg0KDQpDaGVlcnMsDQp0YQ0KDQo+IA0KPiBCb3RoIHBhdGNoZXMgaW4gdGhlIHNlcmllcyBiZWVu
IHJldmlld2VkIGJ5IFR1ZG9yLg0KPiANCj4gLS0NCj4gUmVnYXJkcw0KPiBZb2dlc2ggR2F1cg0K
PiANCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBZb2dlc2ggTmFyYXlh
biBHYXVyDQo+PiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTIsIDIwMTggMTI6MDIgUE0NCj4+IFRv
OiAnQm9yaXMgQnJlemlsbG9uJyA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPg0KPj4gQ2M6
IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
Ow0KPj4gdHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tOyBtYXJlay52YXN1dEBnbWFpbC5jb207
DQo+PiBjeXJpbGxlLnBpdGNoZW5Ad2VkZXY0dS5mcjsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwu
Y29tOw0KPj4gZnJpZWRlci5zY2hyZW1wZkBleGNlZXQuZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMS8yXSBtdGQ6IHNwaS1ub3I6IGFk
ZCBtYWNyb3MgcmVsYXRlZCB0byBNSUNST04gZmxhc2gNCj4+DQo+PiBIaSBCb3JpcywNCj4+DQo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBCb3JpcyBCcmV6aWxsb24g
W21haWx0bzpib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb21dDQo+Pj4gU2VudDogRnJpZGF5LCBP
Y3RvYmVyIDEyLCAyMDE4IDExOjM4IEFNDQo+Pj4gVG86IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlv
Z2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPj4+IENjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsNCj4+PiB0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb207IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsNCj4+PiBjeXJpbGxlLnBpdGNoZW5A
d2VkZXY0dS5mcjsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPj4+IGZyaWVkZXIuc2No
cmVtcGZAZXhjZWV0LmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Pj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyAxLzJdIG10ZDogc3BpLW5vcjogYWRkIG1hY3JvcyByZWxhdGVkIHRv
IE1JQ1JPTg0KPj4+IGZsYXNoDQo+Pj4NCj4+PiBPbiBGcmksIDEyIE9jdCAyMDE4IDAyOjIzOjA4
ICswMDAwDQo+Pj4gWW9nZXNoIE5hcmF5YW4gR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5j
b20+IHdyb3RlOg0KPj4+DQo+Pj4+IFNvbWUgTUlDUk9OIHJlbGF0ZWQgbWFjcm9zIGluIHNwaS1u
b3IgZG9tYWluIHdlcmUgU1QuDQo+Pj4+IFJlbmFtZSBlbnRyaWVzIHJlbGF0ZWQgdG8gU1RNaWNy
b2VsZWN0cm9uaWNzIHVuZGVyIG1hY3JvIFNOT1JfTUZSX1NULg0KPj4+Pg0KPj4+PiBBZGRlZCBl
bnRyeSBvZiBNRlIgSWQgZm9yIE1pY3JvbiBmbGFzaGVzLCAweDAwMkMuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4+
Pj4gUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+IENoYW5nZXMgZm9yIHYzOg0KPj4+PiAtIE5vbmUNCj4+Pj4gQ2hh
bmdlcyBmb3IgdjI6DQo+Pj4+IC0gTm9uZQ0KPj4+Pg0KPj4+PiAgZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGktbm9yLmMgfCA5ICsrKysrKy0tLQ0KPj4+PiAgaW5jbHVkZS9saW51eC9tdGQvY2ZpLmgg
ICAgICAgfCAxICsNCj4+Pj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCAgIHwgMyArKy0N
Cj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
Pj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+
Pj4gYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBpbmRleCA5NDA3Y2E1Li5iOGI0OTRm
IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4+PiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4+PiBAQCAtMjg0LDYgKzI4NCw3
IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNldF80Ynl0ZShzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4+
PiBjb25zdA0KPj4+IHN0cnVjdCBmbGFzaF9pbmZvICppbmZvLA0KPj4+PiAgCXU4IGNtZDsNCj4+
Pj4NCj4+Pj4gIAlzd2l0Y2ggKEpFREVDX01GUihpbmZvKSkgew0KPj4+PiArCWNhc2UgU05PUl9N
RlJfU1Q6DQo+Pj4+ICAJY2FzZSBTTk9SX01GUl9NSUNST046DQo+Pj4+ICAJCS8qIFNvbWUgTWlj
cm9uIG5lZWQgV1JFTiBjb21tYW5kOyBhbGwgd2lsbCBhY2NlcHQgaXQgKi8NCj4+Pj4gIAkJbmVl
ZF93cmVuID0gdHJ1ZTsNCj4+Pj4gQEAgLTEzODgsNyArMTM4OSw3IEBAIHN0YXRpYyBpbnQgc3Bp
X25vcl9pc19sb2NrZWQoc3RydWN0IG10ZF9pbmZvDQo+Pj4+ICptdGQsDQo+Pj4gbG9mZl90IG9m
cywgdWludDY0X3QgbGVuKQ0KPj4+PiAgCXsgIm14NjZsMWc0NWciLCAgSU5GTygweGMyMjAxYiwg
MCwgNjQgKiAxMDI0LCAyMDQ4LCBTRUNUXzRLIHwNCj4+PiBTUElfTk9SX0RVQUxfUkVBRCB8IFNQ
SV9OT1JfUVVBRF9SRUFEKSB9LA0KPj4+PiAgCXsgIm14NjZsMWc1NWciLCAgSU5GTygweGMyMjYx
YiwgMCwgNjQgKiAxMDI0LCAyMDQ4LA0KPj4+PiBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4+Pj4N
Cj4+Pj4gLQkvKiBNaWNyb24gKi8NCj4+Pj4gKwkvKiBNaWNyb24gPC0tPiBTVCBNaWNybyAqLw0K
Pj4+PiAgCXsgIm4yNXEwMTZhIiwJIElORk8oMHgyMGJiMTUsIDAsIDY0ICogMTAyNCwgICAzMiwg
U0VDVF80SyB8DQo+Pj4gU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+Pj4+ICAJeyAibjI1cTAzMiIs
CSBJTkZPKDB4MjBiYTE2LCAwLCA2NCAqIDEwMjQsICAgNjQsDQo+Pj4gU1BJX05PUl9RVUFEX1JF
QUQpIH0sDQo+Pj4+ICAJeyAibjI1cTAzMmEiLAkgSU5GTygweDIwYmIxNiwgMCwgNjQgKiAxMDI0
LCAgIDY0LA0KPj4+IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPj4+PiBAQCAtMzIyMyw2ICszMjI0
LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3Is
DQo+Pj4+ICAJCQlwYXJhbXMtPnF1YWRfZW5hYmxlID0gbWFjcm9uaXhfcXVhZF9lbmFibGU7DQo+
Pj4+ICAJCQlicmVhazsNCj4+Pj4NCj4+Pj4gKwkJY2FzZSBTTk9SX01GUl9TVDoNCj4+Pj4gIAkJ
Y2FzZSBTTk9SX01GUl9NSUNST046DQo+Pj4+ICAJCQlicmVhazsNCj4+Pj4NCj4+Pj4gQEAgLTM2
NzEsOCArMzY3Myw5IEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0IHNwaV9ub3IgKm5vciwgY29u
c3QNCj4+Pj4gY2hhcg0KPj4+ICpuYW1lLA0KPj4+PiAgCW10ZC0+X3Jlc3VtZSA9IHNwaV9ub3Jf
cmVzdW1lOw0KPj4+Pg0KPj4+PiAgCS8qIE5PUiBwcm90ZWN0aW9uIHN1cHBvcnQgZm9yIFNUbWlj
cm8vTWljcm9uIGNoaXBzIGFuZCBzaW1pbGFyICovDQo+Pj4+IC0JaWYgKEpFREVDX01GUihpbmZv
KSA9PSBTTk9SX01GUl9NSUNST04gfHwNCj4+Pj4gLQkJCWluZm8tPmZsYWdzICYgU1BJX05PUl9I
QVNfTE9DSykgew0KPj4+PiArCWlmIChKRURFQ19NRlIoaW5mbykgPT0gU05PUl9NRlJfU1QgfHwN
Cj4+Pj4gKwkgICAgSkVERUNfTUZSKGluZm8pID09IFNOT1JfTUZSX01JQ1JPTiB8fA0KPj4+PiAr
CSAgICBpbmZvLT5mbGFncyAmIFNQSV9OT1JfSEFTX0xPQ0spIHsNCj4+Pj4gIAkJbm9yLT5mbGFz
aF9sb2NrID0gc3RtX2xvY2s7DQo+Pj4+ICAJCW5vci0+Zmxhc2hfdW5sb2NrID0gc3RtX3VubG9j
azsNCj4+Pj4gIAkJbm9yLT5mbGFzaF9pc19sb2NrZWQgPSBzdG1faXNfbG9ja2VkOw0KPj4+DQo+
Pj4gQXJlIHlvdSBzdXJlIFNUIGFuZCBNaWNyb24gTk9ScyB3b3JrIHRoZSBzYW1lIHdheSBXUlQg
bG9ja2luZywgNC1ieXRlDQo+Pj4gYWRkcmVzc2luZyBtb2RlIGFuZCBRdWFkIGVuYWJsZT8NCj4+
DQo+PiBIYXZlIGNoZWNrZWQgZm9yIHRoZSBNaWNyb24gZmxhc2gsIE1UMzV4IHdydCBsb2NraW5n
LCA0LWJ5dGUgYWRkcmVzc2luZyBtb2RlLg0KPj4gRm9yIE1hY3Jvbml4IGFuZCBTcGFuc2lvbiBm
bGFzaCB0aGVyZSBpcyBzcGVjaWFsIGhhbmRsaW5nIHJlcXVpcmVkIGZvciBxdWFkDQo+PiBtb2Rl
IGJ1dCBub3QgbmVlZGVkIGZvciBTVCBmbGFzaC4NCj4+IFRoaXMgZmxhc2ggZGlkbid0IHN1cHBv
cnQgcXVhZCBtb2RlIGFuZCBoYXZlIGNoZWNrZWQgdGhhdCBvdGhlciBNaWNyb24gZmxhc2gNCj4+
IGFsc28gZGlkbid0IG5lZWQgc3BlY2lhbCBoYW5kbGluZyBmb3IgcXVhZCBtb2RlLg0KPj4gLS0N
Cj4+IFJlZ2FyZHMNCj4+IFlvZ2VzaCBHYXVyLg0KPj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L210ZC9jZmkuaCBiL2luY2x1ZGUvbGludXgvbXRkL2NmaS5oIGluZGV4DQo+Pj4+
IDliNTdhOWIuLmNiZjc3MTYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL2Nm
aS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL2NmaS5oDQo+Pj4+IEBAIC0zNzcsNiAr
Mzc3LDcgQEAgc3RydWN0IGNmaV9maXh1cCB7DQo+Pj4+ICAjZGVmaW5lIENGSV9NRlJfU0hBUlAJ
CTB4MDBCMA0KPj4+PiAgI2RlZmluZSBDRklfTUZSX1NTVAkJMHgwMEJGDQo+Pj4+ICAjZGVmaW5l
IENGSV9NRlJfU1QJCTB4MDAyMCAvKiBTVE1pY3JvZWxlY3Ryb25pY3MgKi8NCj4+Pj4gKyNkZWZp
bmUgQ0ZJX01GUl9NSUNST04JCTB4MDAyQyAvKiBNaWNyb24gKi8NCj4+Pj4gICNkZWZpbmUgQ0ZJ
X01GUl9UT1NISUJBCQkweDAwOTgNCj4+Pj4gICNkZWZpbmUgQ0ZJX01GUl9XSU5CT05ECQkweDAw
REENCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaA0K
Pj4+PiBiL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCBpbmRleCA3ZjBjNzMwLi44YjFhY2Y2
IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4+Pj4gKysr
IGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+Pj4+IEBAIC0yMyw3ICsyMyw4IEBADQo+
Pj4+ICAjZGVmaW5lIFNOT1JfTUZSX0FUTUVMCQlDRklfTUZSX0FUTUVMDQo+Pj4+ICAjZGVmaW5l
IFNOT1JfTUZSX0dJR0FERVZJQ0UJMHhjOA0KPj4+PiAgI2RlZmluZSBTTk9SX01GUl9JTlRFTAkJ
Q0ZJX01GUl9JTlRFTA0KPj4+PiAtI2RlZmluZSBTTk9SX01GUl9NSUNST04JCUNGSV9NRlJfU1Qg
LyogU1QgTWljcm8gPC0tPg0KPj4gTWljcm9uDQo+Pj4gKi8NCj4+Pj4gKyNkZWZpbmUgU05PUl9N
RlJfU1QJCUNGSV9NRlJfU1QJLyogU1QgTWljcm8gKi8NCj4+Pj4gKyNkZWZpbmUgU05PUl9NRlJf
TUlDUk9OCQlDRklfTUZSX01JQ1JPTgkvKg0KPj4gTWljcm9uICovDQo+Pj4+ICAjZGVmaW5lIFNO
T1JfTUZSX01BQ1JPTklYCUNGSV9NRlJfTUFDUk9OSVgNCj4+Pj4gICNkZWZpbmUgU05PUl9NRlJf
U1BBTlNJT04JQ0ZJX01GUl9BTUQNCj4+Pj4gICNkZWZpbmUgU05PUl9NRlJfU1NUCQlDRklfTUZS
X1NTVA0KPiANCj4gDQo=
