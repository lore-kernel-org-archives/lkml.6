Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB482192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfBOMg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:36:29 -0500
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:46030 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBOMg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:36:29 -0500
Received: from ttb-m4.gw.nic.fujitsu.com (unknown [192.168.231.162]) by mgwkm04.jp.fujitsu.com with smtp
         id 756f_1180_22ce9f1c_d779_4849_9e69_b9550396eb45;
        Fri, 15 Feb 2019 21:36:26 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
        by ttb-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1232C40C0423
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 21:37:06 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
        by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id 02FAA692668;
        Fri, 15 Feb 2019 21:36:25 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw13 ([10.0.194.52]) with mapi id 14.03.0415.000; Fri, 15 Feb 2019
 21:36:25 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     'Will Deacon' <will.deacon@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdTENhuVebuKtHOoRzCPb6sZ5vznO///+H8AgAAo/wD//jk2sA==
Date:   Fri, 15 Feb 2019 12:36:23 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
In-Reply-To: <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
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
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZ3V5cywNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEphbWVzIE1vcnNlIFttYWlsdG86amFtZXMubW9yc2VAYXJtLmNv
bV0NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxNSwgMjAxOSAzOjIzIEFN
DQo+IFRvOiBNYXJrIFJ1dGxhbmQ7IFpoYW5nLCBMZWkgDQo+IENjOiAnV2ls
bCBEZWFjb24nOyAnQ2F0YWxpbiBNYXJpbmFzJzsgJ2xpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcnOw0KPiAnbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnJw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBhcm02
NDogQWRkIHdvcmthcm91bmQgZm9yIEZ1aml0c3UgQTY0RlggZXJyYXR1bSAw
MTAwMDENCg0KPiBJIHRoaW5rIHdlIHNob3VsZCBkbyB0aGlzOiBuZXZlciBz
ZXQgTkZEeCBvbiBBNjRGWC4gSSBkb24ndCB0aGluayB3ZSBjYW4gbWFpbnRh
aW4NCj4gdGhlIFRDUg0KPiBzd2l2ZWwgYmVmb3JlIGFueSBtZW1vcnkgYWNj
ZXNzIGluIHRoZSBLUFRJIHRyYW1wb2xpbmUuIChJdCBhbHJlYWR5IHVzZXMg
dGhlDQo+IEZBUiBhcyBhDQo+IHNjcmF0Y2ggcmVnaXN0ZXIhKQ0KPiANCj4g
VGhlIGVycmF0YSBtZWFucyB3ZSBjYW4ndCB1c2UgdGhlc2UgYml0cy4gSXRz
IHNpbXBsZXIgdGhhbiB0cnlpbmcgdG8gd29yayBhcm91bmQNCj4gdGhlIHN5
bXB0b21zLg0KDQpJIHRoaW5rIHlvdSBtZWFuIGl0IG1heSBiZSBhIHByb2Js
ZW0gdG8gbW9kaWZ5IHRoZSBLUFRJIHRyYW1wb2xpbmUgDQpiZWNhdXNlIHNv
bWUgcGF0Y2hlcyBhYm91dCBLUFRJIHdpbGwgYmUgbWVyZ2VkIHRvIG1haW5s
aW5lIGluIHRoZSBuZWFyIGZ1dHVyZS4NCkkgdW5kZXJzdG9vZCB0aGF0Lg0K
SSBzaG91bGQgZGlzY3VzcyB3aXRoIG15IGNvbGxlYWd1ZXMgd2hldGhlciB3
ZSBjYW4gc2V0IE5GRHg9MCBhbGwgb2YgdGltZSBvbiBBNjRGWC4NCg0KQW5k
IHRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCklmIHdlIGNhbiBzZXQgTkZEeD0w
IGFsbCBvZiB0aW1lLCBJIHdpbGwgcmV2aWV3LCB0ZXN0IGFuZCByZXBvcnQg
dGhlIHJlc3VsdC4NCg0KQmVzdCBSZWdhcmRzLA0KWmhhbmcgTGVpDQoNCg==
