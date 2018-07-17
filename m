Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9122ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5020693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IO6mo+BG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC5020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeGQUnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:43:20 -0400
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:19264
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729840AbeGQUnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIQnojnXdyVHezk8p4u0AAQG70Bc4ZdlukBeuXLt8sQ=;
 b=IO6mo+BGrzatRR8CuS3V1q6PCbTz3z6c0PAzHUIn495Wd4z+/JaJzA6Px75nyzePUluhkR6ZnP6b/RGWgU6sERx1Ww1nCX4Bw/ZEpxjJdg111cEyWCk+f9imutrgVmitvCrjnLW/zljnUpb2uLNPa1C3lJ2UkN/Q0b6ha80f1Go=
Received: from SN1PR02MB3758.namprd02.prod.outlook.com (52.132.200.144) by
 SN1PR02MB3757.namprd02.prod.outlook.com (52.132.200.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 20:09:01 +0000
Received: from SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::65b3:44a4:cfbe:43d4]) by SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::65b3:44a4:cfbe:43d4%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 20:09:01 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Michal Simek <michals@xilinx.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: RE: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Thread-Topic: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Thread-Index: AQHUCL3wiHDzR04mOkK+ceCYxENFWqSGeWsAgA2HXQA=
Date:   Tue, 17 Jul 2018 20:09:01 +0000
Message-ID: <SN1PR02MB37589FF7DBAFBD0C070F690EB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-11-git-send-email-jollys@xilinx.com>
 <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
In-Reply-To: <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3757;7:SGG30w0Oj9vR/XeTq1KIUwo7uhV9HzVFLy9/dpFvtyi3B0TAJ/ZGvc6XlogQem/lcwAC1Xgr2uHyficbzZH3ocPgW/Z/Qzg4zwgvOgQcJlKFM5JecWe73kzpGGWZFjiJfXrF91sdCesrfCcCyv2S14fZvk0qBRryEX9LbEsGri0sUFAFNDyzUDCT9JoKDkG8+6cFQ9y8oGcVbcsfTk21nwUuAm1qmj3r5qWIAj4Ac4Z+UKiEzbxumTbNebh8M5/3
x-ms-office365-filtering-correlation-id: edb6b6b4-bd2b-434b-2d00-08d5ec212343
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3757;
x-ms-traffictypediagnostic: SN1PR02MB3757:
x-microsoft-antispam-prvs: <SN1PR02MB3757D3E7EB99F1C540743858B85C0@SN1PR02MB3757.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3757;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3757;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(136003)(376002)(346002)(396003)(13464003)(189003)(199004)(51914003)(6246003)(105586002)(99286004)(106356001)(33656002)(68736007)(5660300001)(76176011)(53936002)(2501003)(5250100002)(316002)(39060400002)(3846002)(7696005)(110136005)(7416002)(107886003)(54906003)(6116002)(74316002)(66066001)(478600001)(26005)(476003)(229853002)(2201001)(2906002)(186003)(6436002)(102836004)(11346002)(14454004)(14444005)(4326008)(256004)(486006)(72206003)(25786009)(97736004)(2900100001)(7736002)(305945005)(8676002)(81156014)(81166006)(55016002)(9686003)(8936002)(6506007)(53546011)(446003)(86362001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3757;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zRIc7y3989R/OH9pv85pRByH4AGb4vizL0w020Te4zGUf6vBe/6P2Pmde+3p/mvseSLZu0aDvXnuicQZysRtXhVT9PviUW4luLPsBGj9bcFUMhlsaxQGxXB+UEttiex80ivEwvbzgVizTem0gGHTmB6KqpHR3Mu04XfIb2k0grd5yZjW7RDiUJHC/naXCJ5/GH7vutsdJQp0+i/otAXGEpRk14+n0zM/scQvOvHeBclpb5jUYLcfTLqklytCg50xywe+mYi8rwKGbSIjoRl1FeTi4tm6MphmlDbzIJFe3ynxopvO9tFNi9Lz+2OgUT46vsNLVW2F9rvQqoAZ0XNARrcMAG8G2iGH4uRdEEFuU1Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb6b6b4-bd2b-434b-2d00-08d5ec212343
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 20:09:01.1067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LA0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCBbbWFpbHRvOnNib3lkQGtlcm5lbC5v
cmddDQo+IFNlbnQ6IFN1bmRheSwgSnVseSAwOCwgMjAxOCAxMDoyNyBQTQ0KPiBUbzogSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnOw0KPiBk
bWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4g
aGthbGx3ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsgbGludXgtY2xrQHZn
ZXIua2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IG1hdHRAY29kZWJsdWVwcmlu
dC5jby51azsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBtaW5nb0BrZXJu
ZWwub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBz
Ym95ZEBjb2RlYXVyb3JhLm9yZzsgc3VkZWVwLmhvbGxhQGFybS5jb20NCj4gQ2M6IFJhamFuIFZh
amEgPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgSm9sbHkgU2hhaA0KPiA8Sk9MTFlTQHhpbGlueC5jb20+OyBUZWphcyBQYXRlbCA8
VEVKQVNQQHhpbGlueC5jb20+OyBTaHViaHJhanlvdGkgRGF0dGENCj4gPHNodWJocmFqQHhpbGlu
eC5jb20+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSAxMC8xMF0gZHJpdmVyczogY2xrOiBBZGQgWnlucU1QIGNsb2NrIGRyaXZlcg0KPiAN
Cj4gPiArLyoqDQo+ID4gKyAqIHp5bnFtcF9wbV9jbG9ja19nZXRfcGFyZW50cygpIC0gR2V0IHRo
ZSBmaXJzdCAzIHBhcmVudHMgb2YgY2xvY2sgZm9yIGdpdmVuDQo+IGlkDQo+ID4gKyAqIEBjbG9j
a19pZDogIENsb2NrIElEDQo+ID4gKyAqIEBpbmRleDogICAgIFBhcmVudCBpbmRleA0KPiA+ICsg
KiBAcGFyZW50czogICAzIHBhcmVudHMgb2YgdGhlIGdpdmVuIGNsb2NrDQo+ID4gKyAqDQo+ID4g
KyAqIFRoaXMgZnVuY3Rpb24gaXMgdXNlZCB0byBnZXQgMyBwYXJlbnRzIGZvciB0aGUgY2xvY2sg
c3BlY2lmaWVkIGJ5DQo+ID4gKyAqIGdpdmVuIGNsb2NrIElELg0KPiA+ICsgKg0KPiA+ICsgKiBU
aGlzIEFQSSB3aWxsIHJldHVybiAzIHBhcmVudHMgd2l0aCBhIHNpbmdsZSByZXNwb25zZS4gVG8g
Z2V0DQo+ID4gKyAqIG90aGVyIHBhcmVudHMsIG1hc3RlciBzaG91bGQgY2FsbCBzYW1lIEFQSSBp
biBsb29wIHdpdGggbmV3DQo+ID4gKyAqIHBhcmVudCBpbmRleCB0aWxsIGVycm9yIGlzIHJldHVy
bmVkLiBFLmcgRmlyc3QgY2FsbCBzaG91bGQgaGF2ZQ0KPiA+ICsgKiBpbmRleCAwIHdoaWNoIHdp
bGwgcmV0dXJuIHBhcmVudHMgMCwxIGFuZCAyLiBOZXh0IGNhbGwsIGluZGV4DQo+ID4gKyAqIHNo
b3VsZCBiZSAzIHdoaWNoIHdpbGwgcmV0dXJuIHBhcmVudCAzLDQgYW5kIDUgYW5kIHNvIG9uLg0K
PiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IFJldHVybnMgc3RhdHVzLCBlaXRoZXIgc3VjY2VzcyBv
ciBlcnJvcityZWFzb24NCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgenlucW1wX3BtX2Nsb2Nr
X2dldF9wYXJlbnRzKHUzMiBjbG9ja19pZCwgdTMyIGluZGV4LCB1MzINCj4gKnBhcmVudHMpDQo+
ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCB6eW5xbXBfcG1fcXVlcnlfZGF0YSBxZGF0YSA9IHsw
fTsNCj4gPiArICAgICAgIHUzMiByZXRfcGF5bG9hZFtQQVlMT0FEX0FSR19DTlRdOw0KPiANCj4g
V2hhdCdzIHRoZSBlbmRpYW5uZXNzIG9mIHRoaXMgcGF5bG9hZD8gSXMgaXQgbGl0dGxlIGVuZGlh
bj8gT3IgZG8gdGhlDQo+IGVlbWlfb3BzIGNvbnZlcnQgdG8gQ1BVIG5hdGl2ZSBlbmRpYW5uZXNz
Pw0KDQpJdHMgbGl0dGxlIGVuZGlhbg0KDQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogenlucW1w
X2Nsb2NrX2luaXQoKSAtIEluaXRpYWxpemUgenlucW1wIGNsb2Nrcw0KPiA+ICsgKg0KPiA+ICsg
KiBSZXR1cm46IDAgb24gc3VjY2VzcyBlbHNlIGVycm9yIGNvZGUNCj4gPiArICovDQo+ID4gK3N0
YXRpYyBpbnQgX19pbml0IHp5bnFtcF9jbG9ja19pbml0KHZvaWQpDQo+ID4gK3sNCj4gPiArICAg
ICAgIGludCByZXQ7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ICsN
Cj4gPiArICAgICAgIG5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgInhs
bngsenlucW1wIik7DQo+ID4gKyAgICAgICBpZiAoIW5wKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT0VOVDsNCj4gPiArICAgICAgIG9mX25vZGVfcHV0KG5wKTsNCj4gPiArDQo+ID4g
KyAgICAgICBucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJ4bG54LHp5
bnFtcC1jbGsiKTsNCj4gDQo+IFdoeSBjYW4ndCB0aGlzIGJlIGEgcGxhdGZvcm0gZGV2aWNlIGRy
aXZlcj8NCg0KUGxhdGZvcm0gZHJpdmVyIG1heSBwcm9iZSBsYXRlcihhbiBhY3R1YWxseSBwcm9i
aW5nIGxhdGVyIGluIG91ciBjYXNlKS4gVGhpcyB3aWxsIHJlc3VsdHMgaW4gY2xvY2sgZ2V0IGZh
aWx1cmUgaW4gY2xvY2sgY29uc3VtZXIgcGVyaXBoZXJhbHMuIFNvIGNsb2NrIHJlZ2lzdHJhdGlv
biBuZWVkcyB0byBiZSBkb25lIGVhcmxpZXIuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIG0g
PSByYXRlX2RpdiAvIEZSQUNfRElWOw0KPiA+ICsgICAgICAgICAgICAgICBmID0gcmF0ZV9kaXYg
JSBGUkFDX0RJVjsNCj4gPiArICAgICAgICAgICAgICAgbSA9IGNsYW1wX3QodTMyLCBtLCAoUExM
X0ZCRElWX01JTiksIChQTExfRkJESVZfTUFYKSk7DQo+ID4gKyAgICAgICAgICAgICAgIHJhdGUg
PSBwYXJlbnRfcmF0ZSAqIG07DQo+ID4gKyAgICAgICAgICAgICAgIGZyYWMgPSAocGFyZW50X3Jh
dGUgKiBmKSAvIEZSQUNfRElWOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gZWVt
aV9vcHMtPmNsb2NrX3NldGRpdmlkZXIoY2xrX2lkLCBtKTsNCj4gPiArICAgICAgICAgICAgICAg
aWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuX29uY2UoIiVzKCkg
c2V0IGRpdmlkZXIgZmFpbGVkIGZvciAlcywgcmV0ID0gJWRcbiIsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBjbGtfbmFtZSwgcmV0KTsNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgIGRhdGEgPSAoRlJBQ19ESVYgKiBmKSAvIEZSQUNfRElWOw0K
PiANCj4gRmVlbHMgbGlrZSB0aGVyZSBtdXN0IGJlIHNvbWUgbWFjcm8gZm9yIHRoaXMgaWRpb20g
YnV0IEkgZmFpbGVkIHRvIGZpbmQNCj4gaXQuIHJvdW5kX3NvbWV0aGluZygpPw0KSXQgd2FzIG5v
dCBuZWVkZWQuIFJlbW92ZWQgaW4gdjEwLg0KDQo+IA0KPiA+ICsgICAgICAgcGxsLT5ody5pbml0
ID0gJmluaXQ7DQo+ID4gKyAgICAgICBwbGwtPmNsa19pZCA9IGNsa19pZDsNCj4gPiArDQo+ID4g
KyAgICAgICBodyA9ICZwbGwtPmh3Ow0KPiA+ICsgICAgICAgcmV0ID0gY2xrX2h3X3JlZ2lzdGVy
KGRldiwgaHcpOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICBr
ZnJlZShwbGwpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KPiA+
ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGNsa19od19zZXRfcmF0ZV9yYW5nZShodywg
UFNfUExMX1ZDT19NSU4sIFBTX1BMTF9WQ09fTUFYKTsNCj4gDQo+IFdoeSBpcyB0aGlzIG5lY2Vz
c2FyeT8NClRoaXMgaXMgcmFuZ2Ugb2YgcmF0ZSBzdXBwb3J0ZWQgYnkgaGFyZHdhcmUgZm9yIFBM
TC4NCg0KPiANCj4gPiArICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgICBw
cl9lcnIoIiVzOkVSUk9SIGNsa19zZXRfcmF0ZV9yYW5nZSBmYWlsZWQgJWRcbiIsIG5hbWUsIHJl
dCk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIGh3Ow0KPiA+ICt9DQoNCg0KUmVzdCBhbGwg
Y29tbWVudHMgdGFrZW4gY2FyZSBpbiB2MTAgc2VyaWVzKHBvc3RlZCB0b2RheSkuIA0KDQpUaGFu
a3MsDQpKb2xseSBTaGFoDQoNCg==
