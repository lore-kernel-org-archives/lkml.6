Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62CFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900D5217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfAWOkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:40:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:14160 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfAWOkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="110421432"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 23 Jan 2019 06:40:51 -0800
Received: from [10.254.80.13] (kliang2-mobl1.ccr.corp.intel.com [10.254.80.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 16747580436;
        Wed, 23 Jan 2019 06:40:49 -0800 (PST)
Subject: Re: [PATCH 10/12] perf script: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org
References: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
 <1548090318-19149-10-git-send-email-kan.liang@linux.intel.com>
 <20190122171144.GU6118@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f62f2b34-09a8-c107-b3d0-59e50b4753d3@linux.intel.com>
Date:   Wed, 23 Jan 2019 09:40:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122171144.GU6118@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2019 12:11 PM, Andi Kleen wrote:
>> +	PERF_OUTPUT_CODE_PAGE_SIZE  = 1UL << 32,
> 
> That won't work on 32bit. You need 1ULL
> 
> Also might want to audit that noone puts these flags into
> an int.
> 

I checked the codes, and there is no one puts the flags into an int.

I will use ULL in V2.

Thanks,
Kan

