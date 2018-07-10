Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72646C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B667208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B667208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934693AbeGJQuX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:50:23 -0400
Received: from smtp-out6.electric.net ([192.162.217.183]:59372 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934677AbeGJQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:50:20 -0400
Received: from 1fcvq9-0003Wi-Up by out6c.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcvqB-0003c9-Ur; Tue, 10 Jul 2018 09:50:15 -0700
Received: by emcmailer; Tue, 10 Jul 2018 09:50:15 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcvq9-0003Wi-Up; Tue, 10 Jul 2018 09:50:13 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 10 Jul 2018 17:51:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 10 Jul 2018 17:51:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Thread-Topic: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Thread-Index: AQHUF7i0LRPYc54NzkS35GESBNAwxaSIq0cg
Date:   Tue, 10 Jul 2018 16:51:53 +0000
Message-ID: <cbb4e190f9de45cf8586c1df02ec3619@AcuMS.aculab.com>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <20180709084953.GB2476@hirez.programming.kicks-ass.net>
 <20180709191034.pyadc3cy7ulwaf2o@treble>
In-Reply-To: <20180709191034.pyadc3cy7ulwaf2o@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDkgSnVseSAyMDE4IDIwOjEyDQo+IE9uIE1v
biwgSnVsIDA5LCAyMDE4IGF0IDEwOjQ5OjUzQU0gKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3Rl
Og0KPiA+IE9uIFNhdCwgSnVsIDA3LCAyMDE4IGF0IDEwOjU0OjI4UE0gKzA5MDAsIFRldHN1byBI
YW5kYSB3cm90ZToNCj4gPiA+ID4+IFNpbmNlIHN5emJvdCBpcyBjb25mdXNlZCBieSBjb25jdXJy
ZW50IHByaW50aygpIG1lc3NhZ2VzIFsxXSwNCj4gPiA+ID4+IHRoaXMgcGF0Y2ggY2hhbmdlcyBz
aG93X29wY29kZXMoKSB0byB1c2Ugc25wcmludGYoKS4NCj4gPg0KPiA+IEJ1dCBob3cgYmlnIG9m
IGEgcHJvYmxlbSBpcyB0aGF0IHJlYWxseT8gV2UgY2FuJ3QgdmVyeSB3ZWxsIHJlbW92ZSBhbGwN
Cj4gPiBwcl9jb250IHN0dWZmIGZyb20gdGhlIGtlcm5lbC4NCj4gDQo+IEknZCBzYXkgd2Ugc2hv
dWxkIHRyeSB0byBtYWtlIG9vcHNlcyBhcyBsZWdpYmxlIGFzIHBvc3NpYmxlLg0KDQpUbyBtYWtl
IG9vcHNlcyBsZWdpYmxlIHlvdSBuZWVkIHRvIGxvY2sgdGhlIG91dHB1dCBiZXR3ZWVuIG91dHB1
dCBsaW5lcy4NCldoaWNoIHdvdWxkIHJlcXVpcmUgYSAnS0VSTl9DT05USU5VRUQnIG1hcmtlciBv
biB0aGUgcHJldmlvdXMgcHJpbnQuDQoNCj4gQWxzbyBLRVJOX0NPTlQgaXMgaW5oZXJlbnRseSBi
cm9rZW4sIGFuZCB3ZSBzaG91bGQgYXZvaWQgdXNpbmcgaXQgaW4NCj4gZ2VuZXJhbCwgSU1PLg0K
DQpJJ20gc3VyZSBzb21ldGhpbmcgc2VtaS1hdXRvbWF0aWMgY291bGQgYmUgZG9uZSB0byBleHBl
Y3QgYSBmdXJ0aGVyDQpwcmludCBpZiB0aGUgbGluZSBkb2Vzbid0IGVuZCBpbiAnXG4nLg0KQSBw
ZXItY3B1IGxpbmUgYnVmZmVyIGlzIHByb2JhYmx5IGV4Y2Vzc2l2ZSwgYnV0IHNvbWUga2luZCBv
Zg0KdGltaW5nIG91dCBsb2NrIG1pZ2h0IHdvcmsgKHJlbGVhc2UgZXhwZWN0aW5nIHJlLWFjcXVp
cmUpLg0KDQoJRGF2aWQNCg0K
