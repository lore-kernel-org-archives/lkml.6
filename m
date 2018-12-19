Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE841C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9594221841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeLSNqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:46:44 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:46958 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeLSNqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:46:43 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id F125B67A07A;
        Wed, 19 Dec 2018 14:46:34 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 19 Dec
 2018 14:46:34 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 19 Dec 2018 14:46:34 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Topic: RT-Kernel boot stalls because of change in fs/dcache.c
Thread-Index: AQHUlfUoWBvAkgSJkE+oWdptakv0L6WFokmAgAA/TYCAACQ9gA==
Date:   Wed, 19 Dec 2018 13:46:34 +0000
Message-ID: <d9448930-e466-864a-41ce-08bf4588d0d1@kontron.de>
References: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
 <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
 <20181219113650.ak3wj3h3oapfy3tj@linutronix.de>
In-Reply-To: <20181219113650.ak3wj3h3oapfy3tj@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <86BED2A03AFBD14C825E6D010706EF2E@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: F125B67A07A.ACAC3
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQpPbiAxOS4xMi4xOCAxMjozNiwgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciB3cm90ZToNCj4gT24gMjAxOC0xMi0xOSAwNzo1MDoxNyBbKzAwMDBdLCBTY2hyZW1wZiBG
cmllZGVyIHdyb3RlOg0KPj4gKyBsaW51eC1ydC11c2Vycw0KPj4NCj4+IE9uIDE3LjEyLjE4IDEx
OjQyLCBGcmllZGVyIFNjaHJlbXBmIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gSSBoYXZlIHRy
aWVkIHRvIGJvb3QgYSA0LjE0LUtlcm5lbCB3aXRoIHRoZSBSVC1wYXRjaGVzIGFuZA0KPj4+IFBS
RUVNUFRfUlRfRlVMTCBvbiBhbiBpLk1YNlVMIGJvYXJkLiBVbmZvcnR1bmF0ZWx5IHRoZSBib290
IHN0YWxscyBhdA0KPj4+IHNvbWUgcG9pbnQgYW5kIG5ldmVyIGZpbmlzaGVzLg0KPj4+DQo+Pj4g
SSBkaWQgc29tZSBiaXNlY3RpbmcgYW5kIGZvdW5kIG91dCwgdGhhdCByZXZlcnRpbmcgdGhpcyBj
aGFuZ2U6IFsxXSwNCj4+PiBtYWtlcyB0aGUgYm9hcmQgYm9vdCBjb3JyZWN0bHkuDQo+Pj4NCj4+
PiBDYW4gYW55b25lIGhlbHAgdG8gY29tZSB1cCB3aXRoIGEgcHJvcGVyIGZpeCBmb3IgdGhpcz8N
Cj4gDQo+IGNhbiB5b3UgY2hlY2sgaWYgdGhlIGhhc2h0YWJsZSBpcyBpbml0aWFsaXplZCB0d2lj
ZT8NCg0KSSdtIG5vdCBzdXJlIGhvdyB0byBjaGVjaywgYnV0IEkgZ3Vlc3MgeW91IGFyZSBvbiB0
aGUgcmlnaHQgdHJhY2suIEkgY2FuIA0KbGVhdmUgdGhlIGluaXQgbG9vcCBmb3IgZGVudHJ5X2hh
c2h0YWJsZSBpbiBwbGFjZSBhbmQgcmVtb3ZlIHRoZSBvbmUgZm9yIA0KaW5fbG9va3VwX2hhc2h0
YWJsZSBpbiB2ZnNfY2FjaGVzX2luaXRfZWFybHkoKSBhbmQgdGhpcyBhbHNvIG1ha2VzIHRoZSAN
CmJvYXJkIGJvb3QuDQoNCkNvdWxkIGl0IGJlLCB0aGF0IHRoZSBpbml0aWFsaXppbmcgZm9yIGRl
bnRyeV9oYXNodGFibGUgYW5kIA0KaW5fbG9va3VwX2hhc2h0YWJsZSBzb21laG93IGludGVyZmVy
ZT8NCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAsDQpGcmllZGVyDQoNCj4gDQo+Pj4gVGhhbmtzLA0K
Pj4+IEZyaWVkZXINCj4+Pg0KPj4+IFsxXToNCj4+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9ydC9saW51eC1zdGFibGUtcnQuZ2l0L2NvbW1pdC8/aD12
NC4xNC1ydCZpZD01NjY4NGQyMWY3ZjgzNDFmN2E1ZWQxNDMzNzE0MTEyZjQ5Mjk0NTkwDQo+IA0K
PiBTZWJhc3RpYW4NCj4g
