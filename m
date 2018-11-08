Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B15AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4D920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2D46vvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4D920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKHWTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:19:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36217 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:19:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id z17-v6so8828312pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q2VTVCIeihEWBqiieaox5trudekhByLfshiReF0moCM=;
        b=m2D46vvC7xU+we5P0b0uO1CoWRhSXw7G0R8XCqR472IjJNc01cVAqVZtLNdCP9J0oJ
         LOQGI7VJOv9ZdvHs3iV1OF1d2cwWk4+ALEs/iPb6Oi63fLUdH4gJ9ktta+JwHgXmOHPK
         owDb53tjQyVJhE2FDOp7klR/Jkx5yoFc9Cfc19X8u12+jozF587X7ferO7pewNPrtDUq
         nww2tkTtOR13C/LmHDXoS4FhJZ2Upp7y5PydD7ol7/BdZFNgSeURWWhxyGDYIs5Pt9ZY
         kgttR7S0JlB1X+03XbNkUyOwHnwwDR7lzMgaK5xsSkrzqTj40rfCSgshlLhf84t8PtoP
         Q1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q2VTVCIeihEWBqiieaox5trudekhByLfshiReF0moCM=;
        b=LdhpTr6I/ERAtFLQ1DPmck/TPvgafZ/eZJ5qZkJng4V29ZszVqy9NnLTy5y3yMhajD
         x2/yiw0aFw4MytfWBXMqND7kOMgsQhRclBFpkmfPBkF2g2kGZDzrxKUw4ZrtX0dbw1F8
         /5sYgxr81q8DGhOrB2qUp0UO8tILMHuCvTwdHx9MEw6KYgfXy/ERxlUvZGFlwEoZvhrh
         /xyZW8TbS9uK9UNBEJvvA469fh5f7UkCBBpOHD7Erz0eq8jaWdF5rlTSrslSNBxM5Hkl
         O8muEImbO/ej0BuV6i9EYncGR/4amQK+/1t39qclNvwkdww5n8g1Aoe1xEAt+p9YWg86
         SGsQ==
X-Gm-Message-State: AGRZ1gI5gukLhjZOtsqlWsXkD1efiNTT7aTTa/TDnnaSatmBbLgOzCzw
        asCgUYkgSxN5wpMAPJYn3vzPXCzM
X-Google-Smtp-Source: AJdET5eKSxCqMKC3wvY0wEmQJCbRUMRBC4sYATs+FWAqjLpSk7/qbDCsGkACE7/ZCi9m6cTTxDYJVg==
X-Received: by 2002:a62:2944:: with SMTP id p65-v6mr4304326pfp.176.1541681058227;
        Thu, 08 Nov 2018 04:44:18 -0800 (PST)
Received: from localhost ([39.7.58.178])
        by smtp.gmail.com with ESMTPSA id m20-v6sm4516688pfj.171.2018.11.08.04.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:44:16 -0800 (PST)
Date:   Thu, 8 Nov 2018 21:44:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181108124413.GB30440@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <20181108115310.rf7htdyyocaowbdk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108115310.rf7htdyyocaowbdk@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/08/18 12:53), Petr Mladek wrote:
> > lockdep.c
> > 	printk_safe_enter_irqsave(flags);
> > 	lockdep_report();
> > 	printk_safe_exit_irqrestore(flags);
> 
> All this looks nice. Let's look it also from the other side.
> The following comes to my mind:
> 
> a) lockdep is not the only place when continuous lines get mixed.
>    This patch mentions also RCU stalls. The other patch mentions
>    OOM. I am sure that there will be more.
> 
> b) It is not obvious where printk_safe() would be necessary.
>    While buffered printk is clearly connected with continuous
>    lines.
> 
> c) I am not sure that disabling preemption would always be
>    acceptable.
> 
> d) We might need to increase the size of the per-CPU buffers if
>    they are used more widely.
> 
> e) People would need to learn a new (printk_safe) API when it is
>    use outside printk sources.
> 
> f) Losing the entire log is more painful than loosing one line
>    when the buffer never gets flushed.
> 
> Sigh, no solution is perfect. If only we could agree that one
> way was better than the other.

I agree with what you are saying. All of the above (in my email)
was for lockdep only, that's why I did mention lockdep several times.
Like I said, a random and wild idea.
I'm not proposing printk_safe as a "better" buffered printk for
everyone. The buffered_printk patch is pretty big, and comes with a
price tag.

If lockdep and OOM people will ACK buffered printk transition in
its current form, then we can go ahead.

It's debatable if we need a fixed size list of buffers; or we can
do kmalloc()+cont fallback. But if we will have ACKs, then we can
move forward.

	-ss
