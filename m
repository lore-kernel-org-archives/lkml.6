Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBHOtf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:49:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:65430 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBHOtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:49:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,479,1511856000";
   d="scan'208";a="16300267"
Date: Thu, 8 Feb 2018 06:49:18 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+283c3c447181741aea28@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aryabinin@virtuozzo.com, jlayton@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, rgoldwyn@suse.com,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: Re: INFO: task hung in sync_blockdev
Message-ID: <20180208144918.GF10945@tassilo.jf.intel.com>
References: <001a11447070ac6fcb0564a08cb1@google.com>
 <20180207155229.GC10945@tassilo.jf.intel.com>
 <20180208092839.ebe5rk6mtvkk5da4@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208092839.ebe5rk6mtvkk5da4@quack2.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It seems multiple processes deadlocked on the bd_mutex. 
> > Unfortunately there's no backtrace for the lock acquisitions,
> > so it's hard to see the exact sequence.
> 
> Well, all in the report points to a situation where some IO was submitted
> to the block device and never completed (more exactly it took longer than
> those 120s to complete that IO). It would need more digging into the

Are you sure? I didn't think outstanding IO would take bd_mutex.

-Andi
