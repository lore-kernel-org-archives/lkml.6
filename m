Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eLotNdh/Glt1LQAAmS7hNA
	; Fri, 08 Jun 2018 13:08:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 71BDD608EA; Fri,  8 Jun 2018 13:08:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="orkZj2+u"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A8DE3606FA;
	Fri,  8 Jun 2018 13:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8DE3606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeFHNIe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:08:34 -0400
Received: from mail-dm3nam03on0085.outbound.protection.outlook.com ([104.47.41.85]:39010
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751898AbeFHNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMz93C500IfFfRR1vX6/h5pWjWKXBeg5x782LqRfbQc=;
 b=orkZj2+u/Oi1Mn8nFj7VJC3I/NXGVQMraP9XuejI6INfCjmIGiSsp0hgpojpDK5QK95C6yduYsRl5rwMJDPKOegtgLC79vm8E3LMw9Cz+WG67fgbEzpyLroBrS2cCcsx+oz1Z5cvIL2M0q1R1X5uMacOOPQydMjjm0EELuxCSAM=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2462.namprd02.prod.outlook.com (10.168.204.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Fri, 8 Jun 2018 13:08:25 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::e826:8d65:9e76:6426]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::e826:8d65:9e76:6426%9]) with mapi id 15.20.0841.015; Fri, 8 Jun 2018
 13:08:25 +0000
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "wmw2@infradead.org" <wmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v9 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Topic: [LINUX PATCH v9 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Index: AQHT/WsxpMeMuIfugkKfN+bDxEsXmqRVOVeAgACc2LCAAHlwgIAABzcA
Date: Fri, 8 Jun 2018 13:08:24 +0000
Message-ID: <MWHPR02MB2623EF92D6498ED7D3C45DFBAF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180607215949.58e2d15d@xps13>
        <MWHPR02MB26238A3344D0F611D8D6B0DAAF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180608143549.04400f92@xps13>
In-Reply-To: <20180608143549.04400f92@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2462;7:zNvfEGKtsKG+owTOugJKWjCftlJBtPX/LZvrFp+9bBoFwtklhChE99Hb5+3iITDMxG3mn66fysRU9MkZ9BFZ8Z7Ijd99IdAIITPAqAfwKhyxCeQDHWoEfzmUgZblUepvpsRoHgxk5JTAbHu7EUoUWfd3KnHytaU9UcyZuWeL4RSwYv1qsA/Wr2SmvM5zZvjowP0s4IUclKBzJCpf+jpHyXHTU/kDasWaeIVj+IxNR94V2HDwlInkBOLWxtSlbyka
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2462;
x-ms-traffictypediagnostic: MWHPR02MB2462:
x-microsoft-antispam-prvs: <MWHPR02MB2462475AB3C16B48F1786582AF7B0@MWHPR02MB2462.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2462;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2462;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(346002)(376002)(396003)(13464003)(199004)(189003)(86362001)(33656002)(81166006)(6436002)(8676002)(81156014)(5250100002)(2906002)(486006)(8936002)(7416002)(478600001)(97736004)(6116002)(3846002)(2900100001)(14454004)(54906003)(55016002)(6306002)(966005)(106356001)(105586002)(99286004)(93886005)(229853002)(53936002)(316002)(3280700002)(66066001)(74316002)(7736002)(186003)(7696005)(25786009)(68736007)(76176011)(3660700001)(6916009)(102836004)(59450400001)(39060400002)(26005)(9686003)(476003)(11346002)(446003)(4326008)(53546011)(6506007)(55236004)(5660300001)(305945005)(6246003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2462;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U3/SUhh7bN+gGWUP1DWVIyX4hnh3hTegiHR0onOpGdUiEBrimjfGVuOnHpbjEhomkvP+DPb78RYOm0JU9tqc0v8WRj6B6YQlgbYqfA0sdc5DTCbwJ8/EHab624r1V3uh0TqwWnJs2ZKeg+zQDxoOIZNcXIC0ZGdml7OCrOSHudbutUCB7mJ1nATpcg2SotDC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ccd72a9d-29d5-4561-59f6-08d5cd40eb32
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd72a9d-29d5-4561-59f6-08d5cd40eb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:08:24.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBGcmlk
YXksIEp1bmUgOCwgMjAxOCA2OjA2IFBNDQo+IFRvOiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxu
YWdhc3VyZUB4aWxpbnguY29tPg0KPiBDYzogYm9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tOyBy
aWNoYXJkQG5vZC5hdDsgd213MkBpbmZyYWRlYWQub3JnOw0KPiBjb21wdXRlcnNmb3JwZWFjZUBn
bWFpbC5jb207IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgZi5mYWluZWxsaUBnbWFpbC5jb207DQo+
IG1tYXllckBicm9hZGNvbS5jb207IHJvZ2VycUB0aS5jb207IGxhZGlzQGxpbnV4LW1pcHMub3Jn
OyBhZGFAdGhvcnNpcy5jb207DQo+IGhvbmdodWkuemhhbmdAbWVkaWF0ZWsuY29tOyBsaW51eC1t
dGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
bmFnYXN1cmVzaGt1bWFycmVsbGlAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbTElOVVggUEFU
Q0ggdjkgNC80XSBtdGQ6IHJhd25hbmQ6IHBsMzUzOiBBZGQgYmFzaWMgZHJpdmVyIGZvciBhcm0g
cGwzNTMNCj4gc21jIG5hbmQgaW50ZXJmYWNlDQo+IA0KPiBIaSBOYWdhLA0KPiANCj4gPiA+ID4g
KwkJZWNjLT5yZWFkX3BhZ2UgPSBwbDM1M19uYW5kX3JlYWRfcGFnZV9od2VjYzsNCj4gPiA+ID4g
KwkJZWNjLT5zaXplID0gUEwzNTNfTkFORF9FQ0NfU0laRTsNCj4gPiA+ID4gKwkJZWNjLT53cml0
ZV9wYWdlID0gcGwzNTNfbmFuZF93cml0ZV9wYWdlX2h3ZWNjOw0KPiA+ID4gPiArCQlwbDM1M19z
bWNfc2V0X2VjY19wZ19zaXplKG10ZC0+d3JpdGVzaXplKTsNCj4gPiA+ID4gKwkJc3dpdGNoICht
dGQtPndyaXRlc2l6ZSkgew0KPiA+ID4gPiArCQljYXNlIFNaXzUxMjoNCj4gPiA+ID4gKwkJY2Fz
ZSBTWl8xSzoNCj4gPiA+ID4gKwkJY2FzZSBTWl8ySzoNCj4gPiA+ID4gKwkJCXBsMzUzX3NtY19z
ZXRfZWNjX21vZGUoUEwzNTNfU01DX0VDQ01PREVfQVBCKTsNCj4gPiA+ID4gKwkJCWJyZWFrOw0K
PiA+ID4gPiArCQlkZWZhdWx0Og0KPiA+ID4gPiArCQkJLyoNCj4gPiA+ID4gKwkJCSAqIFRoZSBz
b2Z0d2FyZSBFQ0Mgcm91dGluZXMgd29uJ3Qgd29yayB3aXRoIHRoZQ0KPiA+ID4gPiArCQkJICog
U01DIGNvbnRyb2xsZXINCj4gPiA+ID4gKwkJCSAqLw0KPiA+ID4gPiArCQkJZWNjLT5jYWxjdWxh
dGUgPSBuYW5kX2NhbGN1bGF0ZV9lY2M7DQo+ID4gPiA+ICsJCQllY2MtPmNvcnJlY3QgPSBuYW5k
X2NvcnJlY3RfZGF0YTsNCj4gPiA+ID4gKwkJCWVjYy0+c2l6ZSA9IDI1NjsNCj4gPiA+ID4gKwkJ
CWJyZWFrOw0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJCWlmIChtdGQtPndyaXRlc2l6ZSA8PSBT
Wl81MTIpDQo+ID4gPiA+ICsJCQl4bmFuZC0+YWRkcl9jeWNsZXMgPSAxOw0KPiA+ID4gPiArCQll
bHNlDQo+ID4gPiA+ICsJCQl4bmFuZC0+YWRkcl9jeWNsZXMgPSAyOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsJCWlmIChjaGlwLT5vcHRpb25zICYgTkFORF9ST1dfQUREUl8zKQ0KPiA+ID4gPiArCQkJ
eG5hbmQtPmFkZHJfY3ljbGVzICs9IDM7DQo+ID4gPiA+ICsJCWVsc2UNCj4gPiA+ID4gKwkJCXhu
YW5kLT5hZGRyX2N5Y2xlcyArPSAyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCWlmIChtdGQtPm9v
YnNpemUgPT0gMTYpDQo+ID4gPiA+ICsJCQltdGRfc2V0X29vYmxheW91dChtdGQsICZwbDM1M19l
Y2Nfb29ibGF5b3V0MTZfb3BzKTsNCj4gPiA+ID4gKwkJZWxzZSBpZiAobXRkLT5vb2JzaXplID09
IDY0KQ0KPiA+ID4gPiArCQkJbXRkX3NldF9vb2JsYXlvdXQobXRkLCAmcGwzNTNfZWNjX29vYmxh
eW91dDY0X29wcyk7DQo+ID4gPg0KPiA+ID4gZWxzZT8NCj4gPiBZb3UgbWVhbiB0byBzYXksIGFk
ZCBhbiBlcnJvciBjb25kaXRpb24/DQo+IA0KPiBJIGRvLg0KT2ssIEkgd2lsbCBhZGQgaXQgaW4g
bmV4dCB2ZXJzaW9uLg0KPiANCj4gPiA+DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArfQ0KPiA+ID4g
PiArDQo+ID4gPiA+ICsvKioNCj4gPiA+ID4gKyAqIHBsMzUzX25hbmRfcHJvYmUgLSBQcm9iZSBt
ZXRob2QgZm9yIHRoZSBOQU5EIGRyaXZlcg0KPiA+ID4gPiArICogQHBkZXY6CVBvaW50ZXIgdG8g
dGhlIHBsYXRmb3JtX2RldmljZSBzdHJ1Y3R1cmUNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBU
aGlzIGZ1bmN0aW9uIGluaXRpYWxpemVzIHRoZSBkcml2ZXIgZGF0YSBzdHJ1Y3R1cmVzIGFuZCB0
aGUgaGFyZHdhcmUuDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICogUmV0dXJuOgkwIG9uIHN1Y2Nl
c3Mgb3IgZXJyb3IgdmFsdWUgb24gZmFpbHVyZQ0KPiA+ID4gPiArICovDQo+ID4gPiA+ICtzdGF0
aWMgaW50IHBsMzUzX25hbmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0K
PiA+ID4gPiArCXN0cnVjdCBwbDM1M19uYW5kX2luZm8gKnhuYW5kOw0KPiA+ID4NCj4gPiA+IHhu
YW5kIGlzIGEgc3RyYW5nZSBuYW1lLCBtb3JlIGFuZCBtb3JlIGJlY2F1c2UgaXRzIGEgYm91dCBO
QU5EDQo+ID4gPiBjb250cm9sbGVyIGRhdGEsIG5vdCBOQU5EIGNoaXAuDQo+ID4gV2UgYWRkZWQg
dGhpcyBuYW1lIHRvIHJlcHJlc2VudCBYaWxpbnggTmFuZCh4bmFuZCksDQo+ID4gPg0KPiANCj4g
SSBzZWUgd2hlcmUgdGhlIHggY29tZXMgZnJvbS4NCj4gDQo+IE1heWJlIGp1c3QgbmZjIChmb3Ig
TkFORCBmbGFzaCBjb250cm9sbGVyKSBvciB4bmZjIGlmIHlvdSBwcmVmZXIuIFdoYXQNCj4gSSB3
YW50IGlzIHRvIGNsZWFybHkgbWFrZSB0aGUgZGlzdGluY3Rpb24gYmV0d2VlbiB3aGF0IGlzIGEg
TkFORCBjaGlwLA0KPiB3aGF0IGlzIGEgTkFORCBjb250cm9sbGVyLg0KT2ssIGdvdCBpdC4gSSB3
aWxsIHVwZGF0ZSBsaWtlIHhuZmMuDQo+IA0KPiA+ID4gPiArCXN0cnVjdCBtdGRfaW5mbyAqbXRk
Ow0KPiA+ID4gPiArCXN0cnVjdCBuYW5kX2NoaXAgKm5hbmRfY2hpcDsNCj4gPiA+DQo+ID4gPiBU
aGlzIG9uZSB5b3UgY2FuIGNhbGwgaXQganVzdCAibmFuZCIgb3IgImNoaXAiLg0KPiA+IE9rLCBJ
IHdpbGwgdXBkYXRlLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArCXN0cnVjdCByZXNvdXJjZSAqcmVz
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJeG5hbmQgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwg
c2l6ZW9mKCp4bmFuZCksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiArCWlmICgheG5hbmQpDQo+ID4g
PiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogTWFwIHBoeXNp
Y2FsIGFkZHJlc3Mgb2YgTkFORCBmbGFzaCAqLw0KPiA+ID4gPiArCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gPiA+ICsJeG5hbmQtPm5h
bmRfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KPiA+ID4g
PiArCWlmIChJU19FUlIoeG5hbmQtPm5hbmRfYmFzZSkpDQo+ID4gPiA+ICsJCXJldHVybiBQVFJf
RVJSKHhuYW5kLT5uYW5kX2Jhc2UpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJbmFuZF9jaGlwID0g
JnhuYW5kLT5jaGlwOw0KPiA+ID4gPiArCW10ZCA9IG5hbmRfdG9fbXRkKG5hbmRfY2hpcCk7DQo+
ID4gPiA+ICsJbmFuZF9jaGlwLT5leGVjX29wID0gcGwzNTNfbmZjX2V4ZWNfb3A7DQo+ID4gPiA+
ICsJbmFuZF9zZXRfY29udHJvbGxlcl9kYXRhKG5hbmRfY2hpcCwgeG5hbmQpOw0KPiA+ID4gPiAr
CW10ZC0+cHJpdiA9IG5hbmRfY2hpcDsNCj4gPiA+ID4gKwltdGQtPm93bmVyID0gVEhJU19NT0RV
TEU7DQo+ID4gPiA+ICsJbXRkLT5uYW1lID0gUEwzNTNfTkFORF9EUklWRVJfTkFNRTsNCj4gPiA+
DQo+ID4gPiBBIGxhYmVsIHByb3BlcnR5IGluIHRoZSBEVCBtaWdodCBvdmVyd3JpdGUgdGhpcyB2
YWx1ZS4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gYSBiaXQgbW9yZSA/DQo+ID4NCj4g
DQo+IEkgbWVhbnQgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWFydmVs
bF9uYW5kLmMjTDI1MQ0KPiA1DQpVbmRlcnN0b29kLiBUaGFua3MuDQpJIHdpbGwgdXBkYXRlIGlu
IG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaS4NCj4gDQo+
IFRoYW5rcywNCj4gTWlxdcOobA0K
