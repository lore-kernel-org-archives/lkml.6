Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F9DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8A020877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="z6LYmSCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8A020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeISKvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:51:06 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:18926
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeISKvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+uotQzH6I6GHhD0mkpUQvsx1+/GcH5Y1O7NctCO1f0=;
 b=z6LYmSChD/Qpr9YoQAe0mgvJRmeyiljjZ+kKSBW9OrhCX+UXT7ihFzG8uc3ImdNIrJc9SLJ0ptRV7fE7ygr/h4MZE5hGEvtf+n8bZhr5KsuQ+9hRA7JzaDmshpPaugGIo3vD5Vd4ePn5TXuShvCjDVSKHn/qbgRzfLdpFZENd3w=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB5129.namprd02.prod.outlook.com (20.176.114.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 05:14:51 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 05:14:51 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUTpJW1XQNYRxn3kWgpPIZoEhCVaT1rMEAgAFj0DA=
Date:   Wed, 19 Sep 2018 05:14:51 +0000
Message-ID: <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
In-Reply-To: <20180918075522.GC22202@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5129;6:6oDdGUkWlCi8xFuWGCWxHa/jcGBPdX0Tz8P7rx1z8VU/RytllqHYmtSwMy87l0R2crsgOGJi0UpWpIRhzVVepiCAtOwQWAxYXJ5Os+JEkFdgunv22RMmEUwwfOD+cV/RCSbDSjpo/sEPIw7iaYn5Wi2j1BcRPgKGY71hn8j3kO26qqebqc3ctMb4ycN8vS/2rg+XYT7Jqny9MbgDnZ2gaimiCrN38BxnirPwioHvxWdwYVBVl7uqL/u49B+p8+kkP8AgoRGqc1SZA9F4n1vPwh5oRQ3H1CsMLAlaQLKG9iY9doKh/gwq/FY4Q278P2+zI4fAJse03iEnN6CA2JY71Erapm4fE7KbkqE021hZ6oQVJn7GJuV+VcWUjrbpqe06QHcJLuDu5826XhpYN4rZKvxjA8C/8r8A26khInGrfizRhJKfq/SlS8VKhSi0ocLyhMRJF5/QyPcJJBFgnb+3/Q==;5:Yhuycxy4/xVrn8F/Edbj24KsePFiaZsgNVxc1Mpf/lzf9d0JJ6vLoOeNYatyInAADSLpY1YXs/WZgUbuZgklPbtyzVTXjYbei5FoCmFbOpGSxvo+Yw3E/feIRxSfK8jjd3YeDRGQBCv1Px2iUsZ7hjgWuHYW7H8gjf8o8Larktw=;7:UJrr2oN68FC2abiuxuaQxRDWajk4/LaXWs2WWANa76a2cKUjziIdc8dIrOoJjZZVvG1tt0nQ1393aILxXbxFNF4/C5li/eVIbSkIPWj+66l3IVmZ1hKEtfHsSiNcx7yLs0nJwRG34UPA4tLvbSZtE/EqJdMvIbbg43q34JjDignRCHy5OOOwwKEUHP0iFscsyJgq5T2sDLIc1i6lq4J9fcDPl+ITk47pAOW4sQZSklVcx5zE42ZruaGQpwzNTjzg
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1bb679a6-214a-4f1f-7789-08d61deed3f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5129;
x-ms-traffictypediagnostic: DM6PR02MB5129:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB512996FA505EA11277F7A562C11C0@DM6PR02MB5129.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DM6PR02MB5129;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5129;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(13464003)(97736004)(106356001)(186003)(7416002)(33656002)(446003)(11346002)(68736007)(2900100001)(486006)(476003)(74316002)(6916009)(26005)(7736002)(105586002)(5660300001)(66066001)(2906002)(81156014)(14454004)(99286004)(6246003)(102836004)(81166006)(53546011)(478600001)(7696005)(8936002)(8676002)(72206003)(305945005)(76176011)(86362001)(5250100002)(9686003)(6116002)(25786009)(54906003)(6506007)(3846002)(55016002)(53936002)(229853002)(256004)(4326008)(316002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5129;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RDNGJy7JD0OGisS5w4EIo5t2YivtUhFXBxoAksBTOjy1IvzhZD5QaIn30QGltydCzXvYS+E6UuydQAJILzAFNEzW0rPF6diEccw34l+03JFMmmgHac/U2tVAR4lJ7WbKJZ6HhVva8WNgDJyKDc4IQPq8y4m2WbUDtHPIsHf7kCoVqXby89efG5GY2eaq5QKI01x8G0WRmy2KPa5kff8E/qDXE23bzwoqnjLEHYOtmPaIxKoaOQ8+OQklOt1icuW11Td5RyzT4tWM466gcM1ibVmy3o0d5BxuRwnsRZM3/Fus/O3wmgwZcSmoyF3Re8jhNsaJQT9tDFcxppW81qpXkMKhWVqL2BJyEJ+e6S8xDNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb679a6-214a-4f1f-7789-08d61deed3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 05:14:51.3735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb250aW51b3VzIGd1aWRhbmNlLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJvcmlzbGF2IFBldGtvdiBbbWFpbHRv
OmJwQGFsaWVuOC5kZV0NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE4LCAyMDE4IDE6MjUg
UE0NCj4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4NCj4gQ2M6IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsN
Cj4gTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBsZW95YW5nLmxpQG54cC5jb207
DQo+IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4gZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDIvN10gZWRhYzogc3lucHM6IEFk
ZCBwbGF0Zm9ybSBzcGVjaWZpYyBzdHJ1Y3R1cmVzIGZvcg0KPiBkZHJjIGNvbnRyb2xsZXINCj4g
DQo+IE9uIE1vbiwgU2VwIDE3LCAyMDE4IGF0IDA3OjU1OjAwUE0gKzA1MzAsIE1hbmlzaCBOYXJh
bmkgd3JvdGU6DQo+ID4gQWRkIHBsYXRmb3JtIHNwZWNpZmljIHN0cnVjdHVyZXMsIHNvIHRoYXQg
d2UgY2FuIGFkZCBkaWZmZXJlbnQgSVANCj4gPiBzdXBwb3J0IGxhdGVyIHVzaW5nIHF1aXJrcy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGls
aW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8IDkx
DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiANCj4g
Li4uDQo+IA0KPiA+IEBAIC00MjMsNiArNDY1LDcgQEAgc3RhdGljIHZvaWQgZWRhY19tY19pbml0
KHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCj4gPiAgICovDQo+ID4gIHN0YXRpYyBpbnQgc3lu
cHNfZWRhY19tY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+ICsJ
Y29uc3Qgc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgKnBfZGF0YTsNCj4gPiAgCXN0cnVjdCBl
ZGFjX21jX2xheWVyIGxheWVyc1syXTsNCj4gPiAgCXN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnBy
aXY7DQo+ID4gIAlzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2k7DQo+ID4gQEAgLTQzNSw3ICs0Nzgs
OCBAQCBzdGF0aWMgaW50IHN5bnBzX2VkYWNfbWNfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiAgCWlmIChJU19FUlIoYmFzZWFkZHIpKQ0KPiA+ICAJCXJldHVybiBQ
VFJfRVJSKGJhc2VhZGRyKTsNCj4gPg0KPiA+IC0JaWYgKCFlZGFjX2dldF9lY2NzdGF0ZShiYXNl
YWRkcikpIHsNCj4gPiArCXBfZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+
ZGV2KTsNCj4gPiArCWlmICghKHBfZGF0YS0+Z2V0X2VjY3N0YXRlKGJhc2VhZGRyKSkpIHsNCj4g
DQo+IEZyb20gbGFzdCByZXZpZXcgcm91bmQ6DQo+IA0KPiAiVG9vIG1hbnkgcGFyZW50aGVzZXM6
DQo+IA0KPiAgICAgICAgIGlmICghcF9kYXRhLT4uLi4NCj4gDQo+IGlzIGVub3VnaC4iDQo+IA0K
PiBTbyBJJ20gZ29pbmcgdG8gc3RvcCByZXZpZXdpbmcgdGhpcyBwYXRjaHNldCB1bnRpbCB5b3Ug
Z28gdGhyb3VnaCB0aGUgb2xkIHJldmlldw0KPiByb3VuZCBhZ2FpbiBhbmQgbWFrZSBzdXJlIHlv
dSd2ZSBpbmNvcnBvcmF0ZWQgKmFsbCogcmV2aWV3IGZlZWRiYWNrIGFuZA0KPiBoYXZlbid0IGZv
cmdvdHRlbiBzb21lLCBsaWtlIHRoZSBvbmUgYWJvdmUuDQo+IA0KT2theSwgSSB3aWxsIGRvdWJs
ZSBjaGVjayBhZ2FpbiBmb3IgdGhlIGNvbW1lbnRzIGZyb20gcHJldmlvdXMgcmV2aWV3IGFuZCBy
ZWN0aWZ5IHRoZSBzYW1lIGluIHY4LiBDYW4geW91IHBsZWFzZSByZXZpZXcgdGhlIHJlbWFpbmlu
ZyBwYXRjaGVzIHNvIHRoYXQgSSBjYW4gYWNjb21tb2RhdGUgYW55IGNoYW5nZXMgZm9yIHRoZW0g
aW4gdjg/IEkgcmVncmV0IHRoZSBpbmNvbnZlbmllbmNlIGNhdXNlZCB0byB5b3UgaW4gdGhpcy4N
Cg0KVGhhbmtzLA0KTWFuaXNoDQo=
