Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA982077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nbawIZf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA982077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeICNwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:52:18 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:55768 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbeICNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:52:18 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 03 Sep 2018 18:32:56 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id E21507E46A;
        Mon,  3 Sep 2018 18:32:56 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,324,1531753200"; 
   d="scan'208";a="291400876"
Received: from mail-ty1jpn01lp0176.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.176])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 03 Sep 2018 18:32:56 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpnBC8pIc/5IEaTHPTZoi0WOQ7W1Xd3OaQqwUkaqULo=;
 b=nbawIZf7WaXESXr/B5zHIh/4XPEFCFKwd5bU0I3KxkdD2z2mCojWqP/99dHMnMT2E8o23mSFsVcZR/gj2ednnQk0+47T2nGIz9J06wNvZg2v57eM9dezUyUGJK88Q5D/HkxIsmK9WpZdnAPMu0nNc+Um/YWSRhgh5dOnkRXqV+w=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1708.jpnprd01.prod.outlook.com (52.133.160.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Mon, 3 Sep 2018 09:32:54 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb%4]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 09:32:54 +0000
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
Thread-Index: AQHUQTP8XUjGAOby9EG+9JY2nBABh6TauV+AgAOFTQA=
Date:   Mon, 3 Sep 2018 09:32:54 +0000
Message-ID: <TY1PR01MB1769CBB6FC715E94B10815BFF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
 <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
 <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
In-Reply-To: <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1708;20:UG/izWHZFJ4p0TXCM4RvwhaiU8xhCgQrGGz5AAxcDuyUT0EZXvifbULlGSEWpM4Ghs6UQfpYuJ8Ld+jjQrdwsL0VUtxpm6uKAAIADLK3pFIKsoDjKz+v97fxsn6Mxrx+mBfi7BpQfWuEqLWjqX5mPVdrWvxl1542FrXpNjcvNkU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7a2c10ce-892a-4c3c-a82e-08d611803a21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1708;
x-ms-traffictypediagnostic: TY1PR01MB1708:
x-microsoft-antispam-prvs: <TY1PR01MB1708BE229C6AAAAC9CAF0955F50C0@TY1PR01MB1708.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:TY1PR01MB1708;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1708;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(11346002)(25786009)(305945005)(7736002)(26005)(8936002)(6506007)(53546011)(102836004)(478600001)(6116002)(3846002)(66066001)(54906003)(33656002)(14454004)(446003)(110136005)(8676002)(476003)(81166006)(86362001)(81156014)(186003)(53936002)(74316002)(316002)(76176011)(4326008)(68736007)(5250100002)(5660300001)(7696005)(6246003)(99286004)(9686003)(229853002)(486006)(106356001)(6436002)(97736004)(105586002)(2906002)(14444005)(2900100001)(55016002)(44832011)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1708;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7w8EozgN2KgM2e+zD2fVeSD7ElbmgLglOcwCDP3Cb9qY8ySysirDOVORfE1si4ch4FanQZx6ZkysDqy2k5KW0A41mZk22aKYrLWfo/KTxbL/e9u0CpHjc30BfnPctg2/XK7uns0/GqRHlUoAdkZ1gHAjk+l8dbCK3BY9exjPcndRzPFUS7vScb4gih/cDA0/1nZ9U48m0G5kOEgZ83acFxOPup/VM1cMpuG/SLOl9F8MQd03STDzm/kWF2S6iflyMWwBq8teriwrnxzP6BxLIDO3zfqYyJxMCFr2mcEwcU9OEyTUzRExcD8mcwy3R/0BZTF46KLCPff0s7CLHwIimApXIudCDz0B+lBsqk3lqoQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2c10ce-892a-4c3c-a82e-08d611803a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 09:32:54.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KT24gMDEgU2VwdGVtYmVyIDIwMTggMDM6NDYsIFN0ZXBoZW4gQm95ZCB3
cm90ZToNCj4gUXVvdGluZyBQaGlsIEVkd29ydGh5ICgyMDE4LTA4LTMxIDA3OjA3OjIyKQ0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGtkZXYuYyBiL2RyaXZlcnMvY2xrL2Nsa2Rldi5j
IGluZGV4DQo+ID4gOWFiM2RiOC4uNGFkYjk5ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Ns
ay9jbGtkZXYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsa2Rldi5jDQo+ID4gQEAgLTU0LDMw
ICs1NCwyOSBAQCBFWFBPUlRfU1lNQk9MKG9mX2Nsa19nZXQpOw0KPiA+DQo+ID4gIHN0YXRpYyBz
dHJ1Y3QgY2xrICpfX29mX2Nsa19nZXRfYnlfbmFtZShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpk
ZXZfaWQsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IGNoYXIgKm5hbWUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb2wgb3B0aW9uYWwpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBjbGsgKmNs
ayA9IEVSUl9QVFIoLUVOT0VOVCk7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmNo
aWxkID0gbnA7DQo+ID4gKyAgICAgICBpbnQgaW5kZXggPSAwOw0KPiA+DQo+ID4gICAgICAgICAv
KiBXYWxrIHVwIHRoZSB0cmVlIG9mIGRldmljZXMgbG9va2luZyBmb3IgYSBjbG9jayB0aGF0IG1h
dGNoZXMgKi8NCj4gPiAgICAgICAgIHdoaWxlIChucCkgew0KPiA+IC0gICAgICAgICAgICAgICBp
bnQgaW5kZXggPSAwOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIC8qDQo+ID4gICAgICAgICAg
ICAgICAgICAqIEZvciBuYW1lZCBjbG9ja3MsIGZpcnN0IGxvb2sgdXAgdGhlIG5hbWUgaW4gdGhl
DQo+ID4gICAgICAgICAgICAgICAgICAqICJjbG9jay1uYW1lcyIgcHJvcGVydHkuICBJZiBpdCBj
YW5ub3QgYmUgZm91bmQsIHRoZW4NCj4gPiAtICAgICAgICAgICAgICAgICogaW5kZXggd2lsbCBi
ZSBhbiBlcnJvciBjb2RlLCBhbmQgb2ZfY2xrX2dldCgpIHdpbGwgZmFpbC4NCj4gPiArICAgICAg
ICAgICAgICAgICogaW5kZXggd2lsbCBiZSBhbiBlcnJvciBjb2RlLg0KPiA+ICAgICAgICAgICAg
ICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAgaWYgKG5hbWUpDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgaW5kZXggPSBvZl9wcm9wZXJ0eV9tYXRjaF9zdHJpbmcobnAsICJjbG9jay1u
YW1lcyIsIG5hbWUpOw0KPiA+IC0gICAgICAgICAgICAgICBjbGsgPSBfX29mX2Nsa19nZXQobnAs
IGluZGV4LCBkZXZfaWQsIG5hbWUpOw0KPiA+IC0gICAgICAgICAgICAgICBpZiAoIUlTX0VSUihj
bGspKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gLSAgICAgICAg
ICAgICAgIH0gZWxzZSBpZiAobmFtZSAmJiBpbmRleCA+PSAwKSB7DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKFBUUl9FUlIoY2xrKSAhPSAtRVBST0JFX0RFRkVSKQ0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJFUlJPUjogY291bGQgbm90IGdldCBj
bG9jayAlcE9GOiVzKCVpKVxuIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbnAsIG5hbWUgPyBuYW1lIDogIiIsIGluZGV4KTsNCj4gPiArICAgICAgICAgICAg
ICAgaWYgKGluZGV4ID49IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xrID0gX19v
Zl9jbGtfZ2V0KG5wLCBpbmRleCwgZGV2X2lkLCBuYW1lKTsNCj4gPiArICAgICAgICAgICAgICAg
aWYgKCFJU19FUlIoY2xrKSkNCj4gDQo+IFdhcyB0aGlzIGNoYW5nZSBuZWNlc3Nhcnk/IEl0IGxv
b2tzIGxpa2Ugd2UgY2FuIGxlYXZlIGl0IGFsbCBhbG9uZSBhbmQga2VlcA0KPiBwYXNzaW5nIGEg
bmVnYXRpdmUgbnVtYmVyIHRvIF9fb2ZfY2xrX2dldCgpIGFuZCBoYXZlIHRoYXQgcmV0dXJuIGFu
IGVycm9yDQo+IHBvaW50ZXIgd2hpY2ggd2UgdGhlbiByZXR1cm4gaW1tZWRpYXRlbHkgYXMgYW4g
ZXJyb3IuIEJ1dCwgaWYgdGhlIGNsb2NrIGlzDQo+IG9wdGlvbmFsIGFuZCB3ZSd2ZSBwYXNzZWQg
YSBuYW1lIGhlcmUsIHNob3VsZG4ndCB3ZSB0cmVhdCBhbiBlcnJvciBmcm9tDQo+IG9mX3Byb3Bl
cnR5X21hdGNoX3N0cmluZygpIGFzIHN1Y2Nlc3MgdG9vPyBUaGlzIGlzIGFsbCBsb29raW5nIHBy
ZXR0eSBmcmFnaWxlIHNvDQo+IG1heWJlIGl0IGNhbiBiZSBiZXR0ZXIgY29tbWVudGVkIGFuZCBh
bHNvIG1vcmUgZXhwbGljaXQgaW5zdGVhZCBvZiByZWx5aW5nDQo+IG9uIHRoZSByZWFkZXIgdG8g
anVtcCB0aHJvdWdoIGFsbCB0aGUgZnVuY3Rpb24gY2FsbHMgdG8gZmlndXJlIG91dCB3aGF0IHRo
ZQ0KPiByZXR1cm4gdmFsdWUgaXMgaW4gc29tZSBjYXNlcy4NCklmIHdlIGNhbGwgX19vZl9jbGtf
Z2V0LCB3aXRoIGluZGV4IDwgMCwgd2Ugd2lsbCBub3QgYmUgYWJsZSB0byBkaWZmZXJlbnRpYXRl
DQpiZXR3ZWVuIGNsb2NrIHByb3ZpZGVyIG5vdCBwcmVzZW50IGFuZCBvdGhlciBlcnJvcnMgd2l0
aCB0aGUgcGFzc2VkIGRhdGEsDQphcyBpdCB3aWxsIGp1c3QgcmV0dXJuIC1FSU5WQUwuDQoNCm9m
X3Byb3BlcnR5X21hdGNoX3N0cmluZygpIHdpbGwgcmV0dXJuIC1FSU5WQUwgaWYgdGhlICJjbG9j
ay1uYW1lcyIgcHJvcGVydHkNCmlzIG1pc3NpbmcsIG9yIC1FTk9EQVRBIGlmIHRoZSBzcGVjaWZp
ZWQgY2xvY2sgbmFtZSBpbiB0aGUgImNsb2NrLW5hbWVzIg0KcHJvcGVydHkgaXMgbWlzc2luZy4g
VGhhdCBpcyB3aHkgSSBoYXZlIGNoYW5nZWQgdGhlIGNvZGUgdG8gY29uZGl0aW9uYWxseQ0KY2Fs
bCBfX29mX2Nsa19nZXQsIHNvIHRoZSBjb2RlIHdpbGwgY29ycmVjdGx5IHRyZWF0IG9wdGlvbmFs
IGNsb2NrcyB0aGF0IGFyZSBub3QNCnByZXNlbnQuDQoNCg0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBjbGs7DQo+ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAg
ICAgICAgaWYgKG5hbWUgJiYgaW5kZXggPj0gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gDQo+IEFuZCB0aGlzIGNhdXNlcyB1cyB0byBkdXBsaWNhdGUgbG9naWMgZG93
biBiZWxvdyBiZWNhdXNlIHdlIGhhdmUgdG8gY2hlY2sgaXQNCj4gYWdhaW4gaWYgaXQncyBub3Qg
b3B0aW9uYWwgb3Igc29tZSBvdGhlciBlcnJvciBjb25kaXRpb24/DQpZZXMsIHRoZSBlcnJvciBo
YW5kbGluZyBpcyBtZXNzeSwgdGhvdWdoIEkgaGF2ZSB0cmllZCB0byBtYWtlIHRoaXMgc2ltcGxl
Lg0KSSdsbCBoYXZlIGEgdGhpbmsgYWJvdXQgc29tZSBvdGhlciB3YXkgdG8gbWFrZSB0aGlzIGNs
ZWFuZXIuDQoNCg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIC8qDQo+ID4gICAgICAgICAgICAg
ICAgICAqIE5vIG1hdGNoaW5nIGNsb2NrIGZvdW5kIG9uIHRoaXMgbm9kZS4gIElmIHRoZQ0KPiA+
IHBhcmVudCBub2RlIEBAIC04OSw2ICs4OCwxNiBAQCBzdGF0aWMgc3RydWN0IGNsaw0KPiAqX19v
Zl9jbGtfZ2V0X2J5X25hbWUoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyog
VGhlIGNsb2NrIGlzIG5vdCB2YWxpZCwgYnV0IGl0IGNvdWxkIGJlIG9wdGlvbmFsIG9yIGRlZmVy
cmVkICovDQo+ID4gKyAgICAgICBpZiAob3B0aW9uYWwgJiYgUFRSX0VSUihjbGspID09IC1FTk9F
TlQpIHsNCj4gPiArICAgICAgICAgICAgICAgY2xrID0gTlVMTDsNCj4gPiArICAgICAgICAgICAg
ICAgcHJfaW5mbygibm8gb3B0aW9uYWwgY2xvY2sgJXBPRjolc1xuIiwgY2hpbGQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbmFtZSA/IG5hbWUgOiAiIik7DQo+IA0KPiBJcyB0aGlzIGlu
dGVudGlvbmFsbHkgcHJfaW5mbz8NClllcywgaXQncyBub3QgYW4gZXJyb3IgaWYgYW4gb3B0aW9u
YWwgY2xvY2sgaXNu4oCZdCB0aGVyZS4NCldvdWxkIHByX2RlYnVnIGJlIG1vcmUgYXBwcm9wcmlh
dGU/DQoNCg0KPiA+ICsgICAgICAgfSBlbHNlIGlmIChuYW1lICYmIGluZGV4ID49IDAgJiYgUFRS
X0VSUihjbGspICE9IC1FUFJPQkVfREVGRVIpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJfZXJy
KCJFUlJPUjogY291bGQgbm90IGdldCBjbG9jayAlcE9GOiVzKCVpKVxuIiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBjaGlsZCwgbmFtZSwgaW5kZXgpOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICsNCj4gPiAgICAgICAgIHJldHVybiBjbGs7DQo+ID4gIH0NCj4gPg0KDQpUaGFua3MNClBoaWwN
Cg==
