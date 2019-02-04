Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F3C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB432175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfBDUiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:38:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:41613 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBDUiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:38:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:38:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="144143968"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2019 12:38:00 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9A2FE58044E;
        Mon,  4 Feb 2019 12:37:59 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
 <2c429bbd-00fb-2e3a-7d58-27123400b722@linux.intel.com>
 <20190204181504.GH29639@zn.tnic>
 <134894ac-a43b-7ec7-f313-b5d8de357a7e@linux.intel.com>
 <20190204194306.GI29639@zn.tnic>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <12e3f6d3-0186-a540-7feb-778f4d78c8cf@linux.intel.com>
Date:   Mon, 4 Feb 2019 15:37:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204194306.GI29639@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 2:43 PM, Borislav Petkov wrote:
> On Mon, Feb 04, 2019 at 01:57:49PM -0500, Liang, Kan wrote:
>> You mean a given microcode revision X applying to multiple stepping,
>> right?
> 
> Yes, the range thing. You specify a range of steppings:
> 
> kabylake mobile  with steppings 9-12
> kabylake desktop with steppings 10-13
> 
>> I don't think so. I still think the KABYLAKE case is an uncommon case.
> 
> You mean it is uncommon because there are already *two* models which
> need it or because this is only kabylake and it won't happen in the
> future?

The latter.
As you can see in the patch series, for other platforms (from core to 
atom), the microcode revision is always different on different stepping 
of the same model.
I believe the kabylake thing is one off.

> 
>> Can we do something as below just for this case?
> 
> Of course not. _FOUR is just silly and if a *fifth* stepping appears,
> you need to go fixup again.
> 
> If anything and if this kabylake thing is one off, I'd prefer we keep it
> as is.
> 

OK. I will keep it as is on V7.

Thanks,
Kan
