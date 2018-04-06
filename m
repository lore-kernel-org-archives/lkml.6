Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeDFMOW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:14:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeDFMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:14:20 -0400
Date: Fri, 6 Apr 2018 14:14:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@fb.com>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot
        <bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>, shli@fb.com,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Ingo Molnar <mingo@redhat.com>, linux-fsdevel@vger.kernel.org,
        Nikanth Karthikesan <knikanth@suse.de>
Subject: Re: INFO: task hung in lo_ioctl
Message-ID: <20180406121411.GJ4082@hirez.programming.kicks-ass.net>
References: <94eb2c0810d04f5a46055ffc71aa@google.com>
 <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
 <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
 <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 09:04:18PM +0900, Tetsuo Handa wrote:
> +	/* Temporary hack for handling lock imbalance. */
> +	if (__mutex_owner(&lo->lo_ctl_mutex) == current)
> +		mutex_unlock(&lo->lo_ctl_mutex);

ARGGH.. you didn't read the comment we put on that?
