Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45096C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E902720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gkqHqzz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E902720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeILSru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:47:50 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:41958 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeILSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:47:50 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0BD0110C1B4E;
        Wed, 12 Sep 2018 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536759795; bh=noJwWAwrbrF/aFCT33oOdynvLLL1bC52Tis5TNap/aA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gkqHqzz0S2KgowCPVSwtgQrFXvSckZ4rk5/rdrxzo6XNSyfuAMzF+paCSJvy2609K
         x1Sy6Cqx+OsVuSzIDG73NYaAXJQg1SF1kBiF6+HCyxJY9gyB0+YOGIUtzevJbyITPR
         K4mEOC7Np4y4xk4kXufWa/e6vfNTige2a3TWyb/U3WAGhtOJMdaRrFEW2JtodIuUdp
         6UsEO1K+FEefEoGJeO3nrQV1JgntH4iqIjw+DA7eEihydcpgW0zCKEJZmmP+3RqWa+
         cV/c6jupAQLbaDVhOhTev1igObfULd4Cpc0CLCM2jUT0e1H/jrc/be19Nx1c1AtxD6
         YpOn8xkTjYDcA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id EAC213174;
        Wed, 12 Sep 2018 06:43:14 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 12 Sep 2018 06:43:14 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 12 Sep 2018 15:43:10 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: defconfig fails if CROSS_COMPILE is set while cross-gcc is not
 avaialble
Thread-Topic: defconfig fails if CROSS_COMPILE is set while cross-gcc is not
 avaialble
Thread-Index: AQHUSpFXS1S71sJSu0SpMEzLuj4Mh6TseH6AgAAN7AA=
Date:   Wed, 12 Sep 2018 13:43:09 +0000
Message-ID: <2c5d00f99db07df1a8cc5168d62d5764544fb83e.camel@synopsys.com>
References: <0854f35e92c95e552721dc6a46f4ee2bc4020bc1.camel@synopsys.com>
         <CAK7LNAR0ghuhDXUqJ=nX0dtbtoOvFff9Eeu-hHWLkTONG09GAQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR0ghuhDXUqJ=nX0dtbtoOvFff9Eeu-hHWLkTONG09GAQ@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <37A93BA9001833478BA89F779B85B8EE@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFzYWhpcm8sDQoNCk9uIFdlZCwgMjAxOC0wOS0xMiBhdCAyMTo1MyArMDkwMCwgTWFzYWhp
cm8gWWFtYWRhIHdyb3RlOg0KPiBIaSBBbGV4ZXkuDQo+IA0KPiAyMDE4LTA5LTEyIDIxOjA4IEdN
VCswOTowMCBBbGV4ZXkgQnJvZGtpbiA8QWxleGV5LkJyb2RraW5Ac3lub3BzeXMuY29tPjoNCj4g
PiBIZWxsbyBNYXNhaGlyby1zYW4sDQo+ID4gDQo+ID4gU3RhcnRpbmcgZnJvbSBrZXJuZWwgdjQu
MTcgaXQgaXMgbm8gbG9uZ2VyIHBvc3NpYmxlIHRvIGluc3RhbGwga2VybmVsIGhlYWRlcnMNCj4g
PiBmb3IgQVJDIGFyY2hpdGVjdHVyZSBpZiB0aGVyZSdzIG5vIGNyb3NzLXRvb2xjaGFpbiBpbiBQ
QVRILg0KPiANCj4gDQo+IFJlYWxseT8NCj4gDQo+IEkgY2FuIGRvICdtYWtlIEFSQ0g9YXJjIGhl
YWRlcnNfaW5zdGFsbCcNCj4gd2l0aCB0aGUgbGF0ZXN0IExpbnVzJyB0cmVlLg0KDQpJbmRlZWQg
ImhlYWRlcnNfaW5zdGFsbCIgd29ya3MgdGhhdCB3YXkgYnV0IGlzIGl0IE9LIHRvIGluc3RhbGwg
aGVhZGVycw0Kd2l0aG91dCBwcmV2aW91cyBjb25maWd1cmF0aW9uLiBJbiBteSBleHBlcmltZW50
IEkgZG9uJ3Qgc2VlIGFueSBkaWZmZXJlbmNlcw0KdGhvdWdoIGZvciBleGFtcGxlIE9wZW5FbWJl
ZGRlZCBvbiBjb25maWd1cmF0aW9uIHN0ZXAgb2YgImxpbnV4LWxpYmMtaGVhZGVycyINCmRvICJB
UkNIPXh4eCBtYWtlIGFsbG5vY29uZmlnIiwgc2VlIA0KaHR0cHM6Ly9naXRodWIuY29tL29wZW5l
bWJlZGRlZC9vcGVuZW1iZWRkZWQtY29yZS9ibG9iL21hc3Rlci9tZXRhL3JlY2lwZXMta2VybmVs
L2xpbnV4LWxpYmMtaGVhZGVycy9saW51eC1saWJjLWhlYWRlcnMuaW5jI0w1Nw0KDQpUaGF0IG1p
Z2h0IGJlIHNvbWUgbGVnYWN5IGJ1dCBJJ20gbm90IHJlYWxseSBzdXJlLA0Kd29ydGggYXNraW5n
IE9FIHBlb3BsZS4NCg0KRm9yIHRoZSByZWNvcmQgaW4gQnVpbGRyb290IG5vIGNvbmZpZ3VyYXRp
b24gaGFwcGVucyBmb3IgTGludXggaGVhZGVycywNCnNlZSBodHRwczovL2dpdC5idWlsZHJvb3Qu
b3JnL2J1aWxkcm9vdC90cmVlL3BhY2thZ2UvbGludXgtaGVhZGVycy9saW51eC1oZWFkZXJzLm1r
I24xMDYNCg0KPiBJIHNlZSB0aGUgZm9sbG93aW5nIHdhcm5pbmdzLCBidXQgcG9zc2libGUgdG8g
aW5zdGFsbCBrZXJuZWwgaGVhZGVycy4NCj4gDQo+IC4vc2NyaXB0cy9nY2MtdmVyc2lvbi5zaDog
bGluZSAyNjogYXJjLWxpbnV4LWdjYzogY29tbWFuZCBub3QgZm91bmQNCj4gLi9zY3JpcHRzL2dj
Yy12ZXJzaW9uLnNoOiBsaW5lIDI3OiBhcmMtbGludXgtZ2NjOiBjb21tYW5kIG5vdCBmb3VuZA0K
DQpSaWdodC4uLiB0aGF0IGhhcHBlbnMgYmVjYXVzZSB3ZSdyZSBkb2luZyAyIGhhY2tpc2ggdGhp
bmdzOg0KMS4gQ2hlY2tpbmcgaWYgY3VycmVudCB0b29sY2hhaW4gaXMgY29uZmlndXJlZCBmb3Ig
QVJDb21wYWN0IChBUkN2MSkgSVNBDQogICBvciBBUkN2Mi4gVGhhdCdzIGJlY2F1c2Ugd2UgdXNl
IHRvb2xjaGFpbidzIGxpYmdjYyBhbmQgc28gd2Ugd2FudCB0byB3YXJuDQogICBhIHVzZXIgaWYg
d3JvbmcgdG9vbGNoYWluIGlzIHVzZWQgZWFybHkgaW5zdGVhZCBvZiBsZWF2aW5nIGhpbSB0byBk
ZWFsIHdpdGgNCiAgIGZpbmFsIGxpbmthZ2UgZmFpbHVyZS4NCiAgIFNlZTogaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3Ry
ZWUvYXJjaC9hcmMvTWFrZWZpbGUjbjIzDQoNCjIuIEFza2luZyBDQyBmb3IgYSBwYXRoIHRvIGxp
YmdjYw0KICAgU2VlOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2FyYy9NYWtlZmlsZSNuODINCg0KW3Nu
aXBdDQoNCj4gSSBhbSB0cnlpbmcgdG8gZml4IGV2ZW4gdGhvc2Ugd2FybmluZ3MNCj4gYnkgZWxp
bWluYXRpbmcgdW5uZWVkZWQgY29tcGlsZXIgaW52b2NhdGlvbi4gIEl0IGlzIFdJUC4NCg0KQW5k
IGlmICgxKSBpcyBub3Qgc3VwZXIgaW1wb3J0YW50IChpbiBmYWN0IHdlIHVzZWQgdG8gbGl2ZSB3
aXRob3V0IGl0IGZvciB5ZWFycykNCigyKSByZXF1aXJlcyBpbXBsZW1lbnRhdGlvbiBvZiBsaWJn
Y2MgaW4ga2VybmVsIHNvdXJjZXMgKHdoaWNoIEJUVyB3aWxsIG1ha2UgKDEpDQpvYnNvbGV0ZSBp
bW1lZGlhdGVseSkuIFdlIGRvIGhhdmUgaXQgb24gb3VyIHRvZG8gbGlzdCB0aG91Z2guLi4NCg0K
W3NuaXBdDQoNCj4gPiBUaGF0IGRvZXNuJ3QgaGFwcGVuIGZvciBBUk0gYW5kIG90aGVyIGFyY2hl
cyBzaW1wbHkgYmVjYXVzZSBmb3IgQVJDDQo+ID4gd2UgZGVmaW5lIENST1NTX0NPTVBJTEUgaWYg
aXQgaXMgbm90IHNldCBieSB1c2VyLCBzZWU6DQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UucHJv
b2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC5rZXJuZWwub3JnX3B1Yl9zY21fbGlu
dXhfa2VybmVsX2dpdF90b3J2YWxkc19saW51eC5naXRfdHJlZV9hcmNoX2FyY19NYWtlZmlsZS0y
M245JmQ9RHdJQmFRJmM9RFBMNl9YXzZKa1hGeDdBWFdxQjB0ZyZyPWxxZGVlU1NFZXMwR0ZERGw2
NTZlVmlYTzdicmVTNTV5dFdraHBrNVI4MUkmbT16SnNhNU1yQXREaVlFV3I1UFpOUzFhR2syMUVU
YS1xWHpMUElkZHd2b1FJJnM9QlUwbHRQUG9STG4zbnBfYmE0SFJIZkg5aTE0MXVaam9TOGpzSnJn
OFNOYyZlPQ0KPiANCj4gSSBkbyBub3QgdGhpbmsgaXQgaXMgYSBnb29kIHByYWN0aWNlDQo+IHRv
IGZvcmNpYmx5IHNldCBDUk9TU19DT01QSUxFIHRoYXQgdXNlcnMgbWF5IG5vdCBoYXZlLg0KDQpN
YXliZSBzby4gU3RpbGwgc29tZSBhcmNoZXMgb3IgcmFuZG9tIHBsYXRmb3JtcyBkbyB0aGF0Lg0K
DQo+IGFyY2gvbTY4ay9NYWtlZmlsZSB1c2VzIGNjLWNyb3NzLXByZWZpeCBoZWxwZXINCj4gdG8g
c2V0IHRoZSBmaXJzdCBmb3VuZCBjb21waWxlci4NCg0KV2VsbCBJJ20gbm90IHJlYWxseSBzdXJl
IHdlIG5lZWQgdG8gbWVzcyB3aXRoIENST1NTX0NPTVBJTEUgaW4ga2VybmVsLg0KSS5lLiB0aGVy
ZSBtaWdodCBiZSB0b25zIG9mIHZhcmlhdGlvbnMgZGVwZW5kaW5nIG9uIHdobyB0b29sY2hhaW4g
d2FzIGJ1aWx0DQpldGMuIFNvIEknZCBiZXR0ZXIgZ2V0IHJpZCBvZiBDUk9TU19DT01QSUxFIHNl
dHVwIGluIG91ciBNYWtlZmlsZS4NCg0KPiA+IFN0aWxsIGlmIENST1NTX0NPTVBJTEUgaXMgc2V0
IGJlZm9yZSBleGVjdXRpb24gb2YgIm1ha2UgZGVmY29uZmlnIg0KPiA+IHRoZW4gdGhlIHNhbWUg
cHJvYmxlbSBoYXBwZW5zIGZvciBvdGhlcnMuDQo+ID4gDQo+ID4gSSB3YXMgYWJsZSB0byBmaW5k
IGEgc2VyaWVzIG9mIGNvbW1pdHMgd2hpY2ggY2F1c2UgdGhpcyBwcm9ibGVtLA0KPiA+IGhlcmUg
dGhleSBhcmU6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gNTlmNTM4NTViYWJmIC0gZ2NjLXBsdWdpbnM6IHRlc3QgcGx1
Z2luIHN1cHBvcnQgaW4gS2NvbmZpZyBhbmQgY2xlYW4gdXAgTWFrZWZpbGUNCj4gPiA0NjljYjcz
NzZjMDYgLSBrY29uZmlnOiBhZGQgQ0NfSVNfQ0xBTkcgYW5kIENMQU5HX1ZFUlNJT04NCj4gPiBh
NDM1Mzg5ODk4MGMgLSBrY29uZmlnOiBhZGQgQ0NfSVNfR0NDIGFuZCBHQ0NfVkVSU0lPTg0KPiA+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+IA0KPiA+IFdoYXQgaGFwcGVuIGlzICIkKENDKSIgaXMgcGFzc2VkIGFzIGFuIGFyZ3Vt
ZW50IGFuZCBpbiBpdHMgdHVybiBDQyBpcw0KPiA+ICIkKENST1NTX0NPTVBJTEUpZ2NjIiwgc2Vl
Og0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19naXQua2VybmVsLm9yZ19wdWJfc2NtX2xpbnV4X2tlcm5lbF9naXRfdG9ydmFsZHNfbGlu
dXguZ2l0X3RyZWVfTWFrZWZpbGUtMjNuMzg1JmQ9RHdJQmFRJmM9RFBMNl9YXzZKa1hGeDdBWFdx
QjB0ZyZyPWxxZGVlU1NFZXMwR0ZERGw2NTZlVmlYTzdicmVTNTV5dFdraHBrNVI4MUkmbT16SnNh
NU1yQXREaVlFV3I1UFpOUzFhR2syMUVUYS1xWHpMUElkZHd2b1FJJnM9Uzd6ZUhCcElwMVA5NFhi
eW9Nc2FTbkpXUnFER242OXlHeWVvYi1qek1KNCZlPQ0KPiA+IA0KPiA+IA0KPiA+IFNvIGlmIEkg
c3Vic3RpdHV0ZSAiQ0MiIHdpdGggIkhPU1RDQyIgaW4gYSBjb3VwbGUgb2YgcGxhY2VzIChzZWUg
YmVsb3cpDQo+ID4gdGhlIHByb2JsZW0gZ29lcyBhd2F5LiBCdXQgSSdtIG5vdCByZWFsbHkgc3Vy
ZSBpZiB3aGF0IEkgZG8gaXMgY29ycmVjdC4NCj4gPiBJLmUuIHdoZW4gd2UncmUgaW50ZXJlc3Rl
ZCBpbiBDQyBmb3IgdGFyZ2V0IGFuZCB3aGVuIG9ubHkgaG9zdCBDQyBpcyBvZg0KPiA+IG91ciBp
bnRlcmVzdC4NCj4gDQo+IEkgdGhpbmsgdGhlIGxvZyBvZiBjb21taXQgMzE2ZDU1ZDU1ZjQ5ZWNh
NDQNCj4gaXMgYSBnb29kIHNvdXJjZSB0byBrbm93IHRoZSBiYWNrZ3JvdW5kIG9mIHRoaXMgY2hh
bmdlLg0KPiANCj4gTm93IEtjb25maWcgcmVxdWlyZXMgdGhlIHRhcmdldCBjb21waWxlci4NCj4g
U28sIGl0IGRvZXMgbm90IG1ha2Ugc2Vuc2UgdG8NCj4gZG8gZGVmY29uZmlnIHdpdGggbm9uLWV4
aXN0aW5nIGNvbXBpbGVyLg0KDQpBZ3JlZSwgc28gSSdsbCBjaGVjayB3aXRoIE9wZW5FbWJlZGRl
ZCBwZW9wbGUgaWYgdGhlcmUncyBhIHJlYXNvbiB0byBkbyAibWFrZSBhbGxub2NvbmZpZyINCmlm
IGl0J3MganVzdCBhIGxlZ2FjeSBjb2RlIHdlJ2xsIGZpeCBpdCB0aGVyZS4NCg0KVGhhbmtzIGEg
bG90IGZvciBhbGwgdGhlIGlucHV0LCBtdWNoIGFwcHJlY2lhdGVkIQ0KDQotQWxleGV5DQo=
