Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28EBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F721741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeLTIuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:50:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:59518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbeLTIuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:50:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 00:50:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,376,1539673200"; 
   d="scan'208";a="119800971"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2018 00:50:39 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 20 Dec 2018 00:50:38 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 20 Dec 2018 00:50:38 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.59]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.210]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 16:50:34 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Du, Alek" <alek.du@intel.com>,
        "ping.a.gao@intel.com" <ping.a.gao@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] drm/i915: Fix i915_gem_wait_for_idle oops due to
 active_requests check
Thread-Topic: [PATCH] drm/i915: Fix i915_gem_wait_for_idle oops due to
 active_requests check
Thread-Index: AQHUmDxDeLO92TenP0S4+zyb2yc6QKWGx3UA////zYA=
Date:   Thu, 20 Dec 2018 08:50:34 +0000
Message-ID: <916a5783c2111c601d69a3665d4fee9c51239158.camel@intel.com>
References: <20181220080135.9059-1-bin.yang@intel.com>
         <154529495460.10782.18092727751160821897@skylake-alporthouse-com>
In-Reply-To: <154529495460.10782.18092727751160821897@skylake-alporthouse-com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.204.198]
Content-Type: text/plain; charset="utf-8"
Content-ID: <50BBD52BA48A2640BB0930CFD0E7B7B6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEyLTIwIGF0IDA4OjM1ICswMDAwLCBDaHJpcyBXaWxzb24gd3JvdGU6DQo+
IFF1b3RpbmcgQmluIFlhbmcgKDIwMTgtMTItMjAgMDg6MDE6MzUpDQo+ID4gTm9ybWFsbHksIGk5
MTVfcmVxdWVzdF9hbGxvYygpIGFuZCBpOTE1X3JlcXVlc3RfYWRkKCkgd2lsbCBiZSBjYWxsZWQN
Cj4gPiBpbiBzZXF1ZW5jZSB3aXRoIGRybS5zdHJ1Y3RfbXV0ZXggbG9ja2VkLiBCdXQgaW4NCj4g
PiBpbnRlbF92Z3B1X2NyZWF0ZV93b3JrbG9hZCgpLCBpdCB3aWxsIHByZS1hbGxvY2F0ZSB0aGUg
cmVxdWVzdCBhbmQNCj4gPiBjYWxsIGk5MTVfcmVxdWVzdF9hZGQoKSBpbiB0aGUgd29ya2xvYWQg
dGhyZWFkIGZvciBwZXJmb3JtYW5jZQ0KPiA+IG9wdGltaXphdGlvbi4gVGhlIGFib3ZlIGlzc3Vl
IHdpbGwgYmUgdHJpZ2dlcmVkLg0KPiANCj4gVGhhdCdzIHlvdXIgYnVnLiBJdCdzIG5vdCBub3Jt
YWxseSwgaXQncyBhIHN0cmljdCByZXF1aXJlbWVudCB0aGF0IHRoZQ0KPiBzdHJ1Y3RfbXV0ZXgg
KHJlcXVlc3QgZ2VuZXJhdGlvbiBtdXRleCkgYmUgaGVsZCBvdmVyIHRoZSBjb3Vyc2Ugb2YNCj4g
Z2VuZXJhdGluZyB0aGUgcmVxdWVzdC4NCj4gLUNocmlzDQoNClRoaXMgY29kZSBpcyBpbnRyb2R1
Y2VkIGJ5IGJlbG93IHBhdGNoLiBBZGQgb3JpZ2luYWwgcGF0Y2ggb3duZXJzIHRvDQpkaXNjdXNz
IHRoaXMgaXNzdWUuDQoNCmNvbW1pdCBkMDMwMmU3NDAwM2JmMWYwZmM0MWMwNjk0OGI3NDUyMDRj
NDcwNGVhDQpBdXRob3I6IFBpbmcgR2FvIDxwaW5nLmEuZ2FvQGludGVsLmNvbT4NCkRhdGU6ICAg
VGh1IEp1biAyOSAxMjoyMjo0MyAyMDE3ICswODAwDQoNCiAgICBkcm0vaTkxNS9ndnQ6IEF1ZGl0
IGFuZCBzaGFkb3cgd29ya2xvYWQgZHVyaW5nIEVMU1Agd3JpdGluZw0KICAgIA0KICAgIExldCB0
aGUgd29ya2xvYWQgYXVkaXQgYW5kIHNoYWRvdyBhaGVhZCBvZiB2R1BVIHNjaGVkdWxpbmcsIHRo
YXQNCiAgICB3aWxsIGVsaW1pbmF0ZSBHUFUgaWRsZSB0aW1lIGFuZCBpbXByb3ZlIHBlcmZvcm1h
bmNlIGZvciBtdWx0aS1WTS4NCiAgICANCiAgICBUaGUgcGVyZm9ybWFuY2Ugb2YgSGVhdmVuIHJ1
bm5pbmcgc2ltdWx0YW5lb3VzbHkgaW4gM1ZNcyBoYXMNCiAgICBpbXByb3ZlZCAyMCUgYWZ0ZXIg
dGhpcyBwYXRjaC4NCiAgICANCiAgICB2MjpSZW1vdmUgY29uZGl0aW9uIGN1cnJlbnQtPnZncHU9
PXZncHUgd2hlbiBzaGFkb3cgZHVyaW5nIEVMU1ANCiAgICB3cml0aW5nLg0KICAgIA0KICAgIFNp
Z25lZC1vZmYtYnk6IFBpbmcgR2FvIDxwaW5nLmEuZ2FvQGludGVsLmNvbT4NCiAgICBSZXZpZXdl
ZC1ieTogWmhpIFdhbmcgPHpoaS5hLndhbmdAaW50ZWwuY29tPg0KICAgIFNpZ25lZC1vZmYtYnk6
IFpoZW55dSBXYW5nIDx6aGVueXV3QGxpbnV4LmludGVsLmNvbT4NCg0KDQoNCg==
