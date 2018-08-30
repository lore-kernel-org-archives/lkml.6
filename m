Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QQMNnmuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2762420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeH3WTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:19:33 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:39654 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeH3WTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:19:33 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B899810C0790;
        Thu, 30 Aug 2018 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535652969; bh=3OT9Dh1d8a5eqZnNX91YkGNYh/amv2V3rgCKyd2g6Ns=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QQMNnmuB9VLo6/zhhfhDWl82YB7nDP6oeTK50jUF3e4CIxW+yMNC6NzlK0i+kbDuX
         YI/xv3qpDcbfk2QtM8yGgMjg7UFlwS6cpM0oYxTfqvLGFtO7PB9XBswCVv9+OlzHd2
         Bq88S5KG1+dEpQRM8Ssq0mzO3LDOnkkKJxbXncqYXwwwlPvQXMlEx5GZdwYX8xlS70
         EMVj56qpeJgskI8PccpCDFpoL/NIKnKqYNGU0+1ftmIF8EGEr7rBy/WzgkA7jPxRQQ
         fdGgGxnwWW8xOhaZG6lSMl/MBI/V7XpDco2dVPLEpFEBQ9GyUqvmZuXOwuap7JisZ2
         Pvy7vuKlFFrSw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 93A0B3295;
        Thu, 30 Aug 2018 11:16:09 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 30 Aug 2018 11:16:09 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 30 Aug 2018 20:16:07 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via CREG
 bindings
Thread-Topic: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via
 CREG bindings
Thread-Index: AQHUPsIhxB1AAPfufUm06BH0xqwcvqTX3BAAgACf7IA=
Date:   Thu, 30 Aug 2018 18:16:06 +0000
Message-ID: <1535652965.4465.84.camel@synopsys.com>
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
         <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com>
         <CACRpkdbQryY-R+14GvYAEkLH+7Tr4Pvb6YohWouTwug7qEGbDA@mail.gmail.com>
In-Reply-To: <CACRpkdbQryY-R+14GvYAEkLH+7Tr4Pvb6YohWouTwug7qEGbDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B9760F1D93627448C72AA0FD8165E0F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTMwIGF0IDEwOjQzICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBUdWUsIEF1ZyAyOCwgMjAxOCBhdCAxOjI3IFBNIEV1Z2VuaXkgUGFsdHNldg0KPiA8RXVn
ZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+IA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL3NucHMsY3JlZy1ncGlvLnR4dA0KPiA+IEBA
IC0wLDAgKzEsNDkgQEANCj4gPiArR1BJTyB2aWEgQ1JFRyAoQ29udHJvbCBSRUdpc2VycykgZHJp
dmVyDQpbc25pcF0NCg0KPiA+ICstIHNucHMsbmdwaW9zOiBOdW1iZXIgb2YgR1BJTyBwaW5zLg0K
PiANCj4gVXNlIHRoZSBleGlzdGluZyBuZ3Bpb3MgYXR0cmlidXRlIGZvciB0aGlzLCBzZWUgZ3Bp
by50eHQNCg0KT2sNCg0KPiA+ICstIHNucHMsYml0LXBlci1saW5lOiBOdW1iZXIgb2YgYml0cyBw
ZXIgZWFjaCBncGlvIGxpbmUgKHNlZSBwaWN0dXJlKS4NCj4gPiArICBBcnJheSB0aGUgc2l6ZSBv
ZiAic25wcyxuZ3Bpb3MiDQo+ID4gKy0gc25wcyxzaGlmdDogU2hpZnQgKGluIGJpdHMpIG9mIHRo
ZSBlYWNoIEdQSU8gZmllbGQgZnJvbSB0aGUgcHJldmlvdXMgb25lIGluDQo+ID4gKyAgcmVnaXN0
ZXIgKHNlZSBwaWN0dXJlKS4gQXJyYXkgdGhlIHNpemUgb2YgInNucHMsbmdwaW9zIg0KPiA+ICst
IHNucHMsb24tdmFsOiBWYWx1ZSBzaG91bGQgYmUgc2V0IGluIGNvcnJlc3BvbmRpbmcgZmllbGQg
dG8gc2V0DQo+ID4gKyAgb3V0cHV0IHRvICIxIiAoc2VlIHBpY3R1cmUpLiBBcnJheSB0aGUgc2l6
ZSBvZiAic25wcyxuZ3Bpb3MiDQo+ID4gKy0gc25wcyxvZmYtdmFsOiBWYWx1ZSBzaG91bGQgYmUg
c2V0IGluIGNvcnJlc3BvbmRpbmcgZmllbGQgdG8gc2V0DQo+ID4gKyAgb3V0cHV0IHRvICIwIiAo
c2VlIHBpY3R1cmUpLiBBcnJheSB0aGUgc2l6ZSBvZiAic25wcyxuZ3Bpb3MiDQo+IA0KPiBNb3Zl
IHRoaXMgaW50byBhIGxvb2t1cCB0YWJsZSBpbiB0aGUgZHJpdmVyIGluc3RlYWQsIGFuZCBtYXRj
aA0KPiB0aGUgbG9va3VwIHRhYmxlIHRvIHRoZSBjb21wYXRpYmxlIHN0cmluZy4gVGhlIGZvcm1h
dCBvZiB0aGUNCj4gcmVnaXN0ZXIgaXMga25vd24gZm9yIGEgY2VydGFpbiBjb21wYXRpYmxlLCBy
aWdodD8NCg0KQWN0dWFsbHkgSSByZWFsbHkgZG9uJ3Qgd2FudCB0byBoYXJkY29kZSB0aGlzIHZh
bHVlcyBpbnRvIGxvb2t1cCB0YWJsZSBhcyBJIGdvaW5nIHRvIHVzZQ0KdGhpcyBkcml2ZXIgb24g
MyBhbHJlYWR5IHVwc3RyZWFtZWQgcGxhdGZvcm1zIGFuZCBhdCBsZWFzdCBvbmUgdXBjb21pbmcu
DQoNClRoZXkgYWxsIGhhdmUgc3VjaCBDUkVHIHBzZXVkby0nR1BJT3MnIGRpZmZlcmVudGx5IG1h
cHBlZCB3aXRoIGRpZmZlcmVudCBJTyBsaW5lcyBudW1iZXIsDQpkaWZmZXJlbnQgZW5hYmxlL2Rp
c2FibGUgdmFsdWUsIGV0Yy4uLg0KDQpJcyBpdCByZWFsbHkgYSBwcm9ibGVtIHRvIGhhdmUgdGhp
cyB2YWx1ZXMgY29uZmlndXJlZCB2aWEgZGV2aWNlIHRyZWU/DQpJZiB3ZSByZWFkIHRoZW0gZnJv
bSBEVCB3ZSBhcmUgYWJsZSB0byB1c2UgdGhpcyBnZW5lcmljIGFuZCBjb25maWd1cmFibGUgZHJp
dmVyIHRvIGhhbmRsZQ0KYm90aCBleGlzdGluZyBhbmQgdXBjb21pbmcgcGxhdGZvcm1zIHdpdGhv
dXQgdGhlIG5lZWQgb2YgcGF0Y2hpbmcgdGhlIGRyaXZlciBvbiBldmVyeSBuZXcNCnBsYXRmb3Jt
IHVwc3RyZWFtaW5nLg0KDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0KLS0gDQogRXVn
ZW5peSBQYWx0c2V2
