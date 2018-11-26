Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08317C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AFF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AFF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeK0Isc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:48:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:34711 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeK0Isc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:48:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 13:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="99699524"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2018 13:53:00 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.127]) with mapi id 14.03.0415.000;
 Mon, 26 Nov 2018 13:53:00 -0800
From:   "Li, Juston" <juston.li@intel.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "lyude@redhat.com" <lyude@redhat.com>
CC:     "Ciobanu, Nathan D" <nathan.d.ciobanu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Clinton A" <clinton.a.taylor@intel.com>,
        "jared_dominguez@dell.com" <jared_dominguez@dell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "cpaul@redhat.com" <cpaul@redhat.com>
Subject: Re: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports on
 resume
Thread-Topic: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports
 on resume
Thread-Index: AQHUa0BrUxyBfkiNM0u3Ld3QRT9tzaUva20AgAAKDYCAF8SYgIAcGlIA
Date:   Mon, 26 Nov 2018 21:53:00 +0000
Message-ID: <cfbb393ffa55af35a0db0b9412e0a3847dcf7055.camel@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
         <20181024021925.27026-2-juston.li@intel.com>
         <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
         <ee20a313fb63792c05ab1b67babf1fa9431ebcf8.camel@intel.com>
         <a0646cacfbc4ed8ded12f15d7553c60553adac34.camel@redhat.com>
In-Reply-To: <a0646cacfbc4ed8ded12f15d7553c60553adac34.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.198.166]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C503A07F5C4C1245955296881F2542FD@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBlbWFpbCBnb3QgY2F1Z2h0IGluIGEgYmFkIGZpbHRl
ciA9Lw0KDQpJIGhhdmVuJ3QgYmVlbiBsb29raW5nIGludG8gaXQgbGF0ZWx5IGJ1dCB3ZSBhcmUg
c3RpbGwgaW50ZXJlc3RlZCBpbg0KZ2V0dGluZyB0aGlzIGZpeGVkIHNvIEkgY2FuIHN0YXJ0IGxv
b2tpbmcgaW50byB0aGlzIGFnYWluLg0KDQpJbiB5b3VyIGxhc3QgZW1haWwgeW91IG1lbnRpb25l
ZCBhIHN5c2ZzIGhvdHBsdWcgY291bGQgYmUgdGhlIHdheSB0bw0KZ28/DQoNClRoYW5rcw0KSnVz
dG9uDQoNCk9uIFRodSwgMjAxOC0xMS0wOCBhdCAxOTo0MyAtMDUwMCwgTHl1ZGUgUGF1bCB3cm90
ZToNCj4gQXJlIHlvdSBzdGlsbCBsb29raW5nIGludG8gdGhpcyBhdCBhbGw/IEV2ZW4gaWYgaXQn
cyBub3QgdGhlIHJpZ2h0DQo+IGFwcHJvYWNoDQo+IEknbSBzdGlsbCBpbnRlcmVzdGVkIGluIHNl
ZWluZyB0aGlzIGdldCBmaXhlZCBhcyB3ZWxsL2Rpc2N1c3Npbmcgd2hhdA0KPiBJIHNhaWQNCj4g
YmVmb3JlDQo+IA0KPiBPbiBXZWQsIDIwMTgtMTAtMjQgYXQgMjI6NDUgKzAwMDAsIExpLCBKdXN0
b24gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE4LTEwLTI0IGF0IDE4OjA5IC0wNDAwLCBMeXVkZSBQ
YXVsIHdyb3RlOg0KPiA+ID4gU2luY2UgdGhlcmUncyBnb2luZyB0byBiZSBxdWl0ZSBhIG51bWJl
ciBvZiBjaGFuZ2VzIEkgbmVlZCB0bw0KPiA+ID4gbWFrZSB0bw0KPiA+ID4gdGhpcyBJJ20NCj4g
PiA+IGp1c3QgZ29pbmcgdG8gbWFrZSB0aGUgY2hhbmdlcyBteXNlbGYhIEknbGwgbWFrZSBzdXJl
IHRvIENjIHlvdQ0KPiA+ID4gd2l0aA0KPiA+ID4gdGhlDQo+ID4gPiByZXNwaW4NCj4gPiANCj4g
PiBTb3VuZHMgZ29vZCwgdGhhbmtzIGZvciBwaWNraW5nIGl0IHVwIQ0KPiA+IA0KPiA+IEp1c3Rv
bg0KPiA+IA0K
