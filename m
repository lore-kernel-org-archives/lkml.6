Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D54EA96C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E352F208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jGuoQ8JK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E352F208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeGLSNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:13:43 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42197 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:13:43 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5036F10C05D8;
        Thu, 12 Jul 2018 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531418584; bh=n7Xpnl3/Wb3aw3KMciP8hYdF5H3vjC/fXAblijC9EVE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jGuoQ8JKpD2MKOAMgV8dpYN3YOenbqoMz6XMYUcPZ2rhletm/+M0sY1Mo0yV72KJT
         xc3gossWoKm29MIGjfvOWEMVFo5Js7/6IYPz1ZZIBGZTSlWT+mRx65BQtane+YRuNP
         3qHVo0uGAY3O2dnzDanRsi+XuG1INPNfpN/pP2y+u4IHrWPnQRYPUzSV4smazHnSVG
         bdidTSyVoMltxCuWpf+NNnOFxC6zjZn+GJ0conXJ9qT07EM0KyNAcT7M2MwfEHxZUo
         vbqU9N0hydgGCHCE4aeHb5FuguzmU9uj32vx1QIsnfeCUK+zZQPchz6G059o/fTZW1
         HiT8eMq3HsDew==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3EE3B5DDD;
        Thu, 12 Jul 2018 11:03:04 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 12 Jul 2018 11:03:04 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 12 Jul 2018 20:03:01 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: [plat-axs10x] Get rid of auto-selected
 CONFIG_AX10x options
Thread-Topic: [PATCH] ARC: [plat-axs10x] Get rid of auto-selected
 CONFIG_AX10x options
Thread-Index: AQHUGTqEE/53LsVGkEWzm5NPOOUYI6SLwSUA
Date:   Thu, 12 Jul 2018 18:03:00 +0000
Message-ID: <b0aeb56112386c4301951df8b02603a8e8f124ca.camel@synopsys.com>
References: <20180711171333.1745-1-abrodkin@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA230750110F6680C@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230750110F6680C@us01wembx1.internal.synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <82EE88797A7B7A46B31944ADEF100356@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUaHUsIDIwMTgtMDctMTIgYXQgMTA6MzYgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDcvMTEvMjAxOCAxMDoxMyBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gQ29tbWl0IDRmYmFmNjQ5ZWJiYyAoIkFSQzogW3BsYXQtYXhzMTB4XSBhdXRvLXNl
bGVjdCBBWFMxMDEgb3IgQVhTMTAzIGdpdmVuIHRoZSAgSVNBIGNvbmZpZyIpDQo+ID4gbWFkZSBz
ZWxlY3Rpb24gb2YgQ09ORklHX0FYUzEweCBvcHRpb24gYXV0b21hdGljIHNvIHRoZXJlJ3Mgbm8g
cG9pbnQNCj4gPiBpbiBrZWVwaW5nIHRoZW0gaW4gZGVmY29uZmlncy4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPg0KPiANCj4g
Q2FuIHlvdSByZWdlbmVyYXRlIHRoZSBkZWZjb25maWdzIC0gdGhlcmUgc2VlbSB0byBiZSBtb3Jl
IGNoYW5nZXMgbm93IHRoYW4ganVzdCB0aG9zZS4NCg0KVGhlIG9ubHkgdGhpbmcgbGVmdCBpcyB0
aGlzIG9uZToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkBAIC02Myw3ICs2Myw2IEBAIENPTkZJR19NT1VTRV9QUzJfVE9VQ0hLSVQ9eQ0KIENPTkZJ
R19NT1VTRV9TRVJJQUw9eQ0KIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfVVNCPXkNCiAjIENPTkZJ
R19MRUdBQ1lfUFRZUyBpcyBub3Qgc2V0DQotIyBDT05GSUdfREVWS01FTSBpcyBub3Qgc2V0DQog
Q09ORklHX1NFUklBTF84MjUwPXkNCiBDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15DQogQ09O
RklHX1NFUklBTF84MjUwX0RXPXkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCg0KQnV0IEkgd2FzIGdvaW5nIHRvIGludmVzdGlnYXRlIGEgYml0IG1v
cmUgb24gd2h5IHRoaXMgb25lIGJlY2FtZQ0Kbm90IG5lZWRlZC4gU2hvdWxkbid0IGJlIHJvY2tl
dCBzY2llbmNlIGJ1dCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHdoYXQNCmFtIEkgZG9pbmcgOikN
Cg0KPiBBbHNvIGZvciB0aGUgb3RoZXIgcGF0Y2ggZm9yIEZVU0UsIGlzIHRoaXMgc29tZXRoaW5n
IHdlIHdpbGwgbmVlZCBkYXkgaW4gZGF5IG91dCAtDQo+IEknbSBhZnJhaWQgd2Ugd2lsbCBzdGFy
dCBibG9hdGluZyBzdHVmZiAuDQoNCkZvciBtZSB0aGUgbWFpbiB1c2FnZSBvZiBGVVNFIGlzIFNT
SEZTIHdoaWNoIGFsbG93cyB0byBtb3VudCBmaWxlLXN5c3RlbSBvZg0Kd2hhdGV2ZXIgU1NILWVu
YWJsZWQgc2VydmVyIHRvIHRoZSBib2FyZC4gVGhlIHBvaW50IGlzIGl0J3MgcXVpdGUgYSByYXJl
IG9jY2FzaW9uDQp3aGVuIG9uZSBtYXkgc3RhcnQgYW5kIHVzZSBORlMgc2VydmVyIG9uIG1hY2hp
bmUgaGUvc2hlIGRvZXNuJ3Qgb3duLg0KDQpBcyBhbiBleGFtcGxlIEkgbWF5IGJ1aWxkIHN0dWZm
IG9uIHBvd2VyZnVsIHNlcnZlciBhbmQgc3RpbGwgdXNlIHJlc3VsdHMNCm9uIHRhcmdldC4NCg0K
PiBJZiB5b3UgaW5zaXN0IEkgY2FuIGFkZCBpdCAtIGJ1dCBpJ3Mgc3RpbGwgcHJlZmVyIHlvdSBi
dWlsZCB0aGVtIHVzaW5nIG1vZHVsZXMgYW5kDQo+IHN0YXJ0IHRlc3RpbmcgdGhhdCBpbmZyYSBh
cyB3ZWxsLg0KDQpNb2R1bGVzIGFyZSBhbGwgZmluZSB3aXRoIG9uZSBpbXBvcnRhbnQgbm90ZSAt
IG9uIGV2ZXJ5IGtlcm5lbCBzb3VyY2UgY2hhbmdlIHdlDQpuZWVkIHRvIGNvcHkgZXZlcnkgbW9k
dWxlIGluIHJvb3RmcyBvdGhlcndpc2Ugb2xkZXIgb25lcyB3b24ndCBiZSBldmVuIGxvYWRlZC4N
ClNvIGZvciBkZXZlbG9wbWVudCBtb2R1bGVzIGFyZSBub3Qgc3VwZXIgY29udmVuaWVudC4NCg0K
QW5vdGhlciByZWFzb24gdG8gYWRkIG1vcmUgcHJldHR5IGNvbW1vbiBvcHRpb25zIHRvIGF0IGxl
YXN0IEhTREsgKGFuZCBJIGd1ZXNzDQpBWDEweCBzdHVmZiBpcyBvbiBub3QgbXVjaCBpbnRlcmVz
dCBmb3IgeW91IGFzIGNvbXBhcmVkIHRvIEhTREspIGlzIG1vcmUgYW5kIG1vcmUNCnBlb3BsZSBz
dGFydCB0byBwbGF5IHdpdGggdGhlIGJvYXJkIGFuZCB0byBtYWtlIHRoZWlyIChhbmQgdGh1cyBv
dXJzKSBsaWZlIGVhc2llcg0Kd2UnZCBiZXR0ZXIgaGF2ZSBiYXNpY3MgaW4gcGxhY2UgZnJvbSBk
YXkgb25lIHJhdGhlciB0aGFuIGV4cGxhaW5pbmcgcGVvcGxlIGhvdw0KdG8gb3ZlcmNvbWUgInVu
ZXhwZWN0ZWQiIGRpZmZpY3VsdGllcy4NCg0KV2UgbWF5IGluZGVlZCBvbmUgYWdhaW4gYWdyZWUg
b24gaGF2aW5nIGFuIGFkZGl0aW9uYWwgZGVmY29uZmlnIGZvciBkZW1vcywgZGlzdHJvcw0KYW5k
IHNvIG9uIHRvZ2V0aGVyIHdpdGggYmFyZS1taW5pbWFsIGNvbmZpZyB3ZSdsbCBiZSB1c2luZyBm
b3Igb3VyIGRldmVsb3BtZW50IGJ1dA0KdGhpcyB3aWxsIG1lYW4gdGhhdCBmdWxsZXIgZGVmY29u
ZmlnIHdvbid0IGJlIGRhaWx5IHRlc3RlZCB3aGljaCBpcyBub3Qgd2hhdCB3ZSB3YW50Lg0KQWxz
byBrZWVwaW5nIGluIHN5bmMgbXVsdGlwbGUgY29uZmlncyBpcyBub3QgdGhlIGJlc3QgaWRlYSBl
dmVyIGVzcGVjaWFsbHkgaWYgdGhlcmUncmUNCnN1YnRsZSBkaWZmZXJlbmNlcyBoZXJlIGFuZCB0
aGVyZS4NCg0KLUFsZXhleQ==
