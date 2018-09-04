Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2855C2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2855C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeIDNqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:46:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:65214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeIDNqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:46:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 02:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="67380858"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2018 02:22:21 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 02:22:21 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 02:22:20 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.205]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 17:22:19 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
Thread-Topic: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
Thread-Index: AQHUOOyjY4j6eKGfo0i2H1+4H4FSu6TeqiKAgACX8wCAAA1xAIAAFyQAgAACpIA=
Date:   Tue, 4 Sep 2018 09:22:19 +0000
Message-ID: <b75b65e3fe222fc927ee8e7379d5760d4cdafe8b.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-2-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809032127550.1462@nanos.tec.linutronix.de>
         <76cf0aca5a2f8e9b94fd0631274a3d4ad825d077.camel@intel.com>
         <alpine.DEB.2.21.1809040947040.1462@nanos.tec.linutronix.de>
         <2db43c762164cada1b85ffd63262b5247fd2e3dc.camel@intel.com>
In-Reply-To: <2db43c762164cada1b85ffd63262b5247fd2e3dc.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.4.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <10E20CFEA1D5EA4DB18B656FB03B63E8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTA0IGF0IDE3OjExICswODAwLCBCaW4gWWFuZyB3cm90ZToNCj4gT24g
VHVlLCAyMDE4LTA5LTA0IGF0IDA5OjQ5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+
ID4gT24gVHVlLCA0IFNlcCAyMDE4LCBZYW5nLCBCaW4gd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIw
MTgtMDktMDMgYXQgMjM6NTcgKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gPiA+ID4g
DQo+ID4gPiA+IFRoZSBsYXN0IHBhdGNoIHdoaWNoIGRvZXMgdGhlIG92ZXJsYXAgY2hlY2sgaXMg
ZXF1YWxseSBicm9rZW46DQo+ID4gPiANCj4gPiA+IFNvcnJ5IHRoYXQgSSBkaWQgbm90IHVuZGVy
c3RhbmQgdGhlIGJyb2tlbiBvZiBsYXN0IHBhdGNoLg0KPiA+IA0KPiA+IEkgbWVhbnQgNC81IHNv
cnJ5LiBUaGF0J3MgdGhlIG9uZSB3aGljaCBpbnRyb2R1Y2VzIHRoZSBvdmVybGFwIGNoZWNrIGFu
ZA0KPiA+IGRvZXMgdGhpczoNCj4gPiANCj4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiArICAg
ICAgICAqIEVuc3VyZSB0aGF0IHRoZSByZXF1ZXN0ZWQgcGdwcm90IGRvZXMgbm90IHZpb2xhdGUg
c3RhdGljIHByb3RlY3Rpb24NCj4gPiA+ID4gKyAgICAgICAgKiByZXF1aXJlbWVudHMuDQo+ID4g
PiA+ICsgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgbmV3X3Byb3QgPSBzdGF0aWNfcHJvdGVj
dGlvbnMocmVxX3Byb3QsIGFkZHJlc3MsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbnVtcGFnZXMgPDwgUEFHRV9TSElGVCwgcGZuKTsNCj4gPiA+ID4gDQo+
ID4gPiA+IEl0IGV4cGFuZHMgbmV3X3Byb3QgdG8gdGhlIHdob2xlIHJhbmdlIGV2ZW4gaWYgdGhl
IHByb3RlY3Rpb25zIG9ubHkNCj4gPiA+ID4gb3ZlcmxhcC4gVGhhdCBzaG91bGQgbm90IGhhcHBl
biBpbiBwcmFjdGljZSwgYnV0IHdlIGhhdmUgbm8gY2hlY2tzIGZvciB0aGF0DQo+ID4gPiA+IGF0
IGFsbC4NCj4gPiA+IA0KPiA+ID4gQmVsb3cgY29kZSBpbiBwYXRjaCAjMyBzaG91bGQgY292ZXIg
dGhpcyBjaGVjay4gSXQgd2lsbCBkb3VibGUgY2hlY2sNCj4gPiA+IG5ld19wcm90IGluIHdob2xl
IGxhcmdlIHBhZ2UgcmFuZ2UuDQo+ID4gDQo+ID4gV2hpY2ggaXMgZXhhY3RseSB3aGF0IGlzIHdy
b25nLiBSZWFkIGFnYWluIHdoYXQgSSB3cm90ZS4NCg0KSXQgbG9va3MgdGhpcyBuZXdfcHJvdCBt
aWdodCBoYXZlIGxlc3MgcHJvdGVjdGlvbiBiaXRzIGFuZCBhbHdheXMNCnBhc3NlcyB0aGUgZm9s
bG93aW5nIGNoZWNrIGF0IHRoZSBiZWdpbiBudW1wYWdlcy4gSSB0aGluayBpdCBjYW4gYmUNCmNo
YW5nZWQgYXMgYmVsb3c6DQoNCgluZXdfcHJvdCA9IHN0YXRpY19wcm90ZWN0aW9ucyhyZXFfcHJv
dCwgYWRkcmVzcywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxLCBwZm4p
Ow0KDQoNCkJ5IHRoZSB3YXksIEkganVzdCBzZW50IGEgZW1wdHkgbWFpbCB0byB5b3UuIEkgYW0g
c28gc29ycnkgZm9yIGl0Lg0KDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IA0KPiA+IAl0Z2x4DQo=
