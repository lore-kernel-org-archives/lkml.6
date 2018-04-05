Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDEOe1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeDEOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:34:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D50621720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 5 Apr 2018 10:34:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180405103421.60bcf53c@gandalf.local.home>
In-Reply-To: <20180405142749.GL6312@dhcp22.suse.cz>
References: <20180403093245.43e7e77c@gandalf.local.home>
        <20180403135607.GC5501@dhcp22.suse.cz>
        <CAGWkznH-yfAu=fMo1YWU9zo-DomHY8YP=rw447rUTgzvVH4RpQ@mail.gmail.com>
        <20180404062340.GD6312@dhcp22.suse.cz>
        <20180404101149.08f6f881@gandalf.local.home>
        <20180404142329.GI6312@dhcp22.suse.cz>
        <20180404114730.65118279@gandalf.local.home>
        <20180405025841.GA9301@bombadil.infradead.org>
        <CAJWu+oqP64QzvPM6iHtzowek6s4p+3rb7WDXs1z51mwW-9mLbA@mail.gmail.com>
        <20180405142258.GA28128@bombadil.infradead.org>
        <20180405142749.GL6312@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018 16:27:49 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> > I understand you don't want GFP_NORETRY.  But why is it more important for
> > this allocation to succeed than other normal GFP_KERNEL allocations?  
> 
> I guess they simply want a failure rather than OOM even when they can
> shoot themselves into head by using oom_origin. It is still quite ugly
> to see OOM report...

Exactly!

-- Steve
