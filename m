Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC811C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LQxgY2Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BE220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeFRPWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:22:38 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:42284 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeFRPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:22:36 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1414F1E04F7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 17:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529335355; bh=j8bpD2P10Hw8KsaNJZo7pwdYbCn/Fa2xcyJgnfZo/1E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LQxgY2PeO/D/N8QJvtRZfpAJ0CbzezBPsysahOWyEQmLqx6+2uCM85zHZALLAfQR5
         crXWxNRYzb92UYTc4K4kRZ29ieaI3pASKmzYpTmUxHfa1FU6KNrR76tPahSPn984zw
         lMKV4OYr5lKPhFUf/+JzO6JAOI91zvHrjOme4ZVbyV3fqwGvIZwSnfLExSpc5S1DIn
         EJYy+xSGm6GMCADwg8CAI5R3KGxhmRAabWVwyBVLSXd2qlXz0JIGgmyCaUeyNmeuHc
         QrF2O85Af+t/UmGBzRbBz2jsKWkTJ7S2N42/ukgmNdCPlMepd2tthf29j3ThYMzjx0
         nSOwH0y3cXvYw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 72D66583A;
        Mon, 18 Jun 2018 08:22:34 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 18 Jun 2018 08:20:50 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 18 Jun 2018 17:20:47 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Add PCIe support for ARC HSDK platform
Thread-Topic: [PATCH] ARC: Add PCIe support for ARC HSDK platform
Thread-Index: AQHUBxUCRm/JCNyjD0Wi++lZvsvcaKRmACsA
Date:   Mon, 18 Jun 2018 15:20:46 +0000
Message-ID: <ba4b10e967fb39d18eba7a5c70abb167308481f5.camel@synopsys.com>
References: <3e9a2f384fd831fb2639ad99ec43ce0f019ac17c.1529333762.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <3e9a2f384fd831fb2639ad99ec43ce0f019ac17c.1529333762.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <56FB54FF338EB24BB3236994BEF0B834@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VzdGF2bywNCg0KT24gTW9uLCAyMDE4LTA2LTE4IGF0IDE1OjU5ICswMTAwLCBHdXN0YXZv
IFBpbWVudGVsIHdyb3RlOg0KPiBBZGQgUENJIHN1cHBvcnQgdG8gdGhlIEFSQyBIU0RLIHBsYXRm
b3JtIGFsbG93aW5nIHRvIHVzZSB0aGUgZ2VuZXJpYyBQQ0kNCj4gc2V0dXAgZnVuY3Rpb25zLg0K
DQpUaGlzIGlzIHRoZSBmaXJzdCBsb2dpY2FsbHkgaW5kZXBlbmRlbnQgY2hhbmdlLCBzbyBwdXQg
aXQgaW4gYSBzZXBhcmF0ZSBwYXRjaC4NCg0KPiBBZGQgR1BJTyBpbnRlcnJ1cHQgY29uZmlndXJh
dGlvbiBmdW5jdGlvbiBvbiBBUkMgSFNESyBwbGF0Zm9ybSBhbmQNCj4gY29uZmlndXJlcyBpdCB0
byBQQ0kgc3VwcG9ydC4NCg0KVGhhdCdzIHRoZSBzZWNvbmQgY2hhbmdlIHdoaWNoIGlzIG5vdCBk
aXJlY3RseSB0aWVkIHRvIHRoZSBmaXJzdCBvbmUNCnNvIHBsZWFzZSBwdXQgaXQgaW4gYSBzZXBh
cmF0ZSBwYXRjaC4NCg0KVGhhbiBhcyBjb21wYXJlZCB0byB0aGUgZmlyc3QgW3Zlcnkgc2ltcGxl
IGFuZCBvYnZpb3VzXSBjaGFuZ2UgdGhpcw0Kb25lIHdhcnJhbnRzIG1vcmUgdmVyYm9zZSBqdXN0
aWZpY2F0aW9uLg0KDQoxLiBJTUhPIGl0IHdvcnRoIGFkZGluZyBtb3JlIGluZm8gdG8gY29tbWl0
IG1lc3NhZ2UgZXhwbGFpbmluZyB3aGF0IHByb2JsZW0NCiAgIHlvdSdyZSBzb2x2aW5nIGFuZCB3
aHkgeW91IGRvIGl0IGluIHRoaXMgcGFydGljdWxhciB3YXkuDQogICBJbiBjYXNlIG9mIEhTREsg
d2UgaGF2ZSBpbnRlcm1lZGlhdGUgSU5UQyBpbiBmb3Igb2YgRFcgQVBCIEdQSU8gY29udHJvbGxl
cg0KICAgd2hpY2ggaXMgdXNlZCBhcyBhIGRlLWJvdW5jZSBsb2dpYyBmb3IgaW50ZXJydXB0IHdp
cmVzIHRoYXQgY29tZSBmcm9tIG91dHNpZGUgdGhlIGJvYXJkLg0KICAgV2UgY2Fubm90IHVzZSBl
eGlzdGluZyAiaXJxLWR3LWFwYi1pY3RsIiBkcml2ZXIgaGVyZSBiZWNhdXNlIGFsbCBpbnB1dCBs
aW5lcw0KICAgYXJlIHJvdXRlZCB0byBjb3JyZXNwb25kaW5nIG91dHB1dCBsaW5lcyBidXQgbm90
IG11eGVkIGludG8gb25lIGxpbmUgKHRoaXMgaXMNCiAgIGNvbmZpZ3VyZWQgaW4gUlRMIGFuZCB3
ZSBjYW5ub3QgY2hhbmdlIHRoaXMgaW4gc29mdHdhcmUpLiBCdXQgZXZlbiBpZiB3ZSBhZGQgc3Vj
aA0KICAgYSBmZWF0dXJlIHRvICJpcnEtZHctYXBiLWljdGwiIGRyaXZlciB0aGF0IHdvbid0IGJl
bmVmaXQgdXMgYXMgaGlnaGVyLWxldmVsIElOVEMNCiAgIChpbiBjYXNlIG9mIEhTREsgaXQgaXMg
SURVKSBhbnl3YXlzIGhhcyBwZXItaW5wdXQgY29udHJvbCBzbyBhZGRpbmcgZnVsbHktY29udHJv
bGxlcg0KICAgaW50ZXJtZWRpYXRlIElOVEMgd2lsbCBvbmx5IGJyaW5nIHNvbWUgb3ZlcmhlYWQg
b24gaW50ZXJydXB0IHByb2Nlc3NpbmcgYnV0IG5vIG90aGVyDQogICBiZW5lZml0cy4NCiAgIFRo
dXMgd2UganVzdCBkbyBvbmUtdGltZSBjb25maWd1cmF0aW9uIG9mIERXIEFQUCBHUElPIGNvbnRy
b2xsZXIgYW5kIGZvcmdldCBhYm91dCBpdC4NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8g
UGltZW50ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiAtLS0NCj4gIGFyY2gv
YXJjL3BsYXQtaHNkay9LY29uZmlnICAgIHwgIDEgKw0KPiAgYXJjaC9hcmMvcGxhdC1oc2RrL3Bs
YXRmb3JtLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcmMvcGxhdC1oc2RrL0tjb25maWcgYi9hcmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZw0K
PiBpbmRleCAxOWFiM2NmLi41NTZiYzVlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9wbGF0LWhz
ZGsvS2NvbmZpZw0KPiArKysgYi9hcmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZw0KPiBAQCAtOSwz
ICs5LDQgQEAgbWVudWNvbmZpZyBBUkNfU09DX0hTREsNCj4gIAlib29sICJBUkMgSFMgRGV2ZWxv
cG1lbnQgS2l0IFNPQyINCj4gIAlzZWxlY3QgQ0xLX0hTREsNCj4gIAlzZWxlY3QgUkVTRVRfSFNE
Sw0KPiArCXNlbGVjdCBNSUdIVF9IQVZFX1BDSQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvcGxh
dC1oc2RrL3BsYXRmb3JtLmMgYi9hcmNoL2FyYy9wbGF0LWhzZGsvcGxhdGZvcm0uYw0KPiBpbmRl
eCAyOTU4YWVkLi4zMWFkZGE3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9wbGF0LWhzZGsvcGxh
dGZvcm0uYw0KPiArKysgYi9hcmNoL2FyYy9wbGF0LWhzZGsvcGxhdGZvcm0uYw0KPiBAQCAtNDIs
NiArNDIsNDUgQEAgc3RhdGljIHZvaWQgX19pbml0IGhzZGtfaW5pdF9wZXJfY3B1KHVuc2lnbmVk
IGludCBjcHUpDQo+ICAjZGVmaW5lIFNESU9fVUhTX1JFR19FWFQJKFNESU9fQkFTRSArIDB4MTA4
KQ0KPiAgI2RlZmluZSBTRElPX1VIU19SRUdfRVhUX0RJVl8yCSgyIDw8IDMwKQ0KPiAgDQo+ICsj
ZGVmaW5lIEhTREtfR1BJT19JTlRDICAgICAgICAgIChBUkNfUEVSSVBIRVJBTF9CQVNFICsgMHgz
MDAwKQ0KPiArI2RlZmluZSBHUElPX0lOVEVOICAgICAgICAgICAgICAoSFNES19HUElPX0lOVEMg
KyAweDMwKQ0KPiArI2RlZmluZSBHUElPX0lOVE1BU0sgICAgICAgICAgICAoSFNES19HUElPX0lO
VEMgKyAweDM0KQ0KPiArI2RlZmluZSBHUElPX0lOVFRZUEVfTEVWRUwgICAgICAoSFNES19HUElP
X0lOVEMgKyAweDM4KQ0KPiArI2RlZmluZSBHUElPX0lOVF9QT0xBUklUWSAgICAgICAoSFNES19H
UElPX0lOVEMgKyAweDNjKQ0KPiArDQo+ICsjZGVmaW5lIEdQSU9fQkxVRVRPT1RIX0lOVAkweDAw
MDAwMDAxDQo+ICsjZGVmaW5lIEdQSU9fSEFQU19JTlQJCTB4MDAwMDAwMDQNCj4gKyNkZWZpbmUg
R1BJT19BVURJT19JTlQJCTB4MDAwMDAwMDgNCj4gKy8qIFBNT0RfQSBoZWFkZXIgKi8NCj4gKyNk
ZWZpbmUgR1BJT19QSU5fMDhfSU5UCQkweDAwMDAwMTAwDQo+ICsjZGVmaW5lIEdQSU9fUElOXzA5
X0lOVAkJMHgwMDAwMDIwMA0KPiArI2RlZmluZSBHUElPX1BJTl8xMF9JTlQJCTB4MDAwMDA0MDAN
Cj4gKyNkZWZpbmUgR1BJT19QSU5fMTFfSU5UCQkweDAwMDAwODAwDQo+ICsvKiBQTU9EX0IgaGVh
ZGVyICovDQo+ICsjZGVmaW5lIEdQSU9fUElOXzEyX0lOVAkJMHgwMDAwMTAwMA0KPiArI2RlZmlu
ZSBHUElPX1BJTl8xM19JTlQJCTB4MDAwMDIwMDANCj4gKyNkZWZpbmUgR1BJT19QSU5fMTRfSU5U
CQkweDAwMDA0MDAwDQo+ICsjZGVmaW5lIEdQSU9fUElOXzE1X0lOVAkJMHgwMDAwODAwMA0KPiAr
LyogUE1PRF9DIGhlYWRlciAqLw0KPiArI2RlZmluZSBHUElPX1BJTl8xNl9JTlQJCTB4MDAwMTAw
MDANCj4gKyNkZWZpbmUgR1BJT19QSU5fMTdfSU5UCQkweDAwMDIwMDAwDQo+ICsjZGVmaW5lIEdQ
SU9fUElOXzE4X0lOVAkJMHgwMDA0MDAwMA0KPiArI2RlZmluZSBHUElPX1BJTl8xOV9JTlQJCTB4
MDAwODAwMDANCj4gKyNkZWZpbmUgR1BJT19QSU5fMjBfSU5UCQkweDAwMTAwMDAwDQo+ICsjZGVm
aW5lIEdQSU9fUElOXzIxX0lOVAkJMHgwMDIwMDAwMA0KPiArI2RlZmluZSBHUElPX1BJTl8yMl9J
TlQJCTB4MDA0MDAwMDANCj4gKyNkZWZpbmUgR1BJT19QSU5fMjNfSU5UCQkweDAwODAwMDAwDQoN
CkNvdWxkIHlvdSBwbGVhc2UgcnVuIHlvdXIgcGF0Y2ggdGhyb3VnaCBjaGVja3BhdGNoLnBsPw0K
SGVyZSBJIGd1c3MgbmV3bGluZSBpcyBtaXNzaW5nLg0KDQpBbHNvIHdoeSBhZGRpbmcgdGhvc2Ug
bWFueSBkZWZpbmVzIGlmIHRoZXkgYXJlIG5vdCByZWFsbHkgdXNlZA0KYW55d2hlcmU/DQoNCklu
c3RlYWQgbWF5YmUganVzdCBhZGQgbW9yZSBpbmZvcm1hdGl2ZSBwc2V1ZG8tZ3JhcGhpY3MgYXMg
d2UNCmhhdmUgaW4gYXhzMTB4IHBsYXRmb3JtPyBTZWUNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gvYXJj
L3BsYXQtYXhzMTB4L2F4czEweC5jDQoNCj4gK3N0YXRpYyB2b2lkIF9faW5pdCBoc2RrX2VuYWJs
ZV9ncGlvX2ludGNfd2lyZSh2b2lkKQ0KPiArew0KPiArCXUzMiB2YWwgPSBHUElPX0hBUFNfSU5U
Ow0KPiArDQo+ICsJaW93cml0ZTMyKDB4ZmZmZmZmZmYsICh2b2lkIF9faW9tZW0gKikgR1BJT19J
TlRNQVNLKTsNCj4gKwlpb3dyaXRlMzIofnZhbCwgKHZvaWQgX19pb21lbSAqKSBHUElPX0lOVE1B
U0spOw0KPiArCWlvd3JpdGUzMigweDAwMDAwMDAwLCAodm9pZCBfX2lvbWVtICopIEdQSU9fSU5U
VFlQRV9MRVZFTCk7DQo+ICsJaW93cml0ZTMyKDB4ZmZmZmZmZmYsICh2b2lkIF9faW9tZW0gKikg
R1BJT19JTlRfUE9MQVJJVFkpOw0KPiArCWlvd3JpdGUzMih2YWwsICh2b2lkIF9faW9tZW0gKikg
R1BJT19JTlRFTik7DQo+ICt9DQoNCkkgd291bGQgc3VnZ2VzdCB0byBoYXZlIGEgbWFwIG9mIHJl
YWxseSB1c2VkIGxpbmVzIGFuZCBlbmFibGUgYWxsIG9mIHRoZW0NCmluc3RlYWQgb2YgYWRkaW5n
IG9uZS1ieS1vbmUgb2NjYXNpb25hbGx5Lg0KDQotQWxleGV5
