Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF4EECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D7220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D7220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeGTV1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:27:51 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44611 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbeGTV1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:27:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T50UJDr_1532119068;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T50UJDr_1532119068)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Jul 2018 04:37:50 +0800
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
To:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kirill@shutemov.name, hughd@google.com, aaron.lu@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
 <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
Date:   Fri, 20 Jul 2018 13:37:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/18 1:02 PM, David Rientjes wrote:
> On Fri, 20 Jul 2018, Andrew Morton wrote:
>
>>> By digging into the original review, it looks use_zero_page sysfs knob
>>> was added to help ease-of-testing and give user a way to mitigate
>>> refcounting overhead.
>>>
>>> It has been a few years since the knob was added at the first place, I
>>> think we are confident that it is stable enough. And, since commit
>>> 6fcb52a56ff60 ("thp: reduce usage of huge zero page's atomic counter"),
>>> it looks refcounting overhead has been reduced significantly.
>>>
>>> Other than the above, the value of the knob is always 1 (enabled by
>>> default), I'm supposed very few people turn it off by default.
>>>
>>> So, it sounds not worth to still keep this knob around.
>> Probably OK.  Might not be OK, nobody knows.
>>
>> It's been there for seven years so another six months won't kill us.
>> How about as an intermediate step we add a printk("use_zero_page is
>> scheduled for removal.  Please contact linux-mm@kvack.org if you need
>> it").
>>
> We disable the huge zero page through this interface, there were issues
> related to the huge zero page shrinker (probably best to never free a
> per-node huge zero page after allocated) and CVE-2017-1000405 for huge
> dirty COW.

Thanks for the information. It looks the CVE has been resolved by commit 
a8f97366452ed491d13cf1e44241bc0b5740b1f0 ("mm, thp: Do not make page 
table dirty unconditionally in touch_p[mu]d()"), which is in 4.15 already.

What was the shrinker related issue? I'm supposed it has been resolved, 
right?


