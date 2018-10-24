Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084FAECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9251207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9251207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeJYBGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:06:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:14953 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeJYBGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:06:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 09:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="81274491"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga008.fm.intel.com with ESMTP; 24 Oct 2018 09:37:44 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 09:37:43 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.164]) with mapi id 14.03.0319.002;
 Wed, 24 Oct 2018 09:37:43 -0700
From:   "Li, Juston" <juston.li@intel.com>
To:     "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ciobanu, Nathan D" <nathan.d.ciobanu@intel.com>,
        "jared_dominguez@dell.com" <jared_dominguez@dell.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>
Subject: Re: [Intel-gfx] [RESEND PATCH v2 0/2] Check MST topology change on
 resume
Thread-Topic: [Intel-gfx] [RESEND PATCH v2 0/2] Check MST topology change on
 resume
Thread-Index: AQHUa0BopJxy2RsRZ0GPWoWsCNOADqUujiAAgACAegA=
Date:   Wed, 24 Oct 2018 16:37:42 +0000
Message-ID: <bdc963d6604f1ae7ff7c103c8d16b25db749a3e3.camel@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
         <20181024085750.GK324@phenom.ffwll.local>
In-Reply-To: <20181024085750.GK324@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.198.167]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BA955D5317D3D42B0515A6670218B57@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTI0IGF0IDEwOjU3ICswMjAwLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0K
PiBPbiBUdWUsIE9jdCAyMywgMjAxOCBhdCAwNzoxOToyM1BNIC0wNzAwLCBKdXN0b24gTGkgd3Jv
dGU6DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSnVzdG9uIExpIDxqdXN0b24ubGlAaW50ZWwu
Y29tPg0KPiANCj4gRm9yIGZvcm1hbGl0eSwgZG9lcyB0aGlzIGFsc28gaW1wbHkgYSByZXZpZXdl
ZC1ieSB0YWc/DQoNCkknbSBxdWl0ZSBuZXcgdG8gZHJtIHNvIEknbGwgd2l0aGhvbGQgYSByZXZp
ZXdlZC1ieSB0YWcgYW5kIGFzayB0aGF0DQpzb21lb25lIGVsc2UgdGFrZSBhIGxvb2sgYXQgaXQg
dG9vLg0KDQpMeXVkZSwgdGhlIG9yaWdpbmFsIGF1dGhvciwgbWVudGlvbmVkIGhlIHNob3VsZCBw
cm9iYWJseSB0YWtlIGEgbG9vaw0KYWdhaW4gYWxzbyBzaW5jZSB0aGUgcGF0Y2hzZXQgaXMgYSBi
aXQgb2xkLg0KDQo+IEZvciBtZXJnaW5nIHByb3BhYmx5IGJlc3Qgd2Ugd2FpdCBmb3IgdGhlIGJh
Y2ttZXJnZSBhbmQgdGhlIHB1c2gNCj4gdGhlc2UgaW4NCj4gdGhyb3VnaCBkcm0tbWlzYy1uZXh0
LWZpeGVzLg0KPiANCj4gV2VsbCBmb3IgZHJtLW1pc2MtbmV4dC1maXhlcyBkcm0tbWlzYyBtYWlu
dGFpbmVycyBuZWVkIHRvIHJvbGwgdGhlDQo+IHRyZWUNCj4gZm9yd2FyZC4gRWl0aGVyIHdheSBu
ZWVkcyBzeW5jaHJvbml6YXRpb24uIFBsdXMgYW4gYWNrIGZyb20gZHJtLWludGVsDQo+IG1haW50
YWluZXJzLg0KPiAtRGFuaWVsDQo+IA0KDQpXaWxsIGRvDQoNClRoYW5rcw0KSnVzdG9uDQo=
