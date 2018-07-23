Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA37820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA37820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbeGWW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:56:06 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:51183 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388158AbeGWW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:56:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T5BsF0c_1532382764;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T5BsF0c_1532382764)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Jul 2018 05:52:47 +0800
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
To:     David Rientjes <rientjes@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, hughd@google.com,
        aaron.lu@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720210626.5bnyddmn4avp2l3x@kshutemo-mobl1>
 <3118b646-681e-a2aa-dc7b-71d4821fa50f@linux.alibaba.com>
 <alpine.DEB.2.21.1807231329080.105582@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <91caed46-6437-a137-0dbc-dadd113f8d58@linux.alibaba.com>
Date:   Mon, 23 Jul 2018 14:52:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807231329080.105582@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/18 1:31 PM, David Rientjes wrote:
> On Fri, 20 Jul 2018, Yang Shi wrote:
>
>> I agree to keep it for a while to let that security bug cool down, however, if
>> there is no user anymore, it sounds pointless to still keep a dead knob.
>>
> It's not a dead knob.  We use it, and for reasons other than
> CVE-2017-1000405.  To mitigate the cost of constantly compacting memory to
> allocate it after it has been freed due to memry pressure, we can either
> continue to disable it, allow it to be persistently available, or use a
> new value for use_zero_page to specify it should be persistently
> available.

My understanding is the cost of memory compaction is *not* unique for 
huge zero page, right? It is expected when memory pressure is met, even 
though huge zero page is disabled.

