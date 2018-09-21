Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D70ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542B21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B542B21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390856AbeIUWjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:39:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:45512 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390619AbeIUWjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:39:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 09:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="259212511"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.50]) ([10.24.14.50])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2018 09:49:52 -0700
Subject: Re: [PATCH V5 0/6] perf and x86/intel_rdt: Fix lack of coordination
 with perf
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1537377064.git.reinette.chatre@intel.com>
 <20180920141150.GY24124@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <77383a1e-f343-7529-24cf-874f0999507d@intel.com>
Date:   Fri, 21 Sep 2018 09:49:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920141150.GY24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

On 9/20/2018 7:11 AM, Peter Zijlstra wrote:
> On Wed, Sep 19, 2018 at 10:29:05AM -0700, Reinette Chatre wrote:
>> Reinette Chatre (6):
>>   perf/core: Add sanity check to deal with pinned event failure
>>   perf/x86: Add helper to obtain performance counter index
>>   x86/intel_rdt: Remove local register variables
>>   x86/intel_rdt: Create required perf event attributes
>>   x86/intel_rdt: Use perf infrastructure for measurements
>>   x86/intel_rdt: Re-enable pseudo-lock measurements
>>
>>  Documentation/x86/intel_rdt_ui.txt          |  22 +-
>>  arch/x86/events/core.c                      |  21 ++
>>  arch/x86/include/asm/perf_event.h           |   1 +
>>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 372 ++++++++++++--------
>>  kernel/events/core.c                        |   6 +
>>  5 files changed, 261 insertions(+), 161 deletions(-)
> 
> Yeah, these look good, thanks!
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 

Could you please consider this series for inclusion into v4.19?

- This series is needed to complete the initial cache pseudo-locking
enabling that is first introduced in v4.19. Without this series users
are able to create pseudo-locked regions but unable to accurately
measure their success.
- This is not adding a new feature of pseudo-locked region measurement
but fixing the existing measurement code that was disabled after found
to be poorly integrated.
- This series consists out of 6 patches. Patches 2 to 6 are either new
code in support of this fix or fixes to code that does not exist in
kernels before v4.19.
- Patch 1 is a fix to existing code. It is small, was suggested by, and
does have support from maintainer. Even so, if it is felt that this is
too risky then patches 2 to 6 could still be merged since it does not
actually depend on patch 1. In retrospect I should have submitted it
separately.

Your consideration would be greatly appreciated.

Thank you

Reinette
