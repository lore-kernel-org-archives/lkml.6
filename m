Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385CECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A185921550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A185921550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbeIUU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:26:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:56972 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390040AbeIUU05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:26:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:37:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="264611242"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2018 07:37:24 -0700
Received: from [10.254.69.199] (kliang2-mobl1.ccr.corp.intel.com [10.254.69.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0E9BC580224;
        Fri, 21 Sep 2018 07:37:23 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on
 SKX
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, stable@vger.kernel.org
References: <1537538826-55489-1-git-send-email-kan.liang@linux.intel.com>
 <20180921141437.GE24124@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a95a3f49-d051-fed8-420b-94f437bc9609@linux.intel.com>
Date:   Fri, 21 Sep 2018 10:37:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921141437.GE24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2018 10:14 AM, Peter Zijlstra wrote:
> On Fri, Sep 21, 2018 at 07:07:06AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The counters on M3UPI Link 0 and Link 3 don't count. Writing 0 to
>> these counters may causes system crash on some machines.
>>
>> The PCI BDF addresses of M3UPI in current code are incorrect.
>> The correct addresses should be
>> D18:F1 	0x204D
>> D18:F2 	0x204E
>> D18:F5 	0x204D
> 
> Should this have a Fixes: tag?
> 

Yes, sorry for missing it.
Here it is.
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore 
support")

Thanks,
Kan
