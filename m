Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeBBWWm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:22:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:25343 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeBBWWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:22:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,451,1511856000";
   d="scan'208";a="24494127"
Date: Fri, 2 Feb 2018 14:22:32 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Sergei Trofimovich <slyfox@gentoo.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_GETREGS) (unbreaks strace, gdb)
Message-ID: <20180202222231.23favlxecnxcencr@agluck-desk>
References: <20180202221224.16597-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202221224.16597-1-slyfox@gentoo.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 10:12:24PM +0000, Sergei Trofimovich wrote:
> The strace breakage looks like that:
> ./strace: get_regs: get_regs_error: Input/output error
> 
> It happens because ia64 needs to load unwind tables
> to read certain registers. Unwind tables fail to load
> due to GCC quirk on the following code:
> 
>     extern char __end_unwind[];
>     const struct unw_table_entry *end = (struct unw_table_entry *)table_end;
>     table->end = segment_base + end[-1].end_offset;
> 
> GCC does not generate correct code for this single memory
> reference after constant propagation (see https://gcc.gnu.org/PR84184).

I'm not seeing this ... probably because I build with
a pre-historic 4.3.4 version of gcc.

Do you know which version(s) are affected? I'm not looking
for an exhaustive list, just the one on which you found this
would be good.

-Tony
