Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ACEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987720849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="18WiEhMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5987720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeLLQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:24:45 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51478 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:24:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="24131073"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 12 Dec 2018 09:24:44 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 09:24:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+px+o3B8B4ZTv1UO4yEPDQex4BGoHopDCClmWAPcbd8=;
 b=18WiEhMtpaGKjenQIDxfJQJlvw9mhqJusL4XDNgekeBgsM/eAsRQzOpm4SdKbQfA9yeZZ4cKHTNwgt9tGPCwmlAauwySri/4LnFSQ5bj964ifG7gj0OtUN0mcsC72AgUHbAhbhJZp1ip33pY4KB1cJkCzpef2zpIlpU4/GM+uf4=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0725.namprd11.prod.outlook.com (10.163.112.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.25; Wed, 12 Dec 2018 16:24:41 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 16:24:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Topic: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUhkhcc/FQ+O4mvUqVP1+3dl3KuA==
Date:   Wed, 12 Dec 2018 16:24:41 +0000
Message-ID: <8500c9f1-bfdf-d1ae-4a14-e42e1ee85585@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
 <20181211221324.GA14658@bogus>
 <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
 <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
In-Reply-To: <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0044.eurprd05.prod.outlook.com
 (2603:10a6:800:60::30) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0725;6:/q1x1bP2ttW/nPh3mj7BRdLiLm/836Pder+GAZddvnggq7WyZOSpOH52CrxB+1aDIyJLUAbUHY878LkD2DYNkGZIbnLbfXgwlohyFfxUeP5V57RB7qyWpr43yHpmJ3SU6Xbc/7IRDie1WnpvEXfKcg6KNS3QmdXkZlmnCTTt2pVRxBPBf9UJGpJhXqPztnxn+RTcwy/sJjawKfrc2WUGQj317yvrroMjcFnwkKzPAwnoIozLisBQP4y1/4ghlPMxe6uRFe4E0n7yk+9XxiaT2qTFz4jrmpeLI9KlGlFm39200U6D7V1O/lR72+i5GLi5RvsTkEXj+OV1d+asmSfa87SAy7/0iAzIRD8r4NlsdluBM3Th323R2FINeaLXYFo/x5TQiZW88NM7JZm7uqA2vAYcCjEqoBI3FvTVRuzg9r3FKlUdC9iITMlv4V5qD0hd6J0Hx/9Sir0ZFb22u0eDhQ==;5:GRw5zPhImrL8bkysqx3w6GwZFpKKrcLqJIRuxqky6uR0gnuIVybbdraeFZ2ivCmquV2TyCynESJdoFUTc7Tota3OYginZXdIJ47Hyb0iQD3OazpU/tGWNRGttvBVBUhx+b7Rc0+qx6+NbdwInUG1geF2/roKGN+YDh3iAVBCWjA=;7:kNF/S/kK+45eFW283lu3htk+hCsGNggoGN0VuV0Y9oFqzWejNMfn7c1WXlUvibea2P952sqiggek0Vk1fOBzaZqFJBUaY4lTzvuao5L+QjlSmEt2hqdsmgNhjwlaaMQ6yxEcD+TnJhruHyeVsU9TPQ==
x-ms-office365-filtering-correlation-id: 12dd74cb-9a36-4618-71bb-08d6604e51a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0725;
x-ms-traffictypediagnostic: BY2PR11MB0725:
x-microsoft-antispam-prvs: <BY2PR11MB072549E0A0B87AEF64BB250187A70@BY2PR11MB0725.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(4982022)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0725;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0725;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8936002)(2906002)(10710500007)(31686004)(8676002)(2420400007)(6916009)(229853002)(81156014)(81166006)(93886005)(966005)(72206003)(14444005)(256004)(478600001)(71200400001)(71190400001)(476003)(97736004)(68736007)(25786009)(486006)(86362001)(31696002)(14454004)(6306002)(316002)(6116002)(3846002)(54906003)(11346002)(446003)(4326008)(53936002)(6512007)(15650500001)(66066001)(102836004)(106356001)(52116002)(99286004)(6436002)(36756003)(6506007)(53546011)(76176011)(386003)(7736002)(6246003)(6486002)(39060400002)(5660300001)(2616005)(186003)(105586002)(26005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0725;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZRdAMlvhR1tkm4e4EQ86/LJXCcdII0zog5haHtv+L7oH8zsPvLMfLlyuqMNf7zFoqc20TZa7MUjdaCv46phvlM4774Udbj7IkgDnYwCirjgTn9DNMz9PxoEglQhLvUrY577qads/6TNOiJhUfVMAousiTRzarLDqrQsox/4Gy1pDgl4kNpuDjjKR3SUOZ2i/L5CRArnAtRCFypL6mSQxDPpy6zwbRlayu2wsg44+RiSxZosi4ADUcQfAeIHxee8I/wAT+lXKfGAOQb8ZIhKhbX5cWYWULKvnOfO8QDanFOuIPWzdN6IjmCNR+2MV7gfx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4819D54C0784CB46A0623F3A112B20DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd74cb-9a36-4618-71bb-08d6604e51a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:24:41.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0725
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjEyLjIwMTggMTU6MzIsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBXZWQsIERl
YyAxMiwgMjAxOCBhdCAzOjEzIEFNIDxDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tPiB3cm90
ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDEyLjEyLjIwMTggMDA6MTMsIFJvYiBIZXJyaW5nIHdyb3Rl
Og0KPj4+IE9uIFR1ZSwgTm92IDI3LCAyMDE4IGF0IDExOjU3OjI1QU0gKzAwMDAsIENsYXVkaXUu
QmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+Pg0KPj4+PiBBZGQgZG9jdW1lbnRhdGlv
biBmb3IgcmVndWxhdG9yIG1vZGVzIGFuZCBzdXNwZW5kIHN0YXRlcy4NCj4+Pj4NCj4+Pj4gU2ln
bmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgLi4uL2JpbmRpbmdzL3JlZ3VsYXRvci9hY3Q4OTQ1YS1yZWd1bGF0
b3IudHh0ICAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAxIGZpbGUgY2hh
bmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9hY3Q4OTQ1YS1yZWd1bGF0b3IudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9hY3Q4OTQ1YS1y
ZWd1bGF0b3IudHh0DQo+Pj4+IGluZGV4IGFjOTU1ZGVhMDBkMS4uNDAxNzUyNzYxOWFiIDEwMDY0
NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9y
L2FjdDg5NDVhLXJlZ3VsYXRvci50eHQNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9hY3Q4OTQ1YS1yZWd1bGF0b3IudHh0DQo+Pj4+IEBAIC0x
NSwxMSArMTUsMTcgQEAgT3B0aW9uYWwgaW5wdXQgc3VwcGx5IHByb3BlcnRpZXM6DQo+Pj4+ICAg
IC0gaW5sNjctc3VwcGx5OiBUaGUgaW5wdXQgc3VwcGx5IGZvciBSRUdfTERPMyBhbmQgUkVHX0xE
TzQNCj4+Pj4NCj4+Pj4gIEFueSBzdGFuZGFyZCByZWd1bGF0b3IgcHJvcGVydGllcyBjYW4gYmUg
dXNlZCB0byBjb25maWd1cmUgdGhlIHNpbmdsZSByZWd1bGF0b3IuDQo+Pj4+ICtyZWd1bGF0b3It
aW5pdGlhbC1tb2RlLCByZWd1bGF0b3ItYWxsb3dlZC1tb2RlcyBhbmQgcmVndWxhdG9yLW1vZGUg
Y291bGQgYmUNCj4+Pj4gK3NwZWNpZmllZCB1c2luZyBtb2RlIHZhbHVlcyBmcm9tIGR0LWJpbmRp
bmdzL3JlZ3VsYXRvci9hY3RpdmUtc2VtaSw4OTQ1YS1yZWd1bGF0b3IuaA0KPj4+PiArZmlsZS4N
Cj4+Pj4NCj4+Pj4gIFRoZSB2YWxpZCBuYW1lcyBmb3IgcmVndWxhdG9ycyBhcmU6DQo+Pj4+ICAg
ICAgUkVHX0RDREMxLCBSRUdfRENEQzIsIFJFR19EQ0RDMywgUkVHX0xETzEsIFJFR19MRE8yLCBS
RUdfTERPMywgUkVHX0xETzQuDQo+Pj4+DQo+Pj4+ICBFeGFtcGxlOg0KPj4+PiArDQo+Pj4+ICsj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvcmVndWxhdG9yL2FjdGl2ZS1zZW1pLDg5NDVhLXJlZ3VsYXRv
ci5oPg0KPj4+DQo+Pj4gVGhpcyBmaWxlIGJlbG9uZ3MgaW4gdGhpcyBwYXRjaC4NCj4+DQo+PiBJ
J20gdXNpbmcgdGhlIGRlZmluZXMgaW4gdGhpcyBmaWxlIGFsc28gaW4gZHJpdmVyLiBJIHdhcyB0
aGlua2luZyB0aGF0IGlmIEkNCj4+IHdvdWxkIGluY2x1ZGUgdGhpcyBmaWxlIGluIHRoaXMgcGF0
Y2ggdGhlIGRyaXZlciBjb21waWxhdGlvbiB3b3VsZCBmYWlsIGlmDQo+PiB0aGUgcGF0Y2hlcyB3
b3VsZCBiZSBhY2NlcHRlZCB2aWEgZGlmZmVyZW50IHRyZWVzLg0KPiANCj4gVGhleSB3b24ndCBi
ZS4NCg0KVGhhbmsgeW91ISBJJ2xsIHNlbmQgYSBuZXcgdmVyc2lvbiB3aXRoIHRoZSBwcm9wb3Nl
ZCBjaGFuZ2UuDQoNCj4gDQo+PiBXb3VsZCB5b3UgbGlrZSBtZSB0byBoYXZlIGRpZmZlcmVudCBk
ZWZpbmVzIGluIGRyaXZlciBhbmQgdGhpcyBuZXcgaGVhZGVyDQo+PiBvciBjb3VsZCBoYXBwZW4g
dGhhdCB0aGVzZSBwYXRjaGVzIHRvIGJlIGluY2x1ZGVkIGluIHRoZSBtYWluIHRyZWUgdmlhIHRo
ZQ0KPj4gc2FtZSB0cmVlIChlLmcuIHJlZ3VsYXRvciB0cmVlKT8NCj4gDQo+IE5vIG5lZWQgZm9y
IGRpZmZlcmVudCBkZWZpbmVzLiBUaGUgc3Vic3lzdGVtIG1haW50YWluZXIgd2lsbCB0YWtlDQo+
IGV2ZXJ5dGhpbmcgaW4gdGhpcyBjYXNlLg0KPiANCj4gUm9iDQo+IA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
DQo+IA0K
