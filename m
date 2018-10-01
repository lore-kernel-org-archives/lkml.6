Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5377DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BBC206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdp0Si/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BBC206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeJAM2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:28:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46047 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:28:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so8609024pgd.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=et0YsD1Q0AeXA2V8n6+N+9yKNPSQ8X4v8TvkJYAGNaA=;
        b=Wdp0Si/QhuoNMHwiegeQBYoHDsOLKCqAkWlhJopUs8y1Jw0qy0yxgnMYmT9PKFN5VL
         muLB4z/VJ49zNsFA+I3a/ROm/or1HTqAJtxK+X9myQ+08eVal2ETz3iT5ZUpJv+t8Q56
         xGJLJ7Q2D/Sm2Z1zYiygm8lOxdGclsxqLGh+2X5F6AP01CM1G/8W5Aqva9YORKEV0E7x
         ZJ0bvp1d/1Xso6Afib/MwFngJty6j4e17EakA7sJZ38V70uiRtpo4Ngb4xyJrBh0tfYF
         10SIkIcEkXQxtaXwVqYHn1+227Rv+9v8YR2q6W956tNPP4hoDzRTem8HakVWLN3PKoTw
         b94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=et0YsD1Q0AeXA2V8n6+N+9yKNPSQ8X4v8TvkJYAGNaA=;
        b=FQqfNU7fXw5ZcSY4jA6ynUFNa1Qf1vz1acQAO0cNl8XXAlwGjdwtk4i2URsdm4FYw7
         S99QSwHoNW67g8QIjVfFNjqK+486bFEO1rPpAgAb0Du0bc1ipEvkq9r6r+SB3lfgxGqb
         D8qnbL8IGAWe4zPwGHL7rOyDi2dZVlFLTiNffyoaPVxKykQzb6xCw0qVowOutYDM35OW
         ifGxoVH9QijKYw5JjStMISlsSoVL3WRt9P1Og9kKLkyNlyM/M7CGqnl9RtqkDRR0D3Vy
         agkNF3JcjSucOdimtPuVsluZDSWqHHz/uK1KiO3KI07+NQnYstiMOhmXOPR8P9XM9usu
         iELA==
X-Gm-Message-State: ABuFfohdKo/X9O6cHjqWMjzwO89F06JTAB3U3mK1kVR5DP5zqoUcZPyj
        aZ1rYSaidQBAYSuFezz6+i8=
X-Google-Smtp-Source: ACcGV62DMDMJzF4/bTBpuoA4bH9WeQG+EkYVp8N5HCvjyEVXwfQWmn7WQSsJxKYL+nqO8WUxvWrnMg==
X-Received: by 2002:a63:cc04:: with SMTP id x4-v6mr8682535pgf.33.1538373161052;
        Sun, 30 Sep 2018 22:52:41 -0700 (PDT)
Received: from localhost ([39.7.15.30])
        by smtp.gmail.com with ESMTPSA id l83-v6sm5176458pfi.172.2018.09.30.22.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 22:52:39 -0700 (PDT)
Date:   Mon, 1 Oct 2018 14:52:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181001055236.GA386@jagdpanzerIV>
References: <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <20180928085648.GC1160@jagdpanzerIV>
 <802130a3-b8c1-3973-933b-d6dc5ff2930d@i-love.sakura.ne.jp>
 <20180929111317.GB1392@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929111317.GB1392@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/29/18 20:13), Sergey Senozhatsky wrote:
> We used to flush "incomplete" cont lines (fragments) from console_unlock().
> 
> void console_unlock(void)
> {
> ...
>         /* flush buffered message fragment immediately to console */
>         console_cont_flush(text, sizeof(text));
> again:
>         for (;;) {
> 	...
> 	}
> ...
> }
> 
> Unless I'm missing something, we don't anymore.
> Since 5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb.
> Now we print only log_buf entries. So we either wait for a \n to flush
> a complete cont buffer, or for a race to preliminary flush cont buffer.

BTW, it just crossed my mind:

Previously, we would do console_cont_flush() for each pr_cont(),
so console_unlock() would print data:

	pr_cont();
	 console_lock();
	 console_unlock()
	  console_cont_flush(); // print cont fragment
	...
	pr_cont();
	 console_lock();
	 console_unlock()
	  console_cont_flush(); // print cont fragment

We don't console_cont_flush() anymore, so when we do pr_cont()
console_unlock() does nothing (unless we flushed the cont buffer):

	pr_cont();
	 console_lock();
	 console_unlock();      // noop
	...
	pr_cont();
	 console_lock();
	 console_unlock();      // noop
	...
	pr_cont();
	  cont_flush();
	    console_lock();
	    console_unlock();   // print data

console_lock()/console_unlock() makes sense only when we flush cont
buffer.

We also wakeup klogd purposelessly for pr_cont() output - un-flushed
is not stored in log_buf; there is nothing to pull.

So we can console_lock()/console_unlock()/wake_up_klogd() only when we
know that we log_stor()-ed a message.

A quick-n-dirty patch (I can send a formal one) which compares log_next_seq
before and after vprintk_store(). log_next_seq is getting incremented each
time we log_store() a new log_buf message:

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 308497194bd4..53d9134f02a6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1931,6 +1931,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	int printed_len;
 	bool in_sched = false;
 	unsigned long flags;
+	u64 curr_log_seq;
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
@@ -1942,11 +1943,12 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
+	curr_log_seq = log_next_seq;
 	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && (curr_log_seq != log_next_seq)) {
 		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
@@ -1963,7 +1965,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	wake_up_klogd();
+	if (curr_log_seq != log_next_seq)
+		wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);

---

	-ss
