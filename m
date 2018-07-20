Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B672084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B672084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeGUAmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:42:22 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39770 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbeGUAmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:42:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T50TJur_1532130692;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T50TJur_1532130692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Jul 2018 07:51:34 +0800
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     hughd@google.com, rientjes@google.com, aaron.lu@intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720210626.5bnyddmn4avp2l3x@kshutemo-mobl1>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3118b646-681e-a2aa-dc7b-71d4821fa50f@linux.alibaba.com>
Date:   Fri, 20 Jul 2018 16:51:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180720210626.5bnyddmn4avp2l3x@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/18 2:06 PM, Kirill A. Shutemov wrote:
> On Sat, Jul 21, 2018 at 02:13:50AM +0800, Yang Shi wrote:
>> By digging into the original review, it looks use_zero_page sysfs knob
>> was added to help ease-of-testing and give user a way to mitigate
>> refcounting overhead.
>>
>> It has been a few years since the knob was added at the first place, I
>> think we are confident that it is stable enough. And, since commit
>> 6fcb52a56ff60 ("thp: reduce usage of huge zero page's atomic counter"),
>> it looks refcounting overhead has been reduced significantly.
>>
>> Other than the above, the value of the knob is always 1 (enabled by
>> default), I'm supposed very few people turn it off by default.
>>
>> So, it sounds not worth to still keep this knob around.
> I don't think that having the knob around is huge maintenance burden.
> And since it helped to workaround a security bug relative recently I would
> rather keep it.

I agree to keep it for a while to let that security bug cool down, 
however, if there is no user anymore, it sounds pointless to still keep 
a dead knob.

>

