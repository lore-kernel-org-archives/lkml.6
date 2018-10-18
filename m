Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77755ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D488208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcJRiwKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D488208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeJRQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:13:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40930 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJRQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:13:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so13835259pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0cEwCsCLCQSfwCbbgxtdbG4/uR/rOfcS5MB9+DZW90Y=;
        b=WcJRiwKClfQ7HlXXLjo/rxl48OxxOzq0HUtQ1KapaTr40/Su2R6LB7y5RrPQr0xbut
         Z5piu7P3VpwTcFrpXfKbc1WAtwpFTrqzsVLEfa4jn9YXxZXQVoNyuH/3C5+Pf0iW2EMA
         JP80vyz3dpCJps9JegIqYpU13NKAtxIg0PsxA/YfCjd/pPSaAIlDeWs1j0cqIHoiI6Kp
         Sh28T6cWahLCVhYaN7FJ7mO35n8TpWFPGX08sgTGk2UHhiTzWjBt0TBwEzrbYLjkBs3M
         yS2VviK/FZ4GbnUpC5H+A5XRl4N3sT5QozupXd9oZx4gBnGUbIbiNih2EewK8zC2yRy8
         DGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0cEwCsCLCQSfwCbbgxtdbG4/uR/rOfcS5MB9+DZW90Y=;
        b=aHAPhREexQVym88V8MsH6E/bZGPQOvW1+Q9v1SBi+xCs2TDUoKsO5d5kU9TlQJ43oO
         wlfzYDbmi8lr7UCe5/dfA5RXyP5iM0rdPfFWb2RTF6M2jEza3FXKB5cCZJ0kbhTBKfVL
         lhdSTC3W8s0SJbRjsMnHKoqb9c+jPLChyX0dH9gt19vCzflwwnXKDPkTF7YoA++hGsAO
         p/O5fKsh+mnKlQ7neX+phWZQHSIcoeB9zlFV4xDsDad78HUZkegi63yD6fDjN6mnZDYK
         HCHyEVhF3MQ+lIIYa/aoOrYTwTHsT/TE8Gug1O2YKiBN+YyKHuZrNSRShDr73aT63GGL
         wQaQ==
X-Gm-Message-State: ABuFfohonvDBKm7Iu7YHz5h5kZEguJfxc1LFvral+WwcJ/gBidXYhQ3n
        rQRJ75f2iceaxqu+Uy4+ZUw=
X-Google-Smtp-Source: ACcGV62lli/t0RBXjjNA1yC/aDDCpC1v+069OJjF3/HI+bQuRjeSm2H6p/7XisTPgr8nQNptfxsQtQ==
X-Received: by 2002:a62:7d8d:: with SMTP id y135-v6mr29498705pfc.245.1539850437221;
        Thu, 18 Oct 2018 01:13:57 -0700 (PDT)
Received: from localhost ([175.223.3.251])
        by smtp.gmail.com with ESMTPSA id u13-v6sm18545993pgp.18.2018.10.18.01.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 01:13:56 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:13:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181018081352.GA438@jagdpanzerIV>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
 <20181018061018.GB650@jagdpanzerIV>
 <20181018075611.GY18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018075611.GY18839@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/18/18 09:56), Michal Hocko wrote:
> On Thu 18-10-18 15:10:18, Sergey Senozhatsky wrote:
> [...]
> > and let's hear from MM people what they can suggest.
> > 
> > Michal, Andrew, Johannes, any thoughts?
> 
> I have already stated my position. Let's not reinvent the wheel and use
> the standard printk throttling. If there are cases where oom reports
> cause more harm than good I am open to add a knob to allow disabling it
> altogether (it can be even fine grained one to control whether to dump
> show_mem, task_list etc.).

A knob might do.
As well as /proc/sys/kernel/printk tweaks, probably. One can even add
echo "a b c d" > /proc/sys/kernel/printk to .bashrc and adjust printk
console levels on login and rollback to old values in .bash_logout
May be.

> But please let's stop this dubious one-off approaches.

OK. Well, I'm not proposing anything actually. I didn't even
realize until recently that Tetsuo was talking about "user
interaction" problem; I thought that his problem was stalled
RCU.

	-ss
