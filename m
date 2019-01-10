Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE8020665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Mfxapa+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfAJUAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:00:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39103 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfAJUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:00:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so15065865qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zZz6iFxFd0zHVciM6mZTeJ3dcHBk0+YQR+R9eHIq71M=;
        b=Mfxapa+mz3Nh1ecJCPgldeskv/PAxvmTX6s6tHxIQeuoki+/JbkquSTQ3FcjKznlJC
         o151a6O399J9bkqSh3XpDi9tK/lPAXO1YlBTgz3TMfj3J5YamcUUBHii3IZ8rT8Gn3PF
         KnFGxd7r4exHkb45NEGVuAcajWS7WVTAtLX/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zZz6iFxFd0zHVciM6mZTeJ3dcHBk0+YQR+R9eHIq71M=;
        b=NhxzwjDaI0LveWocqBN332kpm1eCLdbBlQcRFGa4WD3VSlo+YRTvbx3mc3FtGP7Qby
         ILZqCgVz0Pa1KnDrB2/cy5CG0J4A08sZ+Sqq0gDA9PKxYMeq/75JuflxnPJ8yxtxHFJ0
         /b9bJQrClBbdXsKnkzHqb4ledz9m53+4bPJcoq4iIv0b8cX+JkWC5ZywZOZWMZmGaZnu
         IgLYAq5uPGhbAtex0q2Q4gCN5dTCqD+3tO2dnUpkHgQMJf166EUN+OwBVNp8oEq3vzga
         UugfORRjf8sLoyQg2qOpwuOQn8+c+DRHDqauMKL3aP3WSwJac9oeovHtX68akMUsfcip
         shXQ==
X-Gm-Message-State: AJcUukdBUmZAPa15f+l6BRBssmcXmOemLkPkL4/0PZqGVu8NAUZD1k3x
        Vo9WNBbB6ghmirWJmmDmYnLjMg==
X-Google-Smtp-Source: ALg8bN7kUOn43CXIORG/S5uaUpyWG4o2i24BKSkko1ly/MXpQZElLztxqzASYLETJskaqQp7Iq8EMg==
X-Received: by 2002:aed:36c1:: with SMTP id f59mr10998453qtb.250.1547150415518;
        Thu, 10 Jan 2019 12:00:15 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 32sm51810396qto.55.2019.01.10.12.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 12:00:14 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 10 Jan 2019 15:00:11 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
In-Reply-To: <alpine.DEB.2.21.1901101246340.3358@macbook-air>
Message-ID: <alpine.DEB.2.21.1901101500030.3717@macbook-air>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air> <alpine.DEB.2.21.1901101246340.3358@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Vince Weaver wrote:

> On Thu, 10 Jan 2019, Vince Weaver wrote:
> 
> > However if you create an all-process attached to CPU event:
> > 	perf_event_open(attr, -1, X, -1, 0);
> > the mmap event index is set as if this were a valid event and so the rdpmc
> > succeeds even though it shouldn't (we're trying to read an event value
> > on a remote cpu with a local rdpmc).
> 
> For a test case, try the
> 	tests/rdpmc/rdpmc_attach_other_cpu
> test found in my perf_event_tests suite
> 	git clone https://github.com/deater/perf_event_tests

and that was a cut-and-paste error, I meant
	tests/rdpmc/rdpmc_attach_global_cpu
and I was wrong, it does affect AMD machines too.

Vince
