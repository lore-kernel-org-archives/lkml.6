Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE30214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwjXAHtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE30214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJJWkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:40:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:40:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so2667600pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cRO6xWryp9VZ+Z/m1BE0LEBrMcJd0c81mmESyZBjTac=;
        b=XwjXAHtb0076NrYxue1X96i0pusQL6JnkAJlh5lYIGh1VZtESL0yhZI+fP5lOJ6h/x
         8rXVXBc4IH7hc/P9Iae0un9x+SQn8K5kdwgTKc4iTMzP0ZISM48JjZvmJoP9Kk6nvxrh
         vDPpC1G4OqAJ4lLc8c8tzmRuw1LbF28WqNNIXFFLhDnPK0i+ilqe3o+csqKcZyyICqxw
         6KqpVDO/xQ5GAxyv9C9/1bXJofA1DAiDWnihC4lPHVPQ4hw67bciSmi0mOFmRPxWK3jF
         Oli9O4uG+JwZ6qW1vwaG4omh08g+gvjbnbg8c8EDyIAWHruTkTTblTO6p4veYB77eTE5
         yq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cRO6xWryp9VZ+Z/m1BE0LEBrMcJd0c81mmESyZBjTac=;
        b=AIN0IODpYwARbI6b0+n02WZH+XJrsyJ5IYRlKOQRuPJgF40JHVl6IdC7iipKta6Wg+
         5q2dTlhXCxzowFV0jjnKtayIo9RxfZN4Qo3DzNoai5y17qF7AnKTE5LFmvj0sObFzZg1
         glV2sVIqEGfuDzvb4bwmUoHuQB0xMQNZK+0+upk6B59gqQFIlCGocSC7Tv5+TbpotLIA
         sDR7f3rB3oMMYQKLnzKYTk+EE05rorSrFibZnl/MrcSRmxdJlEsT012vK2uZBcQYecAr
         RWu/u2Owza7yEYfmrUURY6P9Dg3KvRmbj7IKRKYd24+UvY50wdeymJCxNuUJaZQhIBgB
         Rg8Q==
X-Gm-Message-State: ABuFfoiEw5eW2xFuT/PiFvcG3EmtL0QN0eu1285/YiQgJ2KyF7wWeg+X
        TtisqJ7LkZ+Mz/LA+j2Flnc=
X-Google-Smtp-Source: ACcGV63cZhwfwsfVC+TaZo4bpjTFvo5bgwHvlTZ7yak1StRjUHEIWq13BRYAIqBcyhwuTjvhxgL69g==
X-Received: by 2002:a63:4e11:: with SMTP id c17-v6mr29686244pgb.6.1539184661626;
        Wed, 10 Oct 2018 08:17:41 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id d18-v6sm48642136pfk.163.2018.10.10.08.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 08:17:40 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 11 Oct 2018 00:17:29 +0900
To:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181010151729.GC3949@tigerII.localdomain>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
 <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz>
 <20181010114833.GB3949@tigerII.localdomain>
 <20181010122539.GI5873@dhcp22.suse.cz>
 <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/18 14:29), Dmitry Vyukov wrote:
> >> A bit unrelated, but while we are at it:
> >>
> >>   I like it when we rate-limit printk-s that lookup the system.
> >> But it seems that default rate-limit values are not always good enough,
> >> DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
> >> verbose. For instance, when we have a very slow IPMI emulated serial
> >> console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
> >> DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
> >> than we evict them.
> >>
> >> Does it sound reasonable enough to use larger than default rate-limits
> >> for printk-s in OOM print-outs? OOM reports tend to be somewhat large
> >> and the reported numbers are not always *very* unique.
> >>
> >> What do you think?
> >
> > I do not really care about the current inerval/burst values. This change
> > should be done seprately and ideally with some numbers.
> 
> I think Sergey meant that this place may need to use
> larger-than-default values because it prints lots of output per
> instance (whereas the default limit is more tuned for cases that print
> just 1 line).
> 
> I've found at least 1 place that uses DEFAULT_RATELIMIT_INTERVAL*10:
> https://elixir.bootlin.com/linux/latest/source/fs/btrfs/extent-tree.c#L8365
> Probably we need something similar here.

Yes, Dmitry, that's what I meant - to use something like
DEFAULT_RATELIMIT_INTERVAL * 10 in OOM. I didn't mean to change
the default values system wide.

---

We are not rate-limiting a single annoying printk() in OOM, but
functions that do a whole bunch of printks - OOM header, backtraces, etc.
Thus OOM report can be, I don't know, 50 or 70 or 100 lines (who knows).
So that's why rate-limit in OOM is more permissive in terms of number of
printed lines. When we rate-limit a single printk() we let 10 prinks()
/*10 lines*/ max every 5 seconds. While in OOM this transforms into
10 dump_header() + 10 oom_kill_process() every 5 seconds. Still can be
too many printk()-s, enough to lockup the system.

	-ss
