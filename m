Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606A2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEC72098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7g5Etjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEC72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJLQ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:56:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46469 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:56:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id r64-v6so5883696pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqifFnPKTRWHjCi8W57X+9Rl1Ju1BHxfx5lZUbg0488=;
        b=p7g5Etjg3FfiRAR3CF9Oh5TZ/jbPhHQG6ru8RmNUPpprKjg/yGmw8HVl3st44V6XXn
         D79x1vABwxUig/rcBWqkndfnchYvBRfP8oL4N4KBb3VxTo+NzELAu/9Zh2YyS67+dVKR
         kswUSmsyz+PziXeetFtfQjyskETiI+EJ7YhvfCQuzVCJYQQ4vZp9minLunJ0gUqEcjVF
         hLLA1rRVn2nR/NAYvs+1+DnSMnEVxNpSiULe81kOIJMiIiV86C4uf9ceSwPY2awc8JGQ
         AANxB6AXMkZ9SeXHsQ9xHpSgy5Rco0pyR3TqLgtBywUZqap4x+05jVwo2CXDzqrKeidc
         eDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqifFnPKTRWHjCi8W57X+9Rl1Ju1BHxfx5lZUbg0488=;
        b=Um4B0WyNagGg+vLUeVL+xaf+sL0t28XaJd9DHc+ez6Z+kU0yPjM0o/Q4h63ZdWQ5WU
         j62stVw/i4ZM8XybvB7J5ysnN7TU0gI0jZL1AhFwqTmyluhHcTEL2ioxFkQz/vlFoNH3
         RAIaNT4R2AV9oIBbNKTusnPupBYiBBSfTeM84YPnq9D2Cnu1zg0l6XzVaQs1z+OIyHmb
         g/fzrHYFW9t1BbrXRx2jBmfyma3BW6tNswfQUFH6wKAm9f/Csykb8jSkcDLxhkRTpcpg
         b5UNgwqdZ02yCBY8SyquNKpXYRGX70rx7Gk/cCZVxlHl69E0zcPJyWApwYYspgIZqRpi
         ifrA==
X-Gm-Message-State: ABuFfoj1Ty2ChHdokAOqoORkd0k6ciTC+mPx79oLqY3MB9PQ6x7MZjNB
        R9bAQM/ktzcNZJWyUQYDuZA=
X-Google-Smtp-Source: ACcGV60rPuViUPgone/Bkhio6Jb5MrQWfhI+iQGOHK1L5K6h+1E1YQ2K5P6hw8NwZ84f2CRgkMLPzA==
X-Received: by 2002:a62:221c:: with SMTP id i28-v6mr5308619pfi.196.1539336314604;
        Fri, 12 Oct 2018 02:25:14 -0700 (PDT)
Received: from localhost ([110.70.57.157])
        by smtp.gmail.com with ESMTPSA id k63-v6sm1191762pga.36.2018.10.12.02.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 02:25:13 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:25:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/3] printk: some pr_cont tweaks and cleanups
Message-ID: <20181012092509.GA19882@jagdpanzerIV>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
 <20181012082701.fsx6ikd5h5ohr57h@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012082701.fsx6ikd5h5ohr57h@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/12/18 10:27), Petr Mladek wrote:
> > 	Forked from "printk feature for syzbot". Let's have a separate
> > discussion thread.
> > 	A buch of pr_cont tweaks and cleanups, please see commits and
> > commits' messages for more details.
> > 
> > Sergey Senozhatsky (3):
> >   printk: keep kernel cont support always enabled
> >   printk: lock/unlock console only for new logbuf entries
> >   printk: do not preliminary split up cont buffer
> 
> JFYI, I have pushed all three patches into printk.git, for-4.20
> branch.

Thanks.

	-ss
