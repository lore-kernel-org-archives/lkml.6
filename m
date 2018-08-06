Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76234C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34314219A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34314219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeHFEBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:01:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:22906 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeHFEBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:01:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 18:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,450,1526367600"; 
   d="scan'208";a="80883362"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2018 18:48:46 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 5 Aug 2018 18:48:46 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Mon, 6 Aug 2018 09:48:44 +0800
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
Thread-Index: AQHUKsvC0DwQCuNy/kuL3+VLNIom66Ss/RQAgAAzBACAAB5xgIAEJPmA
Date:   Mon, 6 Aug 2018 01:48:44 +0000
Message-ID: <1533520123.20683.71.camel@intel.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
         <20180803053948.GB1852@kroah.com> <1533285744.20683.67.camel@intel.com>
         <20180803103121.GB6557@kroah.com>
In-Reply-To: <20180803103121.GB6557@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8661233D88F2F449AC53512842489B3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMTgtMDgtMDPkupTnmoQgMTI6MzEgKzAyMDDvvIxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZ+WGmemBk++8mg0KPiBPbiBGcmksIEF1ZyAwMywgMjAxOCBhdCAwODo0MjoyNUFNICswMDAw
LCBaaGFuZywgTmluZyBBIHdyb3RlOg0KPiA+IOWcqCAyMDE4LTA4LTAz5LqU55qEIDA3OjM5ICsw
MjAw77yMR3JlZyBLSOWGmemBk++8mg0KPiA+ID4gT24gRnJpLCBBdWcgMDMsIDIwMTggYXQgMDk6
NDU6MjFBTSArMDgwMCwgWmhhbmcgTmluZyB3cm90ZToNCj4gPiA+ID4gd2hlbiBmaXJtd2FyZSBp
cyBpbiBmaWxlc3lzdGVtLCByZXF1ZXN0X2Zpcm13YXJlIHdpbGwgbG9hZCBpdCwNCj4gPiA+ID4g
YW5kIGNvcHkgaXQgdG8gdm1hbGxvYyBtZW1vcnksIHRoYXQgaXMgcGFnZSBhbGlnbiBtZW1vcnku
DQo+ID4gPiA+IA0KPiA+ID4gPiBidXQgd2hlbiBmaXJtd2FyZSBpcyBidWlsdGluLCBpdCBpcyA4
IGJ5dGVzIG9yIDQgYnl0ZXMNCj4gPiA+ID4gYWxpZ25tZW50Lg0KPiA+ID4gPiANCj4gPiA+ID4g
bWFrZSBzdXJlIGJ1aWx0aW4gZmlybXdhcmUgaXMgcGFnZSBhbGdubWVudCwgdGhhdCBjYW4gc2lt
cGxpZnkNCj4gPiA+ID4gYWxnb3JpdGhtDQo+ID4gPiA+IHRvIGhhbmRsZSBmaXJtd2FyZS4NCj4g
PiA+IA0KPiA+ID4gSG93IGlzIGl0IHNpbXBsaWZpZWQ/wqDCoEkgZG9uJ3Qgc2VlIGFueSBzdWNo
IGNoYW5nZSBsaWtlIHRoYXQgaGVyZQ0KPiA+ID4gOigNCj4gPiA+IA0KPiA+IA0KPiA+IFRoYW5r
IHlvdSBmb3IgcmV2aWV3IHRoaXMgcGF0Y2guDQo+ID4gDQo+ID4gV2hlbiBkcml2ZXIgaGFuZGxl
cyBpdHMgZmlybXdhcmUgYmFzZWQgb27CoMKgcGFnZSwgbGlrZSBiZWxvdzoNCj4gPiANCj4gPiAJ
c3RydWN0IHBhZ2UgKnA7DQo+ID4gCXAgPSB2bWFsbG9jX3RvX3BhZ2UoZnctPmRhdGEpO8KgwqAv
LyBmb3IgZmlsZXN5c3RlbSBmaXJtd2FyZQ0KPiA+IAlwID0gdmlydF90b19wYWdlKGZ3LT5kYXRh
KTsgLy8gZm9yIGJ1aWx0aW4gZmlybXdhcmUNCj4gPiANCj4gPiBidXQgaWYgYnVpbHRpbiBmaXJt
d2FyZSBpcyBub3QgcGFnZSBhbGlnbm1lbnQsIHBhZ2UgcG9pbnRlciBmb3INCj4gPiBidWlsdGlu
DQo+ID4gZmlybXdhcmUgaXMgd3JvbmcsIGl0IGNvbnRhaW5zIG1lbW9yeSBub3QgYmVsb25nIHRv
IGZpcm13YXJlLg0KPiA+IGRyaXZlcnMNCj4gPiBoYXMgdG8gdXNlIGFkZGl0aW9uYWwgY29kZSB0
byBoYW5kbGUgdGhpcy7CoA0KPiA+IA0KPiA+IGlmIGJ1aWx0aW4gZmlybXdhcmUgaXMgYWxzbyBw
YWdlIGFsaWdubWVudCwgbm8gbmVlZCBhZGRpdGlvbmFsIGNvZGUNCj4gPiB0bw0KPiA+IGhhbmRs
ZSBidWlsdGluIGZpcm13YXJlLiBzaW1wbGlmaWVkLg0KPiANCj4gQnV0IHlvdSBkaWQgbm90IGNo
YW5nZSBhbnl0aGluZyBsaWtlIHRoaXMgaW4geW91ciBjb2RlLCBzbyB3aHkgd291bGQNCj4gSQ0K
PiBrbm93IHRoaXM/DQoNCkkgdW5kZXJzdGFuZCBpdCBpcyB2ZXJ5IGRpZmZpY3VsdCB0byByZXZp
ZXcgdGhpcyBwYXRjaCB3aXRob3V0IGNvbnRleHQuDQpUaGUgZHJpdmVyIGlzIG5vdCBvcGVuc291
cmNlLCBJIGNhbid0IHNob3cgdGhlIHBhdGNoIGZvciBkcml2ZXIuDQoNCnRoaXMgcGF0Y2ggY2hh
bmdlcyBrZXJuZWwgY29tbW9uIGNvZGUsIGFuZCBpdCBoYXMgdmFsdWUgdG8gdXBzdHJlYW0sIHNv
DQpJIHN1Ym1pdCB0aGlzIHBhdGNoIGZvciByZXZpZXcgYW5kIGFsc28gbG9vayBmb3J3YXJkIHNv
bWUgYWR2aXNlcyBmcm9tDQpjb21tdW5pdHkuIE9uY2Ugd2UgZGVjaWRlIHRvIG9wZW5zb3VyY2Us
IHRoZSBkcml2ZXIgY2hhbmdlcyB3aWxsIGJlDQp0aGVyZS4NCg0KDQoNCg0KPiBQbGVhc2UgZml4
IHRoaXMgdXAgc3VibWl0IHRoaXMgcHJvcGVybHkuDQo+IA0KPiBncmVnIGstaA==
