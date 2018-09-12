Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC5020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC5020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeILKGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:06:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:47891 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeILKGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:06:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 22:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="scan'208";a="88000851"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2018 22:03:48 -0700
Subject: Re: [LKP] 0a3856392c [ 10.513760] INFO: trying to register non-static
 key.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20180907010539.GB6655@shao2-debian>
 <20180907021937.GA7440@bombadil.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <283720fb-e9ec-2f2b-660a-ef97d233914f@intel.com>
Date:   Wed, 12 Sep 2018 13:04:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180907021937.GA7440@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2018 10:19 AM, Matthew Wilcox wrote:
> On Fri, Sep 07, 2018 at 09:05:39AM +0800, kernel test robot wrote:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit 0a3856392cff1542170b5bc37211c9a21fd0c3f6
>> Author:     Matthew Wilcox <willy@infradead.org>
>> AuthorDate: Mon Jun 18 17:23:37 2018 -0400
>> Commit:     Matthew Wilcox <willy@infradead.org>
>> CommitDate: Tue Aug 21 23:54:20 2018 -0400
>>
>>      test_ida: Move ida_check_leaf
>>      
>>      Convert to new API and move to kernel space.  Take the opportunity to
>>      test the situation a little more thoroughly (ie at different offsets).
>>      
>>      Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Thank you test-bot.  Can you check if this patch fixes the problem?
Thanks, It works.

Best Regards,
Rong Chen

>
> diff --git a/lib/test_ida.c b/lib/test_ida.c
> index 2d1637d8136b..b06880625961 100644
> --- a/lib/test_ida.c
> +++ b/lib/test_ida.c
> @@ -150,10 +150,10 @@ static void ida_check_conv(struct ida *ida)
>   	IDA_BUG_ON(ida, !ida_is_empty(ida));
>   }
>   
> +static DEFINE_IDA(ida);
> +
>   static int ida_checks(void)
>   {
> -	DEFINE_IDA(ida);
> -
>   	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
>   	ida_check_alloc(&ida);
>   	ida_check_destroy(&ida);
>

