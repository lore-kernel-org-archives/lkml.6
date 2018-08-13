Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC062C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F26215F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="HnA6vuM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F26215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHMFdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:33:53 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.212]:21721 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbeHMFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:33:53 -0400
Received: from [67.219.251.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-west-2.aws.symcld.net id 58/BB-01612-5B2F07B5; Mon, 13 Aug 2018 02:53:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTdxjH97t3CbcdLdpniOgayBRzXVuNuc0
  luv1Vs8zoYmKCLu4KN9rQlqZXIrgYO9HUURuEgXOdFCOIWDRigyiELFtNZL7EMYYhvBglaJSK
  L0MJW2Rmd73qtvvjl8/v+T4v37s8x+C6P6kcRqr0Sz6P6DJSGURpXtLEd814t5mH+1YJ3zUOI
  OGXka8poWfiESWc/LEWCb/3HqWE6roxWjjyOIiE69cGSaHu/gtCGD10GVufYeuJ3KJtLX1TmC
  0e+4ayRa9stoV+eEnYum4GCduzeN4muoh0euzllV+Qjn3Rdsz73FB5arCfDqDrhhqUwei4KQR
  7G2bIGrRAuVxG0DnlV5ng2nE4PM1rSXUY3AveIbTLLQRP6k/SahbFFcBIR5JUhWwugcFkeIBQ
  BZy7gCDU/aHKes4Os79FkcrZXDG0tHXSGlthJh5D2rgCGIoEUnGW2w6JgWpMs+SEF61zqZ4LO
  At01vycYsQtgrmrpzFtlgFG7zanGDgOWvt+xTVeCFOTL0mNl0JtR5jQeAkMNoeQahq4MA4Pxh
  +mk3h42tiYLv4ULjQdoLWkfgSzzfuQJhTC5MEGWnPxGYz+9ZTW4mUQeXyc0ngXzA6fTzfNg1h
  4gtAaxXEYq+5KF+TCpche8hB6L/Kft4ggRuEVcLY3HX4HGkITdCT1YbLgyvd3iWOIiCHB7nOW
  Ovxu0eniLWYzb7FYecuqNbzVbDaJu/hiU4XM75RkP281iTtlk1zlLnaVmDySP46UzXtDeS6i2
  URJAr3NYMaF7KImzzbdm/bykiqHKDt2+CpckpxAuQxjBPYtZUN1WT6pVKr80ulS1veVDEymMZ
  tt+kORWdkrumVnqSZdRe8z0VP19Tgz/6RROcdDh+txHeEp90g5Blan9uPUAkeF53W7Vz/EIFq
  So2eRYlCX6ZV8bqf//3oSGRhk1LPT6thMp8f/empSMYQphspWuFVDfvFfKSeAzlUsju/Z3zcG
  Fz//+6OyrmpBvP38zE8U2X5s046CEzf2ez8YGVr9lcFETs/ppSNbN8Rr226uqwpah4ralgO5d
  rj1rH5l7u5z5g2Fify87nlcDhs3Lz2/OBoWhgLdW8ZbksFlz9Zt/Nb+7p1AvPfjrPCyS/nz1M
  i1T5pj/flsz/KAkZAdoqUQ98niP9dRH4ILBAAA
X-Env-Sender: hehy1@lenovo.com
X-Msg-Ref: server-3.tower-366.messagelabs.com!1534128812!1991374!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11980 invoked from network); 13 Aug 2018 02:53:40 -0000
Received: from unknown (HELO apsmtp03.lenovo.com) (103.30.234.46)
  by server-3.tower-366.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Aug 2018 02:53:40 -0000
Received: from HKGWPEXCH01.lenovo.com (unknown [10.128.62.30]) by apsmtp03.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 496f_ab2b_f82ec8ed_d19d_4f99_b112_6a93d68da6ae;
        Mon, 13 Aug 2018 10:53:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (65.55.88.242) by
 HKGWPEXCH01.lenovo.com (10.128.62.30) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Mon, 13 Aug 2018 10:53:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWt7GoALK3m6UjbKkZPQZT3Ug6s9iu0RsBYAsmubAk4=;
 b=HnA6vuM6U7RICqVCzNPtRnCX+vd/Ea1ZKffW/NpaNHJfA8bFiWNfdF9qcRcf/bJDBaiboY14j7+GzoyVvu9YPB07EMwP49CS+hb8TpirUy27+6ixsFOfGctdUuHzuO1HNGS4CiYuLwHPSOdSUNdTeFpy7mIzn0Gy9LlXwT7FcGE=
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com (52.133.151.140) by
 HK0PR03MB2788.apcprd03.prod.outlook.com (52.133.210.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.14; Mon, 13 Aug 2018 02:53:24 +0000
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::31fa:fa7:383b:2c63]) by HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::31fa:fa7:383b:2c63%5]) with mapi id 15.20.1059.013; Mon, 13 Aug 2018
 02:53:24 +0000
From:   Ocean HY1 He <hehy1@lenovo.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH v2] ACPI: nfit: remove redundant
 assignment if nfit_mem found
Thread-Topic: [External]  Re: [PATCH v2] ACPI: nfit: remove redundant
 assignment if nfit_mem found
Thread-Index: AQHUMQRNzeyQdSQkyk6K+DfVvnpfV6S8/e9w
Date:   Mon, 13 Aug 2018 02:53:24 +0000
Message-ID: <HK0PR03MB31708EFDDA3F29C4A697956889390@HK0PR03MB3170.apcprd03.prod.outlook.com>
References: <1533199444-29607-1-git-send-email-oceanhehy@gmail.com>
 <1533944734.6054.38.camel@intel.com>
In-Reply-To: <1533944734.6054.38.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB2788;20:obhgRhmEdovULSpprJhuqoRz17JQ2NohFr5g+ZClKTAdMUhtygVRQswiPwfTGD29/yDznbaOZQ3eN1EQrpAawc4Kjw4/qQ0pciVeZqFL/WTtXSH8FdvfJHwDLaVljnGWyiJLKrFyflhNGzSSbxsGEGM1CoNuP35ZRSK69UGAwoWB4JFZAF+Fun/60qL+DEoNSt6AcL/dPr2FBba3cKUF83/pD8NLeZdMD9qQd5SQN8wuw4qCfzT+3qP3m/2uSkxq2QBNGF5CML7757BcSXSr3JHvqmHtpGxWU8r1QCOF5huHNG5+/ZUPnuw57UDgioF632KVFbgcv46zSKXOU69STQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3070a64d-0610-47b8-c429-08d600c7f02b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB2788;
x-ms-traffictypediagnostic: HK0PR03MB2788:
x-microsoft-antispam-prvs: <HK0PR03MB27882A41680B4CEA1D66619E89390@HK0PR03MB2788.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(9452136761055)(85827821059158)(162533806227266)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HK0PR03MB2788;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB2788;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39840400004)(13464003)(199004)(189003)(26005)(76176011)(2501003)(5250100002)(99286004)(4326008)(7696005)(105586002)(81166006)(8676002)(81156014)(106356001)(86362001)(39060400002)(102836004)(2201001)(6306002)(7416002)(55016002)(476003)(229853002)(316002)(33656002)(25786009)(110136005)(54906003)(6436002)(446003)(186003)(486006)(9686003)(11346002)(256004)(97736004)(2906002)(2900100001)(478600001)(966005)(14454004)(8936002)(66066001)(6116002)(6506007)(5660300001)(6246003)(53936002)(7736002)(68736007)(74316002)(3846002)(53546011)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB2788;H:HK0PR03MB3170.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (HKGWPEXCH01.lenovo.com: hehy1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AZewS+JUHDQ+JKDfO3CaRDOcGrrSrBxYYD9yknoLfZ02aEjAIYyjGfAdHVlKWUD+9oPGEifi4W50CQHV/7AjaAffnj51D4LbT9sEFC39OIgnYmyT35eFPEqLm//tDywygbS1IQBaQPHixuqZSmPESSqdi4yzvaxVZ7WiFQL4mS1eRvkzrbSOxrpZIMc4EB4hSsWHGoCmAgGBMBXo3LgCOwZFjkuODCQFZILec1Fa6zlyDxx20OoKUcrXmgUP/LQcbaqK5ujyRz0bhymU8v/rFdBlLP6e22bCL9cYIMOyYgZ8Fj9sVaEg4i7Hvj+gEVRhdfR6ibcTGKbI88xrzO0O+ex/IrjPhb0xBY5DU09JJfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3070a64d-0610-47b8-c429-08d600c7f02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 02:53:24.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmVybWEsIFZpc2hhbCBM
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMTEs
IDIwMTggNzo0NiBBTQ0KPiBUbzogV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRl
bC5jb20+OyByb3NzLnp3aXNsZXJAbGludXguaW50ZWwuY29tOw0KPiBvY2VhbmhlaHlAZ21haWwu
Y29tOyBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBsZW5iQGtlcm5lbC5vcmc7
DQo+IHJqd0Byand5c29ja2kubmV0DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IE9jZWFuIEhZMSBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gU3ViamVjdDogW0V4dGVybmFs
XSBSZTogW1BBVENIIHYyXSBBQ1BJOiBuZml0OiByZW1vdmUgcmVkdW5kYW50IGFzc2lnbm1lbnQg
aWYNCj4gbmZpdF9tZW0gZm91bmQNCj4gDQo+IA0KPiBPbiBUaHUsIDIwMTgtMDgtMDIgYXQgMDQ6
NDQgLTA0MDAsIG9jZWFuaGVoeUBnbWFpbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogT2NlYW4gSGUg
PGhlaHkxQGxlbm92by5jb20+DQo+ID4NCj4gPiBXaGVuIG5maXRfbWVtIGlzIGZvdW5kIHZpYSBs
aXN0X2Zvcl9lYWNoX2VudHJ5LCBpdCBoYXMgYWxyZWFkeSBiZWVuDQo+ID4gYXNzaWduZWQgdmFs
aWQgdmFsdWUuIFRoZXJlIGlzIG5vIG5lZWQgdG8gYXNzaWduIGl0IGFnYWluIGluIHRoZQ0KPiA+
IGZvbGxvd2luZw0KPiA+IGNvZGVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogT2NlYW4gSGUg
PGhlaHkxQGxlbm92by5jb20+DQo+ID4gLS0tDQo+ID4gdjE6IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTA1NTMyNzcvDQo+ID4gdjI6IFNvcnJ5IGZvciBub2lzZS4gSSBnb3Qg
YW4gZW1haWwgcHJvYmxlbSwgc28gSSBoYXZlIHRvIHJlc2VuZCB0bw0KPiA+IGxvb3ANCj4gPiBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnLg0KPiA+DQo+ID4gIGRyaXZlcnMvYWNwaS9uZml0L2Nv
cmUuYyB8IDQgKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5j
IGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+ID4gaW5kZXggN2M0NzkwMC4uODVkZGU1NCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gPiArKysgYi9kcml2
ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gPiBAQCAtMTA0OCw5ICsxMDQ4LDcgQEAgc3RhdGljIGlu
dCBfX25maXRfbWVtX2luaXQoc3RydWN0DQo+ID4gYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYywN
Cj4gPiAgCQkJCWJyZWFrOw0KPiA+ICAJCQl9DQo+ID4NCj4gPiAtCQlpZiAoZm91bmQpDQo+ID4g
LQkJCW5maXRfbWVtID0gZm91bmQ7DQo+ID4gLQkJZWxzZSB7DQo+ID4gKwkJaWYgKCFmb3VuZCkg
ew0KPiANCj4gSGkgT2NlYW4sDQo+IA0KPiBXaGlsZSB0aGlzIGlzIHRlY2huaWNhbGx5IGNvcnJl
Y3QsIHRoZSBvbGQgd2F5IHdhcyBlYXNpZXIgdG8gcmVhZC4gV2UNCj4gbG9vcCB0aHJvdWdoIGFu
ZCBmaW5kIHRoZSBtYXRjaGluZyBoYW5kbGUuIElmIHdlIGZvdW5kIG9uZSwgdGhlbg0KPiBuZml0
X21lbSB3YXMgd2hhdGV2ZXIgd2FzIGZvdW5kLiBJZiBub3QsIHdlIGFsbG9jYXRlIGl0Lg0KPiAN
Cj4gV2l0aCB0aGlzIGNoYW5nZSwgb25lIGhhcyB0byBnbyBncm9rIHRoZSBsaXN0X2Zvcl8uLiBs
b29wIHRvIGZpZ3VyZSBvdXQNCj4gd2hlcmUgbmZpdF9tZW0gaXMgY29taW5nIGZyb20uIEknZCBw
ZXJzb25hbGx5IHByZWZlciB0byBrZWVwIHRoZQ0KPiBleGlzdGluZyB3YXkuLg0KPiANCkhpIFZl
cm1hLA0KDQpZb3UncmUgcmlnaHQgdGhhdCBpdCB0b29rIG1lIHNvbWUgdGltZSB0byBmaW5kIG91
dCB3aGVyZSBuZml0X21lbQ0Kd2FzIGZvdW5kLCB3aGVuIEkgbG9vayB0aGVzZSBjb2RlcyBhdCBm
aXJzdC4NCg0KSXQncyByZWFzb25hYmxlIHRvIGtlZXAgdGhlIGV4aXN0aW5nIHdheSBmb3Igd2Vs
bCByZWFkYWJpbGl0eS4NCg0KVGhhbmtzLA0KT2NlYW4uDQo+ID4gIAkJCW5maXRfbWVtID0gZGV2
bV9remFsbG9jKGFjcGlfZGVzYy0+ZGV2LA0KPiA+ICAJCQkJCXNpemVvZigqbmZpdF9tZW0pLA0K
PiA+IEdGUF9LRVJORUwpOw0KPiA+ICAJCQlpZiAoIW5maXRfbWVtKQ0K
