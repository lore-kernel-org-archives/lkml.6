Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B920874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfAKRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:01:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44087 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfAKRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:01:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so6534147pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNb0P6UJcWzbCft/rqy6otNgknXEmxON4cZHrTaO2f4=;
        b=DIK2rpWaFwZ6yhlmjSHVL1elWMwXNY17tOL1BDJMp11grwpGeGhoqRg0kLQwVBeZFd
         DXMKg8Aw1yia4mYktFS3um0xnHIxT+W1ko8DR3Xhf66qFl2S5MjdRQqRU+ldvuMU7Jtu
         jmXcNlmPH/mVqtBd9y41LYq4ueXmHcdpIcgDMuuTa7ClpbqRDOGsFSi4T/PdUJLKr2xy
         9CVvTs0B10GHXphK3u6foQkGQw7DQuDSkYsl5jDqZDI55d5RjJTdNhBIbwO/wQFBxTPm
         255K5EI7kDar7Jcrg87fVfqIGaMh1g1oa8LH2tJoW9PQgA+Kwov+S+agUEVFpGqCFP+3
         zeng==
X-Gm-Message-State: AJcUukdbxFcFqYu68xrqCDGphRI5+/1HPnDjzdjoE5vhapCxMR08Tsul
        R9StJmL+HPGxLzr6mlAx+6A=
X-Google-Smtp-Source: ALg8bN6eXlehCbcSPBsWIlXxqfn4tGpiHqI0PxJJsixsaMqKdPZC6ZQliOjvheXrZHS3Vmqv/ZimqQ==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr15105181pfm.81.1547226103881;
        Fri, 11 Jan 2019 09:01:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 84sm281445271pfa.115.2019.01.11.09.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:01:43 -0800 (PST)
Message-ID: <1547226101.83374.80.camel@acm.org>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 11 Jan 2019 09:01:41 -0800
In-Reply-To: <20190111165529.GA14054@worktop.programming.kicks-ass.net>
References: <20190109210204.192109-1-bvanassche@acm.org>
         <20190111124835.GP1900@hirez.programming.kicks-ass.net>
         <1547222103.83374.72.camel@acm.org>
         <20190111165529.GA14054@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 17:55 +-0100, Peter Zijlstra wrote:
+AD4 On Fri, Jan 11, 2019 at 07:55:03AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Fri, 2019-01-11 at 13:48 +-0100, Peter Zijlstra wrote:
+AD4 +AD4 +AD4 I spotted this new v6 in my inbox and have rebased to it.
+AD4 +AD4 
+AD4 +AD4 Thanks+ACE
+AD4 +AD4 
+AD4 +AD4 +AD4 On Wed, Jan 09, 2019 at 01:01:48PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 The changes compared to v5 are:
+AD4 +AD4 +AD4 +AD4 - Modified zap+AF8-class() such that it doesn't try to free a list entry that
+AD4 +AD4 +AD4 +AD4   is already being freed.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 I however have a question on this+ADs this seems wrong. Once a list entry
+AD4 +AD4 +AD4 is enqueued it should not be reachable anymore. If we can reach an entry
+AD4 +AD4 +AD4 after call+AF8-rcu() happened, we've got a problem.
+AD4 +AD4 
+AD4 +AD4 Apparently I confused you - sorry that I was not more clear. What I meant is
+AD4 +AD4 that I changed a single if test into a loop. The graph lock is held while that
+AD4 +AD4 loop is being executed so the code below is serialized against the code called
+AD4 +AD4 from inside the RCU callback:
+AD4 +AD4 
+AD4 +AD4 +AEAAQA -4574,8 +-4563,9 +AEAAQA static void zap+AF8-class(struct pending+AF8-free +ACo-pf, struct lock
+AD4 +AD4 +AF8-class +ACo-class)
+AD4 +AD4                 entry +AD0 list+AF8-entries +- i+ADs
+AD4 +AD4                 if (entry-+AD4-class +ACEAPQ class +ACYAJg entry-+AD4-links+AF8-to +ACEAPQ class)
+AD4 +AD4                         continue+ADs
+AD4 +AD4 -               if (+AF8AXw-test+AF8-and+AF8-set+AF8-bit(i, pf-+AD4-list+AF8-entries+AF8-being+AF8-freed))
+AD4 +AD4 +-               if (list+AF8-entry+AF8-being+AF8-freed(i))
+AD4 +AD4                         continue+ADs
+AD4 
+AD4 Yes, it is the above change that caught my eye.. That checks +AF8-both+AF8 your
+AD4 lists. One is your current open one (+AEA-pf), but the other could already
+AD4 be pending the call+AF8-rcu().
+AD4 
+AD4 So my question is why do we have to check both ?+ACE How come the old code,
+AD4 that only checked +AEA-pf, is wrong?
+AD4 
+AD4 +AD4 +-               set+AF8-bit(i, pf-+AD4-list+AF8-entries+AF8-being+AF8-freed)+ADs
+AD4 +AD4                 nr+AF8-list+AF8-entries--+ADs
+AD4 +AD4                 list+AF8-del+AF8-rcu(+ACY-entry-+AD4-entry)+ADs
+AD4 +AD4         +AH0

The list+AF8-del+AF8-rcu() call must only happen once. I ran into complaints reporting that
the list+AF8-del+AF8-rcu() call triggered list corruption. This change made these complaints
disappear.

Bart.
