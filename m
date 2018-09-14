Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F73C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E892083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/YdV1dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E892083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeINH2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:28:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeINH2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:28:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so3618562pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sM6W8Z6n11x61yWH3YXoKQ/Pw2ISc5DzBRTKgkCYsWM=;
        b=Y/YdV1dyHFnDE2zpgcUKWosbOFboeQwKc7/VP+I/MHy+A+9148uwdSaURnSFvsx03Z
         7CGKfSRJlQJIYipPmdjhL3DoTgsoHyhTXlG/d9gdL6c1mIgM6l4X6Ai+fq2q5D7Gk7Mt
         kzUK7gQovjE3X1IrDXX+lHFBAtyp30HAlr7CgeyeOQnAxQd2QNCPyb/ctvxH+bDWJg6a
         4t9SwkNinH6d/JT5VNZuIxBGxG7XQ+35V9EylQHrcImuIPGhyU4Oul+Onry3yxe/KSqM
         LMwObH5CMFyNKiFxmGlMiDemJLqGl1ZE3jZUrr5a5iH5wBkOtCF7cdYprC00z9xOmpT/
         UbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sM6W8Z6n11x61yWH3YXoKQ/Pw2ISc5DzBRTKgkCYsWM=;
        b=gu5MH5v0tBpRUWBO/PrwjXtYEhdcNqBXhOW4zuL45F0PXqxTGFjsuXHthL/kUbDF+E
         41n3BUyRnu3dqHzs4O1Yeh7pT9lSdXrwcW9QyWEI+pWMAq0M4YUQ4DXEaELxC8LQ7/HW
         KysofDrOeampRW/is2f6AHoAVTdvupVZsUVQAEGzpT9GUKuA5bJVAJCeK4qpzsMx7Iz5
         LFJpSgOJifstTKYYwWUsFuEvKbs7KT2bbbwP5c7RlH84UPS2UuZ0hAU9FOOfsZvhtUDL
         WeKAA2vB/KgQOJt0alcD65N+vF3u6Ar6LICOLDdNkU+TU0iQtmmgQ8laYR5OgHTHUilK
         J/tw==
X-Gm-Message-State: APzg51Dy4J0ExGPO2iwX0Du4pbk1/4Si6uXEBe/gTrnM3lhqtZD2sdTq
        5ITiBx0MZH8C9FV/83UmMcA=
X-Google-Smtp-Source: ANB0VdaTsNO8aWffoCFfWJZu4t3/Y8F+Mfs+mVPVO/nliso2LVEhLnpiEvzk9rmtIDuBZH5Aa7lgLw==
X-Received: by 2002:a62:9cd7:: with SMTP id u84-v6mr10015730pfk.90.1536891355906;
        Thu, 13 Sep 2018 19:15:55 -0700 (PDT)
Received: from localhost ([39.7.18.191])
        by smtp.gmail.com with ESMTPSA id x24-v6sm6776684pfh.67.2018.09.13.19.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 19:15:53 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:15:50 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180914021550.GB1108@jagdpanzerIV>
References: <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180913212239.112ab10b@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913212239.112ab10b@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/13/18 21:22), Steven Rostedt wrote:
> > Good call. It was a fast path for pr_cont("\n").
> > But it made me wondering and I did some grepping
> > 
> 
> [..]
> 
> > kernel/trace/ftrace.c:          pr_cont("\n expected tramp: %lx\n", ip);
> 
> Note, looking at the history of that, I was just combining a lone "\n"
> with the next string. The code before this print add info to the line
> depending on the input, thus none do a "\n". The "expected tramp" part
> is added to the next line, but I'm fine if you want to break this up.
> This print is very unlikely done with other prints happening. It
> happens when modifying (serially) ftrace nops to calls or back to nops.
> 
> Feel free to send a patch that breaks it up into:
> 
> 	pr_cont("\n");
> 	pr_info(" expected tramp: %lx\n", ip);

I didn't mean to criticize anyone with my "Lovely" comment. Sorry if it
appeared to sound harsh.

I'm fine with the way it is, but we *probably* (up to you) will touch
this code once pr_line is available. As of now, the less pr_cont() calls
we make the better. This

	pr_cont("a");
	pr_cont("b");
	pr_cont("c\n");

in the worst case can be log_store-d as 3 log entries (2 preliminary
flushes). So, from this point of view, this

	pr_cont("ab");
	pr_cont("c\n");

is better, because it can be log_store-d as 2 log entries.
And with pr_line() we can log_store it in 1 log entry [but we will
use some extra stack space for that].

Overall, I counted around 100 cases of printk("\n...."), and around 20+ cases
of pr_cont("\n...") and probably around 10 or 15 printk(KERN_CONT "\n....")
cases. That's what I meant when I said that converting it to pr_line()
will take us some time. Especially given that some of lockdep developers
have really warm feelings toward printk ;)

	-ss
