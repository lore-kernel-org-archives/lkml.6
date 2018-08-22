Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454362089F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h6s7/ZsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454362089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHVWGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:06:32 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46438 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeHVWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:06:31 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 17C3210C09A5;
        Wed, 22 Aug 2018 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534963231; bh=Qu0iYs8wWLOjHJnp7xshH2ji8kCQV/VxeBDaeB9/e/M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h6s7/ZsFdQLDpKpgX+X1SvhYME15huy48DbEql3TOEDg03ysn8DjS2KE2q3UbpFC3
         yc+FPu0/JmOAbp+Nn2DFPJyzUG/3/KD2k+T77b883Jn5Ho+rZkBpSdtFeofAqd2qOe
         cQXx+voEoXh64CCh3EjFu5vc/GzeSMRsSg3VFO/Qk7g5zxKnCeMo4IPPgM5aCil7b7
         /ekWAmkHJ+KostcGOKhRvdCxSNU+04RfpnQ1q+K0LrU1VOLWmrG6uQPuy048caWqoY
         5rCj0bmf9VWOSWUzRDfDdeEbQdwUYSmAzwPYs2PxakA+I2mZydd0g4x2vwjeNxCXkB
         jnoyfBirUs2dg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C81C83CF6;
        Wed, 22 Aug 2018 11:40:30 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 22 Aug 2018 11:40:30 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 22 Aug 2018 20:40:28 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUKCIdYG/CsJzRCEqtaR4z1gy7YaS93p+AgAtbgoCAAuNCAA==
Date:   Wed, 22 Aug 2018 18:40:27 +0000
Message-ID: <1534963226.3962.215.camel@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
         <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com>
         <1534180089.3962.68.camel@synopsys.com>
         <81ddd506-1f7e-db82-4c77-ff08b1c15dd3@synopsys.com>
In-Reply-To: <81ddd506-1f7e-db82-4c77-ff08b1c15dd3@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <782B7B2CFC7553469BA8F1DD9EBA45B6@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBNb24sIDIwMTgtMDgtMjAgYXQgMTU6MzQgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDgvMTMvMjAxOCAxMDowOCBBTSwgRXVnZW5peSBQYWx0c2V2IHdy
b3RlOg0KPiA+IE9uIE1vbiwgMjAxOC0wOC0xMyBhdCAxNjoyNCArMDAwMCwgVmluZWV0IEd1cHRh
IHdyb3RlOg0KPiA+ID4gT24gMDcvMzAvMjAxOCAwOToyNiBBTSwgRXVnZW5peSBQYWx0c2V2IHdy
b3RlOg0KPiA+ID4gPiBAQCAtMTI2MywxMSArMTI1NCw3IEBAIHZvaWQgX19pbml0IGFyY19jYWNo
ZV9pbml0X21hc3Rlcih2b2lkKQ0KPiA+ID4gPiAgCWlmIChpc19pc2FfYXJjdjIoKSAmJiBpb2Nf
ZW5hYmxlKQ0KPiA+ID4gPiAgCQlhcmNfaW9jX3NldHVwKCk7DQo+ID4gPiA+ICANCj4gPiA+ID4g
LQlpZiAoaXNfaXNhX2FyY3YyKCkgJiYgaW9jX2VuYWJsZSkgew0KPiA+ID4gPiAtCQlfX2RtYV9j
YWNoZV93YmFja19pbnYgPSBfX2RtYV9jYWNoZV93YmFja19pbnZfaW9jOw0KPiA+ID4gPiAtCQlf
X2RtYV9jYWNoZV9pbnYgPSBfX2RtYV9jYWNoZV9pbnZfaW9jOw0KPiA+ID4gPiAtCQlfX2RtYV9j
YWNoZV93YmFjayA9IF9fZG1hX2NhY2hlX3diYWNrX2lvYzsNCj4gPiA+ID4gLQl9IGVsc2UgaWYg
KGlzX2lzYV9hcmN2MigpICYmIGwyX2xpbmVfc3ogJiYgc2xjX2VuYWJsZSkgew0KPiANCj4gRm9y
IHRoZSBjYXN1YWwgcmVhZGVyIEknZCBhZGQgYSBjb21tZW50IHdoeSB0aGlzIHdhcyBkZWxldGVk
Lg0KRG8geW91IG1lYW4gY29tbWVudCBpbiBjb21taXQgZGVzY3JpcHRpb24gb3IgY29tbWVudCBy
aWdodCBpbiBzb3VyY2VzPw0KDQo+IA0KPiA+ID4gPiArCWlmIChpc19pc2FfYXJjdjIoKSAmJiBs
Ml9saW5lX3N6ICYmIHNsY19lbmFibGUpIHsNCj4gPiA+ID4gIAkJX19kbWFfY2FjaGVfd2JhY2tf
aW52ID0gX19kbWFfY2FjaGVfd2JhY2tfaW52X3NsYzsNCj4gPiA+ID4gIAkJX19kbWFfY2FjaGVf
aW52ID0gX19kbWFfY2FjaGVfaW52X3NsYzsNCj4gPiA+ID4gIAkJX19kbWFfY2FjaGVfd2JhY2sg
PSBfX2RtYV9jYWNoZV93YmFja19zbGM7DQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gPiA+ICANCj4g
PiA+ID4gLQkvKg0KPiA+ID4gPiAtCSAqIElPQyByZWxpZXMgb24gYWxsIGRhdGEgKGV2ZW4gY29o
ZXJlbnQgRE1BIGRhdGEpIGJlaW5nIGluIGNhY2hlDQo+ID4gPiA+IC0JICogVGh1cyBhbGxvY2F0
ZSBub3JtYWwgY2FjaGVkIG1lbW9yeQ0KPiA+ID4gPiAtCSAqDQo+ID4gPiA+IC0JICogVGhlIGdh
aW5zIHdpdGggSU9DIGFyZSB0d28gcHJvbmdlZDoNCj4gPiA+ID4gLQkgKiAgIC1Gb3Igc3RyZWFt
aW5nIGRhdGEsIGVsaWRlcyBuZWVkIGZvciBjYWNoZSBtYWludGVuYW5jZSwgc2F2aW5nDQo+ID4g
PiA+IC0JICogICAgY3ljbGVzIGluIGZsdXNoIGNvZGUsIGFuZCBidXMgYmFuZHdpZHRoIGFzIGFs
bCB0aGUgbGluZXMgb2YgYQ0KPiA+ID4gPiAtCSAqICAgIGJ1ZmZlciBuZWVkIHRvIGJlIGZsdXNo
ZWQgb3V0IHRvIG1lbW9yeQ0KPiA+ID4gPiAtCSAqICAgLUZvciBjb2hlcmVudCBkYXRhLCBSZWFk
L1dyaXRlIHRvIGJ1ZmZlcnMgdGVybWluYXRlIGVhcmx5IGluIGNhY2hlDQo+ID4gPiA+IC0JICog
ICAodnMuIGFsd2F5cyBnb2luZyB0byBtZW1vcnkgLSB0aHVzIGFyZSBmYXN0ZXIpDQo+ID4gPiA+
IC0JICovDQo+ID4gPiA+IC0JaWYgKChpc19pc2FfYXJjdjIoKSAmJiBpb2NfZW5hYmxlKSB8fA0K
PiA+ID4gPiAtCSAgICAoYXR0cnMgJiBETUFfQVRUUl9OT05fQ09OU0lTVEVOVCkpDQo+ID4gPiA+
ICsJaWYgKGF0dHJzICYgRE1BX0FUVFJfTk9OX0NPTlNJU1RFTlQpDQo+ID4gPiA+ICAJCW5lZWRf
Y29oID0gMDsNCj4gPiA+ID4gIA0KPiANCj4gW3NuaXBdDQo+IA0KPiA+IFllcCwgSSB0ZXN0ZWQg
dGhhdC4NCj4gPiBBbmQgaXQgd29ya3MgZmluZSB3aXRoIGJvdGggQGlvY19lbmFibGUgPT0gMCBh
bmQgQGlvY19lbmFibGUgPT0gMQ0KPiA+IE5vdGUgdGhhdCB3ZSBjaGVjayB0aGlzIHZhcmlhYmxl
IGluIGFyY2hfc2V0dXBfZG1hX29wcygpIGZ1bmN0aW9uIG5vdy4NCj4gPiANCj4gPiBTbyB0aGlz
IGFyY2hfZG1hX3thbGxvYyxmcmVlfSBhcmUgdXNlZCBPTkxZIGluIGNhc2Ugb2Ygc29mdHdhcmUg
YXNzaXN0ZWQgY2FjaGUgbWFpbnRlbmFuY2UuDQo+ID4gVGhhdCdzIHdoeSB3ZSBoYWQgdG8gZG8g
TU1VIG1hcHBpbmcgdG8gZW5mb3JjZSBub24tY2FjaGFiaWxpdHkgcmVnYXJkbGVzcyBvZiBAaW9j
X2VuYWJsZS4NCj4gDQo+IFJlYWRpbmcga2VybmVsL2RtYS8qIEkgc2VlIHdoYXQgeW91IG1lYW4u
IFdlIGNoZWNrIEBpb2NfZW5hYmxlIGF0IHRoZSB0aW1lIG9mDQo+IHJlZ2lzdGVyaW5nIHRoZSBk
bWEgb3AgZm9yIGNvaGVyZW50IHZzLiBub24gY29oZXJlbnQgY2FzZSwgc28gdGhlcmUncyBjb21t
b24gdnMuDQo+IEFSQyB2ZXJzaW9ucyBvZiBhbGxvYy9mcmVlIGZvciBjb2hlcmVudCB2cy4gbm9u
Y29oZXJlbnQuDQoNCkp1c3QgdG8gYmUgc3VyZSB0aGF0IHdlIHVuZGVyc3RhbmQgYm90aCBlYWNo
IG90aGVyIGFuZCBzb3VyY2UgY29kZSBjb3JyZWN0bHk6IA0KLSBJbiBjb2hlcmVudCBjYXNlIHdl
IHVzZSBkbWFfZGlyZWN0Xyogb3BzIHdoaWNoIGRvZXNuJ3QgdXNlIEFSQyBhbGxvYyBmdW5jdGlv
bnMgKGFyY2hfZG1hX3thbGxvY3xmcmVlfSkNCi0gSW4gbm9uLWNvaGVyZW50IGNhc2Ugd2UgdXNl
IGRtYV9ub25jb2hlcmVudF8qIG9wcyB3aGljaCB1c2VzIEFSQyBhbGxvYyBmdW5jdGlvbnMgKGFy
Y2hfZG1hX3thbGxvY3xmcmVlfSkNCg0KPiBCdXQgdGhlbiBJJ20gY3VyaW91cyB3aHkNCj4gZG8g
d2UgYm90aGVyIHRvIGNoZWNrIHRoZSBmb2xsb3dpbmcgaW4gbmV3IGFyY2hfZG1hXyhhbGxvY3xm
cmVlKSBhdCBhbGwuDQo+IA0KPiAJaWYgKGF0dHJzICYgRE1BX0FUVFJfTk9OX0NPTlNJU1RFTlQp
DQo+IA0KPiBJc24ndCBpdCBzdXBwb3NlZCB0byBiZSBOT05fQ09OU0lTVEVOVCBhbHdheXMgZ2l2
ZW4gdGhlIHdheSBuZXcgY29kZSB3b3JrcyA/DQoNCkRNQV9BVFRSX05PTl9DT05TSVNURU5UIGZs
YWcgaXMgbm90IHJlbGF0ZWQgdG8gSU9DIHRvcGljLg0KSXQgaXMgYSBmbGFnIHdoaWNoIHdlIGNh
biBwYXNzIHRvIGRtYV97YWxsb2N8ZnJlZX1fYXR0cnMgZnVuY3Rpb24gZnJvbSBkcml2ZXIgc2lk
ZS4NCg0KQWNjb3JkaW5nIHRvIGRvY3VtZW50YXRpb246DQogIERNQV9BVFRSX05PTl9DT05TSVNU
RU5UOiBMZXRzIHRoZSBwbGF0Zm9ybSB0byBjaG9vc2UgdG8gcmV0dXJuIGVpdGhlcg0KICBjb25z
aXN0ZW50IG9yIG5vbi1jb25zaXN0ZW50IG1lbW9yeSBhcyBpdCBzZWVzIGZpdC4NCg0KV2UgY2hl
Y2sgdGhpcyBmbGFnIGluIGFyY2hfZG1hX2FsbG9jICh3aGljaCBhcmUgdXNlZCBpbiBub24tY29o
ZXJlbnQgY2FzZSkgdG8NCnNraXAgTU1VIG1hcHBpbmcgaWYgd2UgYXJlIGFkdmVydGlzZWQgdGhh
dCBjb25zaXN0ZW5jeSBpcyBub3QgcmVxdWlyZWQuDQoNClNvLCBhY3R1YWxseSB3ZSBjYW4gZ2V0
IHJpZCBvZiB0aGlzIGZsYWcgY2hlY2tpbmcgaW4gYXJjaF9kbWFfYWxsb2MgYW5kIA0Kc2ltcGx5
IGFsd2F5cyBkbyBNTVUgbWFwcGluZyB0byBlbmZvcmNlIG5vbi1jYWNoYWJpbGl0eSBhbmQgcmV0
dXJuDQpub24tY2FjaGVhYmxlIG1lbW9yeSBldmVuIGlmIERNQV9BVFRSX05PTl9DT05TSVNURU5U
IGlzIHBhc3NlZC4NCkJ1dCBJIGRvbid0IHN1cmUgd2Ugd2FudCB0byBkbyB0aGF0Lg0KDQpCVFc6
IGRtYV9hbGxvY19jb2hlcmVudCBpcyBzaW1wbHkgZG1hX2FsbG9jX2F0dHJzIHdpdGggYXR0cnMg
PT0gMC4NCg0KLS0gDQogRXVnZW5peSBQYWx0c2V2
