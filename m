Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BBA2174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BBA2174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbeHCKiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:38:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:52987 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbeHCKiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:38:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 01:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="251400693"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2018 01:42:29 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 3 Aug 2018 01:42:29 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 3 Aug 2018 01:42:28 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0319.002;
 Fri, 3 Aug 2018 16:42:26 +0800
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
Thread-Index: AQHUKsvC0DwQCuNy/kuL3+VLNIom66Ss/RQAgAAzBAA=
Date:   Fri, 3 Aug 2018 08:42:25 +0000
Message-ID: <1533285744.20683.67.camel@intel.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
         <20180803053948.GB1852@kroah.com>
In-Reply-To: <20180803053948.GB1852@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <126C2CD4DA3276408B0FE44FF58A652C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMTgtMDgtMDPkupTnmoQgMDc6MzkgKzAyMDDvvIxHcmVnIEtI5YaZ6YGT77yaDQo+IE9u
IEZyaSwgQXVnIDAzLCAyMDE4IGF0IDA5OjQ1OjIxQU0gKzA4MDAsIFpoYW5nIE5pbmcgd3JvdGU6
DQo+ID4gd2hlbiBmaXJtd2FyZSBpcyBpbiBmaWxlc3lzdGVtLCByZXF1ZXN0X2Zpcm13YXJlIHdp
bGwgbG9hZCBpdCwNCj4gPiBhbmQgY29weSBpdCB0byB2bWFsbG9jIG1lbW9yeSwgdGhhdCBpcyBw
YWdlIGFsaWduIG1lbW9yeS4NCj4gPiANCj4gPiBidXQgd2hlbiBmaXJtd2FyZSBpcyBidWlsdGlu
LCBpdCBpcyA4IGJ5dGVzIG9yIDQgYnl0ZXMgYWxpZ25tZW50Lg0KPiA+IA0KPiA+IG1ha2Ugc3Vy
ZSBidWlsdGluIGZpcm13YXJlIGlzIHBhZ2UgYWxnbm1lbnQsIHRoYXQgY2FuIHNpbXBsaWZ5DQo+
ID4gYWxnb3JpdGhtDQo+ID4gdG8gaGFuZGxlIGZpcm13YXJlLg0KPiANCj4gSG93IGlzIGl0IHNp
bXBsaWZpZWQ/wqDCoEkgZG9uJ3Qgc2VlIGFueSBzdWNoIGNoYW5nZSBsaWtlIHRoYXQgaGVyZSA6
KA0KPiANClRoYW5rIHlvdSBmb3IgcmV2aWV3IHRoaXMgcGF0Y2guDQoNCldoZW4gZHJpdmVyIGhh
bmRsZXMgaXRzIGZpcm13YXJlIGJhc2VkIG9uICBwYWdlLCBsaWtlIGJlbG93Og0KDQoJc3RydWN0
IHBhZ2UgKnA7DQoJcCA9IHZtYWxsb2NfdG9fcGFnZShmdy0+ZGF0YSk7wqDCoC8vIGZvciBmaWxl
c3lzdGVtIGZpcm13YXJlDQoJcCA9IHZpcnRfdG9fcGFnZShmdy0+ZGF0YSk7IC8vIGZvciBidWls
dGluIGZpcm13YXJlDQoNCmJ1dCBpZiBidWlsdGluIGZpcm13YXJlIGlzIG5vdCBwYWdlIGFsaWdu
bWVudCwgcGFnZSBwb2ludGVyIGZvciBidWlsdGluDQpmaXJtd2FyZSBpcyB3cm9uZywgaXQgY29u
dGFpbnMgbWVtb3J5IG5vdCBiZWxvbmcgdG8gZmlybXdhcmUuIGRyaXZlcnMNCmhhcyB0byB1c2Ug
YWRkaXRpb25hbCBjb2RlIHRvIGhhbmRsZSB0aGlzLiANCg0KaWYgYnVpbHRpbiBmaXJtd2FyZSBp
cyBhbHNvIHBhZ2UgYWxpZ25tZW50LCBubyBuZWVkIGFkZGl0aW9uYWwgY29kZSB0bw0KaGFuZGxl
IGJ1aWx0aW4gZmlybXdhcmUuIHNpbXBsaWZpZWQuDQoNCkJSLg0KTmluZy4=
