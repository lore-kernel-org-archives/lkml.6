Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF8CC6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025282524E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025282524E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967026AbeF2Qd7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:33:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:10183 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967002AbeF2Qd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:33:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 09:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="241400989"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2018 09:33:55 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.236]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.167]) with mapi id 14.03.0319.002;
 Fri, 29 Jun 2018 09:33:55 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v2 3/4] x86/split_lock: Handle #AC exception for split
 lock
Thread-Topic: [PATCH v2 3/4] x86/split_lock: Handle #AC exception for split
 lock
Thread-Index: AQHUD7ZVOfJcmIggnkquFQaZQyzL7KR34oGA//+LEfA=
Date:   Fri, 29 Jun 2018 16:33:54 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D348C9A@ORSMSX110.amr.corp.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-4-git-send-email-fenghua.yu@intel.com>
 <f528ef21-0e6f-3c76-5fac-bd88279facc0@intel.com>
In-Reply-To: <f528ef21-0e6f-3c76-5fac-bd88279facc0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzMyZjQ5YzMtYmFkNS00NzRlLTk3MjEtNGM1ZWIzODZiOTE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibFwvWWFYXC81bjh6TFFRQzNnUFBCXC9ORU1ya2gzQWU5cVZQK3hBM1g2OTFPbG91cTVpK0FIdzg4UTNtQ3JobVwvRWMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwlXQVJOX09OQ0UoMSwgIkEgc3BsaXQgbG9jayBpc3N1ZSBpcyBkZXRlY3RlZC4gUGxlYXNl
IEZJWCBpdFxuIik7DQo+DQo+IEJ1dCwgd2FybmluZyBoZXJlIGlzIGFsc28gbm90IHN1cGVyIHVz
ZWZ1bC4gIFNob3VsZG4ndCB3ZSBiZSBkdW1waW5nIG91dA0KPiB0aGUgaW5mbyBpbiAncmVncycg
aW5zdGVhZCBvZiB0aGUgY3VycmVudCBjb250ZXh0PyAgV2UgZG9uJ3QgY2FyZSBhYm91dA0KPiB0
aGUgc3RhdGUgaW4gdGhlICNBQyBoYW5kbGVyLCB3ZSBjYXJlIGFib3V0ICdyZWdzJy4NCg0KTWF5
YmU6DQoNCglXQVJOX09OQ0UoMSwgInNwbGl0IGxvY2sgZGV0ZWN0ZWQgYXQgJXBGXG4iLCByZWdz
W0VJUF0pOw0KDQotVG9ueQ0K
