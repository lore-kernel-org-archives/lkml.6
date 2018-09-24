Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4235C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE58208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eBk6oDRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE58208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIXQWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:22:07 -0400
Received: from mail-co1nam03on0070.outbound.protection.outlook.com ([104.47.40.70]:55063
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbeIXQWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DKwu+pmhnR2c5/4QMOhShx7ByzULsvUsiK0fkp1INc=;
 b=eBk6oDRkbPBoEANDMeri3R4groUNB4z0zbM/QqsUu22Owqkr/rChoafMheaauDTaNrvxe0Ied/lTEJo64Pp4eDSABFyWeJ/UhPfc9M4wubFJy0BNBirVy44RmdbZJXFy69GHs/Mq74WQnJzxs9OK5r2NqBfZzAC2vmqDB5VElZM=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4745.namprd02.prod.outlook.com (20.176.108.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 10:20:42 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 10:20:41 +0000
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
Subject: RE: [PATCH v7 5/7] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Thread-Topic: [PATCH v7 5/7] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Thread-Index: AQHUTpJOPJzTTE/BK0CtzTRmmC6TR6T6t86AgASKeeA=
Date:   Mon, 24 Sep 2018 10:20:41 +0000
Message-ID: <DM6PR02MB522717E2B74148A7069FA57EC1170@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
 <20180921125527.GE30439@nazgul.tnic>
In-Reply-To: <20180921125527.GE30439@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4745;6:p54Ynp5bw6pJ8ANHJXNC0wcb6qSwffKuvOylhsnQSKCOOPOsGHTWo4cSh5Yu9MmtTbQviBQQ5ZzRsXI9O22HAFGR/EbcjxH5lJYvOoCRiu+TwV5K23c+/1/dfHPIBjGRpsTQLFINoshY4L7OFPX+WKeWea1D5f03CMjj8g0RygR0JkihaeqZb/mj+3OcZ4TEEVrhduQ8hv0EcrBJkk/CtiOyn0Owtknezph5U3SIUjBr3Q06OGoG+Ym1yfCIM3xbjolNMZDJtZgXfRgtbjyILSR2novkikOeFTbVBVObkDk20/GMDWOsHqv+H5n0txKpGJX9Pcj3UsUm+DuBa+ISIW7GGWjANbpa7SxgHiFobZ9mv7hSFdOIYN5YT3dPu9sgVio1XEZdjCONEAGoAAkkzWfqDMrx76dOJFS1EEhdj4z+1IbLPhI9r1iAroA2bswnO7eO3jCHUxcEauqsnYzDlw==;5:V8yvVYqMgjpzSq4F8JzbEhGl9s8bEhASAk9YMVYfjJ+gRMW8wXcFGUpNsx1VK+fxR0+5mWS6sfyGutYI+43cwtmMs1W8fj2emG6mEmg0CDqflY4J1bu7UQ7rCE9qbA1rRqdpg98UkPC1K4MofWQkA+e6UoBVsHrRDoyV06gG594=;7:ZGiRvYFzd7EC+ZyinCuJLdCEw1X89V4jRHG5mg4fWa+EI3ypQkt2P/2laXiEBjdbX6fTMdRks5kQ2+6qFKJA7Ut846IPILlX5W5+AeU/UnUmuS88ZcYk+52TBPLyI1jkmeobfpNTsgZKSUN3/eG3Xayn7q5ReOXRkHdpBYZZ5zvh/WyHcb5xaleAVwC/L+D4LpwdnvifBbaCgH7X8ogYXrRE+L0uBP5xl+x5TzdwNYvsGZOQNo0zuIYtTs63Xtv3
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(51914003)(189003)(199004)(7416002)(6916009)(2906002)(105586002)(106356001)(2900100001)(5660300001)(66066001)(6436002)(476003)(6246003)(25786009)(4326008)(6506007)(102836004)(76176011)(53936002)(229853002)(11346002)(446003)(3846002)(6116002)(26005)(186003)(14444005)(256004)(54906003)(55016002)(9686003)(7696005)(217873002)(99286004)(486006)(97736004)(5250100002)(8676002)(81156014)(81166006)(8936002)(478600001)(72206003)(74316002)(305945005)(14454004)(7736002)(316002)(86362001)(33656002)(71190400001)(68736007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4745;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 778101d1-6cfc-4404-1009-08d622076183
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4745;
x-ms-traffictypediagnostic: DM6PR02MB4745:
x-microsoft-antispam-prvs: <DM6PR02MB4745626AAF4E5F017095976AC1170@DM6PR02MB4745.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4745;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4745;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9uNGW7QoT1ZIQayEfrZ7RFuTDJSrHcg13yBG72c3PCWAvUzAq0yxIBByG5ZiWEiOAyUMgvgpKtgnGtV+ctVI5rICfvSxGhbwfE13tmTlntU6RPAHu5zpEe4sTJygE2GOvYOM8Ghn+K/THv3yQ88hiPKGqStV4OgyGaaUDw5/tjUvZmlwT5a15kaKTHRie5VIdWtnAbt2Y194/sNgcMGG1hU4qP1Abc8UmUVV1qNfk8gebcjyZHmXR2iri/p2gIE0kisxzEv2CF6O5J4JqJtoGTa75XReCKbWX+NitY03ZpRkw4bqGxeTPwt4NLJ5K+/gRzKR88251SYf+oBIQYYpLyjwazjPSdbQJw/TqJKOonY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778101d1-6cfc-4404-1009-08d622076183
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 10:20:41.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KDQo+IEZyb206IEJvcmlzbGF2
IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjEsIDIwMTggNjoyNiBQTQ0KPiBPbiBNb24sIFNlcCAxNywgMjAxOCBhdCAwNzo1NTowM1BNICsw
NTMwLCBNYW5pc2ggTmFyYW5pIHdyb3RlOg0KPiA+IEFkZCBFREFDIEVDQyBzdXBwb3J0IGZvciBa
eW5xTVAgRERSQyBJUC4gVGhlIElQIHN1cHBvcnRzIGludGVycnVwdHMNCj4gPiBmb3IgY29ycmVj
dGVkIGFuZCB1bmNvcnJlY3RlZCBlcnJvcnMuIEFkZCBpbnRlcnJ1cHQgaGFuZGxlcnMgZm9yIHRo
ZSBzYW1lLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXNoIE5hcmFuaSA8bWFuaXNoLm5h
cmFuaUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2VkYWMvS2NvbmZpZyAgICAg
ICAgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMgfCAzMDQNCj4g
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMjg3IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gLi4u
DQo+ID4gKwlpZiAocHJpdi0+cF9kYXRhLT5xdWlya3MgJiBERFJfRUNDX0lOVFJfU1VQUE9SVCkg
ew0KPiANCj4gVGhpcyB3aG9sZSBjaHVuayB0b2dldGhlciB3aXRoIHRoZSBpZiwgbG9va3MgbGlr
ZSBpdCBjb3VsZCBiZSBhIHNlcGFyYXRlIGZ1bmN0aW9uDQo+IGNhbGxlZCBtYXliZSByZXF1ZXN0
X2lycSgpIG9yIHNvLg0KTWF5IGJlIEkgY2FuIGtlZXAgaXQgbGlrZSBlZGFjX3NldHVwX2lycSgp
ID8NCg0KPiANCj4gPiArCQlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICsJ
CWlmIChpcnEgPCAwKSB7DQo+ID4gKwkJCWVkYWNfcHJpbnRrKEtFUk5fRVJSLCBFREFDX01DLA0K
PiA+ICsJCQkJCSJObyBpcnEgJWQgaW4gRFRcbiIsIGlycSk7DQo+IA0KPiBBbGlnbiBhcmd1bWVu
dHMgb24gb3BlbmluZyBicmFjZS4NCk9rYXkNCg0KPiANCj4gVGhlbiwgaGVyZSBpdCBpcyAiaXJx
Ii4uLg0KPiANCj4gPiArCQkJcmMgPSBpcnE7DQo+ID4gKwkJCWdvdG8gZnJlZV9lZGFjX21jOw0K
PiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJcmMgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYs
IGlycSwNCj4gPiArCQkJc3lucHNfZWRhY19pbnRyX2hhbmRsZXIsDQo+ID4gKwkJCTAsIGRldl9u
YW1lKCZwZGV2LT5kZXYpLCBtY2kpOw0KPiANCj4gQWxzbyBhbGlnbiBvbiBvcGVuaW5nIGJyYWNl
Lg0KPiANCj4gPiArCQlpZiAocmMgPCAwKSB7DQo+ID4gKwkJCWVkYWNfcHJpbnRrKEtFUk5fRVJS
LCBFREFDX01DLCAiRmFpbGVkIHRvIHJlcXVlc3QNCj4gSXJxXG4iKTsNCj4gDQo+IC4uLiBoZXJl
IGl0IGlzICJJcnEiLg0KPiANCj4gSSdkIHNheSBpdCBzaG91bGQgYmUgIklSUSIgZXZlcnl3aGVy
ZS4NCk9rYXkNCg0KPiANCj4gPiArCQkJZ290byBmcmVlX2VkYWNfbWM7DQo+ID4gKwkJfQ0KPiA+
ICsNCj4gPiArCQkvKiBFbmFibGUgVUUvQ0UgSW50ZXJydXB0cyAqLw0KPiA+ICsJCXdyaXRlbCgo
RERSX1FPU1VFX01BU0sgfCBERFJfUU9TQ0VfTUFTSyksDQo+ID4gKwkJCXByaXYtPmJhc2VhZGRy
ICsgRERSX1FPU19JUlFfRU5fT0ZTVCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmMgPSBlZGFj
X21jX2FkZF9tYyhtY2kpOw0KPiA+ICAJaWYgKHJjKSB7DQo+ID4gIAkJZWRhY19wcmludGsoS0VS
Tl9FUlIsIEVEQUNfTUMsDQo+ID4gQEAgLTY4NCw3ICs5NDUsOCBAQCBzdGF0aWMgaW50IHN5bnBz
X2VkYWNfbWNfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCSAq
IFN0YXJ0IGNhcHR1cmluZyB0aGUgY29ycmVjdGFibGUgYW5kIHVuY29ycmVjdGFibGUgZXJyb3Jz
LiBBIHdyaXRlIG9mDQo+ID4gIAkgKiAwIHN0YXJ0cyB0aGUgY291bnRlcnMuDQo+ID4gIAkgKi8N
Cj4gPiAtCXdyaXRlbCgweDAsIGJhc2VhZGRyICsgRUNDX0NUUkxfT0ZTVCk7DQo+ID4gKwlpZiAo
IShwcml2LT5wX2RhdGEtPnF1aXJrcyAmIEREUl9FQ0NfSU5UUl9TVVBQT1JUKSkNCj4gPiArCQl3
cml0ZWwoMHgwLCBiYXNlYWRkciArIEVDQ19DVFJMX09GU1QpOw0KPiA+ICAJcmV0dXJuIHJjOw0K
PiA+DQo+ID4gIGZyZWVfZWRhY19tYzoNCj4gPiBAQCAtNzAyLDcgKzk2NCwxMyBAQCBzdGF0aWMg
aW50IHN5bnBzX2VkYWNfbWNfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KSAgc3RhdGljIGludCBzeW5wc19lZGFjX21jX3JlbW92ZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpICB7DQo+ID4gIAlzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2kgPSBwbGF0Zm9y
bV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiArCXN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXY7
DQo+ID4NCj4gPiArCXByaXYgPSBtY2ktPnB2dF9pbmZvOw0KPiA+ICsJaWYgKHByaXYtPnBfZGF0
YS0+cXVpcmtzICYgRERSX0VDQ19JTlRSX1NVUFBPUlQpDQo+ID4gKwkJLyogRGlzYWJsZSBVRS9D
RSBJbnRlcnJ1cHRzICovDQo+ID4gKwkJd3JpdGVsKChERFJfUU9TVUVfTUFTSyB8IEREUl9RT1ND
RV9NQVNLKSwNCj4gPiArCQkJcHJpdi0+YmFzZWFkZHIgKyBERFJfUU9TX0lSUV9EQl9PRlNUKTsN
Cj4gDQo+IFRoaXMgY291bGQgYmUgYSBkaXNhYmxlX2lycSgpIGZ1bmN0aW9uLiBNYWtlcyB0aGUg
Y29kZSBlYXNpZXIgdG8gZm9sbG93Lg0KT2theS4gV2lsbCB1cGRhdGUgdGhpcyBpbiB2OC4NCg0K
VGhhbmtzLA0KTWFuaXNoDQo=
