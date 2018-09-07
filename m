Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4248C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890220857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8890220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeIGGu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:50:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:38793 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbeIGGuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:50:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 19:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="72277300"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2018 19:12:28 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 6 Sep 2018 19:12:27 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 6 Sep 2018 19:12:27 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 10:12:23 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page
 mapping
Thread-Topic: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page
 mapping
Thread-Index: AQHUOOymJE+K7YyITE+hh9OuBQRM4qTesq4AgACHUgCAABOQgIAAmdOAgAPAxwA=
Date:   Fri, 7 Sep 2018 02:12:23 +0000
Message-ID: <710f6a6fcc00f836eb78952741b79969f159beb9.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
          <1534814186-37067-6-git-send-email-bin.yang@intel.com>
          <alpine.DEB.2.21.1809040023450.1462@nanos.tec.linutronix.de>
         <2ad0ff43ea406005890ad4fcbb7a42da747289d9.camel@intel.com>
         <alpine.DEB.2.21.1809040939400.1462@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1809041835480.3395@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809041835480.3395@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.0 
x-originating-ip: [10.239.4.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FABD20C80E0D448951557E10E114260@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTA0IGF0IDE4OjUyICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgNCBTZXAgMjAxOCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgNCBTZXAgMjAxOCwgWWFuZywgQmluIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAyMDE4LTA5LTA0
IGF0IDAwOjI3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwg
MjEgQXVnIDIwMTgsIEJpbiBZYW5nIHdyb3RlOg0KPiA+ID4gPiA+IEBAIC02MjUsNiArNjI1LDcg
QEAgdHJ5X3ByZXNlcnZlX2xhcmdlX3BhZ2UocHRlX3QgKmtwdGUsIHVuc2lnbmVkIGxvbmcgYWRk
cmVzcywNCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gIAlwc2l6ZSA9IHBhZ2VfbGV2ZWxfc2l6ZShs
ZXZlbCk7DQo+ID4gPiA+ID4gIAlwbWFzayA9IHBhZ2VfbGV2ZWxfbWFzayhsZXZlbCk7DQo+ID4g
PiA+ID4gKwlhZGRyID0gYWRkcmVzcyAmIHBtYXNrOw0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAg
CS8qDQo+ID4gPiA+ID4gIAkgKiBDYWxjdWxhdGUgdGhlIG51bWJlciBvZiBwYWdlcywgd2hpY2gg
Zml0IGludG8gdGhpcyBsYXJnZQ0KPiA+ID4gPiA+IEBAIC02MzYsNiArNjM3LDEyIEBAIHRyeV9w
cmVzZXJ2ZV9sYXJnZV9wYWdlKHB0ZV90ICprcHRlLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsDQo+
ID4gPiA+ID4gIAkJY3BhLT5udW1wYWdlcyA9IG51bXBhZ2VzOw0KPiA+ID4gPiA+ICANCj4gPiA+
ID4gPiAgCS8qDQo+ID4gPiA+ID4gKwkgKiBUaGUgb2xkIHBncHJvdCBzaG91bGQgbm90IGhhdmUg
YW55IHByb3RlY3Rpb24gYml0LiBPdGhlcndpc2UsDQo+ID4gPiA+ID4gKwkgKiB0aGUgZXhpc3Rp
bmcgbWFwcGluZyBpcyB3cm9uZyBhbHJlYWR5Lg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4g
KwlXQVJOX09OX09OQ0UobmVlZHNfc3RhdGljX3Byb3RlY3Rpb25zKG9sZF9wcm90LCBhZGRyLCBw
c2l6ZSwgb2xkX3BmbikpOw0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGNoZWNrIGl0c2VsZiBpcyBm
aW5lLCBidXQgaXQganVzdCBlbWl0cyBhIHdhcm5pbmcgYW5kIGdvZXMgb24gYXMgaWYNCj4gPiA+
ID4gbm90aGluZyBoYXBwZW5lZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFdlIHJlYWxseSB3YW50IHRv
IHRoaW5rIGFib3V0IGEgcHJvcGVyIHdheSB0byBmaXggdGhhdCB1cCB3aXRob3V0IG92ZXJoZWFk
DQo+ID4gPiA+IGZvciB0aGUgc2FuZSBjYXNlLg0KPiA+ID4gDQo+ID4gPiBjb3VsZCB3ZSBjaGFu
Z2UgaXQgYXMgYmVsb3c/IEkgdGhpbmsgaXQgc2hvdWxkIGJlIHNhZmUgdG8gc3BsaXQgbGFyZ2UN
Cj4gPiA+IHBhZ2UgaWYgY3VycmVudCBtYXBwaW5nIGlzIHdyb25nIGFscmVhZHkuDQo+ID4gPiAN
Cj4gPiA+ICAgICAgICAgaWYgKG5lZWRzX3N0YXRpY19wcm90ZWN0aW9ucyhvbGRfcHJvdCwgYWRk
ciwgcHNpemUsIG9sZF9wZm4pKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgV0FSTl9PTl9PTkNF
KDEpOw0KPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCj4gPiA+ICAgICAg
ICAgfQ0KPiA+IA0KPiA+IFN1cmUsIGJ1dCB3aGF0IGVuZm9yY2VzIHRoZSBzdGF0aWMgcHJvdGVj
dGlvbnMgb24gdGhlIHBhZ2VzIHdoaWNoIGFyZSBub3QNCj4gPiBpbiB0aGUgbW9kaWZpZWQgcmFu
Z2Ugb2YgdGhlIGN1cnJlbnQgQ1BBIGNhbGw/IE5vdGhpbmcuDQo+IA0KPiBJIGxvb2tlZCBkZWVw
ZXIgaW50byB0aGF0LiBGb3IgdGhlIFBNRCBzcGxpdCBpdCdzIHJhdGhlciB0cml2aWFsIHRvIGRv
LCBidXQNCj4gYSBQVUQgc3BsaXQgd291bGQgcmVxdWlyZSBhIGhvcnJpYmxlIHBpbGUgb2YgY2hh
bmdlcyBhcyB3ZSdkIGhhdmUgdG8gcmVtb3ZlDQo+IHRoZSBwcm90ZWN0aW9ucyBmcm9tIHRoZSBu
ZXcgUE1EIGZpcnN0LCBnbyBhbGwgdGhlIHdheSBiYWNrIGFuZCByZXNjYW4gdGhlDQo+IG5ldyBQ
TURzIHdoZXRoZXIgdGhleSBuZWVkIHRvIGJlIHNwbGl0IHVwIGZ1cnRoZXIuIEJ1dCB0aGF0IG5l
ZWRzIGEgbG90IG9mDQo+IHJlZmFjdG9yaW5nIGFuZCBJJ20gbm90IHN1cmUgaWYgaXQncyB3b3J0
aCB0aGUgdHJvdWJsZSByaWdodCBub3cuDQo+IA0KPiBBcyB3ZSBoYXZlbid0IGNhcmVkIGFib3V0
IHRoYXQgc2luY2UgQ1BBIGdvdCBpbnRyb2R1Y2VkLCBJIHRoaW5rIHdlIGp1c3QgZG8NCj4gdGhl
IGNvbnNpc3RlbmN5IGNoZWNrIGFuZCB3YXJuLiBUaGF0J3MgYmV0dGVyIHdoYXQgd2UgaGF2ZSBu
b3cgYW5kIHdoZW4gaXQNCj4gZXZlciB0cmlnZ2VycyByZXZpc2l0IGl0Lg0KDQpJcyBiZWxvdyBj
aGVjayBlbm91Z2g/DQoNCiAgICAgICAgaWYgKChwZ3Byb3RfdmFsKG9sZF9wcm90KSAmIF9QQUdF
X1BSRVNFTlQpICYmDQogICAgICAgICAgICBuZWVkc19zdGF0aWNfcHJvdGVjdGlvbnMob2xkX3By
b3QsIGFkZHIsIHBzaXplLCBvbGRfcGZuKSkgew0KICAgICAgICAgICAgICAgIFdBUk5fT05fT05D
RSgxKTsNCiAgICAgICAgfQ0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo=
