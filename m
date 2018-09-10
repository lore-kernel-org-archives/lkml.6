Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E02C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694C120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MRoDk6W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694C120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeIJJjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:39:22 -0400
Received: from mail-eopbgr680061.outbound.protection.outlook.com ([40.107.68.61]:45312
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbeIJJjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpiUOU+aTs1kfesmSVhHytRmCS2P36BVmDX3IIAVc5o=;
 b=MRoDk6W/GIujpBP8gsuRD9A7jVcP+Xz6ZYUyc5MweE439OVFg4vCdhQDTkL0KJp4Igzhb1lccwBvQzMzLF4MDNCbSSiIVOrLC1ZrygI4C9TU63uovzU/rW80jfvSjOUtW13L+a3wpmVoyHWTadwkWVOSNn+oUHRpsz+khKyx9O4=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4470.namprd02.prod.outlook.com (52.135.239.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 04:47:06 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e%4]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 04:47:06 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 1/3] firmware: xilinx: Add reset API's
Thread-Topic: [RFC PATCH v3 1/3] firmware: xilinx: Add reset API's
Thread-Index: AQHUROdiN5Qgd0WGEEKu0JjyxLmBtKThfPCAgAd67SA=
Date:   Mon, 10 Sep 2018 04:47:05 +0000
Message-ID: <BYAPR02MB4710E2CACAA82D43B7FA0A81C2050@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
         <1536131342-28041-2-git-send-email-nava.manne@xilinx.com>
 <1536143389.4084.4.camel@pengutronix.de>
In-Reply-To: <1536143389.4084.4.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4470;6:RsF2rmRbv9VKBIey0yePRKBcqZPzxO67K5cFpsokV3tPWI1PLUjb4cXwbToBkILZkzPvI9y8QYd849NDkTTO2Vwk2hngZnBMMuo6ZhpGsRBYR0dJ2nYEpXuCau+dfZ5cXmDj6zo0+KimIP1Jb58hWyM5YDBK7qZ75RGw7dVYR96Zt/LN4ALr2vmoa/OUV/TxT8kMhaWMWbJAJNiYDTXjFzzX6aGJKnu7X2FyeBCYT47xCnEXYfcf2HYHSxjPqam29TKLGx5/mPk222haL9KAmRjcrbUUwpCBwk0mlrbWgYLMUJRkhS0EOn4v5Qio0pIitivEh9S7DXZItYhSs72LiY4j9ZRDPewQ83SJBennDtxHtV63KTNppkt9Zn7rlhi4IWJJcr8dZzXtcIHIPVL+HrBCDbgYJ7xj8ygQmAghFcxf5gS3MlwRSI11M/stOPcWhLeztn4cIbUBIUtecTZK4w==;5:KLdRc76Q/lwwd+0ON29gtMYNAwNzGB6SIFLEks1ZtzJa19Da1lDhstp67LtG5l75iYxxORzAoxgeFWWSf+Uwq9mZiAmwVWi5Z51XjmnQvYRM9d8xunhfDUnUzy/CjKpGYzfAxdI7YGnpB5PmGatoPqNWLDu9L4bH5W26VkncgI4=;7:q7uuf5haXDd+9R1kvtNAHA5dr2+YtCCMMwjGCn3WuwZyHjbriTrE4XbXIkf2A25MA8rflrAhbPDpDIMdMop6OGhDEs6nygd4ufgt4IsWYIdeQ1R3x6L5pYqAvjWSHz9LVf/M+APC+TuhprCG8HQzfzJoNfHvJkfIiaErAm0Qt8Eaap05NifTym7oGuebsHE+AjnzchiblKfeLciO/PB9i9riykvTX/KdBwg9awu5aPSANsSjzEBIjoiTBhsDIeGJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 68d10fe0-b68a-48ac-a1c9-08d616d87595
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4470;
x-ms-traffictypediagnostic: BYAPR02MB4470:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB44709FDB1D120A479F6661A2C2050@BYAPR02MB4470.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR02MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4470;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(51914003)(13464003)(189003)(199004)(316002)(6506007)(102836004)(2900100001)(25786009)(110136005)(6246003)(97736004)(68736007)(11346002)(476003)(186003)(26005)(53546011)(486006)(8936002)(76176011)(7696005)(446003)(14454004)(81166006)(81156014)(229853002)(305945005)(5660300001)(55016002)(6436002)(99286004)(53936002)(9686003)(7736002)(66066001)(478600001)(74316002)(2201001)(86362001)(5250100002)(33656002)(8676002)(2501003)(2906002)(106356001)(105586002)(3846002)(6116002)(14444005)(256004)(217873002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4470;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OhJuOYzxX7d2jieUky6RUeAvxmyCVOimWSWgcgmam7q+s9vVyCqaeEX17Q5qIdPBYaGD9SRbjlma8RwG18XJ1ZfD3pvu7MlEkVG0KCR01g6FVMpRG9tml9ppU3dfyZ8hIS/avxXwuquUuXCKM0rvgpH9MrpnxfIMqVP8HWCnJYtRk/leZ32qVoKfLZiS58psFSXAlmVb/xN81f4goyzuEnVdbVwXhCCOTiBdHWlIfuKEUG8ew9UO0T6c7Iw5pdAKJTsVd/lq9MIlVdTwKLLurWsmV+ZerW0p/ygUpZPFQnttEwrQoP/Zvlylifl2sTHRmOEKmb+fRGa4rt7Byp4VSVGy5aQKlRvbt7rGmi2fq9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d10fe0-b68a-48ac-a1c9-08d616d87595
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 04:47:05.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4uLg0KUGxlYXNlIGZp
bmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFBoaWxpcHAgWmFiZWwgW21haWx0bzpwLnphYmVsQHBlbmd1dHJvbml4LmRlXQ0KPiBT
ZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciA1LCAyMDE4IDQ6MDAgUE0NCj4gVG86IE5hdmEga2lz
aG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFy
ay5ydXRsYW5kQGFybS5jb207IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgUmFq
YW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54
LmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDEvM10gZmlybXdhcmU6IHhpbGlueDogQWRkIHJlc2V0
IEFQSSdzDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgMjAxOC0wOS0wNSBhdCAxMjozOSArMDUz
MCwgTmF2YSBraXNob3JlIE1hbm5lIHdyb3RlOg0KPiA+IFRoaXMgUGF0Y2ggQWRkcyByZXNldCBB
UEkncyB0byBzdXBwb3J0IHJlbGVhc2UsIGFzc2VydCBhbmQgc3RhdHVzDQo+ID4gZnVuY3Rpb25h
bGl0aWVzIGJ5IHVzaW5nIGZpcm13YXJlIGludGVyZmFjZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+IC0tLQ0K
PiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+IAkJLU5vbmUuDQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+
ID4gCQktTmV3IFBhdGNoLg0KPiA+DQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFt
cC5jICAgICB8ICA0MCArKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hs
bngtenlucW1wLmggfCAxMzYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE3NiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCj4gPiBiL2RyaXZlcnMv
ZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gaW5kZXggN2NjZWRmMC4uNjM5YzcyZiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gQEAgLTQ0Nyw2ICs0NDcsNDQg
QEAgc3RhdGljIGludCB6eW5xbXBfcG1fY2xvY2tfZ2V0cGFyZW50KHUzMg0KPiBjbG9ja19pZCwg
dTMyICpwYXJlbnRfaWQpDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArLyoq
DQo+ID4gKyAqIHp5bnFtcF9wbV9yZXNldF9hc3NlcnQgLSBSZXF1ZXN0IHNldHRpbmcgb2YgcmVz
ZXQgKDEgLSBhc3NlcnQsIDAgLSByZWxlYXNlKQ0KPiA+ICsgKiBAcmVzZXQ6CQlSZXNldCB0byBi
ZSBjb25maWd1cmVkDQo+ID4gKyAqIEBhc3NlcnRfZmxhZzoJRmxhZyBzdGF0aW5nIHNob3VsZCBy
ZXNldCBiZSBhc3NlcnRlZCAoMSkgb3INCj4gPiArICoJCQlyZWxlYXNlZCAoMCkNCj4gPiArICoN
Cj4gPiArICogUmV0dXJuOiBSZXR1cm5zIHN0YXR1cywgZWl0aGVyIHN1Y2Nlc3Mgb3IgZXJyb3Ir
cmVhc29uICAqLyBzdGF0aWMNCj4gPiAraW50IHp5bnFtcF9wbV9yZXNldF9hc3NlcnQoY29uc3Qg
ZW51bSB6eW5xbXBfcG1fcmVzZXQgcmVzZXQsDQo+ID4gKwkJCQkgIGNvbnN0IGVudW0genlucW1w
X3BtX3Jlc2V0X2FjdGlvbg0KPiBhc3NlcnRfZmxhZykgew0KPiA+ICsJcmV0dXJuIHp5bnFtcF9w
bV9pbnZva2VfZm4oUE1fUkVTRVRfQVNTRVJULCByZXNldCwgYXNzZXJ0X2ZsYWcsDQo+ID4gKwkJ
CQkgICAwLCAwLCBOVUxMKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIHp5bnFt
cF9wbV9yZXNldF9nZXRfc3RhdHVzIC0gR2V0IHN0YXR1cyBvZiB0aGUgcmVzZXQNCj4gPiArICog
QHJlc2V0OiAgICAgIFJlc2V0IHdob3NlIHN0YXR1cyBzaG91bGQgYmUgcmV0dXJuZWQNCj4gPiAr
ICogQHN0YXR1czogICAgIFJldHVybmVkIHN0YXR1cw0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46
IFJldHVybnMgc3RhdHVzLCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvcityZWFzb24gICovIHN0YXRp
Yw0KPiA+ICtpbnQgenlucW1wX3BtX3Jlc2V0X2dldF9zdGF0dXMoY29uc3QgZW51bSB6eW5xbXBf
cG1fcmVzZXQgcmVzZXQsDQo+ID4gKwkJCQkgICAgICB1MzIgKnN0YXR1cykNCj4gPiArew0KPiA+
ICsJdTMyIHJldF9wYXlsb2FkW1BBWUxPQURfQVJHX0NOVF07DQo+ID4gKwlpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArCWlmICghc3RhdHVzKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4g
PiArCXJldCA9IHp5bnFtcF9wbV9pbnZva2VfZm4oUE1fUkVTRVRfR0VUX1NUQVRVUywgcmVzZXQs
IDAsDQo+ID4gKwkJCQkgIDAsIDAsIHJldF9wYXlsb2FkKTsNCj4gPiArCSpzdGF0dXMgPSByZXRf
cGF5bG9hZFsxXTsNCj4gDQo+IEl0IGRvZXNuJ3QgcmVhbGx5IG1hdHRlciBoZXJlLCBidXQgaW4g
Z2VuZXJhbCBJJ2Qgc2tpcCB3cml0aW5nIG91dHB1dCBhcmd1bWVudHMgaW4NCj4gY2FzZSBvZiBl
cnJvci4NCj4gRm9yIGFsbCBJIGtub3csIHRoZSByZXN1bHQgcmV0dXJuZWQgaW4gcmV0X3BheWxv
YWQgY291bGQgYmUgdW5kZWZpbmVkLg0KPiANCg0KV2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
