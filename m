Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14972C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6EE2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cJT+evh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6EE2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbeG0RAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:00:50 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:20193 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731160AbeG0RAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:00:50 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 28 Jul 2018 00:38:19 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 025078EF40;
        Sat, 28 Jul 2018 00:38:20 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,409,1526310000"; 
   d="scan'208";a="286571809"
Received: from mail-os2jpn01lp0148.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.148])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2018 00:38:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjzSFJMBYIWjdogSSBKZuo+MLow4/aBNucP6z/sG7Xc=;
 b=cJT+evh4jjC+3yjWcd6y6Ss+CgQA7dBl1xK0tQIvypjhTdcstG63VHEtQB0VSi0lYritgDYGeOv7HxYuiZsuEZIx6SyPQtFowZwCDFydbwGy5Kpe7EfTDk/2663OZtMMK/pw/Em5ydRfVnDS7cgdVaDCxQ4rzDbuV6n/urWa9Qc=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0206.jpnprd01.prod.outlook.com (10.161.135.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.18; Fri, 27 Jul 2018 15:38:14 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8%4]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 15:38:13 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clk: Add functions to get optional clocks
Thread-Topic: [PATCH] clk: Add functions to get optional clocks
Thread-Index: AQHUHpbsRjZTxwyvBkOBkCNbvUsciKSU8fsAgAAEt4CAAAmi4IALkoEAgAKr6AA=
Date:   Fri, 27 Jul 2018 15:38:12 +0000
Message-ID: <TY1PR01MB1769925385A6FB44A431AA07F52A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
 <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
 <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
In-Reply-To: <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0206;20:/7D44XIJmUzeXONyNwAa2f4iAT5isH4MlaEMp7kqseOxSWue31xZJiRcijk2lLUJGJiKmba52EI+yx/4QYsFteAss4ceFMH7SFPZit3lkoTxWlev7x0CV2o1mQYfx+fPlR/hZsXlGKVEITscB4ShAHNRKxcz0VdI4PtJ+N75U70=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 87aef50d-299c-41da-5d83-08d5f3d6f71d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0206;
x-ms-traffictypediagnostic: TY1PR01MB0206:
x-microsoft-antispam-prvs: <TY1PR01MB020687F730129D23D984516EF52A0@TY1PR01MB0206.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0206;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0206;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(68736007)(93886005)(25786009)(97736004)(106356001)(33656002)(105586002)(7736002)(14454004)(229853002)(99286004)(186003)(26005)(2906002)(446003)(486006)(8936002)(11346002)(6116002)(3846002)(4326008)(7696005)(44832011)(81156014)(66066001)(81166006)(6506007)(102836004)(5250100002)(110136005)(8676002)(476003)(55016002)(76176011)(256004)(53546011)(74316002)(478600001)(316002)(86362001)(6246003)(5660300001)(54906003)(9686003)(53936002)(2900100001)(305945005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0206;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uW8hgwdoVddmByMEkFgFDquqNTYdE6agGmogTvIn/vT7AUfqgwcCngWSDSRfMQwweM2efZhxGBeOi6CG87HUvGmXqZFDKZEq+v1YSu9v7f/48WHBOW47c2lvPoJpcry+kzIpV9aCzaYbexBXXu4p822l949GaoxqiIcmFEkSbnnwXgVwdDmFcMJcRZTID1djZMY2waNLGikRGwGyOWd0BI74Xwi8eX+c6qejs5MPwBEV9fjTpMDzyFmgBE8lHipja6Dpw9YWrs3zLuj97ig+EWFc+t+96YaJlo8zWTdLlfFF7tTIkVObgdOxqi5PEMZADXky8b5CVzVJ3yxTJFqUwEtE716LbU7yD2lZvxMFFqI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aef50d-299c-41da-5d83-08d5f3d6f71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 15:38:12.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KT24gMjUgSnVseSAyMDE4IDIzOjM3LCBTdGVwaGVuIEJveWQgd3JvdGU6
DQo+IFF1b3RpbmcgUGhpbCBFZHdvcnRoeSAoMjAxOC0wNy0xOCAwNjo1NjoyNikNCj4gPiBPbiAx
OCBKdWx5IDIwMTggMTQ6MTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiA+IE9uIFdl
ZCwgSnVsIDE4LCAyMDE4IGF0IDM6MDIgUE0gUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4ICB3cm90
ZToNCj4gPiA+ID4gT24gV2VkLCBKdWwgMTgsIDIwMTggYXQgMDE6NTc6MzhQTSArMDEwMCwgUGhp
bCBFZHdvcnRoeSB3cm90ZToNCj4gPiA+ID4gPiBCZWhhdmVzIHRoZSBzYW1lIGFzIChkZXZtXylj
bGtfZ2V0IGV4Y2VwdCB3aGVyZSB0aGVyZSBpcyBubw0KPiA+ID4gPiA+IGNsb2NrIHByb2R1Y2Vy
LiBJbiB0aGlzIGNhc2UsIGluc3RlYWQgb2YgcmV0dXJuaW5nIC1FTk9FTlQsIHRoZQ0KPiA+ID4g
PiA+IGZ1bmN0aW9uIHJldHVybnMgTlVMTC4gVGhpcyBtYWtlcyBlcnJvciBjaGVja2luZyBzaW1w
bGVyIGFuZA0KPiA+ID4gPiA+IGFsbG93cyBjbGtfcHJlcGFyZV9lbmFibGUsIGV0YyB0byBiZSBj
YWxsZWQgb24gdGhlIHJldHVybmVkDQo+ID4gPiA+ID4gcmVmZXJlbmNlIHdpdGhvdXQgYWRkaXRp
b25hbCBjaGVja3MuDQo+ID4gPiA+DQo+ID4gPiA+IEhvdyBkb2VzIHRoaXMgd29yayB3aXRoIG5v
bi1EVCBzeXN0ZW1zLCB3aGVyZSBsb29raW5nIGEgY2xvY2sgdXANCj4gPiA+ID4gd2hpY2ggaXNu
J3QgeWV0IHJlZ2lzdGVyZWQgd2l0aCBjbGtkZXYgcmV0dXJucyAtRU5PRU5UID8NCj4gPiA+ID4N
Cj4gPiA+ID4gKGNsa2RldiBkb2Vzbid0IGtub3cgd2hlbiBhbGwgY2xvY2tzIGFyZSByZWdpc3Rl
cmVkIHdpdGggaXQuKQ0KPiA+ID4NCj4gPiA+IEdvb2QgcXVlc3Rpb24uDQo+ID4gPg0KPiA+ID4g
SSBndWVzcyBhbGwgZHJpdmVycyB0cnlpbmcgdG8gaGFuZGxlIG9wdGlvbmFsIGNsb2NrcyB0aGlz
IHdheSBhcmUNCj4gPiA+IGFscmVhZHkgYnJva2VuIG9uIG5vbi1EVCBzeXN0ZW1zIHdoZXJlIGNs
b2NrcyBtYXkgYmUgcmVnaXN0ZXJlZCBsYXRlLi4uDQo+ID4NCj4gPiBTbyBob3cgZG8gbm9uLURU
IHN5c3RlbXMgdGhhdCBsb29rIGEgY2xvY2sgdXAgd2hpY2ggaXNuJ3QgeWV0DQo+ID4gcmVnaXN0
ZXJlZCB3aXRoIGNsa2RldiwgZGV0ZXJtaW5lIHRoYXQgYW4gb3B0aW9uYWwgY2xvY2sgaXMgdGhl
cmUgb3INCj4gPiBub3Q/DQo+ID4NCj4gDQo+IFNob3J0IGFuc3dlciBpcyB0aGV5IGRvbid0LiBJ
J2Qgc3RpbGwgcHJlZmVyIHdlIGhhdmUgdGhpcyBBUEkgdGhvdWdoLg0KPiANCj4gQ2FuIHlvdSBy
ZXdvcmsgdGhpcyBwYXRjaCB0byBiZSBhIGxpdHRsZSBtb3JlIGludmFzaXZlIGludG8gdGhlDQo+
IGNsa19nZXQoKSBwYXRoLCBwZXJoYXBzIGJ5IHJld29ya2luZyBfX29mX2Nsa19nZXRfYnlfbmFt
ZSgpIGEgbGl0dGxlIHRvDQo+IHRha2UgYW4gJ29wdGlvbmFsJyBhcmd1bWVudCwgc28gdGhhdCBp
dCBvbmx5IHJldHVybnMgTlVMTCB3aGVuIHRoZSBjbGsgaXMNCj4gbG9va2VkIHVwIGZyb20gRFQ/
IFRoZSBmYWxsYmFjayBwYXRoIGluIGNsa2RldiB3aGVyZSB3ZSBoYXZlIGEgRFQgYmFzZWQNCj4g
c3lzdGVtIGxvb2tpbmcgdXAgYSBjbGsgdGhyb3VnaCBjbGtkZXYgbG9va3VwcyBkb2Vzbid0IHNl
ZW0gdG8gYmUgYSByZWFsDQo+IHNjZW5hcmlvIHRoYXQgd2Ugc2hvdWxkIHdvcnJ5IGFib3V0IGhl
cmUuIEkgdGhpbmsgc29tZXRpbWVzIHBlb3BsZSB1c2UNCj4gY2xrZGV2IGxvb2t1cHMgd2hlbiB0
aGV5J3JlIG1pZ3JhdGluZyB0byBEVCBzeXN0ZW1zIGFuZCB0aGluZ3MgYXJlbid0IHdpcmVkDQo+
IHVwIHByb3Blcmx5IGluIERULCBidXQgdGhhdCBpc24ndCB0aGUgbm9ybS4NCkRvIHlvdSBtZWFu
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGtkZXYu
YyBiL2RyaXZlcnMvY2xrL2Nsa2Rldi5jDQppbmRleCA3ZjJjZDFlLi40MmE3ZDRlIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jbGsvY2xrZGV2LmMNCisrKyBiL2RyaXZlcnMvY2xrL2Nsa2Rldi5jDQpA
QCAtNTcsNyArNTcsOCBAQCBFWFBPUlRfU1lNQk9MKG9mX2Nsa19nZXQpOw0KIA0KIHN0YXRpYyBz
dHJ1Y3QgY2xrICpfX29mX2Nsa19nZXRfYnlfbmFtZShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmRldl9p
ZCwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpu
YW1lKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIg
Km5hbWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBvcHRp
b25hbCkNCiB7DQogICAgICAgIHN0cnVjdCBjbGsgKmNsayA9IEVSUl9QVFIoLUVOT0VOVCk7DQog
DQpAQCAtNzksNiArODAsOCBAQCBzdGF0aWMgc3RydWN0IGNsayAqX19vZl9jbGtfZ2V0X2J5X25h
bWUoc3RydWN0IGRldmljZV9ub2RlICpucCwNCiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChQ
VFJfRVJSKGNsaykgIT0gLUVQUk9CRV9ERUZFUikNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcHJfZXJyKCJFUlJPUjogY291bGQgbm90IGdldCBjbG9jayAlcE9GOiVzKCVpKVxuIiwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBucCwgbmFtZSA/IG5hbWUg
OiAiIiwgaW5kZXgpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKG9wdGlvbmFsICYmIFBU
Ul9FUlIoY2xrKSA9PSAtRU5PRU5UKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
bGsgPSBOVUxMOw0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGNsazsNCiAgICAgICAg
ICAgICAgICB9DQogDQpAQCAtMTA5LDE1ICsxMTIsMzggQEAgc3RydWN0IGNsayAqb2ZfY2xrX2dl
dF9ieV9uYW1lKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGNvbnN0IGNoYXIgKm5hbWUpDQogICAg
ICAgIGlmICghbnApDQogICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7DQog
DQotICAgICAgIHJldHVybiBfX29mX2Nsa19nZXRfYnlfbmFtZShucCwgbnAtPmZ1bGxfbmFtZSwg
bmFtZSk7DQorICAgICAgIHJldHVybiBfX29mX2Nsa19nZXRfYnlfbmFtZShucCwgbnAtPmZ1bGxf
bmFtZSwgbmFtZSwgZmFsc2UpOw0KIH0NCiBFWFBPUlRfU1lNQk9MKG9mX2Nsa19nZXRfYnlfbmFt
ZSk7DQogDQorLyoqDQorICogb2ZfY2xrX2dldF9ieV9uYW1lX29wdGlvbmFsKCkgLSBQYXJzZSBh
bmQgbG9va3VwIGFuIG9wdGlvbmFsIGNsb2NrIHJlZmVyZW5jZWQNCisgKiBieSBhIGRldmljZSBu
b2RlDQorICogQG5wOiBwb2ludGVyIHRvIGNsb2NrIGNvbnN1bWVyIG5vZGUNCisgKiBAbmFtZTog
bmFtZSBvZiBjb25zdW1lcidzIGNsb2NrIGlucHV0LCBvciBOVUxMIGZvciB0aGUgZmlyc3QgY2xv
Y2sgcmVmZXJlbmNlDQorICoNCisgKiBUaGlzIGZ1bmN0aW9uIHBhcnNlcyB0aGUgY2xvY2tzIGFu
ZCBjbG9jay1uYW1lcyBwcm9wZXJ0aWVzLA0KKyAqIGFuZCB1c2VzIHRoZW0gdG8gbG9vayB1cCB0
aGUgc3RydWN0IGNsayBmcm9tIHRoZSByZWdpc3RlcmVkIGxpc3Qgb2YgY2xvY2sNCisgKiBwcm92
aWRlcnMuDQorICogSXQgYmVoYXZlcyB0aGUgc2FtZSBhcyBvZl9jbGtfZ2V0X2J5X25hbWUoKSwg
ZXhjZXB0IHdoZW4gbm8gY2xvY2sgaXMgZm91bmQuDQorICogSW4gdGhpcyBjYXNlLCBpbnN0ZWFk
IG9mIHJldHVybmluZyAtRU5PRU5ULCBpdCByZXR1cm5zIE5VTEwuDQorICovDQorc3RydWN0IGNs
ayAqb2ZfY2xrX2dldF9ieV9uYW1lX29wdGlvbmFsKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZSkN
Cit7DQorICAgICAgIGlmICghbnApDQorICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVO
T0VOVCk7DQorDQorICAgICAgIHJldHVybiBfX29mX2Nsa19nZXRfYnlfbmFtZShucCwgbnAtPmZ1
bGxfbmFtZSwgbmFtZSwgdHJ1ZSk7DQorfQ0KK0VYUE9SVF9TWU1CT0wob2ZfY2xrX2dldF9ieV9u
YW1lX29wdGlvbmFsKTsNCisNCiAjZWxzZSAvKiBkZWZpbmVkKENPTkZJR19PRikgJiYgZGVmaW5l
ZChDT05GSUdfQ09NTU9OX0NMSykgKi8NCiANCiBzdGF0aWMgc3RydWN0IGNsayAqX19vZl9jbGtf
Z2V0X2J5X25hbWUoc3RydWN0IGRldmljZV9ub2RlICpucCwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpkZXZfaWQsDQotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZSkNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgb3B0aW9uYWwpDQogew0KICAgICAgICBy
ZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiB9DQpAQCAtMjAwLDcgKzIyNiw3IEBAIHN0cnVjdCBj
bGsgKmNsa19nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpjb25faWQpDQogICAg
ICAgIHN0cnVjdCBjbGsgKmNsazsNCiANCiAgICAgICAgaWYgKGRldikgew0KLSAgICAgICAgICAg
ICAgIGNsayA9IF9fb2ZfY2xrX2dldF9ieV9uYW1lKGRldi0+b2Zfbm9kZSwgZGV2X2lkLCBjb25f
aWQpOw0KKyAgICAgICAgICAgICAgIGNsayA9IF9fb2ZfY2xrX2dldF9ieV9uYW1lKGRldi0+b2Zf
bm9kZSwgZGV2X2lkLCBjb25faWQsIGZhbHNlKTsNCiAgICAgICAgICAgICAgICBpZiAoIUlTX0VS
UihjbGspIHx8IFBUUl9FUlIoY2xrKSA9PSAtRVBST0JFX0RFRkVSKQ0KICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGNsazsNCiAgICAgICAgfQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvY2xrLmggYi9pbmNsdWRlL2xpbnV4L2Nsay5oDQppbmRleCA5MDcyMDJiLi44MzAyMDlhIDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9jbGsuaA0KKysrIGIvaW5jbHVkZS9saW51eC9jbGsu
aA0KQEAgLTc3MSw2ICs3NzEsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2xrX2J1bGtfZGlzYWJs
ZV91bnByZXBhcmUoaW50IG51bV9jbGtzLA0KICNpZiBkZWZpbmVkKENPTkZJR19PRikgJiYgZGVm
aW5lZChDT05GSUdfQ09NTU9OX0NMSykNCiBzdHJ1Y3QgY2xrICpvZl9jbGtfZ2V0KHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnAsIGludCBpbmRleCk7DQogc3RydWN0IGNsayAqb2ZfY2xrX2dldF9ieV9u
YW1lKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGNvbnN0IGNoYXIgKm5hbWUpOw0KK3N0cnVjdCBj
bGsgKm9mX2Nsa19nZXRfYnlfbmFtZV9vcHRpb25hbChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBj
b25zdCBjaGFyICpuYW1lKTsNCiBzdHJ1Y3QgY2xrICpvZl9jbGtfZ2V0X2Zyb21fcHJvdmlkZXIo
c3RydWN0IG9mX3BoYW5kbGVfYXJncyAqY2xrc3BlYyk7DQogI2Vsc2UNCiBzdGF0aWMgaW5saW5l
IHN0cnVjdCBjbGsgKm9mX2Nsa19nZXQoc3RydWN0IGRldmljZV9ub2RlICpucCwgaW50IGluZGV4
KQ0KDQotLS0NCkEgbG90IG9mIGRyaXZlcnMgdXNlIGRldm1fY2xrX2dldCgpIHNvIEkgdGhpbmsg
YSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoKQ0KdmVyc2lvbiB3b3VsZCBiZSB1c2VmdWwuIFRoYXQg
d291bGQgcHJvYmFibHkgbmVlZCBhbiBhZGRpdGlvbmFsDQpjbGtfZ2V0X29wdGlvbmFsKCkgZnVu
Y3Rpb24uDQoNClRoYW5rcw0KUGhpbA0KDQo=
