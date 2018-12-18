Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC74C21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwv4a3zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeLRO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:56:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46070 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeLRO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:56:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so8228771pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8gnshy4dGyK1gbESzmeHTl5eK9cjXYiVhR5tCRSYfo=;
        b=qwv4a3zph87D4yDvKUapEMKizbTbJidFPnB49VZgcLicX2mt2NlMxRMzGlI7WqEVN8
         QhzoGsbu0jW78zgXve3+j0B4IflNI5deqnzeZ6kCrlsBPbxDeaQ8XKs3v1jQeRkrL/L+
         +GW9KukzY4Dj/T/E1cbFSmT9w5+AdnDYSt5VjBNl5PCSPyjicW+4mKp8Bagmnk6u7XEc
         ieDGVBqoP/ZD0fPAdwlm82Lnq1BeGgOBszMEXXEGMf1B3lppt9z4mbEQreo6FV/ZzI18
         PKyzwxVnpO9eX1xvVhDPdxlxJqtRqY108jNILPB4HAjwDYiw5H2FTi3D1K6mEWjSHL/I
         JquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8gnshy4dGyK1gbESzmeHTl5eK9cjXYiVhR5tCRSYfo=;
        b=JxaNeyVFUFZmJv7KIiWjkHRkNxccF9ev/zLX/I1nFWpeWwE31CEFjIH8P2QM3NHxpR
         4ELc8OP1fEJEbETiPk9JPOfZBlVViWPaJLlWGH9SNA/T7tPLt9KjBHI1+hqMcsbpNiBJ
         pJD9ZH6DZCyL/2Q2I6BDDjmjF5XHhJAI7Jae2LeMEHNwQd7n8Y0Hzlyi1kknRsHQQD+q
         NxZFzPc2Y8eFIvBM209XGQOVxI4aQXscvYdK0EWyrtIbjJW4aedmveCXPRGAtNfON/KF
         0wZtxt4H0XRLqD47AbfH+0C1kiWYEyJyT0v8RACoweiUfl0qJ8jRZ42qmtePREh90D1i
         pLUw==
X-Gm-Message-State: AA+aEWbnvSRrAShHtz6cN7yPwkV75zMUrrLXq0C86L1udc8xEQBY+e/u
        YbBzirs8Nqqx9CreabNGksY=
X-Google-Smtp-Source: AFSGD/WyNM1wYKLqAnydXyz06msDCqXik8NNA3spQDJ/KvTTUqWCT2mXA6zr5H4E2gZRawUuZ11hEw==
X-Received: by 2002:a62:3241:: with SMTP id y62mr16818764pfy.178.1545144962006;
        Tue, 18 Dec 2018 06:56:02 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g11sm21003856pfo.139.2018.12.18.06.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:56:00 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 18 Dec 2018 23:55:58 +0900
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218145558.GD665@tigerII.localdomain>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218142623.GH7485@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 15:26), Borislav Petkov wrote:
> On Tue, Dec 18, 2018 at 10:07:50PM +0900, Sergey Senozhatsky wrote:
> > This is right before shutdown. dmesg is not really available anymore.
> > I can only guess why do they write it to devkmsg - to make it appear
> > on the serial/net console, perhaps. Dunno.
> 
> But still, why do we want to see those messages and enlarge the
> ratelimit for that? Do they contain any particularly important
> information?

Good question. Theoretically, there can be some interesting stuff.
Examples: https://bugzilla.redhat.com/show_bug.cgi?id=1515373#c6
or        https://github.com/systemd/systemd/issues/5433

	-ss
