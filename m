Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6850C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6850C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeK1Mpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:45:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:47345 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeK1Mpz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:45:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 17:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="112725420"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.209.207]) ([10.254.209.207])
  by fmsmga004.fm.intel.com with ESMTP; 27 Nov 2018 17:46:02 -0800
Subject: Re: [PATCH v2 3/3] perf report: Display average IPC and IPC coverage
 per symbol
To:     Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <1543320588-14863-1-git-send-email-yao.jin@linux.intel.com>
 <1543320588-14863-4-git-send-email-yao.jin@linux.intel.com>
 <20181127183302.GW13936@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e44fd7a5-07f0-5760-d1cc-a689d8d06cfa@linux.intel.com>
Date:   Wed, 28 Nov 2018 09:45:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181127183302.GW13936@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2018 2:33 AM, Andi Kleen wrote:
> On Tue, Nov 27, 2018 at 08:09:48PM +0800, Jin Yao wrote:
>> Support displaying the average IPC and IPC coverage for symbol
>> in perf report TUI browser. We create a new sort-key 'ipc' for
>> that.
> 
> Another thing that would be nice would be to automatically enable
> these columns perf report when -b was enabled in the perf.data.
> We can't check for timed LBR being supported without
> looking into samples, but at least can check for -b.
> 
> Otherwise a lot of people won't realize it's supported.
> 
> It would show always 0.0 when timed LBR is not supported,
> but that might be ok. Perhaps make both columns empty
> in this case instead of 0.0.
> 
> 
> -Andi
> 

Hi Andi,

Yes, I agree, people will not realize a new option 'ipc' is created.

So I will enable 2 columns ("IPC" and "IPC columns") even when timed LBR 
is not supported. Just show empty or '-' in these columns.

Thanks
Jin Yao

