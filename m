Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeCETUN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:20:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:48090 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeCETUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:20:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32578295"
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page
 metadata on swap
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        davem@davemloft.net, arnd@arndb.de
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com,
        ross.zwisler@linux.intel.com, dave.jiang@intel.com,
        mgorman@techsingularity.net, willy@infradead.org, hughd@google.com,
        minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org,
        jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <0d77dc3c-1454-a689-a0fb-f07e8973c29e@linux.intel.com>
Date: Mon, 5 Mar 2018 11:20:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
> If a processor supports special metadata for a page, for example ADI
> version tags on SPARC M7, this metadata must be saved when the page is
> swapped out. The same metadata must be restored when the page is swapped
> back in. This patch adds two new architecture specific functions -
> arch_do_swap_page() to be called when a page is swapped in, and
> arch_unmap_one() to be called when a page is being unmapped for swap
> out. These architecture hooks allow page metadata to be saved if the
> architecture supports it.

I still think silently squishing cacheline-level hardware data into
page-level software data structures is dangerous.

But, you seem rather determined to do it this way.  I don't think this
will _hurt_ anyone else, though other than needlessly cluttering up the
code.
