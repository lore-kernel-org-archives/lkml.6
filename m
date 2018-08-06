Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02058C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993AF219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="bJbQHuW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993AF219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeHFJXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:23:14 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:29690 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbeHFJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:23:14 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id EC/97-01623-195F76B5; Mon, 06 Aug 2018 07:15:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTa0wTWRT2dh4dCWOGgsuRFdSqCZpMlyLG+bG
  JGxOy1c0mPhJNRKNTGdtmSyGdYQFNDPjGpilVuqyABaJRAaOxPhBtiKlSX7s+MG4DVrIEjAEi
  Kj5JWXdnOvWx98fJd+53vvO4OZfCdLu1GZRQLglOB2/Xk0m4JWvEwHrfWgpyLjbquTrffcTd7
  K0iuc6B5yR3osuDuIeXG0lul/exlvt9bB/i/rjTQ3DeZzGc66sJa35IMnXWP9GajgaHNaZAWz
  Vp8t9aZXI1fMRN5x/tw02vA1krtesJm8NcXL6ZsO4JtZAlQ9nljd4OohI1Zx9ASZSOGUHw7M4
  ppDrXEfSHe7WKgzMnMThZPY6pTI0GGvrPEQfQVNmJIqj606hgkpkPve0jhBKUxoQ0MOi+jysE
  xnQgcF38XsGpzGbovB6Ji9MYHppfxbQqzoXHkTFSwTgzD/bv/1ejYJrZAJ7Te0i1mA2Ch1sxB
  U9ljHBl9F1ci5hv4P3tUxq1Vjr0DTXFMTAMHAvew1Q8HYYHPxIqngWedjeu4kzoaXLFZwbGjc
  G77nBCzMJLny8h/hmOhMYJNegGgufhc4mghdA/3o2pXayGvomXWvX+F/irJZgQb4O3kQuJyln
  Q5h7A1UQBDP72+GQBJTszobVrRQ36rv6rIeplBmMWwJnLies5UOsa0NbH3yUFbh0ewpsR3oY4
  s9NmsUpFvM3OGnNyWKMxlzUuymNzczgDv401G0pFtkwQJTbXwJeJBrGiaIu90OAQpACSN2+Kf
  C6hR6HCEJpBafTT6Y0RS4Fumrm4sMLKi9ZNzlK7IIbQTIrSA62RN1SX4hQsQvlWm11e3080UM
  n6NHrwjUzTYglfJNosKnUb5VP+1oMHMcrf7ZPt5AvFdrl+k21UsTrcUewQMtLpiCJmFLG11PE
  59afP0YMyM1JpJDerSy4RnEU26f/8CEqnkD6VfqJkSbY5pM8dyGstz5VGb88TlOYk/guVUYna
  68iyiZhL+MfSmd+QP1oVmvxwtWL5vW/JoLc7ZefsuW7peCjsF+3UJv+65iuv1gWwB+bJNVH8p
  6PhBS8kXZ5r97K1/l0xz+hwnWn95N1a59nqrsK1S9401hLQdKLsWuxMpu5p8uJr0Y670umlh4
  Z/3Ytl7xgsmBhbVvnjxuj7fj0uWnnjQswp8v8BeBhEGBcEAAA=
X-Env-Sender: hehy1@lenovo.com
X-Msg-Ref: server-30.tower-346.messagelabs.com!1533539720!1732836!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16387 invoked from network); 6 Aug 2018 07:15:29 -0000
Received: from unknown (HELO mapsmtp01.lenovo.com) (103.30.234.46)
  by server-30.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Aug 2018 07:15:29 -0000
Received: from HKGWPEXCH01.lenovo.com (unknown [10.128.62.30]) by mapsmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 6a05_2a25_ff8407eb_aa08_425b_83f3_329e548c0ead;
        Mon, 06 Aug 2018 15:15:19 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.24) by
 HKGWPEXCH01.lenovo.com (10.128.62.30) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Mon, 6 Aug 2018 15:15:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW+yuGtBWgxNXRSIY+PTPSHz3nZ0uNpMuH4lErvkit4=;
 b=bJbQHuW8nKQ+jUQoZ5ouiRZ9DqPD+AFhwaodyFmPocOyGvRtk50Hl1JN6GuYGGHBPxFTrTlbgM9MmSjji3A8+FoP6uZlD4bmDUL8Ry6akv3laGxuTyCuo0zBJoeXKoXbMJwIu4ivBSOmqZQiWFL+WPnyIqCLBrx4u13gQby4P4I=
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com (52.133.151.140) by
 HK0PR03MB3827.apcprd03.prod.outlook.com (20.177.70.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.10; Mon, 6 Aug 2018 07:15:16 +0000
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::31fa:fa7:383b:2c63]) by HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::31fa:fa7:383b:2c63%5]) with mapi id 15.20.1038.013; Mon, 6 Aug 2018
 07:15:16 +0000
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
Subject: RE: [External]  Re: [PATCH] ACPI: nfit: return -ENODEV if fail to
 find NFIT at startup
Thread-Topic: [External]  Re: [PATCH] ACPI: nfit: return -ENODEV if fail to
 find NFIT at startup
Thread-Index: AQHUK00fTvV+jsB5uk2bSpNTWMxItqSyU5ow
Date:   Mon, 6 Aug 2018 07:15:16 +0000
Message-ID: <HK0PR03MB3170E6D5D62D14B02F39FAE089200@HK0PR03MB3170.apcprd03.prod.outlook.com>
References: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
 <1533316299.8557.71.camel@intel.com>
In-Reply-To: <1533316299.8557.71.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB3827;20:cZOwHWNL81QqnQwSlqDSfI+HHnUe1ZwM3pgO8WyBackfpd1U9xQUExJoxPPKyIeJ4ei2CDU7Sjzhlw8jp5cFsC7LwdbcH63pv5tCl31IdZCvAFC4Vc6rgmscDksulDdT6X3TiQ4MbR0ZdEShTtVOLK2IzZPIv1ZfA0fGPrlO0Cy+eTZBxpHPsT7148DOUSutGgZZMZBsJGCVCHjKdLNi/9RN4aw3Msgirqja/hqp2v+StuRNURoaZ7/qPmtsVxM4OcfgQYoaB4xqoenr03LI3nviVx0L9EIIC7uQKxSMVYsrXbB54ZBFi4sd/WEOGIsX/Y46nx30jYJh0jFHL5zm1w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 637d9128-50f3-4d1c-5109-08d5fb6c5c76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB3827;
x-ms-traffictypediagnostic: HK0PR03MB3827:
x-microsoft-antispam-prvs: <HK0PR03MB3827782213EA731AA3B43F3A89200@HK0PR03MB3827.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(9452136761055)(85827821059158)(162533806227266)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HK0PR03MB3827;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB3827;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(13464003)(476003)(6246003)(8676002)(39060400002)(81166006)(4326008)(14454004)(7696005)(76176011)(26005)(2906002)(81156014)(66066001)(5250100002)(6436002)(74316002)(54906003)(446003)(53936002)(9686003)(11346002)(55016002)(305945005)(186003)(110136005)(5660300001)(25786009)(256004)(99286004)(316002)(486006)(7416002)(7736002)(102836004)(6506007)(53546011)(478600001)(33656002)(86362001)(2201001)(105586002)(2900100001)(8936002)(106356001)(97736004)(68736007)(6116002)(2501003)(229853002)(3846002)(5024004)(14444005)(37363001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB3827;H:HK0PR03MB3170.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (HKGWPEXCH01.lenovo.com: hehy1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5gECPURTz2gw+2qO889Fg7yh2x7FgeNoaf04Ao8BAPnjGzEJvDb6anGaQBr2DrvNwJO/Tqve4NoshhIrOgLVrpy6v3nZLZo94x8FB2GBI4tSLeYN7fpNAhM3IS07C2KfpzW8Ndz1rBM8fL4yt58YH+/DnADuwIxZFJwH2rw62rlSninGs+Wi2uzHpVSFFZjmE+a6tLkRkbZe44jgzOb5oN2X+ipp17hXSOq7WBTlVHyJiWL/3DqTT1GiZeWlJn4S0nEF3atAbNGKJEUK5/m48kMaW4W7gGurQ85g+/I1hxnRfOH2O40H087k0/DJqBrZM2vq9UbI7wH+nbK2Oz9ZKfhmy+ykZByWmity1vUYeOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 637d9128-50f3-4d1c-5109-08d5fb6c5c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 07:15:16.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3827
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmVybWEsIFZpc2hhbCBM
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMDQs
IDIwMTggMToxMiBBTQ0KPiBUbzogV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRl
bC5jb20+OyByb3NzLnp3aXNsZXJAbGludXguaW50ZWwuY29tOw0KPiBvY2VhbmhlaHlAZ21haWwu
Y29tOyBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBsZW5iQGtlcm5lbC5vcmc7
DQo+IHJqd0Byand5c29ja2kubmV0DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IE9jZWFuIEhZMSBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gU3ViamVjdDogW0V4dGVybmFs
XSBSZTogW1BBVENIXSBBQ1BJOiBuZml0OiByZXR1cm4gLUVOT0RFViBpZiBmYWlsIHRvIGZpbmQg
TkZJVCBhdA0KPiBzdGFydHVwDQo+IA0KPiANCj4gT24gRnJpLCAyMDE4LTA4LTAzIGF0IDA1OjM5
IC0wNDAwLCBPY2VhbiBIZSB3cm90ZToNCj4gPiBGcm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3Zv
LmNvbT4NCj4gPg0KPiA+IEluIHRoZSBiZWdpbm5pbmcgb2YgYWNwaV9uZml0X2FkZCwgaWYgZmFp
bCB0byBmaW5kIE5GSVQgdGFibGUgdGhlbg0KPiA+IHNob3VsZA0KPiA+IHJldHVybiAtRU5PREVW
LCBpbnN0ZWFkIG9mIDAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBPY2VhbiBIZSA8aGVoeTFA
bGVub3ZvLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL25maXQvY29yZS5jIHwgMiAr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgYi9kcml2ZXJzL2Fj
cGkvbmZpdC9jb3JlLmMNCj4gPiBpbmRleCA3YzQ3OTAwLi4xNzkwZDdjIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9uZml0
L2NvcmUuYw0KPiA+IEBAIC0zMzU1LDcgKzMzNTUsNyBAQCBzdGF0aWMgaW50IGFjcGlfbmZpdF9h
ZGQoc3RydWN0IGFjcGlfZGV2aWNlDQo+ID4gKmFkZXYpDQo+ID4gIAlpZiAoQUNQSV9GQUlMVVJF
KHN0YXR1cykpIHsNCj4gPiAgCQkvKiBUaGlzIGlzIG9rLCB3ZSBjb3VsZCBoYXZlIGFuIG52ZGlt
bSBob3RwbHVnZ2VkDQo+ID4gbGF0ZXIgKi8NCj4gPiAgCQlkZXZfZGJnKGRldiwgImZhaWxlZCB0
byBmaW5kIE5GSVQgYXQgc3RhcnR1cFxuIik7DQo+ID4gLQkJcmV0dXJuIDA7DQo+ID4gKwkJcmV0
dXJuIC1FTk9ERVY7DQo+IA0KPiBIbSwgdGhlIGNvbW1lbnQgZGlyZWN0bHkgYWJvdmUgdGhpcyBz
YXlzIHRoaXMgaXMgb2suLg0KPiBIYXMgdGhpcyBjYXVzZWQgYW55IHByb2JsZW1zIGluIHByYWN0
aWNlPw0KPiANClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4gQWZ0ZXIgZ29pbmcgdGhyb3VnaCBy
ZWxhdGVkIGNvZGVzIGFuZCBzb21lIHRlc3QsIEkgYW0gDQpub3cgdGhpbmtpbmcgaXQncyByaWdo
dCB0byBrZWVwICJyZXR1cm4gMCIgaWYgTkZJVCBub3QgZm91bmQgYXQgYm9vdCB0aW1lLg0KDQpQ
ZXIgY2hhcHRlciA5LjIwLjIgTlZESU1NIFJvb3QgRGV2aWNlIGluIEFDUEkgNi4yIHNwZWM6DQpU
aGUgTlZESU1NIHJvb3QgZGV2aWNlIGlzIHJlcHJlc2VudGVkIGJ5IGFuIEFDUEkgbmFtZXNwYWNl
IGRldmljZSB3aXRoIGEgX0hJRCANCm9mICJBQ1BJMDAxMiIuIFRoaXMgZGV2aWNlIGFsbG93cyB0
aGUgT1MgdG8gdHJpZ2dlciBlbnVtZXJhdGlvbiBvZiBOVkRJTU1zIA0KdGhyb3VnaCBORklUIGF0
IGJvb3QgdGltZSBhbmQgcmUtZW51bWVyYXRpb24gYXQgcm9vdCBsZXZlbCB2aWEgdGhlIF9GSVQg
bWV0aG9kIA0KZHVyaW5nIHJ1bnRpbWUuIA0KDQpUaGUgYWNwaV9uZml0X2RyaXZlciBpcyByZWdp
c3RlcmVkIHRvIEFDUEkgYnVzIHRvIHN1cHBvcnQgIkFDUEkwMDEyIi4gDQpUaGUgYWNwaV9uZml0
X2RyaXZlci5hY3BpX25maXRfYWRkIGlzIHVzZWQgdG8gZW51bWVyYXRlIE5WRElNTXMgdGhyb3Vn
aCBORklUIA0KYXQgYm9vdCB0aW1lOyBUaGUgYWNwaV9uZml0X2RyaXZlci5hY3BpX25maXRfbm90
aWZ5IGlzIHVzZWQgdG8gZW51bWVyYXRlIA0KTlZESU1NcyBkdXJpbmcgcnVudGltZS4NCg0KSW4g
bXkgTGVub3ZvIFRoaW5rU3lzdGVtIFNSNjMwIHdoaWNoIHN1cHBvcnQgTlZESU1NcywgSWYgSSBy
ZW1vdmUgDQphbGwgTlZESU1NcywgdGhlIE5GSVQgdGFibGUgaXMgZ29uZSBhZnRlciBzeXN0ZW0g
Ym9vdCB1cC4gSWYga2VlcCAicmV0dXJuIDAiIA0KaW4gYWNwaV9uZml0X2FkZCwgdGhlbiBhY3Bp
X25maXRfZHJpdmVyIHdvdWxkIHN0aWxsIGJlIGF0dGFjaGVkIHRvICJBQ1BJMDAxMiIuIA0KT25j
ZSBhIE5WRElNTSBpcyBob3RwbHVnZ2VkIGludG8gc3lzdGVtIGR1cmluZyBydW50aW1lLCB0aGVu
IA0KYWNwaV9uZml0X2RyaXZlci5hY3BpX25maXRfbm90aWZ5IGNhbiBiZSBjYWxsZWQgdG8gZW51
bWVyYXRlIE5WRElNTXMgKEkgY291bGQNCm5vdCBkbyBob3RwbHVnIHRlc3QgYmVjYXVzZSBmaXJt
d2FyZSBkb2Vzbid0IHN1cHBvcnQpLiANCk90aGVyd2lzZSwgInJldHVybiAtRU5PREVWIiB3b3Vs
ZCBibG9jayBOVkRJTU0gZW51bWVyYXRpb24gZHVyaW5nIHJ1bnRpbWUuDQoNCkhvdyBkbyB5b3Ug
dGhpbmsgdG8gYWRqdXN0IGFubm90YXRpb24gYXMgZm9sbG93aW5nPw0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hY3BpL25maXQvY29yZS5jIGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQppbmRl
eCA3YzQ3OTAwLi4xNjczMTYxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5j
DQorKysgYi9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCkBAIC0zMzUzLDcgKzMzNTMsMTMgQEAg
c3RhdGljIGludCBhY3BpX25maXRfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqYWRldikNCiANCiAg
ICAgICAgc3RhdHVzID0gYWNwaV9nZXRfdGFibGUoQUNQSV9TSUdfTkZJVCwgMCwgJnRibCk7DQog
ICAgICAgIGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgew0KLSAgICAgICAgICAgICAgIC8qIFRo
aXMgaXMgb2ssIHdlIGNvdWxkIGhhdmUgYW4gbnZkaW1tIGhvdHBsdWdnZWQgbGF0ZXIgKi8NCisg
ICAgICAgICAgICAgICAvKiBUaGUgTlZESU1NIHJvb3QgZGV2aWNlIGFsbG93cyBPUyB0byB0cmln
Z2VyIGVudW1lcmF0aW9uIG9mIA0KKyAgICAgICAgICAgICAgICAqIE5WRElNTXMgdGhyb3VnaCBO
RklUIGF0IGJvb3QgdGltZSBhbmQgcmUtZW51bWVyYXRpb24gYXQgDQorICAgICAgICAgICAgICAg
ICogcm9vdCBsZXZlbCB2aWEgdGhlIF9GSVQgbWV0aG9kIGR1cmluZyBydW50aW1lLg0KKyAgICAg
ICAgICAgICAgICAqIFRoaXMgaXMgb2sgdG8gcmV0dXJuIDAgaGVyZSwgd2UgY291bGQgaGF2ZSBh
biBudmRpbW0gDQorICAgICAgICAgICAgICAgICogaG90cGx1Z2dlZCBsYXRlciBhbmQgZXZhbHVh
dGUgX0ZJVCBtZXRob2Qgd2hpY2ggcmV0dXJucyANCisgICAgICAgICAgICAgICAgKiBkYXRhIGlu
IHRoZSBmb3JtYXQgb2YgYSBzZXJpZXMgb2YgTkZJVCBTdHJ1Y3R1cmVzLg0KKyAgICAgICAgICAg
ICAgICAqLw0KICAgICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAiZmFpbGVkIHRvIGZpbmQgTkZJ
VCBhdCBzdGFydHVwXG4iKTsNCiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICAgICAgfQ0K
DQpPY2Vhbi4NCg0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlyYyA9IGRldm1fYWRkX2FjdGlvbl9vcl9y
ZXNldChkZXYsIGFjcGlfbmZpdF9wdXRfdGFibGUsDQo+ID4gdGJsKTsNCg==
