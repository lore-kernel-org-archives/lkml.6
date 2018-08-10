Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98CFC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613F922450
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613F922450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeHJU5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:57:39 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40026 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbeHJU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:57:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0T6QQEsX_1533925575;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6QQEsX_1533925575)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Aug 2018 02:26:19 +0800
Subject: Re: [RFC v7 PATCH 2/4] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
 <1533857763-43527-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180810175759.GB6487@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <0594c845-68c8-e15f-6ec6-91641c5fbdd1@linux.alibaba.com>
Date:   Fri, 10 Aug 2018 11:26:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180810175759.GB6487@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/18 10:57 AM, Matthew Wilcox wrote:
> On Fri, Aug 10, 2018 at 07:36:01AM +0800, Yang Shi wrote:
>> +/*
>> + * Zap pages with read mmap_sem held
>> + *
>> + * uf is the list for userfaultfd
>> + */
>> +static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
>> +			       size_t len, struct list_head *uf)
> I don't like the name here.  We aren't zapping rlocks, we're zapping
> pages.  Not sure what to call it though ...

It may look ambiguous, it means "zap with rlock", but I don't think 
anyone would expect we are zapping locks.

Thanks,
Yang


