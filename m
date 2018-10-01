Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17722145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17722145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJBDJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeJBDJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:09:35 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1E6208AE;
        Mon,  1 Oct 2018 20:30:00 +0000 (UTC)
Date:   Mon, 1 Oct 2018 16:29:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Daniel Wang <wonderfly@google.com>, stable@vger.kernel.org,
        pmladek@suse.com, Alexander.Levin@microsoft.com,
        akpm@linux-foundation.org, byungchul.park@lge.com,
        dave.hansen@intel.com, hannes@cmpxchg.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mathieu.desnoyers@efficios.com, mgorman@suse.de, mhocko@kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        xiyou.wangcong@gmail.com, pfeiner@google.com
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181001162958.3b8e4640@gandalf.local.home>
In-Reply-To: <20181001201309.GA9835@amd>
References: <20180927194601.207765-1-wonderfly@google.com>
        <20181001152324.72a20bea@gandalf.local.home>
        <20181001201309.GA9835@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 22:13:10 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > > [1] https://lore.kernel.org/lkml/20180409081535.dq7p5bfnpvd3xk3t@pathway.suse.cz/T/#u
> > > 
> > > Serial console logs leading up to the deadlock. As can be seen the stack trace
> > > was incomplete because the printing path hit a timeout.  
> > 
> > I'm fine with having this backported.  
> 
> Dunno. Is the patch perhaps a bit too complex? This is not exactly
> trivial bugfix.
> 
> pavel@duo:/data/l/clean-cg$ git show dbdda842fe96f | diffstat
>  printk.c |  108
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 
> I see that it is pretty critical to Daniel, but maybe kernel with
> console locking redone should no longer be called 4.4?

But it prevents a deadlock.

I usually weigh backporting as benefit vs risk. And I believe the
benefit outweighs the risk in this case.

-- Steve
