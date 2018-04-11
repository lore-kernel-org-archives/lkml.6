Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeDKOxQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:53:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:26021 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbeDKOxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:53:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="219587946"
Subject: Re: [PATCH 1/3] infiniband: i40iw: Replace GFP_ATOMIC with GFP_KERNEL
 in i40iw_add_mqh_4
To: Jia-Ju Bai <baijiaju1990@gmail.com>, faisal.latif@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523431945-3508-1-git-send-email-baijiaju1990@gmail.com>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a2af56ae-075f-bd13-3308-6c6ebbca7694@intel.com>
Date: Wed, 11 Apr 2018 10:53:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523431945-3508-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2018 3:32 AM, Jia-Ju Bai wrote:
> i40iw_add_mqh_4() is never called in atomic context, because it
> calls rtnl_lock() that can sleep.
> 
> Despite never getting called from atomic context,
> i40iw_add_mqh_4() calls kzalloc() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.

Just a general comment. I don't know that this is the greatest idea. I 
can imagine instances where sleeping is OK as far as how the code is 
written, but for performance reasons you would rather fail than sleep.

As to whether that is the case here I'll let the i40iw folks comment.

> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
You should probably post a pointer to your tool.

-Denny
