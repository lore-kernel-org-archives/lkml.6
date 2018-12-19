Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C9A218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbeLSRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:24:34 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:50332 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeLSRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:24:34 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 2E7EA67A712;
        Wed, 19 Dec 2018 18:24:31 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 19 Dec
 2018 18:24:30 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 19 Dec 2018 18:24:30 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Topic: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Index: AQHUlfUoWBvAkgSJkE+oWdptakv0L6WFokmAgAA/TYCAACQ9gIAAPOUA
Date:   Wed, 19 Dec 2018 17:24:30 +0000
Message-ID: <9d9c55d7-cc62-8c84-1782-e49929e58adf@kontron.de>
References: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
 <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
 <20181219113650.ak3wj3h3oapfy3tj@linutronix.de>
 <d9448930-e466-864a-41ce-08bf4588d0d1@kontron.de>
In-Reply-To: <d9448930-e466-864a-41ce-08bf4588d0d1@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D77791C64BEFCD4B91F3140F41938D76@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2E7EA67A712.AC29D
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMTIuMTggMTQ6NDYsIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+IEhpIFNlYmFzdGlh
biwNCj4gDQo+IE9uIDE5LjEyLjE4IDEyOjM2LCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIHdy
b3RlOg0KPj4gT24gMjAxOC0xMi0xOSAwNzo1MDoxNyBbKzAwMDBdLCBTY2hyZW1wZiBGcmllZGVy
IHdyb3RlOg0KPj4+ICsgbGludXgtcnQtdXNlcnMNCj4+Pg0KPj4+IE9uIDE3LjEyLjE4IDExOjQy
LCBGcmllZGVyIFNjaHJlbXBmIHdyb3RlOg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gSSBoYXZlIHRy
aWVkIHRvIGJvb3QgYSA0LjE0LUtlcm5lbCB3aXRoIHRoZSBSVC1wYXRjaGVzIGFuZA0KPj4+PiBQ
UkVFTVBUX1JUX0ZVTEwgb24gYW4gaS5NWDZVTCBib2FyZC4gVW5mb3J0dW5hdGVseSB0aGUgYm9v
dCBzdGFsbHMgYXQNCj4+Pj4gc29tZSBwb2ludCBhbmQgbmV2ZXIgZmluaXNoZXMuDQo+Pj4+DQo+
Pj4+IEkgZGlkIHNvbWUgYmlzZWN0aW5nIGFuZCBmb3VuZCBvdXQsIHRoYXQgcmV2ZXJ0aW5nIHRo
aXMgY2hhbmdlOiBbMV0sDQo+Pj4+IG1ha2VzIHRoZSBib2FyZCBib290IGNvcnJlY3RseS4NCj4+
Pj4NCj4+Pj4gQ2FuIGFueW9uZSBoZWxwIHRvIGNvbWUgdXAgd2l0aCBhIHByb3BlciBmaXggZm9y
IHRoaXM/DQo+Pg0KPj4gY2FuIHlvdSBjaGVjayBpZiB0aGUgaGFzaHRhYmxlIGlzIGluaXRpYWxp
emVkIHR3aWNlPw0KPiANCj4gSSdtIG5vdCBzdXJlIGhvdyB0byBjaGVjaywgYnV0IEkgZ3Vlc3Mg
eW91IGFyZSBvbiB0aGUgcmlnaHQgdHJhY2suIEkgY2FuIA0KPiBsZWF2ZSB0aGUgaW5pdCBsb29w
IGZvciBkZW50cnlfaGFzaHRhYmxlIGluIHBsYWNlIGFuZCByZW1vdmUgdGhlIG9uZSBmb3IgDQo+
IGluX2xvb2t1cF9oYXNodGFibGUgaW4gdmZzX2NhY2hlc19pbml0X2Vhcmx5KCkgYW5kIHRoaXMg
YWxzbyBtYWtlcyB0aGUgDQo+IGJvYXJkIGJvb3QuDQo+IA0KPiBDb3VsZCBpdCBiZSwgdGhhdCB0
aGUgaW5pdGlhbGl6aW5nIGZvciBkZW50cnlfaGFzaHRhYmxlIGFuZCANCj4gaW5fbG9va3VwX2hh
c2h0YWJsZSBzb21laG93IGludGVyZmVyZT8NCg0KU28gdGhlIHNvdXJjZSBvZiB0aGUgaXNzdWUg
dHVybmVkIG91dCB0byBiZSBjb21wbGV0ZWx5IHVucmVsYXRlZCB0byANCnRoaXMuIEFsdGhvdWdo
IGl0IHNlZW1zIGxpa2UgZW5hYmxpbmcgUFJFRU1QVF9SVF9GVUxMIHRyaWdnZXJlZCB0aGUgDQpw
cm9ibGVtIGluIG15IGNhc2UuDQoNClRoZSBsb2NrdXAgb2YgdGhlIGtlcm5lbCB3YXMgY2F1c2Vk
IGJ5IHRoZSBTTlZTIFJUQyBkcml2ZXIuIFB1bGxpbmcgaW4gDQp0aGlzIHBhdGNoOiBbMV0sIHNv
bHZlZCB0aGUgcHJvYmxlbS4NCg0KQXMgdGhpcyBwYXRjaCBmaXhlcyBhIHJlYWwgYnVnIEkgc2Vu
dCBhIHJlcXVlc3QgZm9yIGl0IHRvIGJlIGJhY2twb3J0ZWQgDQp0byB0aGUgc3RhYmxlIHJlbGVh
c2VzLg0KDQpbMV06IA0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9Y2Q3ZjNhMjQ5ZGJlZDI4NThlNmMy
ZjMwZTViZTdmMWY3YTcwOWVlMg0KDQo+Pj4+DQo+Pj4+IFsxXToNCj4+Pj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcnQvbGludXgtc3RhYmxlLXJ0Lmdp
dC9jb21taXQvP2g9djQuMTQtcnQmaWQ9NTY2ODRkMjFmN2Y4MzQxZjdhNWVkMTQzMzcxNDExMmY0
OTI5NDU5MCANCj4+Pj4NCj4+DQo+PiBTZWJhc3RpYW4NCj4+
