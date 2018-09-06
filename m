Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907F0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0402075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0402075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeIGBOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:14:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:28857 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeIGBOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:14:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 13:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="89607092"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.122]) ([10.24.14.122])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 13:37:14 -0700
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
 <20180906141524.GF24106@hirez.programming.kicks-ass.net>
 <40894b6f-c421-32fb-39c3-3dddbed5aa91@intel.com>
 <20180906194441.GA9358@worktop.programming.kicks-ass.net>
 <2465aa4d-fa84-cb0c-082a-15240472b349@intel.com>
 <20180906202943.GE9358@worktop.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <12da3ce5-710b-b18e-8c0c-a0aa3724afd2@intel.com>
Date:   Thu, 6 Sep 2018 13:37:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180906202943.GE9358@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2018 1:29 PM, Peter Zijlstra wrote:
> On Thu, Sep 06, 2018 at 01:05:05PM -0700, Reinette Chatre wrote:
>> When I separate the above into the two functions it just becomes either:
>>                    rdpmcl(l2_hit_pmcnum, l2_hits_after);
>>                    rdpmcl(l2_miss_pmcnum, l2_miss_after);
>> or:
>>                    rdpmcl(l3_hit_pmcnum, l3_hits_after);
>>                    rdpmcl(l3_miss_pmcnum, l3_miss_after);
>>
> 
> Right, which is the exact _same_ code, so you only need a single
> function.
> 

From my understanding it is not this code specifically that is causing
the cache misses but instead the code and variables used to decide
whether to run them or not. These would still be needed when I extract
the above into inline functions.

Reinette
