Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDEOaz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbeDEOax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:30:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CCA21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 5 Apr 2018 10:30:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joel Fernandes <joelaf@google.com>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180405103050.22f10319@gandalf.local.home>
In-Reply-To: <20180405142258.GA28128@bombadil.infradead.org>
References: <20180403123514.GX5501@dhcp22.suse.cz>
        <20180403093245.43e7e77c@gandalf.local.home>
        <20180403135607.GC5501@dhcp22.suse.cz>
        <CAGWkznH-yfAu=fMo1YWU9zo-DomHY8YP=rw447rUTgzvVH4RpQ@mail.gmail.com>
        <20180404062340.GD6312@dhcp22.suse.cz>
        <20180404101149.08f6f881@gandalf.local.home>
        <20180404142329.GI6312@dhcp22.suse.cz>
        <20180404114730.65118279@gandalf.local.home>
        <20180405025841.GA9301@bombadil.infradead.org>
        <CAJWu+oqP64QzvPM6iHtzowek6s4p+3rb7WDXs1z51mwW-9mLbA@mail.gmail.com>
        <20180405142258.GA28128@bombadil.infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018 07:22:58 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> I understand you don't want GFP_NORETRY.  But why is it more important for
> this allocation to succeed than other normal GFP_KERNEL allocations?

Not sure what you mean by "more important"? Does saying "RETRY_MAYFAIL"
make it more important? The difference is, if GFP_KERNEL fails, we
don't want to trigger an OOM, and simply clean up and report -ENOMEM to
the user. It has nothing to do with being more important than other
allocations.

If there's 100 Megs of memory available, and the user requests a gig of
memory, it's going to fail. Ideally, it doesn't trigger OOM, but
instead simply reports -ENOMEM to the user.

-- Steve
