Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24422146F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24422146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbeKPKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:32:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:5035 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeKPKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:32:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 16:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; 
   d="scan'208";a="91546085"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2018 16:21:56 -0800
Subject: Re: [PATCH v3 1/2] x86/fpu: track AVX-512 usage of tasks
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <6f8a7b97-d889-ce77-b5ad-d03dbf4986b0@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <88a5d6df-0005-db3e-f3be-83e2a8b63a27@linux.intel.com>
Date:   Fri, 16 Nov 2018 08:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <6f8a7b97-d889-ce77-b5ad-d03dbf4986b0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/15 23:40, Dave Hansen wrote:
> On 11/14/18 3:00 PM, Aubrey Li wrote:
>> AVX-512 component has 3 states, only Hi16_ZMM state causes notable
>> frequency drop. Add per task Hi16_ZMM state tracking to context switch.
> 
> Just curious, but is there any public documentation of this?  It seems
> really odd to me that something using the same AVX-512 instructions on
> some low-numbered registers would behave differently than the same
> instructions on some high-numbered registers.  I'm not saying this is
> wrong, but it's certainly counter-intuitive and I think that begs for
> some more explanation.

Yes, Intel 64 and IA-32 Architectures software developer's Manual mentioned
this in performance event CORE_POWER.LVL2_TURBO_LICENSE.

"Core cycles where the core was running with power delivery for license
level 2 (introduced in Skylake Server microarchitecture). This includes
high current AVX 512-bit instructions."

I translated license level 2 to frequency drop.

Thanks,
-Aubrey
