Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDDQNa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeDDQN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:13:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56222133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 12:13:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during
 allocations
Message-ID: <20180404121326.6eca4fa3@gandalf.local.home>
In-Reply-To: <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
References: <20180404115310.6c69e7b9@gandalf.local.home>
        <20180404120002.6561a5bc@gandalf.local.home>
        <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 09:03:47 -0700
Joel Fernandes <joelaf@google.com> wrote:


> > for the tests. Note, without this, I tried to allocate all memory
> > (bisecting it with allocations that failed and allocations that
> > succeeded), and couldn't trigger an OOM :-/  
> 
> I guess you need to have something *else* other than the write to
> buffer_size_kb doing the GFP_KERNEL allocations but unfortunately gets
> OOM killed?

Yeah, for some reason, my test box seems to always have something doing
that, because I trigger an OOM about 2 out of every 3 tries.

Here's the tasks that trigger it:

 lvmetad, crond, systemd-journal, abrt-dump-journ, chronyd,

I guess my system is rather busy even when idle :-/

> 
> Also, I agree with the new patch and its nice idea to do that.

Thanks, want to give it a test too?

-- Steve
