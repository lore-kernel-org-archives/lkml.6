Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E68C20892
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E68C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440461AbeKXClX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436676AbeKXClX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:41:23 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90362205C9;
        Fri, 23 Nov 2018 15:56:36 +0000 (UTC)
Date:   Fri, 23 Nov 2018 10:56:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181123105634.4956c255@vmware.local.home>
In-Reply-To: <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
        <20181108044510.GC2343@jagdpanzerIV>
        <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
        <20181109061204.GC599@jagdpanzerIV>
        <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
        <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
        <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
        <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 13:46:47 +0100
Petr Mladek <pmladek@suse.com> wrote:

> Steven told me on Plumbers conference that even few initial
> characters saved him a day few times.

Yes, and that has happened more than once. I would reboot and retest
code that is crashing, and due to a triple fault, the machine would
reboot because of some race, and the little output I get from the
console would help tremendously.

Remember, debugging the kernel is a lot like forensics, especially when
it's from a customer's site. You look at all the evidence that you can
get, and sometimes it's just 10 characters in the output that gives you
an idea of where things went wrong. I'm really not liking the buffering
idea because of this.

-- Steve
