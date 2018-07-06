Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15792C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995323F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B995323F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeGFIOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:14:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:10630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753029AbeGFIN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:13:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 01:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,315,1526367600"; 
   d="scan'208";a="64856323"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2018 01:13:58 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 6 Jul 2018 01:13:57 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.100]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.17]) with mapi id 14.03.0319.002;
 Fri, 6 Jul 2018 16:13:55 +0800
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Robert Hoo <robert.hu@linux.intel.com>
Subject: RE: [PATCH v2] KVM: Expose the split lock detection feature to
 guest VM
Thread-Topic: [PATCH v2] KVM: Expose the split lock detection feature to
 guest VM
Thread-Index: AQHUE5fnWpiJU0XHCkCVtYR6jiO3kaR+iscAgANOKRA=
Date:   Fri, 6 Jul 2018 08:13:55 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D352762245@SHSMSX103.ccr.corp.intel.com>
References: <1530709593-87702-1-git-send-email-jingqi.liu@intel.com>
 <7813a04b-8058-538b-8c9b-cdd01ce119ac@redhat.com>
In-Reply-To: <7813a04b-8058-538b-8c9b-cdd01ce119ac@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTYyMDE1ZDYtM2M4Ni00NGRmLTllNDAtZTdhZGM1OTZlYzFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRFwveXpHcHlzTkxFTnhcL2wxb2cySUFmNmpMMmJId0xPUFUxYUFqQ2xNRHZ1NjhLVm5zOUVtKzJNUjdBWGhVd2p1In0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDcvMjAxOCAyMTozNywgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gMDQvMDcvMjAx
OCAxNTowNiwgSmluZ3FpIExpdSB3cm90ZToNCj4gPiBBIG5ldyBjb250cm9sIGJpdChiaXQgMjkp
IGluIHRoZSBURVNUX0NUUkwgTVNSIHdpbGwgYmUgaW50cm9kdWNlZCB0bw0KPiA+IGVuYWJsZSBk
ZXRlY3Rpb24gb2Ygc3BsaXQgbG9ja3MuDQo+ID4NCj4gPiBXaGVuIGJpdCAyOSBvZiB0aGUgVEVT
VF9DVFJMKDMzSCkgTVNSIGlzIHNldCwgdGhlIHByb2Nlc3NvciBjYXVzZXMgYW4NCj4gPiAjQUMg
ZXhjZXB0aW9uIHRvIGJlIGlzc3VlZCBpbnN0ZWFkIG9mIHN1cHByZXNzaW5nIExPQ0sgb24gYnVz
KGR1cmluZw0KPiA+IHNwbGl0IGxvY2sgYWNjZXNzKS4gQSBwcmV2aW91cyBjb250cm9sIGJpdCAo
Yml0IDMxKSBpbiB0aGlzIE1TUiBjYXVzZXMNCj4gPiB0aGUgcHJvY2Vzc29yIHRvIGRpc2FibGUg
TE9DSyMgYXNzZXJ0aW9uIGZvciBzcGxpdCBsb2NrZWQgYWNjZXNzZXMNCj4gPiB3aGVuIHNldC4g
V2hlbiBiaXRzIDI5IGFuZCAzMSBhcmUgYm90aCBzZXQsIGJpdCAyOSB0YWtlcyBwcmVjZWRlbmNl
Lg0KPiA+DQo+ID4gVGhlIHJlbGVhc2UgZG9jdW1lbnQgcmVmIGJlbG93IGxpbms6DQo+ID4gaHR0
cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vc2l0ZXMvZGVmYXVsdC9maWxlcy9tYW5hZ2VkL2M1LzE1
L1wNCj4gPiBhcmNoaXRlY3R1cmUtaW5zdHJ1Y3Rpb24tc2V0LWV4dGVuc2lvbnMtcHJvZ3JhbW1p
bmctcmVmZXJlbmNlLnBkZg0KPiA+IFRoaXMgcGF0Y2ggaGFzIGEgZGVwZW5kZW5jeSBvbiBodHRw
czovL2xrbWwub3JnL2xrbWwvMjAxOC81LzI3Lzc4Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmluZ3FpIExpdSA8amluZ3FpLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCAgMSArDQo+ID4gIGFyY2gveDg2L2t2bS92bXguYyAg
ICAgICAgICAgICAgfCA3Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICBhcmNoL3g4Ni9rdm0veDg2LmMgICAgICAgICAgICAgIHwgMTAgKysrKysrDQo+
ID4gIGFyY2gveDg2L2t2bS94ODYuaCAgICAgICAgICAgICAgfCAgNSArKysNCj4gPiAgaW5jbHVk
ZS91YXBpL2xpbnV4L2t2bS5oICAgICAgICB8ICAxICsNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA5
NCBpbnNlcnRpb25zKCspDQo+IA0KPiBDaGVja2luZyBmb3Igc3BsaXQgbG9jayBpcyBkb25lIHdp
dGggdGhlIE1TUl9URVNUX0NUTCB0b28sIHNvIHlvdSBzaG91bGQgbm90DQo+IHVzZSBhIGNhcGFi
aWxpdHkgdG8gZXhwb3NlIHRoZSBhdmFpbGFiaWxpdHkgdG8gS1ZNIHVzZXJzcGFjZS4NCj4gSW5z
dGVhZCB5b3Ugc2hvdWxkIGV4cG9zZSB0aGUgY29udGVudHMgb2YgTVNSX1RFU1RfQ1RMIG9uIHRo
ZSBob3N0LCBpbiBhDQo+IHNpbWlsYXIgd2F5IHRvIGh0dHBzOi8vbWFyYy5pbmZvLz9sPWt2bSZt
PTE1Mjk5ODY2MTcxMzU0NyZ3PTIuDQo+IA0KPiBQbGVhc2UgY29vcmRpbmF0ZSB3aXRoIFJvYmVy
dCBIdSBvbiB0aGUgUUVNVSBwYXRjaGVzIHRvbywgYmVjYXVzZSBoZSdzDQo+IHdvcmtpbmcgb24g
dGhlIGluZnJhc3RydWN0dXJlIHRvIHVzZSBLVk1fR0VUX01TUl9GRUFUVVJFX0lOREVYX0xJU1Qg
aW4NCj4gUUVNVS4NCj4gDQpIaSBQYW9sbywNClRoYW5rcyAgZm9yIHlvdXIgcmV2aWV3LCBoYWQg
c3luY2VkIHdpdGggUm9iZXJ0Lg0KTmVlZCB0byB3b3JrIG91dCBhIHdheSwgbm90IGltcGFjdCBv
biB0aGUgb2xkIGluZnJhc3RydWN0dXJlLg0KDQpUaGFua3MNCkppbmdxaQ0KDQo+IFRoYW5rcywN
Cj4gDQo+IFBhb2xvDQo=
