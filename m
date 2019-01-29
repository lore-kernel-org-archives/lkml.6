Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73705C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B8921473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kvyu8utr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfA2Rca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:32:30 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:35444 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfA2Rca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:32:30 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 4FF7210C15B3;
        Tue, 29 Jan 2019 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548783150; bh=ibL+64ziqHSaoC0t51v+5CQbE3Q1Am78u9L9VtwtGrg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kvyu8utrYFBVrfp6MArX36XQprIT0EvzrsLjSDlePK9b0ZbPE2Guww436H/pSM0lx
         QKy9X0OLOmEzL0uEhJ+WsatzH2j5x9LRdM/OEhidqreVxfQBBM3O0u3YCFwFCQEyYD
         xnYBjO0K2W2YR9GfQHi6h/lRHiKLr0cQg9ac7BznXnKZMUtzk3TWIBT+XZ175sANj0
         eApUq5qunAZJ9bx2SoDQsCSc0+wlwuaR+JXi1Cp8ak8YN4FNk5wDYr++xjwbb/de85
         96WEdafoT8DpZhsfZ+RCC1sANMnUtxE1PJ+HTbIg1rPICg6thbew/MN2415KqCvQ0C
         Zl8Mh7uvicniA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1FDFBA00D5;
        Tue, 29 Jan 2019 17:32:29 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Jan 2019 09:32:09 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 29 Jan 2019 18:32:06 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Thread-Topic: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Thread-Index: AQHUrY7S1r2HqQHrAUmKrUzEXiBQFaXGhToA
Date:   Tue, 29 Jan 2019 17:32:06 +0000
Message-ID: <1548783126.29008.22.camel@synopsys.com>
References: <20190116112951.10641-1-Eugeniy.Paltsev@synopsys.com>
         <3c341dd9-f360-640e-a3c9-3291300d02ae@synopsys.com>
         <1548782756.29008.20.camel@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075014642D45B@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014642D45B@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <945BF332CBA9624B91ABC437F0544F6A@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAxLTI5IGF0IDA5OjI4IC0wODAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDEvMjkvMTkgOToyNiBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiA+ID4gSSBwcmVz
dW1lIHRoZXJlIGlzIG5vIHNwZWNpZmljIHJlYXNvbiB0byBpbmNsdWRlIHRoaXMgY29uZGl0aW9u
YWxseS4NCj4gPiA+IGlycWZsYWdzLmggYWxyZWFkeSBpbmNsdWRlcyB0aGUgcmlnaHQgdmVyc2lv
bi4NCj4gPiANCj4gPiBBZ3JlZS4NCj4gPiBJJ3ZlIGp1c3QgZm9yZ290dGVuIGFib3V0IGNvbW1v
biBpcnFmbGFncy5oDQo+IA0KPiBObyBuZWVkIGZvciB0aGlzIHNlcmllcy4gR2l2ZW4gQWxleGV5
J3MgcmVxdWVzdCwgSSd2ZSBwdXNoZWQgdGhlIG1pbmltYWwgcGF0Y2guDQo+IFlvdSBkbyBuZWVk
IHRvIHJlYmFzZSB0aGUgb3RoZXIgdW5hbGluZ2VkIGFjY2VzcyBzZXJpZXMgb24gdG9wLCBob3dl
dmVyIHdhaXQgZm9yDQo+IG1lIHRvIGNvbW1lbnQgb24gdGhhdC4NCg0KT2suDQoNCj4gLVZpbmVl
dA0KPiANCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
