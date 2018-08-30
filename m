Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89EBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E23205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OPDXgz5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E23205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeH3QQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:16:20 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:49282 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeH3QQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:16:20 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E7B2B24E0D52;
        Thu, 30 Aug 2018 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535631269; bh=pXIIsxuQmSWBCzRdj90PQNroC3iXUdTnDmgVyLaVHw4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OPDXgz5DsDI6BMi8/Z3GpM9oPBxcOxTDCVb0Vl7bMt/4tG7uZJkLmG+FrkkCFPz1j
         9fzSU+GDSAOy28CySq3pdWDwApAGcT2YISNaD91jtIdHNr7oQHv8etMBAPDA2QPuw0
         /kUUjgwsznVZTUhdQO1eBUdRkj7KXkPg3fUyAZ9GNWMjVRR8kadU/I+fr/gHf4MqBT
         9u2K4zpw1U3ZZem1fHev/mqHv9Bb82zfwBVK7hWBPFWqx2Wdz4JgHEAfBpupSEy9LG
         JozbdJ2EmocKOk/AuXozMntLyAnu9vKPWOvWpeUxP+Xq8bZ0j8489mhccm5oN+f7FO
         sZUgqk4O2URtQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id C3F883D13;
        Thu, 30 Aug 2018 05:14:28 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 30 Aug 2018 05:14:28 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 30 Aug 2018 14:14:26 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] GPIO: add single-register gpio via creg driver
Thread-Topic: [PATCH v2 1/2] GPIO: add single-register gpio via creg driver
Thread-Index: AQHUPsIfY3Cd69zzhkqSf9aKtntySaTVVz2AgAK/fIA=
Date:   Thu, 30 Aug 2018 12:14:25 +0000
Message-ID: <1535631219.4465.47.camel@synopsys.com>
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
         <20180828112721.28178-2-Eugeniy.Paltsev@synopsys.com>
         <024be088-15ff-89ed-3766-09eb64e47342@infradead.org>
In-Reply-To: <024be088-15ff-89ed-3766-09eb64e47342@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDFDA5BDD648947967BBC318628814F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTI4IGF0IDExOjE1IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IEhpLA0KPiANCj4gSSBkb24ndCBzZWUgYW55IHVwZGF0ZXMvY29ycmVjdGlvbnMgaGVyZS4gIDoo
DQoNCk15IGZhdWx0IC0gSSd2ZSBmb3Jnb3R0ZW4gdG8gcmUtZ2VuZXJhdGUgbmV3IHBhdGNoIHZp
YSBnaXQgZm9ybWF0LXBhdGNoDQphbmQgc2VuZCB5b3UgcHJldmlvdXMgdmVyc2lvbi4NCg0KPiAN
Cj4gT24gMDgvMjgvMjAxOCAwNDoyNyBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL0tjb25maWcgYi9kcml2ZXJzL2dwaW8vS2NvbmZp
Zw0KPiA+IGluZGV4IDcxYzBhYjQ2ZjIxNi4uMGY5Y2MxNTgyY2FiIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3Bpby9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9ncGlvL0tjb25maWcNCj4g
PiBAQCAtNDMwLDYgKzQzMCwxNSBAQCBjb25maWcgR1BJT19SRUcNCj4gPiAgCSAgQSAzMi1iaXQg
c2luZ2xlIHJlZ2lzdGVyIEdQSU8gZml4ZWQgaW4vb3V0IGltcGxlbWVudGF0aW9uLiAgVGhpcw0K
PiA+ICAJICBjYW4gYmUgdXNlZCB0byByZXByZXNlbnQgYW55IHJlZ2lzdGVyIGFzIGEgc2V0IG9m
IEdQSU8gc2lnbmFscy4NCj4gPiAgDQo+ID4gK2NvbmZpZyBHUElPX1NOUFNfQ1JFRw0KPiA+ICsJ
Ym9vbCAiR1BJTyB2aWEgQ1JFRyAoQ29udHJvbCBSRUdpc2VycykgZHJpdmVyIg0KPiA+ICsJc2Vs
ZWN0IE9GX0dQSU8NCj4gPiArCWhlbHANCj4gPiArCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgR1BJ
T3MgdmlhIENSRUcgb24gdmFyaW91cyBTeW5vcHN5cyBTb0NzLg0KPiA+ICsJICBUaGlzIGlzIGlz
IHNpbmdsZS1yZWdpc3RlciBNTUlPIGdwaW8gZHJpdmVyIGZvciBjb21wbGV4IGNhc2VzDQo+ID4g
KwkgIHdoZXJlIG9ubHkgc2V2ZXJhbCBmaWVsZHMgaW4gcmVnaXN0ZXIgYmVsb25nIHRvIEdQSU8g
YW5kDQo+ID4gKwkgIGVhY2ggR1BJTyBvd25zIGZpZWxkIHdpdGggZGlmZmVyZW50IGxlbmd0aCBh
bmQgb24vb2ZmIHZhbHVlcy4NCj4gPiArDQo+ID4gIGNvbmZpZyBHUElPX1NQRUFSX1NQSUNTDQo+
ID4gIAlib29sICJTVCBTUEVBcjEzeHggU1BJIENoaXAgU2VsZWN0IGFzIEdQSU8gc3VwcG9ydCIN
Cj4gPiAgCWRlcGVuZHMgb24gUExBVF9TUEVBUg0KPiANCj4gDQotLSANCiBFdWdlbml5IFBhbHRz
ZXY=
