Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D01BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83032086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="luNcNqs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83032086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeJKGRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:17:22 -0400
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:41420
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeJKGRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTv+5tZAmDALpvaIKLdC/oWX2Wvof9u2LFlJ+b8DwIM=;
 b=luNcNqs8T6RrUt+dEpxE8YGERNRG4IcyOIpMeHbuft2F+mPtgrWjFhFpUi8skX9po8YRDk6JcIdeP/com0/KeA1FDtqf74VZSN9rRzrhQjeD3UW/gR63olBo7S7YZ/BH0e/P3DGgzb1LB79AvY1FR0R+I3s63K9Br+zCsNxwXwo=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3675.namprd06.prod.outlook.com (10.167.236.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 10 Oct 2018 22:52:59 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f4ee:3633:74c0:ab4%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 22:52:59 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "barakw@amazon.com" <barakw@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "talel@amazon.com" <talel@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Thread-Topic: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Thread-Index: AQHUYGgRyN3gGcSYHUSF2EMwZYIPcqUYRFiAgAASOwCAAAEugIAAEKJ3gACuxwA=
Date:   Wed, 10 Oct 2018 22:52:58 +0000
Message-ID: <1539211978.1944.46.camel@impinj.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
         <20181010101825.GA6294@sirena.org.uk>
         <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
         <20181010112753.GC6294@sirena.org.uk>
         <ba83a08073614d9244c01218da28fe3e23f3bbc2.camel@amazon.co.uk>
         <20181010122710.GE6294@sirena.org.uk>
In-Reply-To: <20181010122710.GE6294@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3675;6:jNKQJn1DxSJ3Ny2a/OI0H2xWi4q9icl9TcG6y2xUFOFFZ6do+hg6bsVCONrEcTt4q16lxdt+PrZYjsTQJk5h8hW/vQE6EKlmaYF/1R5vV/o1GNwo9jTAO5lfalN7d0d8zNMAc84EHyxBsOgmZh54WIMLdRyAjxz2//yIgl8tKWNJFm4TxHnj6Do6UrhoP6uF4UUTauwsqCGU8sg/EpW/kkcNTA9ZWj17fOC7nP+T7ur9vS4PXtYe0meLEOdrZTwMZZSrWJihemMrOtAtnFxCuZZTUdH4Im11p3YwcIeMc6Z+ehX1kjheXVasJHVQXn5rKF7VUHLX6o9D3cekfUYOVKtuv42wHVb/Gk6nCpf32wFgbZNqsCYtqUBoRCc8fWUQb3lnoCmVuM6IYEEE1IloG4PAKGSr69LIfeZ1fZHzmDyENfm+csuFSFvGr6OBY3kw6HyXnB5eBHuC/+5bXok8jw==;5:fzjWduqyFGb6m19sh+/46Yrb/goUEZR7zPUD1sUFrnZ6Rj41Wi2OElPn4POyue91oet3JGnVGrFCUu2ThvKg1r5TsgiJ9U7dwIsNrNDLXHzP1AywQP1U7kcNdLop1VtVtK+9LN8VQ1qfdjYWz8h7Ddj6jOOFKKsfOr4ouoVOD2Q=;7:v9eUpUqmiGuAbsKCWQm/OKjjo3mk/GXia6K27yrERbGQ9OzJI8+lWWIeMNV66NlGgOo/MdkgVhqOFTBfu3hGHYE3PYF5EbB3/HJJbaOfNL1h5eWJ8egFGzEk33f9aLPwvBDiN+LdI+WY861qF9pvJyhFrZ6JaR9YXz6nS5HOpXpeyPQp+VDF+Kqjzuj+RW9sUliuvpPs+2WKlBn8sgkeDboTqGg6eC5q44vsJSdDI+iBx02o6D889+QSgrTBpYDK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a37315e2-d464-44c3-5168-08d62f032028
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3675;
x-ms-traffictypediagnostic: MWHPR0601MB3675:
x-microsoft-antispam-prvs: <MWHPR0601MB3675E22142982358EF56D5AAD3E00@MWHPR0601MB3675.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:MWHPR0601MB3675;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3675;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(189003)(199004)(2501003)(6346003)(97736004)(103116003)(76176011)(6116002)(4001150100001)(8936002)(186003)(5660300001)(3846002)(7416002)(2906002)(7736002)(6506007)(229853002)(102836004)(5250100002)(305945005)(26005)(99286004)(6436002)(14454004)(2900100001)(86362001)(6486002)(68736007)(256004)(106356001)(93886005)(105586002)(66066001)(478600001)(8676002)(81166006)(71190400001)(54906003)(110136005)(316002)(25786009)(4326008)(6512007)(81156014)(486006)(36756003)(71200400001)(2616005)(446003)(11346002)(476003)(6246003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3675;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-message-info: jLGxLQFeZNGVa9BOIxmXMyIl+WwHLcmsp8LLcvmLswzHJaEspAQbFTcdz8y2l9hfYfbGJY2fccwwl0isJBoetufqK75ToR2uJLQBqnHFHk8uYCbFtSh4ENFAIXl8//1QDYud6LN0vA1EjYjArNKISlOd9vAt8ofuSDrYu10OeSE5Uc702IaVT0ZGg3DibNRkXwo/GUHZV0uQiUXyUaIBe+AZrqeKpR47+8/+SJyxSLMbKZsqqBXxIRC5YsANDaSZ0VuElRWrWQ1UcRjfIsDtBLLbEPM23QWVHZ02xgFQUkLQ5GJaEoHtMYm8gjz7BvMM5QLQY8qTNPZgEVduCoRwIOYqxiIm2C7i1JejckrqKDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <581F67DDB68ED04C916ACC1F0CEA7874@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37315e2-d464-44c3-5168-08d62f032028
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 22:52:58.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTEwIGF0IDEzOjI3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAN
Cj4gVGhhdCdzIGdyZWF0IGFuZCB3ZSBnZXQgdG8gcmV1c2UgYWxsIHRoZSBkcml2ZXIgY29kZSB3
aXRoIGEgcXVpcmsgKGENCj4gcXVpcmsgd2hpY2ggZml4ZXMgdGhlIGhhcmR3YXJlIHRvIGJlIG1v
cmUgY29tcGF0aWJsZSB3aXRoIGRldmljZXMsIHRoaXMNCj4gaXMgYSByZWFsbHkgZ29vZCBoYXJk
d2FyZSBjaGFuZ2UpLiAgSWRlYWxseSB3ZSdkIGJlIGFibGUgdG8gZW51bWVyYXRlDQo+IHRoaW5n
cyBsaWtlIElQIHZlcnNpb25zIGFuZCBvcHRpb25zIGZyb20gaGFyZHdhcmUgYnV0IHRoYXQncyBh
IG1vcmUNCj4gZW50ZXJ0YWluaW5nIHByb2JsZW0uDQoNCk1pZ2h0IHdlbGwgYmUgcG9zc2libGUg
aGVyZS4gIFRoZXJlIGFyZSBhbiBpZCBjb2RlIGFuZCB2ZXJzaW9uDQpyZWdpc3RlcnMgdGhhdCBj
b3VsZCBiZSB1c2VkLiAgRGlkIGFueW9uZSBoYXZlIHRoZSBmb3Jlc2lnaHQgdG8gY2hhbmdlDQp0
aGVtIHdvdWxkIG1vZGlmeWluZyB0aGUgSVAgaXMgdGhlIHF1ZXN0aW9uLg0KDQoNCj4gSGF2aW5n
IHNhaWQgYWxsIHRoaXMgaWYgdGhlcmUgYXJlIHByb2R1Y3Rpb24gc3lzdGVtcyB1c2luZyB0aGlz
DQo+IHByb3BlcnR5LCBlc3BlY2lhbGx5IHByb2R1Y3Rpb24gc3lzdGVtcyB3aGVyZSBwZW9wbGUg
b3RoZXIgdGhhbiB0aGUNCj4gc3lzdGVtIGludGVncmF0b3IgY2FuIHJlYWxpc3RpY2FsbHkgZGVw
bG95IHRoZWlyIG93biBrZXJuZWwgc2VwYXJhdGUgdG8NCj4gdGhlIGRldmljZSB0cmVlLCB0aGVu
IHN1cHBvcnRpbmcgdGhvc2UgZXhpc3RpbmcgRFRzIGV2ZW4gaWYgdGhleSdyZSBub3QNCj4gZG9p
bmcgdGhlIGlkZWFsIHRoaW5nIG1pZ2h0IGJlIHRoZSBiZXN0IHRoaW5nLiAgWW91IG1lbnRpb25l
ZCB0aGF0IHRoaXMNCj4gbWlnaHQgYmUgdGhlIGNhc2UsIGNhbiB5b3UgY2hlY2sgd2hhdCB0aGUg
c3RhdHVzIGlzIHRoZXJlIHBsZWFzZT8NCg0KSSd2ZSBkZXZlbG9wZWQgc3lzdGVtcyB0aGF0IHVz
ZWQgY2hpcHMgd2l0aCB0aGlzIFNQSSBtYXN0ZXIuICBJIHVzZWQNCkdQSU8gY2hpcCBzZWxlY3Rz
IHRvIHdvcmsgYXJvdW5kIHRoZSBleGlzdGluZyBiZWhhdmlvciBhbmQgd291bGQgbm90IGJlDQpu
ZWdhdGl2ZWx5IGFmZmVjdGVkIGlmIHNvbWVvbmUgZml4ZWQgdGhpcyBidWcuDQoNClRoZXJlJ3Mg
YWxzbyBhbm90aGVyIHF1aXJrIHdoZXJlIGNlcnRhaW4gcGhhc2UvcG9sYXJpdHkgY29tYmluYXRp
b24NCm1ha2UgaXQgZ2VuZXJhdGUgYSBDUyBwdWxzZSBiZXR3ZWVuIGVhY2ggd29yZC4NCg0KSU1I
TywgTGludXggU1BJIGhhcyBhIHNwZWNpZmljYXRpb24gZm9yIGhvdyBpdCB3b3Jrcy4gIFNldHVw
IGFuIHhmZXIgYQ0KY2VydGFpbiB3YXkgYW5kIHlvdSBnZXQgYSBjZXJ0YWluIHdhdmVmb3JtIGZy
b20gdGhlIG1hc3Rlci4gIElmIHRoZQ0KbWFzdGVyIGdlbmVyYXRlcyB0aGUgd3Jvbmcgd2F2ZWZv
cm0gdGhlbiBpdCdzIGEgYnVnLiAgRGVzaWduZXJzIHNob3VsZA0Ka25vdyBiZXR0ZXIgdGhhbiB0
byBkZXNpZ24gYSBzeXN0ZW0gdGhhdCBkZXBlbmRzIG9uIGEgYnVnIG5ldmVyIGJlaW5nDQpmaXhl
ZCBhbmQgYmUgY2F1Z2h0IG9mZiBndWFyZCB3aGVuIGl0IGlzLiAgSWYgeW91IHdhbnQgQ1MgdG8g
dHVybiBvZmYNCndoZW5ldmVyIHRoZSBGSUZPIGlzIGVtcHR5ICh3aHk/Pz8pIHRoZW4gZXh0ZW5k
IHRoZSBzcGVjIHRvIGVuY29tcGFzcw0KdGhlIGJlaGF2aW9yIHlvdSB3YW50LiAgTGlrZSBob3cg
InB1bHNlIGJldHdlZW4gd29yZHMiIGNhbiBiZSBzcGVjaWZpZWQNCm5vdy4=
