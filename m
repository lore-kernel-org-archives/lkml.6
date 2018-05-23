Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeEWSvt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:51:49 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39041 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:51:46 -0400
X-Google-Smtp-Source: AB8JxZphDC1cj42Db3ZuZu3o2gDBKzv7BfuMza1dubJYH0VGB+SSXn/q2F0mzHBBZ9D0nYumUt3wEw==
Date: Wed, 23 May 2018 11:51:43 -0700
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
Message-ID: <20180523185143.GS1718769@devbig577.frc2.facebook.com>
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
 <20180523183907.GZ3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523183907.GZ3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:39:07AM -0700, Paul E. McKenney wrote:
> > While this resolves the problem at hand, it might be a good idea to
> > isolate rcu_exp_work to its own workqueue too as it can be used from
> > various paths and is prone to this sort of indirect A-A deadlocks.
> 
> Commit ad7c946b35ad4 ("rcu: Create RCU-specific workqueues with rescuers")
> was accepted into mainline this past merge window.  Does that do what
> you want, or are you looking for something else?

Ah, that does it.  Sorry, was looking at an older kernel.

Thanks.

-- 
tejun
