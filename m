Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F868FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9320881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Z/5tWHtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeG3K71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:59:27 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:62886 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbeG3K70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:59:26 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 30 Jul 2018 18:25:19 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 2345E7DBA1;
        Mon, 30 Jul 2018 18:25:19 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,422,1526310000"; 
   d="scan'208";a="286790067"
Received: from mail-os2jpn01lp0147.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.147])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 30 Jul 2018 18:25:18 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9w2NWERnz91XERJaVZsxEg+NuP08ZHAqp6VYZ6XFq8=;
 b=Z/5tWHtVIklwq9dINHhB+p91HgtrcmQA44MplEC/17BbvmIB5brxqvD7H/rYcUCn4NG+UYXta2am31Ww6L4uRRooR9NJ+c4mmOG3R5CZBrcGKJt2150AMPOBJL+BNHUkO5tB5445ZV4a+RvnUUWEGCc43NeuyFh/aW/AnWCoVMY=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0064.jpnprd01.prod.outlook.com (10.161.133.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Mon, 30 Jul 2018 09:25:14 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8%4]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 09:25:13 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Topic: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Index: AQHUJ+BrgDRV4XPe7UaQMWUF9ALkgqSndnyAgAAFtEA=
Date:   Mon, 30 Jul 2018 09:25:13 +0000
Message-ID: <TY1PR01MB17696DB07249128850A58572F52F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
 <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
In-Reply-To: <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0064;20:prjlNPMh8S+Ak9FazgRZmwt3soB+tfuGuR2BApTXJTbF7q/4Kyx4bFNfXfTga5HXvoziSr+JFOl1nO/mon7aEpgtzJEKhpl6mnzbQ67E+mOjSxu2S6GX5fLfG3CXPa3S+/GuJe8E9ldhcwjll3MTt9PRYpHPSz55cS80zF9tZ0c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 36f0caf7-ef43-48a9-56ce-08d5f5fe5ad6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0064;
x-ms-traffictypediagnostic: TY1PR01MB0064:
x-microsoft-antispam-prvs: <TY1PR01MB0064FFBDBBDD9B233E23140AF52F0@TY1PR01MB0064.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0064;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0064;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(74316002)(105586002)(102836004)(106356001)(3846002)(6116002)(33656002)(9686003)(478600001)(186003)(55016002)(25786009)(229853002)(81166006)(81156014)(8676002)(5250100002)(6436002)(76176011)(97736004)(5660300001)(99286004)(44832011)(6506007)(53546011)(6246003)(305945005)(26005)(66066001)(6916009)(316002)(14454004)(486006)(7736002)(53936002)(54906003)(2906002)(476003)(4326008)(86362001)(68736007)(8936002)(7696005)(2900100001)(446003)(11346002)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0064;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KaoT33h8U9hJbHmf5vY9nOSc3CjWzpIrSjZqoRr1AUST3k9NAPuxK7cE1hWfOBBBcnfO9gMdo1remU33QwTpI/WdBhgdg9TTfSmqxmRXAEtwyWk/lP47ncLxa7+40RIKIyr3v31n882MokScXfMp36D8u2tRxBXfYL/RfIJ0FvwA/GHmOXArnpvXou+BrCduIPrJC2Gm4H6OhZGH3Qmx/eNzqlsSxpaAOaNnQhReORzSfdQFqOfggPscuvBBOmwS0Y3KzKqiryGlyhncvm2v4zjpzbnMTY10LlA5kgCLqQkEOzZssfSLYjj+OxmT5lypqbWzyU/fH1fXv7G0sPsYIjbTSITPDX+tJI5RnMD9WtU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f0caf7-ef43-48a9-56ce-08d5f5fe5ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 09:25:13.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDMwIEp1bHkgMjAxOCAwOTo1NiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBPbiBNb24sIEp1bCAzMCwgMjAxOCBhdCAxMDozNiBBTSBQaGlsIEVkd29ydGh5IHdy
b3RlOg0KPiA+IFF1aXRlIGEgZmV3IGRyaXZlcnMgZ2V0IGFuIG9wdGlvbmFsIGNsb2NrLCBlLmcu
IGEgY2xvY2sgcmVxdWlyZWQgdG8NCj4gPiBhY2Nlc3MgcGVyaXBoZXJhbCdzIHJlZ2lzdGVycyB0
aGF0IGlzIGFsd2F5cyBlbmFibGVkIG9uIHNvbWUgZGV2aWNlcy4NCj4gPg0KPiA+IFRoaXMgZnVu
Y3Rpb24gYmVoYXZlcyB0aGUgc2FtZSBhcyBvZl9jbGtfZ2V0X2J5X25hbWUoKSBleGNlcHQgdGhh
dCBpdA0KPiA+IHdpbGwgcmV0dXJuIE5VTEwgaW5zdGVhZCBvZiAtRU5PRU5ULiBUaGlzIG1ha2Vz
IGVycm9yIGNoZWNraW5nIGZvcg0KPiA+IHVzZXJzIGVhc2llciBhbmQgYWxsb3dzIGNsa19wcmVw
YXJlX2VuYWJsZSwgZXRjIHRvIGJlIGNhbGxlZCBvbiB0aGUNCj4gPiByZXR1cm5lZCByZWZlcmVu
Y2Ugd2l0aG91dCBhZGRpdGlvbmFsIGNoZWNrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBo
aWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsa2Rldi5jDQo+ID4gKysr
IGIvZHJpdmVycy9jbGsvY2xrZGV2LmMNCj4gPiBAQCAtNTQsNyArNTQsOCBAQCBFWFBPUlRfU1lN
Qk9MKG9mX2Nsa19nZXQpOw0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgY2xrICpfX29mX2Nsa19n
ZXRfYnlfbmFtZShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpkZXZfaWQsDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgb3B0aW9uYWwp
DQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBjbGsgKmNsayA9IEVSUl9QVFIoLUVOT0VOVCk7
DQo+ID4NCj4gPiBAQCAtNzMsNiArNzQsOCBAQCBzdGF0aWMgc3RydWN0IGNsayAqX19vZl9jbGtf
Z2V0X2J5X25hbWUoc3RydWN0DQo+IGRldmljZV9ub2RlICpucCwNCj4gPiAgICAgICAgICAgICAg
ICAgaWYgKCFJU19FUlIoY2xrKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKG5hbWUgJiYgaW5kZXggPj0gMCkgew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChvcHRpb25hbCAmJiBQVFJfRVJSKGNsaykg
PT0gLUVOT0VOVCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsayA9IE5V
TEw7DQo+IA0KPiBUaGlzIG9ubHkgaGFuZGxlcyB0aGUgIm5hbWUgJiYgaW5kZXggPj0gMCIgY2Fz
ZS4NCj4gSWYgdGhhdCBjb25kaXRpb24gaXMgbmV2ZXIgdHJ1ZSwgdGhlIGxvb3Agd2lsbCBlbmQs
IGV2ZW50dWFsbHksIGFuZCB0aGUgbGFzdCB2YWx1ZQ0KPiBvZiBjbGsgd2lsbCBiZSByZXR1cm5l
ZC4gSGVuY2UgdGhlcmUgc2hvdWxkIGJlIGEgc2ltaWxhciBjaGVjayBhdCB0aGUgZW5kIG9mDQo+
IHRoZSBmdW5jdGlvbi4NCk9vcHMsIEkgd2FzIG9ubHkgY29uc2lkZXJpbmcgbmFtZWQgb3B0aW9u
YWwgY2xvY2tzLCBJJ2xsIGZpeCB0aGlzLg0KDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKFBUUl9FUlIoY2xrKSAhPSAtRVBST0JFX0RFRkVSKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHJfZXJyKCJFUlJPUjogY291bGQgbm90IGdldCBjbG9jayAlcE9GOiVz
KCVpKVxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnAs
IG5hbWUgPyBuYW1lIDogIiIsIGluZGV4KTsNCj4gDQo+IEhlbmNlIGlmIG5vdCBmb3VuZCwgdGhp
cyB3aWxsIGFsd2F5cyBwcmludCBhbiBlcnJvciwgZXZlbiBpZiB0aGUgY2xvY2sgaXMNCj4gb3B0
aW9uYWw/DQpSaWdodC4NCg0KPiA+IEBAIC0xMDYsMTUgKzEwOSwzOCBAQCBzdHJ1Y3QgY2xrICpv
Zl9jbGtfZ2V0X2J5X25hbWUoc3RydWN0DQo+IGRldmljZV9ub2RlICpucCwgY29uc3QgY2hhciAq
bmFtZSkNCj4gPiAgICAgICAgIGlmICghbnApDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBF
UlJfUFRSKC1FTk9FTlQpOw0KPiA+DQo+ID4gLSAgICAgICByZXR1cm4gX19vZl9jbGtfZ2V0X2J5
X25hbWUobnAsIG5wLT5mdWxsX25hbWUsIG5hbWUpOw0KPiA+ICsgICAgICAgcmV0dXJuIF9fb2Zf
Y2xrX2dldF9ieV9uYW1lKG5wLCBucC0+ZnVsbF9uYW1lLCBuYW1lLCBmYWxzZSk7DQo+ID4gIH0N
Cj4gPiAgRVhQT1JUX1NZTUJPTChvZl9jbGtfZ2V0X2J5X25hbWUpOw0KPiA+DQo+ID4gKy8qKg0K
PiA+ICsgKiBvZl9jbGtfZ2V0X2J5X25hbWVfb3B0aW9uYWwoKSAtIFBhcnNlIGFuZCBsb29rdXAg
YW4gb3B0aW9uYWwgY2xvY2sNCj4gPiArcmVmZXJlbmNlZA0KPiA+ICsgKiBieSBhIGRldmljZSBu
b2RlDQo+ID4gKyAqIEBucDogcG9pbnRlciB0byBjbG9jayBjb25zdW1lciBub2RlDQo+ID4gKyAq
IEBuYW1lOiBuYW1lIG9mIGNvbnN1bWVyJ3MgY2xvY2sgaW5wdXQsIG9yIE5VTEwgZm9yIHRoZSBm
aXJzdCBjbG9jaw0KPiA+ICtyZWZlcmVuY2UNCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlv
biBwYXJzZXMgdGhlIGNsb2NrcyBhbmQgY2xvY2stbmFtZXMgcHJvcGVydGllcywNCj4gPiArICog
YW5kIHVzZXMgdGhlbSB0byBsb29rIHVwIHRoZSBzdHJ1Y3QgY2xrIGZyb20gdGhlIHJlZ2lzdGVy
ZWQgbGlzdA0KPiA+ICtvZiBjbG9jaw0KPiA+ICsgKiBwcm92aWRlcnMuDQo+ID4gKyAqIEl0IGJl
aGF2ZXMgdGhlIHNhbWUgYXMgb2ZfY2xrX2dldF9ieV9uYW1lKCksIGV4Y2VwdCB3aGVuIG5vIGNs
b2NrIGlzDQo+IGZvdW5kLg0KPiA+ICsgKiBJbiB0aGlzIGNhc2UsIGluc3RlYWQgb2YgcmV0dXJu
aW5nIC1FTk9FTlQsIGl0IHJldHVybnMgTlVMTC4NCj4gPiArICovDQo+ID4gK3N0cnVjdCBjbGsg
Km9mX2Nsa19nZXRfYnlfbmFtZV9vcHRpb25hbChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1l
KSB7DQo+ID4gKyAgICAgICBpZiAoIW5wKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJS
X1BUUigtRU5PRU5UKTsNCj4gDQo+IFNob3VsZG4ndCB0aGlzIHJldHVybiBOVUxMPw0KSSB3YXNu
4oCZdCBzdXJlIG9uIHRoaXMsIEkgdGhvdWdodCB0aGUgbm9kZSBzaG91bGQgYmUgdmFsaWQsIGJ1
dCBJIGd1ZXNzIHRoZSBub2RlDQppcyBhbHNvIG9wdGlvbmFsLiBJJ2xsIGZpeC4NCg0KPiBPciBs
ZXQgX19vZl9jbGtfZ2V0X2J5X25hbWUoKSBoYW5kbGUgdGhhdCAoY2ZyLiBhYm92ZSk/DQoNCj4g
SG1tLCBvZl9jbGtfZ2V0X2J5X25hbWUoKSBoYXMgYSBzaW1pbGFyIGNoZWNrLCB3aGlsZSB0aGUg
Y3VycmVudA0KPiBfX29mX2Nsa19nZXRfYnlfbmFtZSgpIGFscmVhZHkgaGFuZGxlIG5wID09IE5V
TEwsIHRvby4NClllcyBJIHNlZSwgSSdsbCBjbGVhbiB0aGF0IHVwLg0KDQogDQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIF9fb2ZfY2xrX2dldF9ieV9uYW1lKG5wLCBucC0+ZnVsbF9uYW1lLCBu
YW1lLCB0cnVlKTsgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKG9mX2Nsa19nZXRfYnlfbmFtZV9vcHRp
b25hbCk7DQo+ID4gKw0KPiA+ICAjZWxzZSAvKiBkZWZpbmVkKENPTkZJR19PRikgJiYgZGVmaW5l
ZChDT05GSUdfQ09NTU9OX0NMSykgKi8NCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IGNsayAqX19v
Zl9jbGtfZ2V0X2J5X25hbWUoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZGV2X2lkLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpu
YW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG9w
dGlvbmFsKQ0KPiA+ICB7DQo+ID4gICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCj4g
PiAgfQ0KPiA+IEBAIC0xOTcsNyArMjIzLDcgQEAgc3RydWN0IGNsayAqY2xrX2dldChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIGNvbnN0IGNoYXINCj4gKmNvbl9pZCkNCj4gPiAgICAgICAgIHN0cnVjdCBj
bGsgKmNsazsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGRldiAmJiBkZXYtPm9mX25vZGUpIHsNCj4g
PiAtICAgICAgICAgICAgICAgY2xrID0gX19vZl9jbGtfZ2V0X2J5X25hbWUoZGV2LT5vZl9ub2Rl
LCBkZXZfaWQsIGNvbl9pZCk7DQo+ID4gKyAgICAgICAgICAgICAgIGNsayA9IF9fb2ZfY2xrX2dl
dF9ieV9uYW1lKGRldi0+b2Zfbm9kZSwgZGV2X2lkLA0KPiA+ICsgY29uX2lkLCBmYWxzZSk7DQo+
ID4gICAgICAgICAgICAgICAgIGlmICghSVNfRVJSKGNsaykgfHwgUFRSX0VSUihjbGspID09IC1F
UFJPQkVfREVGRVIpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGNsazsNCj4g
PiAgICAgICAgIH0NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jbGsuaCBiL2luY2x1
ZGUvbGludXgvY2xrLmggaW5kZXgNCj4gPiA0Zjc1MGM0Li44Y2I1NDU1IDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvY2xrLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Nsay5oDQo+
ID4gQEAgLTc3Nyw2ICs3NzcsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2xrX2J1bGtfZGlzYWJs
ZV91bnByZXBhcmUoaW50DQo+ID4gbnVtX2Nsa3MsICAjaWYgZGVmaW5lZChDT05GSUdfT0YpICYm
IGRlZmluZWQoQ09ORklHX0NPTU1PTl9DTEspDQo+ID4gc3RydWN0IGNsayAqb2ZfY2xrX2dldChz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBpbnQgaW5kZXgpOyAgc3RydWN0IGNsaw0KPiA+ICpvZl9j
bGtfZ2V0X2J5X25hbWUoc3RydWN0IGRldmljZV9ub2RlICpucCwgY29uc3QgY2hhciAqbmFtZSk7
DQo+ID4gK3N0cnVjdCBjbGsgKm9mX2Nsa19nZXRfYnlfbmFtZV9vcHRpb25hbChzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wLCBjb25zdA0KPiA+ICtjaGFyICpuYW1lKTsNCj4gPiAgc3RydWN0IGNsayAq
b2ZfY2xrX2dldF9mcm9tX3Byb3ZpZGVyKHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MNCj4gPiAqY2xr
c3BlYyk7ICAjZWxzZSAgc3RhdGljIGlubGluZSBzdHJ1Y3QgY2xrICpvZl9jbGtfZ2V0KHN0cnVj
dA0KPiA+IGRldmljZV9ub2RlICpucCwgaW50IGluZGV4KQ0KPiANCj4gTm8gZHVtbXkgdmVyc2lv
biBvZiBvZl9jbGtfZ2V0X2J5X25hbWVfb3B0aW9uYWwoKSBmb3IgdGhlICFDTEsgfHwNCj4gIUNP
TU1PTl9DTEsgY2FzZT8NCj4gDQo+IEl0IHNlZW1zIG9mX2Nsa19nZXRfYnlfbmFtZSgpIGFuZCBv
Zl9jbGtfZ2V0X2J5X25hbWVfb3B0aW9uYWwoKSBjYW4NCj4ganVzdCBiZSBzaW1wbGUgd3JhcHBl
cnMgYXJvdW5kIF9fb2ZfY2xrX2dldF9ieV9uYW1lKCksIGRpZmZlcmluZyBvbmx5IGluDQo+IHRo
ZSB2YWx1ZSBvZiB0aGUgIm9wdGlvbmFsIiBwYXJhbWV0ZXIuIEhlbmNlIEkgdGhpbmsgaXQgbWFr
ZXMgc2Vuc2UgdG8gbW92ZQ0KPiB0aGVtIHRvIHRoZSBoZWFkZXIgZmlsZSwgYW5kIG1ha2UgdGhl
bSBzdGF0aWMgaW5saW5lLg0KPiBUaGVuIG9ubHkgX19vZl9jbGtfZ2V0X2J5X25hbWUoKSBuZWVk
cyBhIChzdGF0aWMgaW5saW5lKSBkdW1teSBmb3IgdGhlDQo+ICFPRiB8fCAhQ09NTU9OX0NMSyBj
YXNlLg0KTWFrZXMgc2Vuc2UuDQoNClRoYW5rcyENClBoaWwNCg0K
