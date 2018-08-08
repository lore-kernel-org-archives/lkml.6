Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C21C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9B521708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9B521708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeHHDps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:45:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:9173 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHHDpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:45:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 18:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="222807933"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2018 18:28:38 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 7 Aug 2018 18:28:38 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.41]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.207]) with mapi id 14.03.0319.002;
 Tue, 7 Aug 2018 18:28:38 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hindman, Gavin" <gavin.hindman@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of
 coordination with perf
Thread-Topic: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of
 coordination with perf
Thread-Index: AQHUKQYf135FXo9d20Wb8GEtiswxTKSs3vqAgAA8AwCAAAEtgIAABziAgAAO4ICAAAtVgIAAGt0AgAADZYCAAAHtAIAACIUAgADscACAAErwgIAAAgWAgAA1mYCABMuQAIAAJ4+AgAAPS4CAAK/FgIAA3QCA//+2VXA=
Date:   Wed, 8 Aug 2018 01:28:37 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
References: <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
In-Reply-To: <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmU1YzQ5YjctYTFlZS00YTI4LTljODktODJkNDdmNWJmMjQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTm5BYkVlR1l0NlpId3Q1OThFUkFQK3hWaWpFa2lnRW5qTXhNZERUcUxEOThHWUtkMDMxSmdock5EVHFtOTNMViJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V291bGQgaXQgaGVscCB0byBjYWxsIHJvdXRpbmVzIHRvIHJlYWQgdGhlICJiZWZvcmUiIHZhbHVl
cyBvZiB0aGUgY291bnRlcg0KdHdpY2UuIFRoZSBmaXJzdCB0aW1lIHRvIHByZWxvYWQgdGhlIGNh
Y2hlIHdpdGggYW55dGhpbmcgbmVlZGVkIHRvIGV4ZWN1dGUNCnRoZSBwZXJmIGNvZGUgcGF0aC4N
Cg0KPj4gSW4gYW4gYXR0ZW1wdCB0byBpbXByb3ZlIHRoZSBhY2N1cmFjeSBvZiB0aGUgYWJvdmUg
SSBtb2RpZmllZCBpdCB0byB0aGUNCj4+IGZvbGxvd2luZzoNCj4+DQo+PiAvKiBjcmVhdGUgdGhl
IHR3byBldmVudHMgYXMgYmVmb3JlIGluICJlbmFibGVkIiBzdGF0ZSAqLw0KPj4gbDJfaGl0X3Bt
Y251bSA9IGwyX2hpdF9ldmVudC0+aHcuZXZlbnRfYmFzZV9yZHBtYzsNCj4+IGwyX21pc3NfcG1j
bnVtID0gbDJfbWlzc19ldmVudC0+aHcuZXZlbnRfYmFzZV9yZHBtYzsNCj4+IGxvY2FsX2lycV9k
aXNhYmxlKCk7DQo+PiAvKiBkaXNhYmxlIGh3IHByZWZldGNoZXJzICovDQo+PiAvKiBpbml0IGxv
Y2FsIHZhcnMgdG8gbG9vcCB0aHJvdWdoIHBzZXVkby1sb2NrZWQgbWVtDQogICAgICAqIG1heSB0
YWtlIHNvbWUgbWlzc2VzIGluIHRoZSBwZXJmIGNvZGUNCiAgICAgICovDQogICAgIGwyX2hpdHNf
YmVmb3JlID0gbmF0aXZlX3JlYWRfcG1jKGwyX2hpdF9wbWNudW0pOw0KICAgICBsMl9taXNzX2Jl
Zm9yZSA9IG5hdGl2ZV9yZWFkX3BtYyhsMl9taXNzX3BtY251bSk7DQogICAgIC8qIFJlYWQgY291
bnRlcnMgYWdhaW4sIGhvcGUgbm8gbmV3IG1pc3NlcyBoZXJlICovDQo+PiBsMl9oaXRzX2JlZm9y
ZSA9IG5hdGl2ZV9yZWFkX3BtYyhsMl9oaXRfcG1jbnVtKTsNCj4+IGwyX21pc3NfYmVmb3JlID0g
bmF0aXZlX3JlYWRfcG1jKGwyX21pc3NfcG1jbnVtKTsNCj4+IC8qIGxvb3AgdGhyb3VnaCBwc2V1
ZG8tbG9ja2VkIG1lbSAqLw0KPj4gbDJfaGl0c19hZnRlciA9IG5hdGl2ZV9yZWFkX3BtYyhsMl9o
aXRfcG1jbnVtKTsNCj4+IGwyX21pc3NfYWZ0ZXIgPSBuYXRpdmVfcmVhZF9wbWMobDJfbWlzc19w
bWNudW0pOw0KPj4gLyogZW5hYmxlIGh3IHByZWZldGNoZXJzICovDQo+PiBsb2NhbF9pcnFfZW5h
YmxlKCk7DQoNCg==
