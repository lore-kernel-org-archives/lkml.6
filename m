Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE393C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30D020856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfAQSE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:04:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:56884 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfAQSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:04:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 10:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="136647956"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2019 10:04:56 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 17 Jan 2019 10:04:55 -0800
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 17 Jan 2019 10:04:55 -0800
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.15]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.39]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 12:04:53 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/13] x86/fsgsbase/64: Add intrinsics/macros for
 FSGSBASE instructions
Thread-Topic: [PATCH v4 04/13] x86/fsgsbase/64: Add intrinsics/macros for
 FSGSBASE instructions
Thread-Index: AQHUre217UI/BdFLXUeK3bbdpSYohKWzTlQAgADYrwA=
Date:   Thu, 17 Jan 2019 18:04:52 +0000
Message-ID: <0E0B43A0-76AC-440B-A592-F4940C1028CF@intel.com>
References: <20190116224849.8617-1-chang.seok.bae@intel.com>
 <20190116224849.8617-5-chang.seok.bae@intel.com>
 <20190117050920.GJ6118@tassilo.jf.intel.com>
In-Reply-To: <20190117050920.GJ6118@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.157.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DA721196DCF344FA73A3B2C03BB2451@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEphbiAxNiwgMjAxOSwgYXQgMjE6MDksIEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVs
LmNvbT4gd3JvdGU6DQo+IA0KPj4gKyNpZmRlZiBDT05GSUdfWDg2XzY0DQo+PiArDQo+PiArI2lu
Y2x1ZGUgPGFzbS9pbnN0Lmg+DQo+PiArDQo+PiArLm1hY3JvIFJER1NCQVNFIG9wZA0KPiANCj4g
VGhlIGNhbGxlciBjYW4gbm93IHVzZSB0aGUgYXNzZW1ibGVyIGluc3RydWN0aW9ucyBkaXJlY3Rs
eSwgc28gdGhlIG1hY3Jvcw0KPiBhcmUgbm90IG5lZWRlZCBhbnltb3JlLg0KPiANCj4gLUFuZGkN
Cg0KWWVhaCwgeW914oCZcmUgcmlnaHQsIHNpbmNlIEdBUyBpcyBpbmNsdWRlZCBpbiB0aGUgYmlu
dXRpbHMuDQoNClRoYW5rcw==
