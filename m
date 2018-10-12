Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22927C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE8320645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJLMDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:03:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:21726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeJLMDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:03:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 21:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="98537394"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2018 21:33:06 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 21:33:06 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 21:33:05 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.48]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 12:33:03 +0800
From:   "Zhang, Ning A" <ning.a.zhang@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: question about V4L2_MEMORY_USERPTR on 64bit applications
Thread-Topic: question about V4L2_MEMORY_USERPTR on 64bit applications
Thread-Index: AQHUYdg6M/rTSYlERUCXZPSjuhezLaUaf4UA
Date:   Fri, 12 Oct 2018 04:33:03 +0000
Message-ID: <1539318782.21249.7.camel@intel.com>
References: <1539313441.21249.3.camel@intel.com>
In-Reply-To: <1539313441.21249.3.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.115]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FBD4F6272ACF147B26934BDF01033E9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c29ycnkgZm9yIHdyb25nIHF1ZXN0aW9uLCBJIHJlYWxseSBtZWV0IG1lbW9yeSBhZGRyZXNzIHRy
dW5jYXRlZCBpc3N1ZSwNCndoZW4gdXNlIFY0TDIga2VybmVsIEFQSXMuDQoNCmluIGEga2VybmVs
IHRocmVhZCBjcmVhdGVkIGJ5IGtlcm5lbF90aHJlYWQoKQ0KSSB2bV9tbWFwIGEgc2htZW1fZmls
ZSB0byBhZGRyOiAwMDAwN2ZmZmY3ZmE4MDAwDQphbmQgcXVldWUgaXQgdG8gVjRMMiwgYWZ0ZXIg
ZGVxdWV1ZSBpdCwgYW5kIEkgZmluZCB0aGUgYWRkcmVzcyBpcw0KdHJ1bmNhdGVkIHRvIDAwMDAw
MDAwZjdmYTgwMDANCg0KSSB1c2UgX191NjQge2FrYSBsb25nIGxvbmcgdW5zaWduZWQgaW50fSB0
byBzYXZlIGFkZHJlc3MsIGFuZCBJIGZpbmQNCnVzZXJwdHIgaXMgdW5zaWduZWQgbG9uZywgd3Jv
bmdseSB0aGluayBpdCBhcyAiZGF0YSB0cnVuY2F0ZWQiDQphbmQgYSBsb3Qgb2YgX191MzIgaW4g
dGhpcyBzdHJ1Y3R1cmUuDQoNCmV2ZXJ5dGhpbmcgd29ya3MgZmluZSwgYnV0IEkgc3RpbGwgZG9u
J3QgdW5kZXJzdGFuZCB3aHkgaGlnaCAzMmJpdCBiZQ0KMC4uDQoNCkJSLg0KTmluZy4NCg0KDQrl
nKggMjAxOC0xMC0xMuS6lOeahCAxMTowNCArMDgwMO+8jFpoYW5nIE5pbmflhpnpgZPvvJoNCj4g
SGksDQo+IA0KPiBJIGhhdmUgcXVlc3Rpb24gYWJvdXQgVjRMMl9NRU1PUllfVVNFUlBUUiBvbiA2
NGJpdCBhcHBsaWNhdGlvbnMuDQo+IA0KPiBzdHJ1Y3QgdjRsMl9idWZmZXIgew0KPiAJX191MzIJ
CQlpbmRleDsNCj4gCV9fdTMyCQkJdHlwZTsNCj4gCV9fdTMyCQkJYnl0ZXN1c2VkOw0KPiAJX191
MzIJCQlmbGFnczsNCj4gCV9fdTMyCQkJZmllbGQ7DQo+IAlzdHJ1Y3QgdGltZXZhbAkJdGltZXN0
YW1wOw0KPiAJc3RydWN0IHY0bDJfdGltZWNvZGUJdGltZWNvZGU7DQo+IAlfX3UzMgkJCXNlcXVl
bmNlOw0KPiANCj4gCS8qIG1lbW9yeSBsb2NhdGlvbiAqLw0KPiAJX191MzIJCQltZW1vcnk7DQo+
IAl1bmlvbiB7DQo+IAkJX191MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb2Zmc2V0Ow0KPiAJCXVu
c2lnbmVkIGxvbmfCoMKgwqB1c2VycHRyOyAgIDw8PC0tLSB0aGlzIGlzIGEgMzJiaXQgYWRkci4N
Cj4gCQlzdHJ1Y3QgdjRsMl9wbGFuZSAqcGxhbmVzOw0KPiAJCV9fczMyCQlmZDsNCj4gCX0gbTsN
Cj4gCV9fdTMyCQkJbGVuZ3RoOw0KPiAJX191MzIJCQlyZXNlcnZlZDI7DQo+IAlfX3UzMgkJCXJl
c2VydmVkOw0KPiB9Ow0KPiANCj4gd2hlbiB1c2UgYSA2NGJpdCBhcHBsaWNhdGlvbiwgbWVtb3J5
IGZyb20gbWFsbG9jIGlzIDY0Yml0IGFkZHJlc3MuDQo+IG1lbW9yeSBmcm9tIEdQVSAoZWcsIGlu
dGVsIGk5MTUpIGFyZSBhbHNvIDY0Yml0IGFkZHJlc3MuDQo+IA0KPiB3aGVuIHVzZSB0aGVzZSBr
aW5kIG9mIG1lbW9yeSBhc8KgVjRMMl9NRU1PUllfVVNFUlBUUiwgYWRkcmVzcyB3aWxsIGJlDQo+
IHRydW5jYXRlZCBpbnRvIDMyYml0Lg0KPiANCj4gdGhpcyB3b3VsZCBiZSBlcnJvciwgYnV0IGFj
dHVhbGx5IG5vdC4gSSByZWFsbHkgZG9uJ3QgdW5kZXJzdGFuZC4NCj4gDQo+IEJSLg0KPiBOaW5n
Lg==
