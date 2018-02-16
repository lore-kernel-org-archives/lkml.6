Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162743AbeBPSDw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:03:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:32141 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161111AbeBPSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:03:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18718023"
Subject: Re: [PATCH 2/3] x86/mm: introduce __PAGE_KERNEL_GLOBAL
To: Nadav Amit <nadav.amit@gmail.com>
References: <20180215132053.6C9B48C8@viggo.jf.intel.com>
 <20180215132055.F341C31E@viggo.jf.intel.com>
 <E0AB2852-C4E0-43D3-ABA7-34117A5516C1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <a3dd1676-a2dc-aa02-77ad-51cd3b7a78d5@linux.intel.com>
Date: Fri, 16 Feb 2018 10:03:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <E0AB2852-C4E0-43D3-ABA7-34117A5516C1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 09:47 AM, Nadav Amit wrote:
>> But, this also means that we now get *no* opportunity to use
>> global pages with PTI, even for data which is shared such as the
>> cpu_entry_area and entry/exit text.
> 
> Doesn’t this patch change the kernel behavior when the “nopti”
> parameter is used?

I don't think so.  It takes the "nopti" behavior and effectively makes
it apply everywhere.  So it changes the PTI behavior, not the "nopti"
behavior.

Maybe it would help to quote the code that you think does this instead
of the description. :)
