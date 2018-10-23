Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4EEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D520671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1D520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJWOSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:18:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbeJWOSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:18:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5C14ACB5;
        Tue, 23 Oct 2018 05:56:56 +0000 (UTC)
Date:   Tue, 23 Oct 2018 07:56:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        yang.s@alibaba-inc.com, Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm,oom: Use timeout based back off.
Message-ID: <20181023055655.GM18839@dhcp22.suse.cz>
References: <1540033021-3258-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1810221406400.120157@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810221406400.120157@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 14:11:10, David Rientjes wrote:
[...]
> I've proposed patches that have been running for months in a production 
> environment that make the oom killer useful without serially killing many 
> processes unnecessarily.  At this point, it is *much* easier to just fork 
> the oom killer logic rather than continue to invest time into fixing it in 
> Linux.  That's unfortunate because I'm sure you realize how problematic 
> the current implementation is, how abusive it is, and have seen its 
> effects yourself.  I admire your persistance in trying to fix the issues 
> surrounding the oom killer, but have come to the conclusion that forking 
> it is a much better use of time.

These are some pretty strong words for a code that tends to work for
most users out there. I do not remember any bug reports except for
artificial stress tests or your quite unspecific claims about absolutely
catastrophic impact which is not backed by any specific details.

I have shown interest in addressing as many issues as possible but I
absolutely detest getting back to the previous state with an
indeterministic pile of heuristic which were lockup prone and basically
unmaintainable.

Going around with timeouts and potentially export them to userspace
might sound attractive for the simplicity but this should be absolutely
the last resort when a proper solution is too complex (from a code or
maintainability POV). I do not believe we have reached that state yet.
-- 
Michal Hocko
SUSE Labs
