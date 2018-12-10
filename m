Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC544C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8347620672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeLJVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:14:28 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:36476 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeLJVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:14:27 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wBALDe2B002137
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 06:13:40 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wBALDecV022619;
        Tue, 11 Dec 2018 06:13:40 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wBALDeQQ014850;
        Tue, 11 Dec 2018 06:13:40 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-517067; Tue, 11 Dec 2018 06:10:42 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Tue,
 11 Dec 2018 06:10:41 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, lijiang <lijiang@redhat.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Thread-Topic: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Thread-Index: AQHUjKXemQXNLRGc+UGdsBH5ZuUNaqVwM/AQgAeJRICAAK+kgA==
Date:   Mon, 10 Dec 2018 21:10:41 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03564659@BPXM09GP.gisp.nec.co.jp>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205113032.GF29510@zn.tnic>
 <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0356426E@BPXM09GP.gisp.nec.co.jp>
 <20181210183221.GA5482@zn.tnic>
In-Reply-To: <20181210183221.GA5482@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.135.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBtYWtlZHVtcGZpbGUgZG9lc24ndCBoYXZl
IGFueSBzd2l0Y2ggd2hpY2ggZHVtcHMgVk1DT1JFSU5GTyBmcm9tIGtjb3JlDQo+ID4gZm9yIG5v
dy4gKEknbSB0aGlua2luZyB0byBoYXZlIG1ha2VkdW1wZmlsZSBkdW1wIGl0IGFzIGRlYnVnIG1l
c3NhZ2UsDQo+ID4gdGhvdWdoLikNCj4gDQo+IE1pZ2h0IGJlIHVzZWZ1bCBhcyBwZW9wbGUgYXJl
IGxvb2tpbmcgaW50byB1c2luZyBWTUNPUkVJTkZPIHdoZW4NCj4gZGVidWdnaW5nIGEgbGl2ZSBr
ZXJuZWwuLi4NCg0KTm93IG1ha2VkdW1wZmlsZSBpbiAnZGV2ZWwnIGJyYW5jaCBjYW4gcHJpbnQg
Vk1DT1JFSU5GTyBpbiAvcHJvYy9rY29yZQ0KYXMgZGVidWcgbWVzc2FnZSB3aXRoIHRoZSBmb2xs
b3dpbmcgY29tbWFuZDoNCg0KIyAuL21ha2VkdW1wZmlsZSAtLW1lbS11c2FnZSAvcHJvYy9rY29y
ZSAtRA0KLi4uDQpWTUNPUkVJTkZPICAgOg0KICBPU1JFTEVBU0U9NC4yMC4wLTAucmMyLmdpdDAu
MS5mYzMwLng4Nl82NA0KICBQQUdFU0laRT00MDk2DQpwYWdlX3NpemUgICAgOiA0MDk2DQogIFNZ
TUJPTChpbml0X3V0c19ucyk9ZmZmZmZmZmY4NDIxMzU0MA0KICAuLi4NCg0KQWxzbywgaXQgc2Vl
bXMgdGhhdCByZWNlbnQgY3Jhc2ggdXRpbGl0eSBpbiBnaXQgcmVwbyB3aXRoIGtlcm5lbCA0LjE5
DQpvciBuZXdlciBjYW4gZHVtcCBpdCB3aXRoICdoZWxwIC1uJyBjb21tYW5kOg0KDQojIC4vY3Jh
c2ggdm1saW51eCAvcHJvYy9rY29yZQ0KLi4uDQpjcmFzaD4gaGVscCAtbg0KLi4uDQogIEVsZjY0
X05oZHI6DQogICAgICBuX25hbWVzejogMTEgKCJWTUNPUkVJTkZPIikNCiAgICAgIG5fZGVzY3N6
OiAxOTU1DQogICAgICAgIG5fdHlwZTogMCAodW5rbm93bikNCg0KICAgICAgT1NSRUxFQVNFPTQu
MjAuMC0wLnJjMi5naXQwLjEuZmMzMC54ODZfNjQNCiAgICAgIFBBR0VTSVpFPTQwOTYNCiAgICAg
IFNZTUJPTChpbml0X3V0c19ucyk9ZmZmZmZmZmY4NDIxMzU0MA0KICAgICAgLi4uDQoNClRoYW5r
cywNCkthenUNCg==

