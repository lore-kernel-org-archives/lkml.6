Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008362084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeLTBF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:05:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:16767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbeLTBF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:05:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 17:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,374,1539673200"; 
   d="scan'208";a="119716364"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2018 17:05:55 -0800
To:     Yang Shi <yang.shi@linux.alibaba.com>, ying.huang@intel.com,
        tim.c.chen@intel.com, minchan@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1545115948-25467-1-git-send-email-yang.shi@linux.alibaba.com>
 <6a51d47a-b87f-b0f1-4dae-843730dba698@linux.intel.com>
 <03462367-3f75-4907-8c5e-526a919e5cf3@linux.alibaba.com>
 <c0290c77-87ba-32bf-8ed0-d42a322d3d06@linux.intel.com>
 <606b73ed-da62-fdd1-71da-c4de7a02e837@linux.alibaba.com>
 <bc63155c-39b4-02b0-4045-da51022dbff5@linux.intel.com>
 <2df52dc3-ae66-0ab8-459e-49f49eaa569c@linux.alibaba.com>
 <50e14a30-97bb-06c6-ae6a-74e6dc827713@linux.intel.com>
 <385ffd4f-d903-6e2f-e80e-7d3797885c54@linux.alibaba.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 dvVU867d07PlWksfYwCeYP4bs+4GSLzI1w==
Subject: Re: [RFC PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Message-ID: <ed458728-23ad-3cb1-6308-2e9679863e3c@linux.intel.com>
Date:   Wed, 19 Dec 2018 17:05:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <385ffd4f-d903-6e2f-e80e-7d3797885c54@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 3:48 PM, Yang Shi wrote:
> 
> 
> On 12/19/18 11:00 AM, Tim Chen wrote:
>> On 12/19/18 10:40 AM, Yang Shi wrote:
>>>
>>>>>> I don't think your dereference inode = si->swap_file->f_mapping->host
>>>>>> is always safe.  You should do it only when (si->flags & SWP_FS) is true.
>>>>> Do you mean it is not safe for swap partition?
>>>> The f_mapping may not be instantiated.  It is only done for SWP_FS.
>>> Really? I saw the below calls in swapon:
>>>
>>> swap_file = file_open_name(name, O_RDWR|O_LARGEFILE, 0);
>>> ...
>>> p->swap_file = swap_file;
>>> mapping = swap_file->f_mapping;
>>> inode = mapping->host;
>>> ...
>>>
>>> Then the below code manipulates the inode.
>>>
>>> And, trace shows file_open_name() does call blkdev_open if it is turning block device swap on. And, blkdev_open() would return instantiated address_space and inode.
>>>
>>> Am I missing something?
>>>
>> I was trying to limit the congestion logic for block devices backed swap.
>> So the check I had in mind should really be "si->flags & SWP_BLKDEV"
>> instead of si->flags & SWP_FS.  I was concerned that there could
>> be other use cases where the inode dereference is invalid.
>>
>> Looking at the code a bit more, looks like swap_cluster_readahead is not
>> used for other special case swap usage (like page migration).  So
>> you would a proper swapfile and inode here.  But I think it is still
> 
> Yes, just swap page fault and shmem calls this function. Actually, your above concern is valid if the inode were added into swap_address_space (address_space->host). I did this in my first attempt, and found out it may break some assumption in clear_page_dirty_for_io() and migration.
> 
> So, I made the patch as it is.
> 
>> a good idea to have a check for SWP_BLKDEV in si->flags.
> 
> I don't get your point why it should be block dev swap only. IMHO, block dev swap should be less likely fragmented and congested than swap file, right? Block dev swap could be a dedicated physical device, but swap file has to be with filesystem.
> 
> It sounds reasonable to me to have this check for swap file only. However, to be honest, it sounds not hurt to have both.
> 

Yes, I think we want to do it for both cases.

My original concern was that the backing store was not sitting on
a block device for some special case swap usage.  And si->swap_file->f_mapping->host
may fails to dereference to a host inode that's a valid block device.

It looks like on the call paths si->flags should either be SWP_BLKDEV or SWP_FS
on all the call paths. So si->swap_file->f_mapping->host should be valid
and your code is safe.

If we want to be paranoid we may do

	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
		if (inode_read_congested(si->swap_file->f_mapping->host))
			goto skip;
	}

Thanks.

Tim
