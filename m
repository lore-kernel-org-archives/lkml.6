Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB1C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C1218CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CEjjs979"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851C1218CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbeGFQf3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:35:29 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41179 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933735AbeGFQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:35:25 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 232BC10C0684;
        Fri,  6 Jul 2018 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530894925; bh=O+WCo44TbjT7oCG28VAzZ6eIOaJxsM5oKbZAUV0C6pU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CEjjs979sAMaNvpSKlkgMtJJA3SX4s2HF5WTF6u1BMggNn47i9/rpb5+zJBaKbeFN
         SbmZdA+8d4MWxtP/jZJ23ZkMq/s2Cr9A77Pt6IdH6+kaw/U4ORr7gUP5TKoFF492lx
         AkBv+UCdweNYE1A9cL6ont+YFXTUq17EPesYnS7LO0nefxEtRj9apeThsavJhVahRx
         J939WrVfEo5gp8Vv3ZKFJuE8cNl6UcDAx27dsVMkjsfkDh//UJunbzfkT1/cc1dtcT
         Y1uBc28HGHVGlT0vDYuUA4wc/mb53Mr77rX7/p+AH4FmqTB6BZKNnLKB/SJgwWkj6N
         EbEKB2KtvMtMg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 07E1438BE;
        Fri,  6 Jul 2018 09:35:24 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 09:35:24 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 6 Jul 2018 18:35:22 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eugeniy.paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>
Subject: Re: [PATCH v2] ARC: Configure APB GPIO controller on ARC HSDK
 platform
Thread-Topic: [PATCH v2] ARC: Configure APB GPIO controller on ARC HSDK
 platform
Thread-Index: AQHUFRS2bkeo9glRjk+/4EfPTjeLTKSCQvcA
Date:   Fri, 6 Jul 2018 16:35:21 +0000
Message-ID: <1b200ba226f7e509049f0ffbf4478ca0d80a67b0.camel@synopsys.com>
References: <5f3c59cdf0f4eb8bf22ca27031187fd866ffbecc.1530872741.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <5f3c59cdf0f4eb8bf22ca27031187fd866ffbecc.1530872741.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BCDB80801E2784AB88A35664BA75059@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VzdGF2bywNCg0KT24gRnJpLCAyMDE4LTA3LTA2IGF0IDExOjMyICswMTAwLCBHdXN0YXZv
IFBpbWVudGVsIHdyb3RlOg0KPiBJbiBjYXNlIG9mIEhTREsgd2UgaGF2ZSBpbnRlcm1lZGlhdGUg
SU5UQyBpbiBmb3Igb2YgRFcgQVBCIEdQSU8gY29udHJvbGxlcg0KPiB3aGljaCBpcyB1c2VkIGFz
IGEgZGUtYm91bmNlIGxvZ2ljIGZvciBpbnRlcnJ1cHQgd2lyZXMgdGhhdCBjb21lIGZyb20NCj4g
b3V0c2lkZSB0aGUgYm9hcmQuDQo+IA0KPiBXZSBjYW5ub3QgdXNlIGV4aXN0aW5nICJpcnEtZHct
YXBiLWljdGwiIGRyaXZlciBoZXJlIGJlY2F1c2UgYWxsIGlucHV0DQo+IGxpbmVzIGFyZSByb3V0
ZWQgdG8gY29ycmVzcG9uZGluZyBvdXRwdXQgbGluZXMgYnV0IG5vdCBtdXhlZCBpbnRvIG9uZQ0K
PiBsaW5lICh0aGlzIGlzIGNvbmZpZ3VyZWQgaW4gUlRMIGFuZCB3ZSBjYW5ub3QgY2hhbmdlIHRo
aXMgaW4gc29mdHdhcmUpLg0KPiANCj4gQnV0IGV2ZW4gaWYgd2UgYWRkIHN1Y2ggYSBmZWF0dXJl
IHRvICJpcnEtZHctYXBiLWljdGwiIGRyaXZlciB0aGF0IHdvbid0DQo+IGJlbmVmaXQgdXMgYXMg
aGlnaGVyLWxldmVsIElOVEMgKGluIGNhc2Ugb2YgSFNESyBpdCBpcyBJRFUpIGFueXdheXMgaGFz
DQo+IHBlci1pbnB1dCBjb250cm9sIHNvIGFkZGluZyBmdWxseS1jb250cm9sbGVyIGludGVybWVk
aWF0ZSBJTlRDIHdpbGwgb25seQ0KPiBicmluZyBzb21lIG92ZXJoZWFkIG9uIGludGVycnVwdCBw
cm9jZXNzaW5nIGJ1dCBubyBvdGhlciBiZW5lZml0cy4NCj4gDQo+IFRodXMgd2UganVzdCBkbyBv
bmUtdGltZSBjb25maWd1cmF0aW9uIG9mIERXIEFQQiBHUElPIGNvbnRyb2xsZXIgYW5kDQo+IGZv
cmdldCBhYm91dCBpdC4NCj4gDQo+IEJhc2VkIG9uIGltcGxlbWVudGF0aW9uIGF2YWlsYWJsZSBv
biBhcmNoL2FyYy9wbGF0LWF4czEweC9heHMxMHguYyBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQoNCkFj
a2VkLWJ5OiBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPg==
