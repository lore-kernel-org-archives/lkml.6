Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06158214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7GqRu75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06158214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJITwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:52:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40944 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJITwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:52:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so748831pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ws3c+mOi366Eu0vM1CHgmIxNDfYRZCpV4B9T9jf4DtY=;
        b=E7GqRu75d2ptDvC5NCP+2cJfGcdgH3+Kfmk01PSSfdYMvqPgp6dbV4NrJaxcLklrhq
         WmuU9MRdlFTHFRdUkYq2Kd6buD/OnIy3OgH0PvrAM+F+iptEo8vn+lcu0HgPlpKEPSuO
         2F96TfpKVJyk1tXgTuhjnXnh6KLJXfxW8u+8rpxJm7qHL+JHTKSQevgZRtu7gCdg8K6E
         1jhI8nYsNwuPPwrTYHlETbYqhfbksJ5BvPa75nEO7thtcGkZskxBosR/4hm+6EfKLE1c
         lQZA1QIRuZQeCZkHzGJmc199s4Lh3Lwvm+5TEM/9jSyKfZpfWrYvnNAGeAvkfpugWvpS
         vvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ws3c+mOi366Eu0vM1CHgmIxNDfYRZCpV4B9T9jf4DtY=;
        b=e4OboUi3qYJTbYjb+AE7G5M91fv1j1SOMfw814VX6lXIZ9uLlbtTuEcInzbG9T9oYf
         3k6rCMAcb/M3RopJotwE1k0a+iQmZOXfsiScE++2TpGrHSezPBbKd7HemWiB0TDP4fYO
         DX6qXSaKphd0+r+xixAKTl/cEFltrsPp1jjcnHUle+XEtNaPHKBLeQKa7yCbP9WaIhma
         dKg9DGnxV73lK0RPsEFxGiJucLlH9JO2lWHUBQ8mbbuNqTzG1G1UekF0KHOTse0MsPEr
         oZDa9JtLGyeOFHD9OtaGMTApLcSWRa7dQSEnuBKinRvGl4RSxluyFE/RFMD3S8esJpiI
         dJRQ==
X-Gm-Message-State: ABuFfoj2h9G4MQMLku3Uxtxv22vwOAn2kpiT8Vq3mtetTVH2/OpAN5k3
        kCQU+wXhUOEd77nEuoRMBFU=
X-Google-Smtp-Source: ACcGV61oif/oQ++4e0GdJ9tpMZDCQ2r6f6wWjAF2QtfmvZ9EJb9NTqLXsa8AbjtgyMjCKSRbZjcLfQ==
X-Received: by 2002:a62:6801:: with SMTP id d1-v6mr3423679pfc.7.1539088515475;
        Tue, 09 Oct 2018 05:35:15 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 6-v6sm22277069pgl.6.2018.10.09.05.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 05:35:14 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 9 Oct 2018 21:35:03 +0900
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
Subject: Re: [RFC][PATCH 2/3] printk: lock/unlock console only for new logbuf
 entries
Message-ID: <20181009123503.GB471@tigerII.localdomain>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
 <20181002023836.4487-3-sergey.senozhatsky@gmail.com>
 <20181009083959.rhbxdihzjj44nogk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009083959.rhbxdihzjj44nogk@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/09/18 10:39), Petr Mladek wrote:
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  kernel/printk/printk.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> The patch makes perfect sense. It looks a bit hacky but I can't
> think about any less hacky one.
>
> I wonder if it is worth it. But if nobody else is against it
> I am going to push it.

Well, getting to buffered printk may take some time; so I'd probably
apply it, shouldn't hurt :)

	-ss
