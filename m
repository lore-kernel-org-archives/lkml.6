Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9428C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11DE21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11DE21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbeITShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:37:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:21086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbeITShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:37:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74826652"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 05:53:26 -0700
Message-ID: <5BA39968.8030309@intel.com>
Date:   Thu, 20 Sep 2018 20:58:16 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 5/5] KVM/x86/lbr: lazy save the guest lbr stack
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com> <1537437959-8751-6-git-send-email-wei.w.wang@intel.com> <20180920123753.GT24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180920123753.GT24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 08:37 PM, Peter Zijlstra wrote:
> On Thu, Sep 20, 2018 at 06:05:59PM +0800, Wei Wang wrote:
>>   /**
>> + * lbr_select_user_callstack - check if the user callstack mode is set
>> + *
>> + * @lbr_select: the lbr select msr
>> + *
>> + * Returns: true if the msr is configured to the user callstack mode.
>> + * Otherwise, false.
>> + *
>> + */
>> +bool lbr_select_user_callstack(u64 lbr_select)
>> +{
>> +	return !!(lbr_select & LBR_USER_CALLSTACK);
>> +}
>> +EXPORT_SYMBOL_GPL(lbr_select_user_callstack);
> That function is pure and tiny, wth is that an exported symbol and not
> an inline?
Thanks Peter for the comments.

Because this function uses the LBR_ macros which are defined in this 
lbr.c file.
Do you think it would be OK to move all the above LBR_ macros to 
asm/perf_event.h?

Best,
Wei
