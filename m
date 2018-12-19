Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14175C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE89721852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeLSA0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:26:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:26170 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeLSA0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:26:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 16:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="119934500"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2018 16:26:30 -0800
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20181218042218.8653-1-aubrey.li@intel.com>
 <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
 <62997df2-0817-b54d-b11e-00a567f1d67c@linux.intel.com>
 <alpine.DEB.2.21.1812181630530.14031@nanos.tec.linutronix.de>
 <b14a9c82-3336-0f13-1a27-fba929e6b4fb@linux.intel.com>
 <20181218213826.GI25620@tassilo.jf.intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <6695cf98-17e8-df5f-4dac-264435e2aea5@linux.intel.com>
Date:   Wed, 19 Dec 2018 08:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20181218213826.GI25620@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/19 5:38, Andi Kleen wrote:
>> I misunderstood, you mean 32bit kernel, not 32bit machine. Theoretically 32bit
>> kernel can use AVX512, but not sure if anyone use it like this. get_jiffies_64()
>> includes jiffies_lock ops so not good in context switch. So I want to use raw
>> jiffies_64 here. jiffies is a good candidate but it has wraparound overflow issue.
>> Other time source are expensive here.
>>
>> Should I limit the code only running on 64bit kernel? 
> 
> Yes making it 64bit only should be fine.
> 


> Other alternative would be to use 32bit jiffies on 32bit. I assume
> wrapping is not that big a problem here.
> 

Thomas, is this acceptable?

Thanks,
-Aubrey
