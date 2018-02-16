Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbeBPUAl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:00:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:35753 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeBPUAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:00:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18742395"
Subject: Re: [PATCH 2/3] x86/mm: introduce __PAGE_KERNEL_GLOBAL
To: Nadav Amit <nadav.amit@gmail.com>
References: <20180215132053.6C9B48C8@viggo.jf.intel.com>
 <20180215132055.F341C31E@viggo.jf.intel.com>
 <E0AB2852-C4E0-43D3-ABA7-34117A5516C1@gmail.com>
 <a3dd1676-a2dc-aa02-77ad-51cd3b7a78d5@linux.intel.com>
 <DF43D1DD-42EE-4545-9F54-4BC2395D66EA@gmail.com>
 <0f8abc68-1092-1bae-d244-1adbbee455f9@linux.intel.com>
 <4542D3AE-6A4F-45AD-AD70-8DFA9503071A@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, keescook@google.com,
        Hugh Dickins <hughd@google.com>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <9f77b568-d86c-47db-f7a3-ddb931f33af0@linux.intel.com>
Date: Fri, 16 Feb 2018 12:00:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4542D3AE-6A4F-45AD-AD70-8DFA9503071A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 11:54 AM, Nadav Amit wrote:
>> But I don't really want to hide that gunk in a macro like that.  It
>> might make more sense as a static inline.  I'll give that a shot and resent.
> Since determining whether PTI is on is done in several places in the kernel,
> maybe there should a single function to determine whether PTI is on,
> something like:
> 
> static inline bool is_pti_on(void)
> {
> 	return IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) && 
> 		static_cpu_has(X86_FEATURE_PTI);
> }

We should be able to do it with disabled-features.h and the X86_FEATURE
bit.  I'll look into it.
