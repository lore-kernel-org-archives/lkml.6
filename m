Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83481C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322632081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322632081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeKJAXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:23:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJAXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:23:52 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB80E206BA;
        Fri,  9 Nov 2018 14:42:57 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:42:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     sergey.senozhatsky.work@gmail.com,
        penguin-kernel@i-love.sakura.ne.jp, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dvyukov@google.com, glider@google.com, fengguang.wu@intel.com,
        jpoimboe@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181109094256.147a5de0@gandalf.local.home>
In-Reply-To: <CAHk-=wizC7pn=+F5kNWaz65hb=meyVGLgkGGfZ82mNXp=-E=tQ@mail.gmail.com>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
        <20181108044510.GC2343@jagdpanzerIV>
        <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
        <20181109061204.GC599@jagdpanzerIV>
        <CAHk-=wizC7pn=+F5kNWaz65hb=meyVGLgkGGfZ82mNXp=-E=tQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 08:08:13 -0600
Linus Torvalds <torvalds@linux-foundation.org> wrote:

>  You guys seem to be talking it out
> ok.

Do your new filters not only remove words, but also add text?

  ;-)

-- Steve
