Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39300219D0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39300219D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeHFHVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:21:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:20607 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeHFHVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:21:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 22:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="70448102"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2018 22:13:20 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 5 Aug 2018 22:13:20 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 5 Aug 2018 22:13:19 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0319.002;
 Mon, 6 Aug 2018 13:13:18 +0800
From:   "Zhang, Ning A" <ning.a.zhang@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Ting" <ting.li@intel.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "markus@trippelsdorf.de" <markus@trippelsdorf.de>
Subject: Re: [PATCH] firmware: make sure builtin firmware is page alignment
Thread-Topic: [PATCH] firmware: make sure builtin firmware is page alignment
Thread-Index: AQHUKsvC0DwQCuNy/kuL3+VLNIom66Ss/RQAgAAzBACAAB5xgIAEJPmAgAA5KIA=
Date:   Mon, 6 Aug 2018 05:13:17 +0000
Message-ID: <1533532397.20683.74.camel@intel.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
         <20180803053948.GB1852@kroah.com> <1533285744.20683.67.camel@intel.com>
         <20180803103121.GB6557@kroah.com> <1533520123.20683.71.camel@intel.com>
In-Reply-To: <1533520123.20683.71.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6971E5EAEA7F469A56FF3EA7D321EF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMTgtMDgtMDbkuIDnmoQgMDE6NDggKzAwMDDvvIxaaGFuZywgTmluZyBB5YaZ6YGT77ya
DQo+IOWcqCAyMDE4LTA4LTAz5LqU55qEIDEyOjMxICswMjAw77yMZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmflhpnpgZPvvJoNCj4gPiBPbiBGcmksIEF1ZyAwMywgMjAxOCBhdCAwODo0MjoyNUFN
ICswMDAwLCBaaGFuZywgTmluZyBBIHdyb3RlOg0KPiA+ID4g5ZyoIDIwMTgtMDgtMDPkupTnmoQg
MDc6MzkgKzAyMDDvvIxHcmVnIEtI5YaZ6YGT77yaDQo+ID4gPiA+IE9uIEZyaSwgQXVnIDAzLCAy
MDE4IGF0IDA5OjQ1OjIxQU0gKzA4MDAsIFpoYW5nIE5pbmcgd3JvdGU6DQo+ID4gPiA+ID4gd2hl
biBmaXJtd2FyZSBpcyBpbiBmaWxlc3lzdGVtLCByZXF1ZXN0X2Zpcm13YXJlIHdpbGwgbG9hZA0K
PiA+ID4gPiA+IGl0LA0KPiA+ID4gPiA+IGFuZCBjb3B5IGl0IHRvIHZtYWxsb2MgbWVtb3J5LCB0
aGF0IGlzIHBhZ2UgYWxpZ24gbWVtb3J5Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGJ1dCB3aGVu
IGZpcm13YXJlIGlzIGJ1aWx0aW4sIGl0IGlzIDggYnl0ZXMgb3IgNCBieXRlcw0KPiA+ID4gPiA+
IGFsaWdubWVudC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBtYWtlIHN1cmUgYnVpbHRpbiBmaXJt
d2FyZSBpcyBwYWdlIGFsZ25tZW50LCB0aGF0IGNhbg0KPiA+ID4gPiA+IHNpbXBsaWZ5DQo+ID4g
PiA+ID4gYWxnb3JpdGhtDQo+ID4gPiA+ID4gdG8gaGFuZGxlIGZpcm13YXJlLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gSG93IGlzIGl0IHNpbXBsaWZpZWQ/wqDCoEkgZG9uJ3Qgc2VlIGFueSBzdWNoIGNo
YW5nZSBsaWtlIHRoYXQNCj4gPiA+ID4gaGVyZQ0KPiA+ID4gPiA6KA0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gVGhhbmsgeW91IGZvciByZXZpZXcgdGhpcyBwYXRjaC4NCj4gPiA+IA0KPiA+ID4g
V2hlbiBkcml2ZXIgaGFuZGxlcyBpdHMgZmlybXdhcmUgYmFzZWQgb27CoMKgcGFnZSwgbGlrZSBi
ZWxvdzoNCj4gPiA+IA0KPiA+ID4gCXN0cnVjdCBwYWdlICpwOw0KPiA+ID4gCXAgPSB2bWFsbG9j
X3RvX3BhZ2UoZnctPmRhdGEpO8KgwqAvLyBmb3IgZmlsZXN5c3RlbSBmaXJtd2FyZQ0KPiA+ID4g
CXAgPSB2aXJ0X3RvX3BhZ2UoZnctPmRhdGEpOyAvLyBmb3IgYnVpbHRpbiBmaXJtd2FyZQ0KPiA+
ID4gDQo+ID4gPiBidXQgaWYgYnVpbHRpbiBmaXJtd2FyZSBpcyBub3QgcGFnZSBhbGlnbm1lbnQs
IHBhZ2UgcG9pbnRlciBmb3INCj4gPiA+IGJ1aWx0aW4NCj4gPiA+IGZpcm13YXJlIGlzIHdyb25n
LCBpdCBjb250YWlucyBtZW1vcnkgbm90IGJlbG9uZyB0byBmaXJtd2FyZS4NCj4gPiA+IGRyaXZl
cnMNCj4gPiA+IGhhcyB0byB1c2UgYWRkaXRpb25hbCBjb2RlIHRvIGhhbmRsZSB0aGlzLsKgDQo+
ID4gPiANCj4gPiA+IGlmIGJ1aWx0aW4gZmlybXdhcmUgaXMgYWxzbyBwYWdlIGFsaWdubWVudCwg
bm8gbmVlZCBhZGRpdGlvbmFsDQo+ID4gPiBjb2RlDQo+ID4gPiB0bw0KPiA+ID4gaGFuZGxlIGJ1
aWx0aW4gZmlybXdhcmUuIHNpbXBsaWZpZWQuDQo+ID4gDQo+ID4gQnV0IHlvdSBkaWQgbm90IGNo
YW5nZSBhbnl0aGluZyBsaWtlIHRoaXMgaW4geW91ciBjb2RlLCBzbyB3aHkNCj4gPiB3b3VsZA0K
PiA+IEkNCj4gPiBrbm93IHRoaXM/DQo+IA0KPiBJIHVuZGVyc3RhbmQgaXQgaXMgdmVyeSBkaWZm
aWN1bHQgdG8gcmV2aWV3IHRoaXMgcGF0Y2ggd2l0aG91dA0KPiBjb250ZXh0Lg0KPiBUaGUgZHJp
dmVyIGlzIG5vdCBvcGVuc291cmNlLCBJIGNhbid0IHNob3cgdGhlIHBhdGNoIGZvciBkcml2ZXIu
DQo+IA0KPiB0aGlzIHBhdGNoIGNoYW5nZXMga2VybmVsIGNvbW1vbiBjb2RlLCBhbmQgaXQgaGFz
IHZhbHVlIHRvIHVwc3RyZWFtLA0KPiBzbw0KPiBJIHN1Ym1pdCB0aGlzIHBhdGNoIGZvciByZXZp
ZXcgYW5kIGFsc28gbG9vayBmb3J3YXJkIHNvbWUgYWR2aXNlcw0KPiBmcm9tDQo+IGNvbW11bml0
eS4gT25jZSB3ZSBkZWNpZGUgdG8gb3BlbnNvdXJjZSwgdGhlIGRyaXZlciBjaGFuZ2VzIHdpbGwg
YmUNCj4gdGhlcmUuDQo+IA0KPiANCg0KYXMgc2FpZCBvdXIgZHJpdmVyIGhhbmRsZXMgZmlybXdh
cmUgYmFzZWQgb24gcGFnZSwgYW5kIGlmIGZpcm13YXJlIGlzDQpidWlsdGluLCBwYWdlIHBvaW50
IGZyb20gdmlydF90b19wYWdlKGZ3LT5kYXRhKSBjb250YWlucyBtZW1vcnkgZG9lc24ndA0KYmVs
b25nIHRvIGZpcm13YXJlLiB0aGVyZSBhcmUgdHdvIHdheSB0byBmaXggaXQuDQoNCjEsIGNvcHkg
YnVpbHRpbiBmaXJtd2FyZSB0byB2bWFsbG9jIG1lbW9yeSwgdGhpcyBpcyBhZGRpdGlvbmFsIHdv
cmsgdG8NCmhhbmRsZSBmaXJtd2FyZS4gSSBjcmVhdGUgYSB3cmFwIGZ1bmN0aW9uIGZvciBmaXJt
d2FyZSByZXF1ZXN0Lg0KDQppbnQgcmVxdWVzdF9YWVpfZncoY29uc3Qgc3RydWN0IGZpcm13YXJl
ICoqZmlybXdhcmVfcCwgY29uc3QgY2hhcg0KKm5hbWUsDQoJCcKgc3RydWN0IGRldmljZSAqZGV2
aWNlKQ0Kew0KCWNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZnc7DQoJc3RydWN0IGZpcm13YXJlICp0
bXA7DQoJaW50IHJldDsNCg0KCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBuYW1lLCBkZXZp
Y2UpOw0KDQoJaWYgKHJldCA8IDApDQoJCXJldHVybiByZXQ7DQoNCglpZiAoaXNfdm1hbGxvY19h
ZGRyKGZ3LT5kYXRhKSkNCgkJKmZpcm13YXJlX3AgPSBmdzsNCgllbHNlIHsNCgkJdG1wID0gKHN0
cnVjdCBmaXJtd2FyZSAqKWt6YWxsb2Moc2l6ZW9mKHN0cnVjdA0KZmlybXdhcmUpLCBHRlBfS0VS
TkVMKTsNCgkJaWYgKCF0bXApDQoJCQlyZXR1cm4gLUVOT01FTTsNCgkJdG1wLT5zaXplID0gZnct
PnNpemU7DQoJCXRtcC0+ZGF0YSA9IHZtYWxsb2MoZnctPnNpemUpOw0KCQltZW1jcHkodG1wLT5k
YXRhLCBmdy0+ZGF0YSwgZnctPnNpemUpOw0KCQkqZmlybXdhcmVfcCA9IHRtcDsNCgl9DQoJcmV0
dXJuIHJldDsNCn0NCg0KMiwgbWFrZSBidWlsdGluIGZpcm13YXJlIGlzIGFsc28gcGFnZSBhbGln
bm1lbnQuIHRoZSBjaGFuZ2UgaW4gZHJpdmVyDQpjb2RlIGlzIHRvIGNoZWNrIG1lbW9yeSB0eXBl
IG9mIGZ3LT5kYXRhLCBhbmQgdXNlIGRpZmZlcmVudCBYWFhfdG9fcGFnZQ0KZnVuY3Rpb24uDQoN
CnN0cnVjdCBwYWdlICpwOw0KaWYgKGlzX3ZtYWxsb2NfYWRkcihmdy0+ZGF0YSkpICAvLyBuZXcN
CglwID0gdm1hbGxvY190b19wYWdlKGZ3LT5kYXRhKTsNCmVsc2UgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLy8gbmV3DQoJcCA9IHZpcnRfdG9fcGFnZShmdy0+ZGF0YSk7IC8vIG5ldw0KDQoN
CmNvbXBhcmUgdG8gc29sdXRpb24sIHNvbHV0aW9uIDIgaXMgc2ltcGxlLCB0aGlzIGlzIHdoYXQg
SSBzYWlkDQpzaW1wbGlmaWVkLiBhbmQgc29sdXRpb24gMiBhbHNvIHNhdmUgbWVtb3J5IChJIGRv
bid0IGtub3cgdGhlIGFmZmVjdA0KY2hhbmdlIG1lbW9yeSBhbGlnbm1lbnQgb24gbWVtb3J5IHVz
YWdlLikNCg0KSGksIEdyZWcNCmlzIHRoaXMgZWFzaWVyIGZvciB5b3UgdG8gcmV2aWV3Pw0KDQpC
Ui4NCk5pbmcuDQo+IA0KDQo+IA0KUGxlYXNlIGZpeCB0aGlzIHVwIHN1Ym1pdCB0aGlzIHByb3Bl
cmx5Lg0KDQpncmVnIGstaA==
