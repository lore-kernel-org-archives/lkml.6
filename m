Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5833320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MgyC5aat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5833320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeLLJNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:13:06 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10861 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:13:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="22174918"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 02:13:05 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 02:13:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+edqSbu+dMOh6QCwOK+gZSGJC4EO10P11AJs/G3ZPY=;
 b=MgyC5aatH/GROuCOOMjjKa6JIjYustBdeflCfgLp56zz5moMyX48XNt5v+i/WO9/RFePtUGBGi/LtnG1Zft0q4Xr1u12t9bj8hUygrVnqp+hyJartn5GFKTkV25IExaon9SPUKT9nJlSuB83pKVMYQcxefbsnkHgPnheepxOKxs=
Received: from BLUPR11MB0740.namprd11.prod.outlook.com (10.163.216.18) by
 BLUPR11MB0657.namprd11.prod.outlook.com (10.163.118.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 09:12:59 +0000
Received: from BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::39b0:53ba:f0d2:91ba]) by BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::39b0:53ba:f0d2:91ba%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 09:12:59 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Topic: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUhkhcc/FQ+O4mvUqVP1+3dl3KuKV6MOYAgAC4PgA=
Date:   Wed, 12 Dec 2018 09:12:58 +0000
Message-ID: <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
 <20181211221324.GA14658@bogus>
In-Reply-To: <20181211221324.GA14658@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0225.eurprd07.prod.outlook.com
 (2603:10a6:802:58::28) To BLUPR11MB0740.namprd11.prod.outlook.com
 (2a01:111:e400:594c::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR11MB0657;6:GJjiEhZj1p5915hbIYs8dyYE/aX6nlGzRD8gItIVXX7OnFMlg6ba6QbYJ0DGTxwWhYorgmBGIGasy8d0mLT5iWxQ4Bp0Wmx+mU1iUpVA5SK72pptTsO3IA8agOzujlQPZGuWySIzXoRj0dVT20TYCadY07rqHS6cIv1ZJAXsEvdMDs0D1TGqGIb3h2vHHpwmvfG/tdFMQr20zh/RZKfw63pR6KYg+UolSI8dJ4EkX/jCyp+hGY4zpTAKyqgmzPRl3u5ovwCmGn8FA8WiiWUg2fp9TIPuF5o5zBxRTvH4aVhushVXsTff+wu6jp66K594L0Z1anYGJ1B/pmVI687b2ZN5AFTEevXL3fFmWiJIezWtWb3+TGv9VwVyl7s5BV5qXy27J56kdzpllmLqZNldZ9orZiI0r6/p6cbVIdqRAQXoQlCH+KHhGzvXEuWVycqKEeqAP1d4mg42B1SiaRZdVQ==;5:sqtEqV3JMKGbTp88Goupt2MgbAaubm1nrQAWZPoJOaVk7LTomhQgOoKYqdQG5p1qU+DgSg1c9jkePonWw7tX/EJq4dowrkYXS27c3VpofiMZJgD1EIHhOz7P5JwYkESPUFuPFBBfUeY94WZe0uwbAlGWqHR7nem7UZVYAORrBK4=;7:g+HZu+yNc51nRNRBrc+jV2QOiowErKUkwntMbH5fkjvAmcZcQd0EDm3oKT11Hbbphmbrkp/iDNgrWhi66+AfplaOes+3MSspucAk0NnaMWbfD5EeZ3dXorwpHeNQMw84fJ2Pz4E9n0rsjyP9RnxXhA==
x-ms-office365-filtering-correlation-id: ee73f532-21a7-4e45-2f2b-08d66012025b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR11MB0657;
x-ms-traffictypediagnostic: BLUPR11MB0657:
x-microsoft-antispam-prvs: <BLUPR11MB0657BF3E3BEE69EC1F549E7287A70@BLUPR11MB0657.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR11MB0657;BCL:0;PCL:0;RULEID:;SRVR:BLUPR11MB0657;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(8936002)(2906002)(5660300001)(316002)(3846002)(229853002)(14454004)(486006)(81156014)(8676002)(81166006)(99286004)(446003)(256004)(11346002)(6916009)(6486002)(14444005)(476003)(15650500001)(6436002)(2616005)(36756003)(72206003)(186003)(6246003)(53936002)(31696002)(105586002)(6512007)(7736002)(86362001)(97736004)(102836004)(25786009)(386003)(6506007)(4326008)(106356001)(53546011)(26005)(68736007)(478600001)(31686004)(6116002)(71190400001)(71200400001)(39060400002)(66066001)(305945005)(76176011)(54906003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR11MB0657;H:BLUPR11MB0740.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DTGtX45Nj2F/Y1IYqjxucncNUZ05VI53OI2u3NbTSjibCnUMltjEGoJZAj8/xOE1Ewm1nYvf5KQELDOqom3zYJQshT2pU6NVjxnCmCoxTT1vuKEZtz/m2KdC8DBs5mJW2pXBj1bsKklx4pFCMkXUXPOCX7RCpiMdrYogClV0ApRWRwrf91Y3TVF7q1IXh5nrdo47b67ZYCM5GRVrVN/r7HJKewOl+agnjJMeC9RTo8sjVdLHtaXvetbzix7cMZGQvEPyr4YrlvHfq7YIMOHnt1VjDjuXJ0rMShQ2YVWfMXx1neRhephcS/BlFyyirusL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE533817C65E354FB65DEFCEAD0647DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee73f532-21a7-4e45-2f2b-08d66012025b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 09:12:58.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR11MB0657
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjEyLjIwMTggMDA6MTMsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIE5v
diAyNywgMjAxOCBhdCAxMTo1NzoyNUFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPj4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHJlZ3VsYXRvciBtb2RlcyBh
bmQgc3VzcGVuZCBzdGF0ZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vYmluZGluZ3Mv
cmVndWxhdG9yL2FjdDg5NDVhLXJlZ3VsYXRvci50eHQgICAgICB8IDM0ICsrKysrKysrKysrKysr
KysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL2Fj
dDg5NDVhLXJlZ3VsYXRvci50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVndWxhdG9yL2FjdDg5NDVhLXJlZ3VsYXRvci50eHQNCj4+IGluZGV4IGFjOTU1ZGVhMDBkMS4u
NDAxNzUyNzYxOWFiIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3JlZ3VsYXRvci9hY3Q4OTQ1YS1yZWd1bGF0b3IudHh0DQo+PiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL2FjdDg5NDVhLXJlZ3VsYXRvci50
eHQNCj4+IEBAIC0xNSwxMSArMTUsMTcgQEAgT3B0aW9uYWwgaW5wdXQgc3VwcGx5IHByb3BlcnRp
ZXM6DQo+PiAgICAtIGlubDY3LXN1cHBseTogVGhlIGlucHV0IHN1cHBseSBmb3IgUkVHX0xETzMg
YW5kIFJFR19MRE80DQo+PiAgDQo+PiAgQW55IHN0YW5kYXJkIHJlZ3VsYXRvciBwcm9wZXJ0aWVz
IGNhbiBiZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUgc2luZ2xlIHJlZ3VsYXRvci4NCj4+ICtyZWd1
bGF0b3ItaW5pdGlhbC1tb2RlLCByZWd1bGF0b3ItYWxsb3dlZC1tb2RlcyBhbmQgcmVndWxhdG9y
LW1vZGUgY291bGQgYmUNCj4+ICtzcGVjaWZpZWQgdXNpbmcgbW9kZSB2YWx1ZXMgZnJvbSBkdC1i
aW5kaW5ncy9yZWd1bGF0b3IvYWN0aXZlLXNlbWksODk0NWEtcmVndWxhdG9yLmgNCj4+ICtmaWxl
Lg0KPj4gIA0KPj4gIFRoZSB2YWxpZCBuYW1lcyBmb3IgcmVndWxhdG9ycyBhcmU6DQo+PiAgCVJF
R19EQ0RDMSwgUkVHX0RDREMyLCBSRUdfRENEQzMsIFJFR19MRE8xLCBSRUdfTERPMiwgUkVHX0xE
TzMsIFJFR19MRE80Lg0KPj4gIA0KPj4gIEV4YW1wbGU6DQo+PiArDQo+PiArI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL3JlZ3VsYXRvci9hY3RpdmUtc2VtaSw4OTQ1YS1yZWd1bGF0b3IuaD4NCj4gDQo+
IFRoaXMgZmlsZSBiZWxvbmdzIGluIHRoaXMgcGF0Y2guDQoNCkknbSB1c2luZyB0aGUgZGVmaW5l
cyBpbiB0aGlzIGZpbGUgYWxzbyBpbiBkcml2ZXIuIEkgd2FzIHRoaW5raW5nIHRoYXQgaWYgSQ0K
d291bGQgaW5jbHVkZSB0aGlzIGZpbGUgaW4gdGhpcyBwYXRjaCB0aGUgZHJpdmVyIGNvbXBpbGF0
aW9uIHdvdWxkIGZhaWwgaWYNCnRoZSBwYXRjaGVzIHdvdWxkIGJlIGFjY2VwdGVkIHZpYSBkaWZm
ZXJlbnQgdHJlZXMuDQoNCldvdWxkIHlvdSBsaWtlIG1lIHRvIGhhdmUgZGlmZmVyZW50IGRlZmlu
ZXMgaW4gZHJpdmVyIGFuZCB0aGlzIG5ldyBoZWFkZXINCm9yIGNvdWxkIGhhcHBlbiB0aGF0IHRo
ZXNlIHBhdGNoZXMgdG8gYmUgaW5jbHVkZWQgaW4gdGhlIG1haW4gdHJlZSB2aWEgdGhlDQpzYW1l
IHRyZWUgKGUuZy4gcmVndWxhdG9yIHRyZWUpPw0KDQpQbGVhc2UsIGxldCBtZSBrbm93IHdoYXQg
ZG8geW91IHRoaW5rLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4gKw0K
Pj4gIAlwbWljQDViIHsNCj4+ICAJCWNvbXBhdGlibGUgPSAiYWN0aXZlLXNlbWksYWN0ODk0NWEi
Ow0KPj4gIAkJcmVnID0gPDB4NWI+Ow0KPj4gQEAgLTMyLDYgKzM4LDE4IEBAIEV4YW1wbGU6DQo+
PiAgCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDEzNTAwMDA+Ow0KPj4gIAkJCQlyZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMzUwMDAwPjsNCj4+ICAJCQkJcmVndWxhdG9yLWFsd2F5
cy1vbjsNCj4+ICsNCj4+ICsJCQkJcmVndWxhdG9yLWFsbG93ZWQtbW9kZXMgPSA8QUNUODk0NUFf
UkVHVUxBVE9SX01PREVfRklYRUQ+LA0KPj4gKwkJCQkJCQkgIDxBQ1Q4OTQ1QV9SRUdVTEFUT1Jf
TU9ERV9MT1dQT1dFUj47DQo+PiArCQkJCXJlZ3VsYXRvci1pbml0aWFsLW1vZGUgPSA8QUNUODk0
NUFfUkVHVUxBVE9SX01PREVfRklYRUQ+Ow0KPj4gKw0KPj4gKwkJCQlyZWd1bGF0b3Itc3RhdGUt
bWVtIHsNCj4+ICsJCQkJCXJlZ3VsYXRvci1vbi1pbi1zdXNwZW5kOw0KPj4gKwkJCQkJcmVndWxh
dG9yLXN1c3BlbmQtbWluLW1pY3Jvdm9sdD08MTQwMDAwMD47DQo+PiArCQkJCQlyZWd1bGF0b3It
c3VzcGVuZC1tYXgtbWljcm92b2x0PTwxNDAwMDAwPjsNCj4+ICsJCQkJCXJlZ3VsYXRvci1jaGFu
Z2VhYmxlLWluLXN1c3BlbmQ7DQo+PiArCQkJCQlyZWd1bGF0b3ItbW9kZT08QUNUODk0NUFfUkVH
VUxBVE9SX01PREVfTE9XUE9XRVI+Ow0KPj4gKwkJCQl9Ow0KPj4gIAkJCX07DQo+PiAgDQo+PiAg
CQkJdmRkXzF2Ml9yZWc6IFJFR19EQ0RDMiB7DQo+PiBAQCAtMzksNiArNTcsMTQgQEAgRXhhbXBs
ZToNCj4+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTEwMDAwMD47DQo+PiAgCQkJ
CXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDEzMDAwMDA+Ow0KPj4gIAkJCQlyZWd1bGF0b3It
YWx3YXlzLW9uOw0KPj4gKw0KPj4gKwkJCQlyZWd1bGF0b3ItYWxsb3dlZC1tb2RlcyA9IDxBQ1Q4
OTQ1QV9SRUdVTEFUT1JfTU9ERV9GSVhFRD4sDQo+PiArCQkJCQkJCSAgPEFDVDg5NDVBX1JFR1VM
QVRPUl9NT0RFX0xPV1BPV0VSPjsNCj4+ICsJCQkJcmVndWxhdG9yLWluaXRpYWwtbW9kZSA9IDxB
Q1Q4OTQ1QV9SRUdVTEFUT1JfTU9ERV9GSVhFRD47DQo+PiArDQo+PiArCQkJCXJlZ3VsYXRvci1z
dGF0ZS1tZW0gew0KPj4gKwkJCQkJcmVndWxhdG9yLW9mZi1pbi1zdXNwZW5kOw0KPj4gKwkJCQl9
Ow0KPj4gIAkJCX07DQo+PiAgDQo+PiAgCQkJdmRkXzN2M19yZWc6IFJFR19EQ0RDMyB7DQo+PiBA
QCAtNTMsNiArNzksMTQgQEAgRXhhbXBsZToNCj4+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8MjUwMDAwMD47DQo+PiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDI1MDAw
MDA+Ow0KPj4gIAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPj4gKw0KPj4gKwkJCQlyZWd1bGF0
b3ItYWxsb3dlZC1tb2RlcyA9IDxBQ1Q4OTQ1QV9SRUdVTEFUT1JfTU9ERV9OT1JNQUw+LA0KPj4g
KwkJCQkJCQkgIDxBQ1Q4OTQ1QV9SRUdVTEFUT1JfTU9ERV9MT1dQT1dFUj47DQo+PiArCQkJCXJl
Z3VsYXRvci1pbml0aWFsLW1vZGUgPSA8QUNUODk0NUFfUkVHVUxBVE9SX01PREVfTk9STUFMPjsN
Cj4+ICsNCj4+ICsJCQkJcmVndWxhdG9yLXN0YXRlLW1lbSB7DQo+PiArCQkJCQlyZWd1bGF0b3It
b2ZmLWluLXN1c3BlbmQ7DQo+PiArCQkJCX07DQo+PiAgCQkJfTsNCj4+ICANCj4+ICAJCQl2ZGRf
M3YzX2xwX3JlZzogUkVHX0xETzIgew0KPj4gLS0gDQo+PiAyLjcuNA0KPj4NCj4gDQo=
