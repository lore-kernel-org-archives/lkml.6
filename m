Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3C4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E234207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E234207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJZHiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:38:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:31300 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbeJZHiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:38:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 16:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="98762463"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2018 16:03:35 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 25 Oct 2018 16:03:35 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 25 Oct 2018 16:03:34 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.244]) with mapi id 14.03.0415.000;
 Thu, 25 Oct 2018 17:03:32 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the
 helper functions
Thread-Topic: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in
 the helper functions
Thread-Index: AQHUawBO9chRqp+c5EKJrUo1DG8ZGaUvKsMAgADNk4CAAQNRgIAAANKA
Date:   Thu, 25 Oct 2018 23:03:31 +0000
Message-ID: <6CD573FD-3B38-45B1-9DC6-B5F0E9087FB4@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-5-chang.seok.bae@intel.com>
 <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
 <1EE75BE7-12C6-4BD9-9D31-E9C396D2015B@intel.com>
 <CALCETrVdxKsSgU8zeyn7DO-1toO770yZbEAPTGOtF0FvPfQOXg@mail.gmail.com>
In-Reply-To: <CALCETrVdxKsSgU8zeyn7DO-1toO770yZbEAPTGOtF0FvPfQOXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.152.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <31D47EBD5DD6A34F9903BC9DAD28C9F5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI1LCAyMDE4LCBhdCAxNjowMCwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMjUsIDIwMTggYXQgMTI6MzIgQU0g
QmFlLCBDaGFuZyBTZW9rDQo+IDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+PiBPbiBPY3QgMjQsIDIwMTgsIGF0IDEyOjE2LCBBbmR5IEx1dG9taXJza2kgPGx1
dG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVHVlLCBPY3QgMjMsIDIwMTggYXQg
MTE6NDMgQU0gQ2hhbmcgUy4gQmFlIDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+IHdyb3RlOg0K
Pj4+PiB2b2lkIHg4Nl9mc2Jhc2Vfd3JpdGVfY3B1KHVuc2lnbmVkIGxvbmcgZnNiYXNlKQ0KPj4+
PiB7DQo+Pj4+IC0gICAgICAgLyoNCj4+Pj4gLSAgICAgICAgKiBTZXQgdGhlIHNlbGVjdG9yIHRv
IDAgYXMgYSBub3Rpb24sIHRoYXQgdGhlIHNlZ21lbnQgYmFzZSBpcw0KPj4+PiAtICAgICAgICAq
IG92ZXJ3cml0dGVuLCB3aGljaCB3aWxsIGJlIGNoZWNrZWQgZm9yIHNraXBwaW5nIHRoZSBzZWdt
ZW50IGxvYWQNCj4+Pj4gLSAgICAgICAgKiBkdXJpbmcgY29udGV4dCBzd2l0Y2guDQo+Pj4+IC0g
ICAgICAgICovDQo+Pj4+IC0gICAgICAgbG9hZHNlZyhGUywgMCk7DQo+Pj4+IC0gICAgICAgd3Jt
c3JsKE1TUl9GU19CQVNFLCBmc2Jhc2UpOw0KPj4+PiArICAgICAgIGlmIChzdGF0aWNfY3B1X2hh
cyhYODZfRkVBVFVSRV9GU0dTQkFTRSkpIHsNCj4+Pj4gKyAgICAgICAgICAgICAgIHdyZnNiYXNl
KGZzYmFzZSk7DQo+Pj4+ICsgICAgICAgfSBlbHNlIHsNCj4+Pj4gKyAgICAgICAgICAgICAgIC8q
DQo+Pj4+ICsgICAgICAgICAgICAgICAgKiBTZXQgdGhlIHNlbGVjdG9yIHRvIDAgYXMgYSBub3Rp
b24sIHRoYXQgdGhlIHNlZ21lbnQgYmFzZSBpcw0KPj4+PiArICAgICAgICAgICAgICAgICogb3Zl
cndyaXR0ZW4sIHdoaWNoIHdpbGwgYmUgY2hlY2tlZCBmb3Igc2tpcHBpbmcgdGhlIHNlZ21lbnQg
bG9hZA0KPj4+PiArICAgICAgICAgICAgICAgICogZHVyaW5nIGNvbnRleHQgc3dpdGNoLg0KPj4+
PiArICAgICAgICAgICAgICAgICovDQo+Pj4+ICsgICAgICAgICAgICAgICBsb2Fkc2VnKEZTLCAw
KTsNCj4+Pj4gKyAgICAgICAgICAgICAgIHdybXNybChNU1JfRlNfQkFTRSwgZnNiYXNlKTsNCj4+
Pj4gKyAgICAgICB9DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4+IHZvaWQgeDg2X2dzYmFzZV93cml0ZV9j
cHVfaW5hY3RpdmUodW5zaWduZWQgbG9uZyBnc2Jhc2UpDQo+Pj4+IHsNCj4+Pj4gLSAgICAgICAv
KiBTZXQgdGhlIHNlbGVjdG9yIHRvIDAgZm9yIHRoZSBzYW1lIHJlYXNvbiBhcyAlZnMgYWJvdmUu
ICovDQo+Pj4+IC0gICAgICAgbG9hZHNlZyhHUywgMCk7DQo+Pj4+IC0gICAgICAgd3Jtc3JsKE1T
Ul9LRVJORUxfR1NfQkFTRSwgZ3NiYXNlKTsNCj4+Pj4gKyAgICAgICBpZiAoc3RhdGljX2NwdV9o
YXMoWDg2X0ZFQVRVUkVfRlNHU0JBU0UpKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICB3cl9pbmFj
dGl2ZV9nc2Jhc2UoZ3NiYXNlKTsNCj4+Pj4gKyAgICAgICB9IGVsc2Ugew0KPj4+PiArICAgICAg
ICAgICAgICAgLyogU2V0IHRoZSBzZWxlY3RvciB0byAwIGZvciB0aGUgc2FtZSByZWFzb24gYXMg
JWZzIGFib3ZlLiAqLw0KPj4+PiArICAgICAgICAgICAgICAgbG9hZHNlZyhHUywgMCk7DQo+Pj4+
ICsgICAgICAgICAgICAgICB3cm1zcmwoTVNSX0tFUk5FTF9HU19CQVNFLCBnc2Jhc2UpOw0KPj4+
IA0KPj4+IEkgc3RpbGwgZG9uJ3QgZ2V0IHdoYXQgdGhpcyBjb2RlIGlzIHRyeWluZyB0byBkby4g
IFNlZSBvdGhlciBlbWFpbC4gIEkNCj4+PiB0aGluayBpdCB3aWxsIHN0cmFpZ2h0IHVwIGNyYXNo
IHRoZSBrZXJuZWwgb24gc29tZSBDUFVzLCBzaW5jZSB3cml0aW5nDQo+Pj4gMCB0byAlJWdzIHdp
bGwgemVybyBvdXQgdGhlICphY3RpdmUqIGJhc2Ugb24gc29tZSBDUFVzLg0KPj4+IA0KPj4gDQo+
PiBPbiB0aG9zZSBDUFVzLCBob3cgdGhlIG9sZCBkb19hcmNoX3ByY3RsXzY0KCkgd29ya2VkPw0K
Pj4gbG9hZHNlZyhHUywgMCkgZXZlbnR1YWxseSBoaXRzIHRoZSBuYXRpdmVfbG9hZF9nc19pbmRl
eCBlbnRyeSwgd2hlcmUgYWN0dWFsDQo+PiBtb3Yg4oCmLCAlZ3MgaXMgd3JhcHBlZCBieSB0d28g
U1dBUEdTZXMuIFNvLCBpdCB3b27igJl0IGNhdXNlIHRoZSBzaWRlIGVmZmVjdA0KPj4gb2Ygb3Zl
cndyaXRpbmcgdGhlICphY3RpdmUqIGJhc2UsIEkgdGhpbmsuDQo+PiANCj4+PiBJIHRoaW5rIHRo
YXQsIGlmIHlvdSByZWFsbHkgd2FudCBzb21lIGZhbmN5IG9wdGltaXphdGlvbiBmb3IgdGhlDQo+
Pj4gbm9uLUZTR1NCQVNFIGNhc2UsIHlvdSBuZWVkIHRvIHB1bGwgdGhhdCBvdXQgaW50byB0aGUg
Y2FsbGVycyBvZiB0aGVzZQ0KPj4+IGhlbHBlcnMuDQo+PiANCj4gDQo+IEkgd2FzIHRoaW5raW5n
IG9mIGxvYWRzZWdtZW50LCBub3QgbG9hZHNlZy4gIFNvcnJ5IQ0KDQpObyBwcm9ibGVtISAgQXBw
cmVjaWF0ZSB5b3VyIHJldmlld3MuDQoNCkNoYW5nDQoNCg==
