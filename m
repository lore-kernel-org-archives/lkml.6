Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A3CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B320867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="IiGkNG5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49B320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeICRlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:41:19 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:16546 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbeICRlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:41:19 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 03 Sep 2018 22:21:06 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 89F3A7C846;
        Mon,  3 Sep 2018 22:21:06 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,325,1531753200"; 
   d="scan'208";a="289862317"
Received: from mail-os2jpn01lp0147.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.147])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2018 22:21:06 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf9i3YNP4weTur9et0ZcxTvWuk22ZtVtxhqgHXww91E=;
 b=IiGkNG5GW9aIysr+DOJz5Ua3vW2AzGNwKRlpoPTRdsxAf4MBPY03GEYiDdzW5Wyv4XvbDYyOd4UIwpgV2bAQRGOP2CEecAdfx6mYqYg7FR69TjH2as3FIEwmSJn730/xciB7FrTAvrk2q0PG0BxA2FcjDeCRv7TgwRWQWNnPgys=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0079.jpnprd01.prod.outlook.com (10.161.133.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Mon, 3 Sep 2018 13:21:03 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb%4]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 13:21:03 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Topic: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Index: AQHUQTP8XUjGAOby9EG+9JY2nBABh6TauV+AgAOFTQCAAEwC8A==
Date:   Mon, 3 Sep 2018 13:21:02 +0000
Message-ID: <TY1PR01MB1769B2978D73DBC2EADC6B8DF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
 <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
 <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769CBB6FC715E94B10815BFF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769CBB6FC715E94B10815BFF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0079;20:FieRShyBN0FTfkqiqR45T942EBimAG8OvdKAmX3zDfJg1GzhD/NtYwpLFEhb/TGHlwkQH59/MRd9RQ2Ne8XodK34cXQIR6pq/cAEhOWWYFlqherRaQUt2c5UHXZprO1UR5aOQjqyRg2k7whUrBxkuMqoayeMVMxjwf4PYPoGGJk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a042728-cae4-4ed9-b306-08d611a018f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0079;
x-ms-traffictypediagnostic: TY1PR01MB0079:
x-microsoft-antispam-prvs: <TY1PR01MB007900268C6EC236BFB1A9CFF50C0@TY1PR01MB0079.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:TY1PR01MB0079;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0079;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(2906002)(102836004)(14444005)(256004)(6246003)(6506007)(305945005)(6436002)(53936002)(3846002)(74316002)(6116002)(7736002)(53546011)(11346002)(110136005)(446003)(186003)(2900100001)(7696005)(486006)(66066001)(26005)(44832011)(76176011)(476003)(316002)(54906003)(86362001)(93156006)(99286004)(5660300001)(97736004)(8936002)(5250100002)(25786009)(4326008)(68736007)(229853002)(14454004)(81166006)(81156014)(55016002)(9686003)(8676002)(33656002)(2940100002)(478600001)(106356001)(105586002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0079;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: djOj6GK66td2cReetVg/Bab0PBgXWltDHB5VwmPL+BDc99+M/G69EIPawrHydRYdJMeKhHdK/+m6Ag1SOD1McQmwvuJFs01ZddregnsgYf90LokmgGbnaWfqa/hM6hC2hoarg7tdoA/pL6kNAwNzoBx/ROMqz4PRgxcckg/e8/qz1PtAE+SFu2lzuRvbPYkt7iJMXKdJ7Ic1zOC0WQMN84CyFXluf6CKlpxMp/IdzJKeIModfTz/z+9cGuGmvoYNv+M7gt3n7ha3G30a/0socCTvZ9DVboYtqhtD9h66NM3aYI9F0G3R2pBhhWDcsQtpAQsynW8JdEkwCN31m9wDcR3+Ngb82kBQZW7RcyRo0EA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a042728-cae4-4ed9-b306-08d611a018f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 13:21:02.9209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KT24gMDMgU2VwdGVtYmVyIDIwMTggMTA6MzMgUGhpbCBFZHdvcnRoeSB3
cm90ZToNCj4gT24gMDEgU2VwdGVtYmVyIDIwMTggMDM6NDYsIFN0ZXBoZW4gQm95ZCB3cm90ZToN
Cj4gPiBRdW90aW5nIFBoaWwgRWR3b3J0aHkgKDIwMTgtMDgtMzEgMDc6MDc6MjIpDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrZGV2LmMgYi9kcml2ZXJzL2Nsay9jbGtkZXYuYyBp
bmRleA0KPiA+ID4gOWFiM2RiOC4uNGFkYjk5ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
Y2xrL2Nsa2Rldi5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGtkZXYuYw0KPiA+ID4gQEAg
LTU0LDMwICs1NCwyOSBAQCBFWFBPUlRfU1lNQk9MKG9mX2Nsa19nZXQpOw0KPiA+ID4NCj4gPiA+
ICBzdGF0aWMgc3RydWN0IGNsayAqX19vZl9jbGtfZ2V0X2J5X25hbWUoc3RydWN0IGRldmljZV9u
b2RlICpucCwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBjaGFyICpkZXZfaWQsDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3QgY2hhciAqbmFtZSkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgb3B0aW9uYWwpDQo+ID4gPiAgew0KPiA+ID4g
ICAgICAgICBzdHJ1Y3QgY2xrICpjbGsgPSBFUlJfUFRSKC1FTk9FTlQpOw0KPiA+ID4gKyAgICAg
ICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxkID0gbnA7DQo+ID4gPiArICAgICAgIGludCBpbmRl
eCA9IDA7DQo+ID4gPg0KPiA+ID4gICAgICAgICAvKiBXYWxrIHVwIHRoZSB0cmVlIG9mIGRldmlj
ZXMgbG9va2luZyBmb3IgYSBjbG9jayB0aGF0IG1hdGNoZXMgKi8NCj4gPiA+ICAgICAgICAgd2hp
bGUgKG5wKSB7DQo+ID4gPiAtICAgICAgICAgICAgICAgaW50IGluZGV4ID0gMDsNCj4gPiA+DQo+
ID4gPiAgICAgICAgICAgICAgICAgLyoNCj4gPiA+ICAgICAgICAgICAgICAgICAgKiBGb3IgbmFt
ZWQgY2xvY2tzLCBmaXJzdCBsb29rIHVwIHRoZSBuYW1lIGluIHRoZQ0KPiA+ID4gICAgICAgICAg
ICAgICAgICAqICJjbG9jay1uYW1lcyIgcHJvcGVydHkuICBJZiBpdCBjYW5ub3QgYmUgZm91bmQs
IHRoZW4NCj4gPiA+IC0gICAgICAgICAgICAgICAgKiBpbmRleCB3aWxsIGJlIGFuIGVycm9yIGNv
ZGUsIGFuZCBvZl9jbGtfZ2V0KCkgd2lsbCBmYWlsLg0KPiA+ID4gKyAgICAgICAgICAgICAgICAq
IGluZGV4IHdpbGwgYmUgYW4gZXJyb3IgY29kZS4NCj4gPiA+ICAgICAgICAgICAgICAgICAgKi8N
Cj4gPiA+ICAgICAgICAgICAgICAgICBpZiAobmFtZSkNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGluZGV4ID0gb2ZfcHJvcGVydHlfbWF0Y2hfc3RyaW5nKG5wLCAiY2xvY2stbmFtZXMi
LA0KPiBuYW1lKTsNCj4gPiA+IC0gICAgICAgICAgICAgICBjbGsgPSBfX29mX2Nsa19nZXQobnAs
IGluZGV4LCBkZXZfaWQsIG5hbWUpOw0KPiA+ID4gLSAgICAgICAgICAgICAgIGlmICghSVNfRVJS
KGNsaykpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gLSAg
ICAgICAgICAgICAgIH0gZWxzZSBpZiAobmFtZSAmJiBpbmRleCA+PSAwKSB7DQo+ID4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoUFRSX0VSUihjbGspICE9IC1FUFJPQkVfREVGRVIpDQo+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiRVJST1I6IGNvdWxk
IG5vdCBnZXQgY2xvY2sgJXBPRjolcyglaSlcbiIsDQo+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbnAsIG5hbWUgPyBuYW1lIDogIiIsIGluZGV4KTsNCj4gPiA+
ICsgICAgICAgICAgICAgICBpZiAoaW5kZXggPj0gMCkNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGNsayA9IF9fb2ZfY2xrX2dldChucCwgaW5kZXgsIGRldl9pZCwgbmFtZSk7DQo+ID4g
PiArICAgICAgICAgICAgICAgaWYgKCFJU19FUlIoY2xrKSkNCj4gPg0KPiA+IFdhcyB0aGlzIGNo
YW5nZSBuZWNlc3Nhcnk/IEl0IGxvb2tzIGxpa2Ugd2UgY2FuIGxlYXZlIGl0IGFsbCBhbG9uZSBh
bmQga2VlcA0KPiA+IHBhc3NpbmcgYSBuZWdhdGl2ZSBudW1iZXIgdG8gX19vZl9jbGtfZ2V0KCkg
YW5kIGhhdmUgdGhhdCByZXR1cm4gYW4gZXJyb3INCj4gPiBwb2ludGVyIHdoaWNoIHdlIHRoZW4g
cmV0dXJuIGltbWVkaWF0ZWx5IGFzIGFuIGVycm9yLiBCdXQsIGlmIHRoZSBjbG9jayBpcw0KPiA+
IG9wdGlvbmFsIGFuZCB3ZSd2ZSBwYXNzZWQgYSBuYW1lIGhlcmUsIHNob3VsZG4ndCB3ZSB0cmVh
dCBhbiBlcnJvciBmcm9tDQo+ID4gb2ZfcHJvcGVydHlfbWF0Y2hfc3RyaW5nKCkgYXMgc3VjY2Vz
cyB0b28/IFRoaXMgaXMgYWxsIGxvb2tpbmcgcHJldHR5IGZyYWdpbGUNCj4gc28NCj4gPiBtYXli
ZSBpdCBjYW4gYmUgYmV0dGVyIGNvbW1lbnRlZCBhbmQgYWxzbyBtb3JlIGV4cGxpY2l0IGluc3Rl
YWQgb2YgcmVseWluZw0KPiA+IG9uIHRoZSByZWFkZXIgdG8ganVtcCB0aHJvdWdoIGFsbCB0aGUg
ZnVuY3Rpb24gY2FsbHMgdG8gZmlndXJlIG91dCB3aGF0IHRoZQ0KPiA+IHJldHVybiB2YWx1ZSBp
cyBpbiBzb21lIGNhc2VzLg0KPiBJZiB3ZSBjYWxsIF9fb2ZfY2xrX2dldCwgd2l0aCBpbmRleCA8
IDAsIHdlIHdpbGwgbm90IGJlIGFibGUgdG8gZGlmZmVyZW50aWF0ZQ0KPiBiZXR3ZWVuIGNsb2Nr
IHByb3ZpZGVyIG5vdCBwcmVzZW50IGFuZCBvdGhlciBlcnJvcnMgd2l0aCB0aGUgcGFzc2VkIGRh
dGEsDQo+IGFzIGl0IHdpbGwganVzdCByZXR1cm4gLUVJTlZBTC4NCj4gDQo+IG9mX3Byb3BlcnR5
X21hdGNoX3N0cmluZygpIHdpbGwgcmV0dXJuIC1FSU5WQUwgaWYgdGhlICJjbG9jay1uYW1lcyIN
Cj4gcHJvcGVydHkNCj4gaXMgbWlzc2luZywgb3IgLUVOT0RBVEEgaWYgdGhlIHNwZWNpZmllZCBj
bG9jayBuYW1lIGluIHRoZSAiY2xvY2stbmFtZXMiDQo+IHByb3BlcnR5IGlzIG1pc3NpbmcuIFRo
YXQgaXMgd2h5IEkgaGF2ZSBjaGFuZ2VkIHRoZSBjb2RlIHRvIGNvbmRpdGlvbmFsbHkNCj4gY2Fs
bCBfX29mX2Nsa19nZXQsIHNvIHRoZSBjb2RlIHdpbGwgY29ycmVjdGx5IHRyZWF0IG9wdGlvbmFs
IGNsb2NrcyB0aGF0IGFyZSBub3QNCj4gcHJlc2VudC4NCldoZW4gZ2V0dGluZyBuYW1lZCBvcHRp
b25hbCBjbG9ja3MsIGlmIHRoZSBub2RlIGhhcyBhICJjbG9jay1uYW1lcyIgcHJvcGVydHksDQpi
dXQgbm8gY2xvY2sgbWF0Y2hpbmcgdGhlIG5hbWUgd2Ugd2FudCwgSSB0aGluayB0aGUgZnVuY3Rp
b24gc2hvdWxkIHN0b3AgdGhlcmUNCmFuZCAqbm90KiB3YWxrIHVwIHRoZSB0cmVlIG9mIGRldmlj
ZXMgbG9va2luZyBmb3IgYSBtYXRjaGluZyBjbG9jay4gSW4gdGhpcyBjYXNlLA0KdGhlIGNvZGUg
ZGV0ZXJtaW5lcyB0aGF0IHRoZSBvcHRpb25hbCBjbG9jayBpcyBub3QgcHJlc2VudC4NCg0KSWYg
dGhlcmUgaXNu4oCZdCBhICJjbG9jay1uYW1lcyIgcHJvcGVydHkgaW4gdGhlIGN1cnJlbnQgbm9k
ZSwgdGhlIGZ1bmN0aW9uIHNob3VsZA0Kd2FsayB1cCB0aGUgdHJlZSBvZiBkZXZpY2VzIGxvb2tp
bmcgZm9yIGEgbWF0Y2hpbmcgb3B0aW9uYWwgY2xvY2suIElmIHRoZXJlIGFyZSBubw0KcGFyZW50
IG5vZGVzIGxlZnQgYW5kIHdlIGhhdmVuJ3QgZm91bmQgYSBtYXRjaGluZyBvcHRpb25hbCBjbG9j
aywgd2UgZGV0ZXJtaW5lDQp0aGF0IHRoZSBjbG9jayBpc27igJl0IHRoZXJlLg0KDQpJcyB0aGF0
IGhvdyB0aGlzIHNob3VsZCB3b3JrPw0KDQpUaGFua3MNClBoaWwNCg0KDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gY2xrOw0KPiA+ID4gLSAgICAgICAgICAgICAgIH0NCj4g
PiA+ICsgICAgICAgICAgICAgICBpZiAobmFtZSAmJiBpbmRleCA+PSAwKQ0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4NCj4gPiBBbmQgdGhpcyBjYXVzZXMgdXMgdG8g
ZHVwbGljYXRlIGxvZ2ljIGRvd24gYmVsb3cgYmVjYXVzZSB3ZSBoYXZlIHRvIGNoZWNrDQo+IGl0
DQo+ID4gYWdhaW4gaWYgaXQncyBub3Qgb3B0aW9uYWwgb3Igc29tZSBvdGhlciBlcnJvciBjb25k
aXRpb24/DQo+IFllcywgdGhlIGVycm9yIGhhbmRsaW5nIGlzIG1lc3N5LCB0aG91Z2ggSSBoYXZl
IHRyaWVkIHRvIG1ha2UgdGhpcyBzaW1wbGUuDQo+IEknbGwgaGF2ZSBhIHRoaW5rIGFib3V0IHNv
bWUgb3RoZXIgd2F5IHRvIG1ha2UgdGhpcyBjbGVhbmVyLg0KPiANCj4gDQo+ID4gPg0KPiA+ID4g
ICAgICAgICAgICAgICAgIC8qDQo+ID4gPiAgICAgICAgICAgICAgICAgICogTm8gbWF0Y2hpbmcg
Y2xvY2sgZm91bmQgb24gdGhpcyBub2RlLiAgSWYgdGhlDQo+ID4gPiBwYXJlbnQgbm9kZSBAQCAt
ODksNiArODgsMTYgQEAgc3RhdGljIHN0cnVjdCBjbGsNCj4gPiAqX19vZl9jbGtfZ2V0X2J5X25h
bWUoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+ID4gICAgICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgICAgICAvKiBUaGUgY2xv
Y2sgaXMgbm90IHZhbGlkLCBidXQgaXQgY291bGQgYmUgb3B0aW9uYWwgb3IgZGVmZXJyZWQgKi8N
Cj4gPiA+ICsgICAgICAgaWYgKG9wdGlvbmFsICYmIFBUUl9FUlIoY2xrKSA9PSAtRU5PRU5UKSB7
DQo+ID4gPiArICAgICAgICAgICAgICAgY2xrID0gTlVMTDsNCj4gPiA+ICsgICAgICAgICAgICAg
ICBwcl9pbmZvKCJubyBvcHRpb25hbCBjbG9jayAlcE9GOiVzXG4iLCBjaGlsZCwNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIG5hbWUgPyBuYW1lIDogIiIpOw0KPiA+DQo+ID4gSXMgdGhp
cyBpbnRlbnRpb25hbGx5IHByX2luZm8/DQo+IFllcywgaXQncyBub3QgYW4gZXJyb3IgaWYgYW4g
b3B0aW9uYWwgY2xvY2sgaXNu4oCZdCB0aGVyZS4NCj4gV291bGQgcHJfZGVidWcgYmUgbW9yZSBh
cHByb3ByaWF0ZT8NCj4gDQo+IA0KPiA+ID4gKyAgICAgICB9IGVsc2UgaWYgKG5hbWUgJiYgaW5k
ZXggPj0gMCAmJiBQVFJfRVJSKGNsaykgIT0gLUVQUk9CRV9ERUZFUikgew0KPiA+ID4gKyAgICAg
ICAgICAgICAgIHByX2VycigiRVJST1I6IGNvdWxkIG5vdCBnZXQgY2xvY2sgJXBPRjolcyglaSlc
biIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBjaGlsZCwgbmFtZSwgaW5kZXgpOw0K
PiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIHJldHVybiBjbGs7DQo+ID4g
PiAgfQ0KPiA+ID4NCj4gDQo+IFRoYW5rcw0KPiBQaGlsDQo=
