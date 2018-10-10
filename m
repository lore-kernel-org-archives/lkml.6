Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB59C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A4820858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYfuJZ21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A4820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJJTKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:10:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39300 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:10:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so2418206plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9rX++vGHuUVTHBx+RFzH2Dn0pBlm6wwSZMASPuD7SI=;
        b=oYfuJZ21idS0i7mMiLtpFk/WQxesC0htAnq2gDyArprwfbFmyu62Rd6Q38SuWJOtC0
         HbQ71bkTg1dcxeaWl+dGmypjd2Uulla2PnIlRhb2iBzZTholHO2zM+1031mUntPfcmvu
         q1U4uiK9D9G2gF22DMhLK5TueCdA3AyGEmWNwXR+gT7M2zCUOOapLZtTuMt0Hn3PUM91
         Taukb/XtJ2SXtgXTW3x1Lk+I3xoJvgFWMGE3rUGaS6JC6Hl3BWBZ6gUioJC3DoSa9uZ0
         9+XzvMghUDfxZfY1kfhb/D2w7j4y2/ET1f9yLCNQV4N8iTiLb1t+zOvpezbkrRepexVf
         Hr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9rX++vGHuUVTHBx+RFzH2Dn0pBlm6wwSZMASPuD7SI=;
        b=Qw+sRcP1F8Da51QhQ+G2r8PDFobTtk9HZl1jWRnuWtWpiEbUuACw3JYXusnL/JhM48
         mWovRTLi7rEDaLAD+RWMMHt8rKvV5ovkh0bvgSSYEnizZcrjayys6P5anM49+sc+xN7n
         ravy2ge+ItyYRzfcq3o96zT2BBsjcTgtf6hXUFa12rbHDQpuXVnGrS1iOGnk8Usf2sJE
         99dNeW0GJiMWfDIy7ZRHH4uuxgz++uXacvUxMl1PqsSQJdiowAQ+V1PBMCrCGCQfDSBN
         yNaf1qbj+JUuEzAVzDtlJ0hIKwt0TU0D5DdrUHivR9FQxpJf9xEA/96t/oLNN8zufjR7
         t84A==
X-Gm-Message-State: ABuFfohRC5Z57pZCbu9q07LeNQeYj7lcjh9aqbwtupgQiECkjaQxAynw
        C4mEQozOcLaGlhMlc5OBI5c=
X-Google-Smtp-Source: ACcGV607OTzFS0Xi66e5drsNYy0z3+PEOqgMHqoFPAYlNksWU8NOiG+pmNXo4yhh0tUM+vDSyCf3Mg==
X-Received: by 2002:a17:902:934a:: with SMTP id g10-v6mr33344138plp.288.1539172129172;
        Wed, 10 Oct 2018 04:48:49 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id c124-v6sm38452056pfa.119.2018.10.10.04.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 04:48:48 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 10 Oct 2018 20:48:33 +0900
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181010114833.GB3949@tigerII.localdomain>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
 <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010113500.GH5873@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/18 13:35), Michal Hocko wrote:
> > Just flooding out of memory messages can trigger RCU stall problems.
> > For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing
> 
> [...]
> 
> Quite some of them, indeed! I guess we want to rate limit the output.
> What about the following?

A bit unrelated, but while we are at it:

  I like it when we rate-limit printk-s that lookup the system.
But it seems that default rate-limit values are not always good enough,
DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
verbose. For instance, when we have a very slow IPMI emulated serial
console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
than we evict them.

Does it sound reasonable enough to use larger than default rate-limits
for printk-s in OOM print-outs? OOM reports tend to be somewhat large
and the reported numbers are not always *very* unique.

What do you think?

	-ss
