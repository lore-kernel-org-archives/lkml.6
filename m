Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89217C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE120862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu+DKolI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CE120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbeKGAAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:00:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41271 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388284AbeKGAAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:00:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so6188144pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DNcqsBQQ+l/EsLUJDnIlU8mQKruh77XsKD6w7wRJZxY=;
        b=Mu+DKolIRXlbNcvhDJXjs5zcJhDscbu5jYOgJ2+yj64Yy49xLkUbHuQ7Q1iykHJfIZ
         F1eZW3g2gPwdWpV7dohIj/JuMJtOxWrJx4Fhk3z/Wz0sogm4/A9Kekz0YEf2wwBOx4Xi
         cQcKfOsa3j3ftFEfaJIs0cox4Xu6j/qAn0FGdYBvioDDooKeD+PUObwr0QhdP7W82CTq
         rvt2eUfYVMCHL45dtUtjti9eVeEf+CDhDy/CG1diR9i4O8gOd6JRiEFcdsFHx55EimFR
         JX7Qsp1tMpT09h2+tAcF8zzIVG03aBtwwTXv4LTFyRAFrV8JK3EppJ7ps1Y4RkcuTPmB
         duwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DNcqsBQQ+l/EsLUJDnIlU8mQKruh77XsKD6w7wRJZxY=;
        b=SUdGtsSHOtsxKOzv3I7hXd+rfeThk97wTHdgYy9TuxhLVjGVKOwMsvJCItFvYp3yj7
         K8I5qvDM6cZznVrIBe7EKlYFx4XOEJ8XXnH8CSMqZ52j7AkuQduUvnjDwaeVLJlNFiBC
         p9a0yjiafLZHgLFN/jDO3oP2c/AvP2lfUd1TTIGQaNkNG55LUyBq3/FBma+OcfBoO0/Y
         XBtfsBpFqg879u7ErWF/JqEatbPCclnbaWPWx2NlwDZw2DhppM9t/pz6THhUKZkpD2zk
         0NND8eYnSv4BrKuWAk3RFK2lFTehB3xbNCvGHmb4xzqTRrB1zCcooXs17mYMcXgC6NqR
         Dwgw==
X-Gm-Message-State: AGRZ1gK9xh9i9oDpBJaXd/Jv93nWzfgpnvQ/tFFsf0JU4clH4021Bct1
        0sBLVbEFfBfNqdFrec1gwCvTwabt
X-Google-Smtp-Source: AJdET5dByaCPMqgj7nry45fpuZjXP+lFh6cc/uvVXCv9qBuG8R4Sj9/z92IbNufS2wT/lhskcuawZA==
X-Received: by 2002:a63:4342:: with SMTP id q63mr24068997pga.63.1541514916581;
        Tue, 06 Nov 2018 06:35:16 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r18-v6sm44642541pgv.17.2018.11.06.06.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:35:15 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 6 Nov 2018 23:35:02 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181106143502.GA32748@tigerII.localdomain>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/02/18 22:31), Tetsuo Handa wrote:
>   (1) Call get_printk_buffer() and acquire "struct printk_buffer *".
> 
>   (2) Rewrite printk() calls in the following way. The "ptr" is
>       "struct printk_buffer *" obtained in step (1).
> 
>       printk(fmt, ...)     => printk_buffered(ptr, fmt, ...)
>       vprintk(fmt, args)   => vprintk_buffered(ptr, fmt, args)
>       pr_emerg(fmt, ...)   => bpr_emerg(ptr, fmt, ...)
>       pr_alert(fmt, ...)   => bpr_alert(ptr, fmt, ...)
>       pr_crit(fmt, ...)    => bpr_crit(ptr, fmt, ...)
>       pr_err(fmt, ...)     => bpr_err(ptr, fmt, ...)
>       pr_warning(fmt, ...) => bpr_warning(ptr, fmt, ...)
>       pr_warn(fmt, ...)    => bpr_warn(ptr, fmt, ...)
>       pr_notice(fmt, ...)  => bpr_notice(ptr, fmt, ...)
>       pr_info(fmt, ...)    => bpr_info(ptr, fmt, ...)
>       pr_cont(fmt, ...)    => bpr_cont(ptr, fmt, ...)
> 
>   (3) Release "struct printk_buffer" by calling put_printk_buffer().

[..]

> Since we want to remove "struct cont" eventually, we will try to remove
> both "implicit printk() users who are expecting KERN_CONT behavior" and
> "explicit pr_cont()/printk(KERN_CONT) users". Therefore, converting to
> this API is recommended.

- The printk-fallback sounds like a hint that the existing 'cont' handling
  better stay in the kernel. I don't see how the existing 'cont' is
  significantly worse than
		bpr_warn(NULL, ...)->printk() // no 'cont' support
  I don't see why would we want to do it, sorry. I don't see "it takes 16
  printk-buffers to make a thing go right" as a sure thing.

A question.

How bad would it actually be to:

- Allocate seq_buf 512-bytes buffer (GFP_ATOMIC) just-in-time, when we
  need it.
    // How often systems cannot allocate a 512-byte buffer? //

- OK, assuming that systems around the world are so badly OOM like all the
  time and even kmalloc(512) is absolutely impossible, then have a fallback
  to the existing 'cont' handling; it just looks to me better than a plain
  printk()-fallback with removed 'cont' support.

- Do not allocate seq_buf if we are in printk-safe or in printk-nmi mode.
  To avoid "buffering for the sake of buffering". IOW, when in printk-safe
  use printk-safe.

	-ss
