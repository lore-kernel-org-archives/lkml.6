Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeDJTFR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeDJTFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:05:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF0A217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 10 Apr 2018 15:05:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410150512.189f849c@gandalf.local.home>
In-Reply-To: <CAJWu+ooC4hCK31srhBFoAf=qwfFFOyTGsjRRJ9PdxaVsb6waQQ@mail.gmail.com>
References: <20180410061447.GQ21835@dhcp22.suse.cz>
        <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
        <20180410074921.GU21835@dhcp22.suse.cz>
        <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
        <20180410081231.GV21835@dhcp22.suse.cz>
        <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
        <20180410090128.GY21835@dhcp22.suse.cz>
        <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
        <20180410104902.GC21835@dhcp22.suse.cz>
        <20180410082316.263d34ec@gandalf.local.home>
        <20180410122706.GH21835@dhcp22.suse.cz>
        <20180410083625.2c904ab2@gandalf.local.home>
        <20180410091311.20bd8ccc@gandalf.local.home>
        <CAJWu+oo5iUDjCnbhhJ7x2BGeuL6FDAVqFCa5tcTikVh5OtxfRA@mail.gmail.com>
        <20180410140036.650a8732@gandalf.local.home>
        <CAJWu+ooC4hCK31srhBFoAf=qwfFFOyTGsjRRJ9PdxaVsb6waQQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 11:39:24 -0700
Joel Fernandes <joelaf@google.com> wrote:

> Yes I agree. So lets just do that and no other patches additional
> patches are needed then. Let me know if there's anything else I
> missed?

Yeah, I think there's really no other issue. I'm not going to apply
more patches.

> 
> Also I got a bit confused, I reread all the threads. Zhaoyang's
> current issue is that the OOM hint *IS* working which is what
> triggered your patch to toggle the behavior through an option. Where
> was in this message we are discussing that the OOM hint doesn't always
> work which is not Zhaoyang's current issue. Let me know if I missed
> something? Sorry if I did.

Right, it's that if someone does extend the ring buffer page size while
the system is about to go into OOM, it may be triggered to get killed
even though it's not the culprit of the memory problems. But again,
this is really pushing what happens in the real world. That's the
problem with stress test cases. What happens when it triggers something
that will never actually happen in normal environments, and the fix
just complicates everything for really no benefit.

-- Steve
