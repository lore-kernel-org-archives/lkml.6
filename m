Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EFBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BBC217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLRKBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:01:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:59392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeLRKBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:01:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EBA6B088;
        Tue, 18 Dec 2018 10:01:20 +0000 (UTC)
Date:   Tue, 18 Dec 2018 11:01:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181218100119.3lf5ktzqbqkwsfb2@pathway.suse.cz>
References: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218085524.GA1047@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218085524.GA1047@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-18 17:55:24, Sergey Senozhatsky wrote:
> On (12/18/18 06:05), Tetsuo Handa wrote:
> > +#ifdef CONFIG_PRINTK_CALLER
> > +static size_t print_caller(u32 id, char *buf)
> > +{
> > +	char from[12];
> > +
> > +	snprintf(from, sizeof(from), "%c%u",
> > +		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
> > +	return sprintf(buf, "[%6s]", from);
> > +}
> 
> A nitpick:
> 
> s/from/caller/g   :)

Great catch!

> 
> > +	  Selecting this option causes "thread id" (if in task context) or
> > +	  "processor id" (if not in task context) of the printk() messages
> > +	  to be added.
> 
> Would the following wording be a bit simpler?
> 
>   "Selecting this option causes printk() to add a caller "thread id" (if
>    in task context) or a caller "processor id" (if not in task context)
>    to every message."

It sounds good to me.

I have updated the patch in printk.git, for-4.22 branch.

Best Regards,
Petr

PS: I think that I have rushed the patch probably too much.
I did too much nitpicking in the past and am trying to find
a better balance now.
