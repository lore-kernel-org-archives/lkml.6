Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DACC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9012199D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9012199D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeGCIpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:45:11 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:61625 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754682AbeGCIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:45:05 -0400
Received: from 1faGve-0006ur-UV by out4b.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1faGvk-0007PO-Vb; Tue, 03 Jul 2018 01:45:00 -0700
Received: by emcmailer; Tue, 03 Jul 2018 01:45:00 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4b.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1faGve-0006ur-UV; Tue, 03 Jul 2018 01:44:54 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 3 Jul 2018 09:46:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 3 Jul 2018 09:46:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "jbeulich@suse.com" <jbeulich@suse.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Thread-Topic: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Thread-Index: AQHUEqkqUgcuA0q28EukrINgYR6YAqR9LYhQ
Date:   Tue, 3 Jul 2018 08:46:33 +0000
Message-ID: <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
References: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
 <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
In-Reply-To: <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFuIEJldWxpY2gNCj4gU2VudDogMDMgSnVseSAyMDE4IDA5OjM2DQouLi4NCj4gQXMg
c2FpZCB0aGVyZSwgb21pdHRpbmcgc3VmZml4ZXMgZnJvbSBpbnN0cnVjdGlvbnMgaW4gQVQmVCBt
b2RlIGlzIGJhZA0KPiBwcmFjdGljZSB3aGVuIG9wZXJhbmQgc2l6ZSBjYW5ub3QgYmUgZGV0ZXJt
aW5lZCBieSB0aGUgYXNzZW1ibGVyIGZyb20NCj4gcmVnaXN0ZXIgb3BlcmFuZHMsIGFuZCBpcyBs
aWtlbHkgZ29pbmcgdG8gYmUgd2FybmVkIGFib3V0IGJ5IHVwc3RyZWFtDQo+IGdhcyBpbiB0aGUg
ZnV0dXJlIChtaW5lIGRvZXMgYWxyZWFkeSkuDQouLi4NCj4gLQlidAkkOSwgRUZMQUdTKCVyc3Ap
CQkvKiBpbnRlcnJ1cHRzIG9mZj8gKi8NCj4gKwlidGwJJDksIEVGTEFHUyglcnNwKQkJLyogaW50
ZXJydXB0cyBvZmY/ICovDQoNCkhtbW0uLi4uDQpEb2VzIHRoZSBvcGVyYW5kIHNpemUgbWFrZSBh
bnkgZGlmZmVyZW5jZSBhdCBhbGwgZm9yIHRoZSBiaXQgaW5zdHJ1Y3Rpb25zPw0KSSdtIHByZXR0
eSBzdXJlIHRoYXQgdGhlIGNwdXMgKDM4NiBvbndhcmRzKSBoYXZlIGFsd2F5cyBkb25lIGFsaWdu
ZWQgMzJiaXQNCnRyYW5zZmVycyAodGhlIGRvY3MgbmV2ZXIgYWN0dWFsbHkgc2FpZCBhbGlnbmVk
KS4NCkkgY2FuJ3QgcmVtZW1iZXIgd2hldGhlciA2NGJpdCBtb2RlIGFsbG93cyBpbW1lZGlhdGVz
IGFib3ZlIDMxLg0KDQpTbyBnYXMgYWNjZXB0aW5nICdidGIgJG4sbWVtb3J5JyBpcyBnaXZpbmcg
YSBmYWxzZSBpbXByZXNzaW9uIG9mDQp3aGF0IGFjdHVhbGx5IGhhcHBlbnMuDQoNCglEYXZpZA0K
DQo=
