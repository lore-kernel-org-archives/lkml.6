Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48DF21A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48DF21A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeHHTCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:02:40 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:53494 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728159AbeHHTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:02:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-70-hVx3zmF7MYSdjDil8YEeXQ-1; Wed, 08 Aug 2018 17:42:07 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 8 Aug 2018 17:43:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 8 Aug 2018 17:43:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "Russell King - ARM Linux" <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "neko@bakuhatsu.net" <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Topic: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Index: AQHULxGqyzS7gP0u+Em6lFS72D3AkaS10FEA///9OACAABjskIAAJmTwgAAB3mA=
Date:   Wed, 8 Aug 2018 16:43:46 +0000
Message-ID: <a804913d98ae4598a725cb40a6d19b4e@AcuMS.aculab.com>
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local>
 <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
 <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
 <20180808145017.GE24736@iMac.local>
 <alpine.LRH.2.02.1808081215120.31259@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
In-Reply-To: <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: hVx3zmF7MYSdjDil8YEeXQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwOCBBdWd1c3QgMjAxOCAxNzozMQ0KLi4NCj4g
PiBUaGV5IGRvIG1vZGlmeSB0aGUgc2FtZSBieXRlLCBidXQgd2l0aCB0aGUgc2FtZSB2YWx1ZS4g
U3VwcG9zZSB0aGF0IHlvdQ0KPiA+IHdhbnQgdG8gY29weSBhIHBpZWNlIG9mIGRhdGEgdGhhdCBp
cyBiZXR3ZWVuIDggYW5kIDE2IGJ5dGVzIGxvbmcuIFlvdSBjYW4NCj4gPiBkbyB0aGlzOg0KPiA+
DQo+ID4gYWRkIHNyY19lbmQsIHNyYywgbGVuDQo+ID4gYWRkIGRzdF9lbmQsIGRzdCwgbGVuDQo+
ID4gbGRyIHgwLCBbc3JjXQ0KPiA+IGxkciB4MSwgW3NyY19lbmQgLSA4XQ0KPiA+IHN0ciB4MCwg
W2RzdF0NCj4gPiBzdHIgeDEsIFtkc3RfZW5kIC0gOF0NCg0KSSd2ZSBkb25lIHRoYXQgbXlzZWxm
IChvbiB4ODYpIGNvcGllZCB0aGUgbGFzdCAnd29yZCcgZmlyc3QgdGhlbg0KZXZlcnl0aGluZyBl
bHNlIGluIGluY3JlYXNpbmcgYWRkcmVzcyBvcmRlci4NCg0KPiA+IFRoZSBBUk02NCBtZW1jcHkg
dXNlcyB0aGlzIHRyaWNrIGhlYXZpbHkgaW4gb3JkZXIgdG8gcmVkdWNlIGJyYW5jaGluZywgYW5k
DQo+ID4gdGhpcyBpcyB3aGF0IG1ha2VzIHRoZSBQQ0llIGNvbnRyb2xsZXIgY2hva2UuDQoNCk1v
cmUgbGlrZWx5IHRoZSB3cml0ZSBjb21iaW5pbmcgYnVmZmVyPw0KDQo+IFNvIHdoZW4gYSBzaW5n
bGUgdW5hbGlnbmVkICdzdHAnIGdldHMgdHJhbnNsYXRlZCBpbnRvIGEgUENJZSB3aXRoIFRMUA0K
PiB3aXRoIGxlbmd0aD01ICgyMCBieXRlcykgYW5kIExhc3RCRSA9IH4xc3RCRSwgd3JpdGUgY29t
YmluaW5nIHRoZQ0KPiBvdmVybGFwcGluZyBzdG9yZXMgZ2l2ZXMgdXMgYSBUTFAgd2l0aCBhIGxv
bmdlciBsZW5ndGggKDUuLjggZm9yIHR3bw0KPiBzdG9yZXMpLCBhbmQgYnl0ZS1lbmFibGUgYml0
cyB0aGF0IGFyZSBub3QgZXhhY3RseSBhIGNvbXBsZW1lbnQuDQoNCldyaXRlIGNvbWJpbmluZyBz
aG91bGQgZ2VuZXJhdGUgYSBtdWNoIGxvbmdlciBUTFAuDQpEZXBlbmRpbmcgb24gdGhlIHNpemUg
b2YgdGhlIHdyaXRlIGNvbWJpbmluZyBidWZmZXIuDQoNCkJ1dCBpbiB0aGUgYWJvdmUgY2FzZSBJ
J2QgaGF2ZSB0aG91Z2h0IHRoYXQgdGhlIHNlY29uZCB3cml0ZQ0Kd291bGQgZmFpbCB0byAnY29t
YmluZScgLSBiZWNhdXNlIGl0IGlzbid0IGNvbnRpZ3VvdXMgd2l0aCB0aGUNCnN0b3JlZCBkYXRh
Lg0KDQpTbyBzb21ldGhpbmcgbW9yZSBjb21wbGV4IHdpbGwgYmUgZ29pbmcgb24uDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

