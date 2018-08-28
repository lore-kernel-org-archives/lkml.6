Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33F9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A8620842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DeQOY/ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A8620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeH1Ozu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:55:50 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:60690 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeH1Ozu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:55:50 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A805124E2570;
        Tue, 28 Aug 2018 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535454283; bh=+AlZw9trSky9h9cjyoCx5vU8hWbtqFuztSJqnv6gi1Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DeQOY/ED5CnwVjp/ym3LLvO8U5SpT8PlCULlboDzxxx/ntl+xJL0AqZW63f+e8QvW
         OAm+eh3fRe0CzdXG/ddt+ATtmn+PbjnavV2Cc/DZxHhbzLvoETh0vk84zHoUGJq6yS
         cNdp6p9UguTpkUWxQPknTj/A5/k9DSeQUHZqkQyRLIz5OuaMWXVRLJ9rI0IT2II+XX
         PVHQ6sXZ89RWUGLTJ55HP5QWtwwR+GdvsRcY+9keox0f4tlYs/EY9y/ikbvAxJkCH2
         xoXP8YP0lcQ/3omKgjAilPjlbibJTR3vtWIiLaaHH+YXtz9Y/fI4qzFqd9dEmMOGoC
         pycIU00YLboMw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 29ACE3D1E;
        Tue, 28 Aug 2018 04:04:42 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 28 Aug 2018 04:04:41 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 28 Aug 2018 13:04:39 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] GPIO: add single-register gpio via creg driver
Thread-Topic: [PATCH 1/2] GPIO: add single-register gpio via creg driver
Thread-Index: AQHUOvIJDEdSDSpA8ESZHK2vWQNSu6TNTuYAgAeXgIA=
Date:   Tue, 28 Aug 2018 11:04:38 +0000
Message-ID: <1535454277.24765.1.camel@synopsys.com>
References: <20180823150013.21837-1-Eugeniy.Paltsev@synopsys.com>
         <20180823150013.21837-2-Eugeniy.Paltsev@synopsys.com>
         <c5f75b43-6ef3-31e2-0366-b6c8623d3f5d@infradead.org>
In-Reply-To: <c5f75b43-6ef3-31e2-0366-b6c8623d3f5d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2E4A5A9F3CE234FA728D27A04B4E36C@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCnRoYW5rcyBmb3IgY29tbWVudHMsIHdpbGwgYmUgZml4ZWQgaW4gcGF0Y2gg
VjIuDQoNCk9uIFRodSwgMjAxOC0wOC0yMyBhdCAwODowOCAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOg0KPiBPbiAwOC8yMy8yMDE4IDA4OjAwIEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9LY29uZmlnIGIvZHJpdmVycy9ncGlvL0tjb25m
aWcNCj4gPiBpbmRleCA3MWMwYWI0NmYyMTYuLjBmOWNjMTU4MmNhYiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwaW8vS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3Bpby9LY29uZmlnDQo+
ID4gQEAgLTQzMCw2ICs0MzAsMTUgQEAgY29uZmlnIEdQSU9fUkVHDQo+ID4gIAkgIEEgMzItYml0
IHNpbmdsZSByZWdpc3RlciBHUElPIGZpeGVkIGluL291dCBpbXBsZW1lbnRhdGlvbi4gIFRoaXMN
Cj4gPiAgCSAgY2FuIGJlIHVzZWQgdG8gcmVwcmVzZW50IGFueSByZWdpc3RlciBhcyBhIHNldCBv
ZiBHUElPIHNpZ25hbHMuDQo+ID4gIA0KPiA+ICtjb25maWcgR1BJT19TTlBTX0NSRUcNCj4gPiAr
CWJvb2wgIkdQSU8gdmlhIENSRUcgKENvbnRyb2wgUkVHaXNlcnMpIGRyaXZlciINCj4gDQo+IAkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJFR2lzdGVycykNCj4gDQo+ID4gKwlzZWxlY3Qg
T0ZfR1BJTw0KPiA+ICsJaGVscA0KPiA+ICsJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBHUElPcyB2
aWEgQ1JFRyBvbiB2YXJpb3VzIFN5bm9wc3lzIFNvQ3MuDQo+ID4gKwkgIFRoaXMgaXMgaXMgc2lu
Z2xlLXJlZ2lzdGVyIE1NSU8gZ3BpbyBkcml2ZXIgZm9yIGNvbXBsZXggY2FzZXMNCj4gDQo+IAkg
IFRoaXMgaXMgYSAgICAgICAgICAgICAgICAgIE1NSU8gR1BJTw0KPiANCj4gPiArCSAgd2hlcmUg
b25seSBzZXZlcmFsIGZpZWxkcyBpbiByZWdpc3RlciBiZWxvbmcgdG8gR1BJTyBhbmQNCj4gDQo+
IAkgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW4gYSByZWdpc3Rlcg0KPiANCj4gPiArCSAg
ZWFjaCBHUElPIG93bnMgZmllbGQgd2l0aCBkaWZmZXJlbnQgbGVuZ3RoIGFuZCBvbi9vZmYgdmFs
dWVzLg0KPiANCj4gbWF5YmU6DQo+IAkgICAgICAgICAgICAgICAgIGZpZWxkcyB3aXRoIGRpZmZl
cmVudCBsZW5ndGhzDQo+IA0KPiA+ICsNCj4gPiAgY29uZmlnIEdQSU9fU1BFQVJfU1BJQ1MNCj4g
PiAgCWJvb2wgIlNUIFNQRUFyMTN4eCBTUEkgQ2hpcCBTZWxlY3QgYXMgR1BJTyBzdXBwb3J0Ig0K
PiA+ICAJZGVwZW5kcyBvbiBQTEFUX1NQRUFSDQo+IA0KPiANCi0tIA0KIEV1Z2VuaXkgUGFsdHNl
dg==
