Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B645C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B86620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfBENcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:32:16 -0500
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:17301 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBENcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:32:16 -0500
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.231.131]) by mgwkm02.jp.fujitsu.com with smtp
         id 12ac_46e2_8499786e_bedc_46b5_ae3f_f9f393683377;
        Tue, 05 Feb 2019 22:32:09 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 265E8AC010F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Feb 2019 22:32:09 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id CE1C2BD66E1;
        Tue,  5 Feb 2019 22:32:07 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw13 ([10.0.194.52]) with mapi id 14.03.0415.000; Tue, 5 Feb 2019
 22:32:06 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Will Deacon' <will.deacon@arm.com>
CC:     'Mark Rutland' <mark.rutland@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'James Morse' <james.morse@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AQHUuKy5V4yTFdOO5Emj9g0aGwlQl6XKckPA//+9wQCABwJDsA==
Date:   Tue, 5 Feb 2019 13:32:07 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A30C3CB@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
 <20190201105144.GA27140@fuggles.cambridge.arm.com>
In-Reply-To: <20190201105144.GA27140@fuggles.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBsaW51eC1hcm0ta2VybmVsDQo+IFttYWlsdG86bGludXgtYXJtLWtl
cm5lbC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmddIE9uIEJlaGFsZiBP
Zg0KPiBXaWxsIERlYWNvbg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDAx
LCAyMDE5IDc6NTIgUE0NCj4gVG86IFpoYW5nLCBMZWkgDQo+IENjOiAnTWFy
ayBSdXRsYW5kJzsgJ0NhdGFsaW4gTWFyaW5hcyc7ICdKYW1lcyBNb3JzZSc7
DQo+ICdsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnJzsNCj4gJ2xpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZycNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAwLzFdIGFybTY0OiBBZGQgd29ya2Fyb3VuZCBmb3Ig
RnVqaXRzdSBBNjRGWA0KPiBlcnJhdHVtIDAxMDAwMQ0KDQo+IFNvIEkgZ3Vl
c3Mgd2Ugc2hvdWxkIGJvb3Qgd2l0aCBORkQxIGNsZWFyLCBhbmQgdGhlbiBz
ZXQgaXQgb25seSB3aGVuIHdlDQo+IHJlYWxpc2Ugd2UncmUgbm90IG9uIGFu
IEE2NEZYPw0KDQpJbiBteSBwYXRjaCwgSSBkbyBzaW1pbGFyIHRoaW5ncyBh
dCBfX2NwdV9zZXR1cCB3aGljaCB3ZSANCnNldCBORkQxPTEgb24gYWxsIHBy
b2Nlc3NvcnMgZXhjZXB0IEE2NEZYLg0KDQpEbyB5b3UgbWVhbiB3ZSB3b3Vs
ZCBiZXR0ZXIgdG8gY2hhbmdlIHRoZSBwbGFjZSB3aGVyZSB3ZSANCnNldC9j
bGVhciBORkQxPw0KDQpUaGFua3MsDQpaaGFuZyBMZWkNCg0K
