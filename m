Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278C821473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278C821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeHHSRi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:17:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:40273 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbeHHSRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:17:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 08:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="252391022"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2018 08:57:19 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 8 Aug 2018 08:57:11 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.41]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.230]) with mapi id 14.03.0319.002;
 Wed, 8 Aug 2018 08:55:54 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
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
Thread-Index: AQHUKQYf135FXo9d20Wb8GEtiswxTKSs3vqAgAA8AwCAAAEtgIAABziAgAAO4ICAAAtVgIAAGt0AgAADZYCAAAHtAIAACIUAgADscACAAErwgIAAAgWAgAA1mYCABMuQAIAAJ4+AgAAPS4CAAK/FgIAA3QCA//+2VXCAAL5QAIAAIImAgAAT5tA=
Date:   Wed, 8 Aug 2018 15:55:54 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D3A1B83@ORSMSX110.amr.corp.intel.com>
References: <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
 <413c3b6f-770d-9549-4249-c2407267b63c@intel.com>
 <20180808074111.GM2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180808074111.GM2494@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDNjM2IzYjYtNTllZi00NWQ2LWE2NzEtMjExZWM1NmZjMGM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQlZPT0hNMGVmcWIrckxGb3ZXdHVUNUVZTjhHZTVZOFNXSm5JWXU2WUFRaXhuc3dGVVRBdTNmVjE1Nyt5eTNXVCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So _why_ doesn't this work? As said by Tony, that first call should
> prime the caches, so the second and third calls should not generate any
> misses.

How much code/data is involved? If there is a lot, then you may be unlucky
with cache coloring and the later parts of the "prime the caches" code path
may evict some lines loaded in the early parts.

-Tony
