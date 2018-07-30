Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E023FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BED020893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="pn4XO95a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BED020893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeG3SOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:14:44 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:55629 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729331AbeG3SOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:14:44 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 31 Jul 2018 01:38:53 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 3785C36D5F;
        Tue, 31 Jul 2018 01:38:53 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,422,1526310000"; 
   d="scan'208";a="286814448"
Received: from mail-os2jpn01lp0143.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.143])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2018 01:38:52 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeBGHLg48V3QqsdSbyHTVvdPjkm5F8/NwtFL5WDbanc=;
 b=pn4XO95asHRt+aWLCc8GTfzmw6lQbO5FKhxj+XiQ+gFK7PDPhNFfqY4p5tjyUFk1hcupkepHRSHQ8lMO1tI8s07VWRdtmPoEb79CQsog81fZX/SN6PJG+eHroty/h/EawmgtNfiAiGzibt/xS5xC2zPUuY0K3hbiyk8pm3LdwhU=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1199.jpnprd01.prod.outlook.com (10.174.226.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Mon, 30 Jul 2018 16:38:49 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8%4]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 16:38:48 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Topic: [PATCH v3 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Index: AQHUKAm4z9eXk6hScU2PWxMzOjFm4qSn7bIAgAABJ3A=
Date:   Mon, 30 Jul 2018 16:38:48 +0000
Message-ID: <TY1PR01MB1769B0BC7769B14EFBC0F3DEF52F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
         <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
 <884376f1fd82a99e5d47eeba1fd1aaa3b19bc604.camel@linux.intel.com>
In-Reply-To: <884376f1fd82a99e5d47eeba1fd1aaa3b19bc604.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1199;20:TXxGpBiO2/RFb9qSN0s9AwkmODby+6KwB6luu8BAUIn1Z6OTmLLdGAh38jyGIiCHTZzvkP2FfZU827o8TniTct98nQBaax+3Jn3NArOnCApj3QFPim41VGDy/PZjivwUZK8i3nYTLusfZXVWOB/CrgfR96ErLFPo2zt1D6z1p58=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9c86057d-e773-494c-d060-08d5f63aed1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1199;
x-ms-traffictypediagnostic: TY1PR01MB1199:
x-microsoft-antispam-prvs: <TY1PR01MB1199FAA5AB7524065605B292F52F0@TY1PR01MB1199.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1199;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1199;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(8676002)(446003)(9686003)(97736004)(486006)(44832011)(476003)(5250100002)(11346002)(478600001)(4326008)(86362001)(25786009)(76176011)(14444005)(7696005)(14454004)(68736007)(2906002)(81166006)(105586002)(256004)(106356001)(3846002)(81156014)(6436002)(6506007)(6246003)(8936002)(26005)(53546011)(99286004)(102836004)(33656002)(5660300001)(53936002)(6116002)(229853002)(66066001)(74316002)(305945005)(54906003)(7736002)(110136005)(2900100001)(186003)(316002)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1199;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LB7IBTIvukLq1zg04cRUJ/e9R0Tt8Di8dvKusQM1gFh7LNBfkI48PXKu8Yvr812h0TX2Q4KcA06/s8pwGSU9obgEP+hGpDuD0PLi6dP/buBl6tkbF9ws/MxLcK20UvuUnE5CzZ4xQyVbHWZQ93uhXSnFmR1cXA29BSBd/QPexXWs3wuXNywpTN+f9+YH+nzCTf0lS4oVz1uIpdeVGuj/Qe1TERVmEepSF8tDU1M/KIKLzY73Ia49rEVLPvJwbvZGZw9UkoueOxOvfOWP9JB7ZRBqWYZhcVv98ybDvmLtSzXqpPX3lBdYydn/ENWW0rwPebqwxC+D/4wTJx97Vnu///HqYwzGXn2LZcK8kOQ9evQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c86057d-e773-494c-d060-08d5f63aed1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 16:38:48.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KT24gMzAgSnVseSAyMDE4IDE3OjA0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgMjAxOC0wNy0zMCBhdCAxNDozMSArMDEwMCwgUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gPiBRdWl0ZSBhIGZldyBkcml2ZXJzIGdldCBhbiBvcHRpb25hbCBjbG9jaywgZS5nLiBh
IGNsb2NrIHJlcXVpcmVkIHRvDQo+ID4gYWNjZXNzIHBlcmlwaGVyYWwncyByZWdpc3RlcnMgdGhh
dCBpcyBhbHdheXMgZW5hYmxlZCBvbiBzb21lIGRldmljZXMuDQo+ID4NCj4gPiBUaGlzIGZ1bmN0
aW9uIGJlaGF2ZXMgdGhlIHNhbWUgYXMgb2ZfY2xrX2dldF9ieV9uYW1lKCkgZXhjZXB0IHRoYXQg
aXQNCj4gPiB3aWxsIHJldHVybiBOVUxMIGluc3RlYWQgb2YgLUVJTlZBTC4NCj4gDQo+IEknbSBw
dXp6bGVkIGEgYml0Lg0KPiANCj4gX19vZl9jbGtfZ2V0KCkgbWF5IHJldHVybiBmZXcgZXJyb3Ig
Y29kZXMsIGFuZCB0byBtZSBFTk9FTlQgc291bmRzDQo+IGNvcnJlY3Qgd2hlbiBjbG9jayBpcyBu
b3QgZm91bmQuIE90aGVyIGVycm9yIGNvZGVzIHNob3VsZCBiZSBwYXNzZWQgdG8gdGhlDQo+IGNh
bGxlciBldmVuIGZvciBvcHRpb25hbCBjbG9ja3MuDQo+IA0KPiBJZiBhYm92ZSBpcyBub3QgdHJ1
ZSwgd2UgbmVlZCB0byB1bmRlcnN0YW5kIHdoYXQgY2lyY3Vtc3RhbmNlcyBmb3IgZWFjaA0KPiBw
b3NzaWJsZSByZXR1cm5lZCBjb2RlIGFyZSwgYW5kIGZpeCAvIGFjdCBhY2NvcmRpbmdseS4NCj4N
Cj4gUC5TLiBQb3NzaWJsZSB3YXkgbGlrZSByZWd1bGF0b3IgZnJhbWV3b3JrIGRvZXMgaXMgdG8g
cmV0dXJuIC1FTk9ERVYuDQo+IA0KPiBTbywgYmFzaWNhbGx5IHdoYXQgSSdtIGFza2luZyBoZXJl
IGlzIHRvIGJlIHN1cmUgdGhhdCBzaW5nbGUgZXJyb3IgY29kZSAoZm9yIG5vdw0KPiBzdXBwb3Nl
ZCAtRUlOVkFMKSBpbiB0aGlzIGNhc2UgaXMgX3RoZV8gZXJyb3IgY29kZSBmb3IgYWJzZW50IC8g
Y2FuJ3QgYmUNCj4gZm91bmQgY2xvY2suDQpvZl9wcm9wZXJ0eV9tYXRjaF9zdHJpbmcoKSBjYW4g
cmV0dXJuIGRpZmZlcmVudCByZXR1cm4gdmFsdWVzIGZvciB3aGVuOg0KIHRoZSAiY2xvY2stbmFt
ZXMiIHByb3BlcnR5IGlzIG1pc3NpbmcgKC1FSU5WQUwpLA0KIHRoZSBzcGVjaWZpZWQgY2xvY2sg
bmFtZSBpbiB0aGUgImNsb2NrLW5hbWVzIiBwcm9wZXJ0eSBpcyBtaXNzaW5nICAoLUVOT0RBVEEp
LA0KIG9yIGludGVybmFsIGVycm9ycywgKGUuZy4gLUVJTFNFUSkuDQpIb3dldmVyLCBpZiB5b3Ug
dGhlbiBjYWxsIF9fb2ZfY2xrX2dldCgpIHdpdGggdGhlIGZhaWxlZCBpbmRleCwgeW91IGp1c3Qg
Z2V0DQp0aGUgLUVJTlZBTCBlcnJvci4NCg0KTG9va2luZyBhdCBpdCBmdXJ0aGVyLCBfX29mX2Ns
a19nZXQoKSBzaG91bGQgcmV0dXJuIC1FTk9FTlQgaWYgcGFzc2VkIGEgdmFsaWQNCmluZGV4IChl
LmcuIDAgd2hlbiBuYW1lPU5VTEwpIGFuZCB0aGUgY2xvY2sgaXMgbm90IHRoZXJlLiBIb3dldmVy
LCBJIHRoaW5rDQppdCB3aWxsIHRha2UgYSB3aGlsZSB0byBjaGVjayBhbGwgcG9zc2libGUgcmV0
dXJuIHZhbHVlcyBhcyBpdCdzIG5vdCBpbW1lZGlhdGVseQ0KY2xlYXIgd2hhdCB0aGV5IGFyZSAo
dG8gbWUpLg0KDQpJIHRoaW5rIHRoZSBiZXN0IHRoaW5nIGlzIHRvIHRlc3QgdGhlIHJldHVybiB2
YWx1ZSBvZiBvZl9wcm9wZXJ0eV9tYXRjaF9zdHJpbmcoKQ0KZm9yIC1FTk9EQVRBLCBhbmQgZGVh
bCB3aXRoIGl0IHRoZW4uIFRoZW4gZGVhbCB3aXRoIHRoZSBjYXNlIG9mIG5hbWU9TlVMTA0Kc2Vw
YXJhdGVseS4NCg0KVGhhbmtzDQpQaGlsDQoNCiA+ICAtIEZpeCBjaGVjayBmb3IgY2xvY2sgbm90
IHByZXNlbnQuIF9fb2ZfY2xrX2dldCgpIHJldHVybnMgLUVJTlZBTA0KPiA+ICAgIGlmIGl0J3Mg
bm90IHRoZXJlLiBDb3ZlciBjYXNlIG9mIHdoZW4gdGhlcmUgaXMgbm8gY2xvY2sgbmFtZS4NCj4g
DQo+IC0tDQo+IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tPg0KPiBJbnRlbCBGaW5sYW5kIE95DQo=
