Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A44E2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A44E2241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeKMAOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:14:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:21203 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbeKMAOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:14:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 06:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="85216844"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.254.49.202]) ([10.254.49.202])
  by fmsmga007.fm.intel.com with ESMTP; 12 Nov 2018 06:21:18 -0800
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
 <20181108063246.GA13233@gmail.com>
 <20181108101729.GP9761@hirez.programming.kicks-ass.net>
 <20181112053147.GA78520@gmail.com> <20181112085650.GM3056@worktop>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <d8a68174-70b0-8c6c-3293-b4ebb717d39e@linux.intel.com>
Date:   Mon, 12 Nov 2018 06:21:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181112085650.GM3056@worktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I'd prefer the kernel to do such clustering...
> 
> I think that is a next step.
> 
> Also, while the kernel can do this at a best effort basis, it cannot
> take into account things the kernel doesn't know about, like high
> priority job peak load etc.., things a job scheduler would know.
> 
> Then again, a job scheduler would likely already know about the AVX
> state anyway.

the job scheduler can guess.
unless it can also *measure* it won't know for sure...

so even in that scenario having a decent way to report actuals is useful


> 

