Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDD5C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED312087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED312087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbeJLASD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:18:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:12930 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbeJLASC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:18:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="240541350"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.157]) ([10.7.198.157])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2018 09:49:59 -0700
Subject: Re: [workqueue/driver-core PATCH v2 1/5] workqueue: Provide
 queue_work_node to queue work near a given NUMA node
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230715.10609.83647.stgit@localhost.localdomain>
 <20181011150417.GO270328@devbig004.ftw2.facebook.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <6f91e26d-00e5-10ba-b0ee-2b9f8d50934b@linux.intel.com>
Date:   Thu, 11 Oct 2018 09:49:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181011150417.GO270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2018 8:04 AM, Tejun Heo wrote:
> On Wed, Oct 10, 2018 at 04:07:42PM -0700, Alexander Duyck wrote:
>> This patch provides a new function queue_work_node which is meant to
>> schedule work on a "random" CPU of the requested NUMA node. The main
>> motivation for this is to help assist asynchronous init to better improve
>> boot times for devices that are local to a specific node.
>>
>> For now we just default to the first CPU that is in the intersection of the
>> cpumask of the node and the online cpumask. The only exception is if the
>> CPU is local to the node we will just use the current CPU. This should work
>> for our purposes as we are currently only using this for unbound work so
>> the CPU will be translated to a node anyway instead of being directly used.
>>
>> As we are only using the first CPU to represent the NUMA node for now I am
>> limiting the scope of the function so that it can only be used with unbound
>> workqueues.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Please let me know how you wanna route the patch.
> 
> Thanks.

I would be good with routing the patches through you if that works. I 
had included you, Greg, and Andrew as I wasn't sure how you guys had 
wanted this routed since this affected both the workqueue and device trees.

I'll update the patches to resolve the lack of kerneldoc for the new 
"async_" functions and add some comments to the patch descriptions on 
the gains seen related to some of the specific patches for v3.

Thanks.

- Alex






