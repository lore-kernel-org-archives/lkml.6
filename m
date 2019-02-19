Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A6EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0BF204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3p5FTkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfBSMvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:51:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45045 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBSMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:51:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so5374897pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 04:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLJGGyw1ORKNIxDzpGH3jaJrr4hlEb1GdSZgwab9IMQ=;
        b=J3p5FTkRPx5k3vWXcaE2DQjD9+0XI8sPoJ8kmZc1MjGtFvdDX3SUXshVlTk10hJPjS
         EfV096wwIsLUqfc+yVHWLGgYJzl9Hf5IaAMQ8S5PojxX+ekvnvMpArWbDSLPdFa3x0vq
         PZ9LRESzCxKgK4TjqVxN2G2LkBoltx6zFbf7INGD0o9Aw6/RYKsbu4PJM49yNH1pE4ZY
         jqiAL0aDZ0fETTGuD8NjWBl5sVdMpcCI1Ot8xmNprfdE313VPuJ/+PbOv9HtAHmK1rpM
         MJ7GjRb0q2RA+pOk9EmboDHIwGnbVxLQ/AxGbnhe6d62Jh44NGLegq27cXDMKpiULGV8
         UiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLJGGyw1ORKNIxDzpGH3jaJrr4hlEb1GdSZgwab9IMQ=;
        b=iA/DAdiVHS+TOCRZKLko0hZGG3KbqHB7G53W6TvP8VK1eQI43bKLP6YvjuDCY6bybd
         Ux8/o4PWL0OeX9qPSQ0a0cFqZp1qxWDHPUXJiCQr9d8yKQ/NBUxjaLlAtOARL8+nuENx
         Gyg5BzTzQOxR4cdNE9gWBEclb+OgOprf+UKIlNzbGX1hMO80a5MfG/kl3IbhKVH2uW4o
         cv+WatrS2CErjfIXb7zDWQCBEzaX4O4a7l2SZyLg43hYgu+fAe8qyUQNRIbCMmIcS5HT
         oXzq0ewnieD1XOWpHNfQvVKMXaQKrn/zrckFgkvX9ojyqhzDd70Pxz9ymHy5QKWX1+fW
         gB7A==
X-Gm-Message-State: AHQUAubtcK9guZ4GNQreAd7bi0s2ULDsbuwtalFNAXpQgnyVn5pLLT1/
        7atXE1vSGv9zpNaTC0N8FVA=
X-Google-Smtp-Source: AHgI3IbYZ8RvAWcr9gVEqtVXARLnBq5KSuAP70g3+6heBIzfDCJflRQMOS2Nf3xLcRbWgtyXJx2heQ==
X-Received: by 2002:a17:902:7586:: with SMTP id j6mr14706120pll.259.1550580680185;
        Tue, 19 Feb 2019 04:51:20 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id u186sm23735615pfu.51.2019.02.19.04.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 04:51:19 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 19 Feb 2019 21:51:15 +0900
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20190219125115.GA19910@tigerII.localdomain>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-9-pmladek@suse.com>
 <20190219033003.GA2284@jagdpanzerIV>
 <CAHp75VfeNvThbue+v1VHK_zxw9N82AkOQZUL=nH6xy21WXX7sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfeNvThbue+v1VHK_zxw9N82AkOQZUL=nH6xy21WXX7sg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/19/19 13:02), Andy Shevchenko wrote:
[..]
> And if it's not? You will get in either case incomplete information,
> but at least with "(e" (or even "(") you might get a clue that it
> errornous conditions.

The thing I'm signaling here is that in some cases we still can
crash the kernel; with the difference that invalid dereference
can now be a memory corruption. Just saying.

	-ss
