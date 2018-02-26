Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeBZEfH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 23:35:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:20639 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeBZEfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 23:35:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="20336550"
Message-ID: <5A938F26.4040901@intel.com>
Date: Mon, 26 Feb 2018 12:37:58 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Michal Hocko <mhocko@kernel.org>
CC: linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/page_poison: move PAGE_POISON to page_poison.c
References: <1518163694-27155-1-git-send-email-wei.w.wang@intel.com> <20180213101615.GO3443@dhcp22.suse.cz>
In-Reply-To: <20180213101615.GO3443@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 06:16 PM, Michal Hocko wrote:
> On Fri 09-02-18 16:08:14, Wei Wang wrote:
>> The PAGE_POISON macro is used in page_poison.c only, so avoid exporting
>> it. Also remove the "mm/debug-pagealloc.c" related comment, which is
>> obsolete.
> Why is this an improvement? I thought the whole point of poison.h is to
> keep all the poison value at a single place to make them obviously
> unique.

There isn't a comment explaining why they are exposed. We did this 
because PAGE_POISON is used by page_poison.c only, it seems not 
necessary to expose the private values.
Why would it be not unique if moved to page_poison.c (on condition that 
it is only used there)?

Best,
Wei
