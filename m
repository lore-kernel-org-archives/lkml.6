Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeBTQ1g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:27:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:37765 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbeBTQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:27:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="176701489"
Date: Tue, 20 Feb 2018 09:27:37 -0700
From: Keith Busch <keith.busch@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com
Subject: Re: [PATCH] blk: optimization for classic polling
Message-ID: <20180220162737.GC7076@localhost.localdomain>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <20180220132137.GG25314@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220132137.GG25314@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:21:37PM +0100, Peter Zijlstra wrote:
> Also, set_current_state(TASK_RUNNING) is dodgy (similarly in
> __blk_mq_poll), why do you need that memory barrier?

You're right. The subsequent revision that was committed removed the
barrier. The commit is here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=67b4110f8c8d16e588d7730db8e8b01b32c1bd8b

I hope the code at least looks more reasonable. The changelog isn't much
different, though.
