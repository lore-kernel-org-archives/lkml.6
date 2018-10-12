Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D588C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2647F20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2647F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJLKeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:34:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:35856 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeJLKeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:34:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 20:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="80820315"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 20:04:05 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 20:04:04 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 20:04:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.48]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 11:04:03 +0800
From:   "Zhang, Ning A" <ning.a.zhang@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: question about V4L2_MEMORY_USERPTR on 64bit applications
Thread-Topic: question about V4L2_MEMORY_USERPTR on 64bit applications
Thread-Index: AQHUYdg6M/rTSYlERUCXZPSjuhezLQ==
Date:   Fri, 12 Oct 2018 03:04:01 +0000
Message-ID: <1539313441.21249.3.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.115]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D845363F52D0254183211ECF6AE2A429@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkgaGF2ZSBxdWVzdGlvbiBhYm91dCBWNEwyX01FTU9SWV9VU0VSUFRSIG9uIDY0Yml0
IGFwcGxpY2F0aW9ucy4NCg0Kc3RydWN0IHY0bDJfYnVmZmVyIHsNCglfX3UzMgkJCWluZGV4Ow0K
CV9fdTMyCQkJdHlwZTsNCglfX3UzMgkJCWJ5dGVzdXNlZDsNCglfX3UzMgkJCWZsYWdzOw0KCV9f
dTMyCQkJZmllbGQ7DQoJc3RydWN0IHRpbWV2YWwJCXRpbWVzdGFtcDsNCglzdHJ1Y3QgdjRsMl90
aW1lY29kZQl0aW1lY29kZTsNCglfX3UzMgkJCXNlcXVlbmNlOw0KDQoJLyogbWVtb3J5IGxvY2F0
aW9uICovDQoJX191MzIJCQltZW1vcnk7DQoJdW5pb24gew0KCQlfX3UzMsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBvZmZzZXQ7DQoJCXVuc2lnbmVkIGxvbmfCoMKgwqB1c2VycHRyOyAgIDw8PC0tLSB0
aGlzIGlzIGEgMzJiaXQgYWRkci4NCgkJc3RydWN0IHY0bDJfcGxhbmUgKnBsYW5lczsNCgkJX19z
MzIJCWZkOw0KCX0gbTsNCglfX3UzMgkJCWxlbmd0aDsNCglfX3UzMgkJCXJlc2VydmVkMjsNCglf
X3UzMgkJCXJlc2VydmVkOw0KfTsNCg0Kd2hlbiB1c2UgYSA2NGJpdCBhcHBsaWNhdGlvbiwgbWVt
b3J5IGZyb20gbWFsbG9jIGlzIDY0Yml0IGFkZHJlc3MuDQptZW1vcnkgZnJvbSBHUFUgKGVnLCBp
bnRlbCBpOTE1KSBhcmUgYWxzbyA2NGJpdCBhZGRyZXNzLg0KDQp3aGVuIHVzZSB0aGVzZSBraW5k
IG9mIG1lbW9yeSBhc8KgVjRMMl9NRU1PUllfVVNFUlBUUiwgYWRkcmVzcyB3aWxsIGJlDQp0cnVu
Y2F0ZWQgaW50byAzMmJpdC4NCg0KdGhpcyB3b3VsZCBiZSBlcnJvciwgYnV0IGFjdHVhbGx5IG5v
dC4gSSByZWFsbHkgZG9uJ3QgdW5kZXJzdGFuZC4NCg0KQlIuDQpOaW5nLg==
