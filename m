Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C9D20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DdXo6UXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C9D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeGIImj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:42:39 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45199 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeGIIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:08 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 92D7A10C1A29;
        Mon,  9 Jul 2018 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531125427; bh=R95diFH99Kvv4iB4OdRDcySG3rCEUPHDGtNpbZY21rU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DdXo6UXODetHTIcvL6dgjYTMnUBL5YZjghW+8qWCsS/A3IpaD7SKZDz515vRpNOFM
         CPF2gZ4Ghj5zMzfS2Gib0fiuQilBnzMiNJ6DlbnUlJh9EKsdd3MY6bFoklTbfmjDFv
         lP9afAGgcHGw5I3hsRqpE0tZnkQqzg/DngGic9NGywOCKObQfT2O8YdosPxtU0ikjj
         pAaTlIQFVXH6ckLFFq/Z06HXHpY0nVIaBadfRKyMpw5clzhHUsFmrgq9qAb5vMdvQe
         sE3MnRlhzMM2uCJhdZAf/Qr8GqXVk8fICSreWgEA1s0vpL2sWdv4uCikdPH+TH3d0F
         Y19WJdc4CcyVA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3137038FA;
        Mon,  9 Jul 2018 01:37:07 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 01:37:07 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 10:37:04 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGQPUAgAAV8ICAAAQqgIAACJwAgAAMUgA=
Date:   Mon, 9 Jul 2018 08:37:03 +0000
Message-ID: <cabc2aa35ecf81dc7a47d4ec7bd5dcb1c3d566c3.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <20180709054842.GB7618@kroah.com>
         <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
         <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
         <CAMuHMdULgdLsETpZ9+RC6d2ZoARPs72Fn=SRboM-8Xm7t1Qd2g@mail.gmail.com>
In-Reply-To: <CAMuHMdULgdLsETpZ9+RC6d2ZoARPs72Fn=SRboM-8Xm7t1Qd2g@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB46D824A85094695C2F5BA0064F527@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAwOTo1MiArMDIwMCwgR2VlcnQgVXl0
dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBBbGV4ZXksDQo+IA0KPiBPbiBNb24sIEp1bCA5LCAyMDE4
IGF0IDk6MjIgQU0gQWxleGV5IEJyb2RraW4NCj4gPEFsZXhleS5Ccm9ka2luQHN5bm9wc3lzLmNv
bT4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE4LTA3LTA5IGF0IDA5OjA3ICswMjAwLCBHZWVydCBV
eXR0ZXJob2V2ZW4gd3JvdGU6DQo+ID4gPiBPbiBNb24sIEp1bCA5LCAyMDE4IGF0IDc6NDkgQU0g
R3JlZyBLSCA8Z3JlZ0Brcm9haC5jb20+IHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIEp1bCAwOSwg
MjAxOCBhdCAwNzo0NDo0NEFNICswMzAwLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4gPiA+ID4g
PiBEZXBlbmRpbmcgb24gQUJJICJsb25nIGxvbmciIHR5cGUgb2YgYSBwYXJ0aWN1bGFyIDMyLWJp
dCBDUFUNCj4gPiA+ID4gPiBtaWdodCBiZSBhbGlnbmVkIGJ5IGVpdGhlciB3b3JkICgzMi1iaXRz
KSBvciBkb3VibGUgd29yZCAoNjQtYml0cykuDQo+ID4gPiANCj4gPiA+IE9yIGV2ZW4gMTYtYml0
IChvbiBlLmcuIG02OGspLg0KPiA+IA0KPiA+IEluZGVlZCwgdGhhbmtzIGZvciB0aGUgbm90ZSEN
Cj4gPiBXaWxsIGFkZCB0aGlzIGluIG15IHYzLg0KPiANCj4gTm90ZSB0aGF0IGluIHRoaXMgcGFy
dGljdWxhciBjYXNlLCB0aGUgZmllbGQgd2lsbCBwcm9iYWJseSBhbHdheXMgYmUNCj4gYWxpZ25l
ZCB0byA0IGJ5dGVzLA0KPiBhcyB0aGUgc3RydWN0IHdpbGwgYmUgYWxsb2NhdGVkIHVzaW5nICph
bGxvYygpLg0KDQpXZWxsIEkgdGhpbmsgbWF5YmUgaXQgd29ydGggbWVudGlvbmluZyBvbmx5IDMy
LWJpdCBhbmQgNjQtYml0IGFsaWdubWVudHMgaW4NCnRoaXMgcGFydGljdWxhciBjYXNlIGJlY2F1
c2UgYXMgaXQgd2FzIG1lbnRpb25lZCBpbml0aWFsbHkgaW4gdGhlIGNvbW1lbnQgdGhlcmUncmUN
CjMgcG9pbnRlcnMgYmVmb3JlICJkYXRhIiBmaWVsZCBhbmQgZm9yIDMyLWJpdCBtYWNoaW5lcyBJ
IGd1ZXNzIHdlIG1heSBzYWZlbHkNCmFzc3VtZSB0aGF0IGEgcG9pbnRlciBzaXplIGlzIDMyLWJp
dC4NCg0KVGhpcyBsZWF2ZXMgdXMgb25seSBvbmUgcHJvYmxlbWF0aWMgc2l0dWF0aW9uIDMyLWJp
dCBpbnN0ZWFkIG9mIDY0LWJpdCBhbGlnbm1lbnQuDQoNCj4gPiBGb3IgQVJDIEknZCBsaWtlIHRo
aXMgZml4IHRvIGJlIGJhY2stcG9ydGVkIHN0YXJ0aW5nDQo+ID4gZnJvbSB2NC44IHdoZXJlIHdl
IGFkZGVkIHN1cHBvcnQgb2YgIm5hdGl2ZSIgYXRvbWljNjRfdCwgc2VlIGNvbW1pdA0KPiA+IGNl
NjM2NTI3MGVjZCAoIiBBUkN2MjogSW1wbGVtZW50IGF0b21pYzY0IGJhc2VkIG9uIExMT0NLRC9T
Q09OREQgaW5zdHJ1Y3Rpb25zIikuDQo+ID4gDQo+ID4gV2hhdCBhYm91dCBtNjhrLCBkbyB5b3Ug
aGF2ZSBhbnkgcHJlZmVyZW5jZSBvZiBlYXJsaWVzdCBrZXJuZWwgdmVyc2lvbg0KPiA+IHdoZXJl
IHRoaXMgZml4IG1pZ2h0IGJlIHVzZWZ1bD8NCj4gDQo+IEdpdmVuIG02OGsgaXMgMzItYml0LCBp
dCB3aWxsIGFjY2VzcyBhdG9taWM2NF90IHZhcmlhYmxlcyB3aGlsZQ0KPiBob2xkaW5nIGEgc3Bp
bmxvY2ssDQo+IHNvIGl0IHNob3VsZCBzdGlsbCBiZSBzYWZlIHdpdGhvdXQgdGhpcyBjaGFuZ2Uu
DQoNCldlbGwgQVJDIGFuZCBBUk12NyBhcmUgMzItYml0IG1hY2hpbmVzIGFzIHdlbGwgc3RpbGwg
Ym90aCBoYXZlDQphIHNwZWNpYWwgaW5zdHJ1Y3Rpb25zIHRvIHJlYWQvd3JpdGUgNjQtYml0IGRh
dGEuDQoNCj4gTm90IHRvIG1lbnRpb24gbm8gb25lIHdpbGwgdHJ5IGV0bmF2aXYgb24gbTY4ayA7
LSkNCg0KU2VlIGl0IHdhcyBqdXN0IGEgdHJpZ2dlciBjYXNlIGJ1dCBvdGhlciBHUFVzIHRoYXQg
dXNlIG9yIHdpbGwgdXNlDQpEUk0gR1BVIHNjaGVkdWxlciBhcmUgZ29vZCBjYW5kaWRhdGVzIHRv
IGl0IHRoYXQgcHJvYmxlbSBhbmQgbm90IHRvDQptZW50aW9uIHNvbWUgb3RoZXIgdXNlcnMgb2Yg
YXRvbWljNjRfdC4NCg0KQnV0IGZyb20geW91IGFib3ZlIGNvbW1lbnQgSSBtYXkgZGVkdWNlIHRo
YXQgbTY4ayBkb2Vzbid0IGhhdmUNCmluc3RydWN0aW9ucyBmb3IgNjQtYml0IGRhdGE7IGluIHRo
YXQgY2FzZSB0aGVyZSdzIG5vIHJlYXNvbiB0byB3b3JyeQ0KYXQgbGVhc3QgYWJvdXQgc3RydWN0
IGRldnJlc19ub2RlIDopDQoNCi1BbGV4ZXk=
