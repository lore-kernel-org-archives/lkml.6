Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 13:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C6218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4YV/DlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfAANhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 08:37:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37480 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfAANhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 08:37:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so25751049wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjUVU2ybTR2Rlq9XWQP5P5Fy5OxBSiBv/vBqRVVSl3I=;
        b=r4YV/DlXuN5dNGpX9jyYSFH9HiqJQTA8W17YZx4xI5wJDdROtoLd29q5++LKdJUjMR
         YC7+vvc2WkCcKrddU1V0m0uqSNAeRI98lIqrOdc9JpLn6aGicpC8OJTm25PYgR12QhbJ
         Sn2PqNgi/Oc+ewMHcwXXPybHbggbXbKIkk+lnKbHJul9r0gTsq9RMo0sbtCp8/tolYuH
         IH/c5XTwK2uHlzamYBB12NJNwyx/6/mTsaQkie3ZaJVM27gs94Em/QFSklCjjbumd9Fu
         pSp8hE0GVvL2xfLz4brrzedvJwXxUM87ss67gNWrICMGFAcLfYzXJ6X6C613YDCkPkaw
         ADbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjUVU2ybTR2Rlq9XWQP5P5Fy5OxBSiBv/vBqRVVSl3I=;
        b=AFkDNsEq7skoWoVOQ068iz97IFG81VslrdryF9+vyz5U0PkTx7X0aAgpMe5rrfqA9a
         Ri6rAhT6axeN87ffAXw8u7s6tJLxOs+PrzpwDrf6s8//dE8lHekdj75AB429efg/jgdj
         9Sdkl3R6msiFUKMAcIgCpkrgpdhjJJnebydyVYT770re84ueNi4nZxf+Z+QvEawU/f2n
         zb7iAiI+3U4bjCKVk0kwO1CahSsJOxjIadP52+iV3srJpEIk7Z79mDCz1JVOwauKQucJ
         JbxPpP+ASJICXDsrfx+orCVCg5+Ee4cHcKXwEgD7vgssjHfOaf28Yly65DPQ8FnLN5EC
         qotw==
X-Gm-Message-State: AA+aEWYiYpvjLG/UiIevyiR3WA8uBaM8Hx2e4ntdyDzLDRw43C0Ity5H
        ekdugTOEJDHzbL2x2D9SCw==
X-Google-Smtp-Source: ALg8bN6JjG0LmNl6rJRbanTk+vZ2juYD1+xjDW5RQi73cKONkFOHzl/DRQpi81wlrenRHJ8U7qMC4g==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr32331791wma.76.1546349838701;
        Tue, 01 Jan 2019 05:37:18 -0800 (PST)
Received: from localhost (host254-25-dynamic.53-79-r.retail.telecomitalia.it. [79.53.25.254])
        by smtp.gmail.com with ESMTPSA id a12sm42442754wro.18.2019.01.01.05.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Jan 2019 05:37:17 -0800 (PST)
Date:   Tue, 1 Jan 2019 14:37:16 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86: kprobes: Show correct blaclkist in debugfs
Message-ID: <20190101133716.GA1811@xps-13>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
 <20181217154713.GA1308@Dell>
 <20181218135026.6f96a89247e9b70fa45afbe9@kernel.org>
 <20181218172134.GA2902@xps-13>
 <20181227170934.GA2057@xps-13>
 <20190101221654.fedda794776540d6b81f6167@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190101221654.fedda794776540d6b81f6167@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 10:16:54PM +0900, Masami Hiramatsu wrote:
...
> > > > > Do you see a nice and clean way to blacklist all these functions
> > > > > (something like arch_populate_kprobe_blacklist()), or should we just
> > > > > flag all of them explicitly with NOKPROBE_SYMBOL()?
> > > > 
> > > > As I pointed, you can probe it via your own kprobe module. Like systemtap,
> > > > you still can probe it. The blacklist is for "kprobes", not for "kprobe_events".
> > > > (Those are used to same, but since the above commit, those are different now)
> > > > 
> > > > I think the most sane solution is, identifying which (combination of) functions
> > > > in ftrace (kernel/trace/*) causes a problem, marking those NOKPROBE_SYMBOL() and
> > > > removing CONFIG_KPROBE_EVENTS_ON_NOTRACE.
> > 
> > I'm planning to spend a little bit more time on this and see if I can
> > identify the problematic ftrace functions and eventually drop
> > CONFIG_KPROBE_EVENTS_ON_NOTRACE, following the sane solution.
> > 
> > However, in the meantime, with the following patch I've been able to get
> > a more reliable kprobes blacklist and show also the notrace functions in
> > debugfs when CONFIG_KPROBE_EVENTS_ON_NOTRACE is off.
> 
> Hmm, if CONFIG_KPROBE_EVENTS_ON_NOTRACE=n, we already have a whitelist of
> functions in /sys/kernel/debug/tracing/available_filter_functions,
> so I don't think we need a blacklist.

OK.

> 
> > It's probably ugly and inefficient, because it's iterating over all
> > symbols in x86's arch_populate_kprobe_blacklist(), but it seems to work
> > for my specific use case, so I thought it shouldn't be bad to share it,
> > just in case (maybe someone else is also interested).
> 
> Hmm, but in that case, it limits other native kprobes users like systemtap
> to disable probing on notrace functions with no reasons. That may not be acceptable.

True...

> 
> OK, I'll retry to find which notrace function combination tracing with
> kprobes are problematic. Let me do it...

OK. Thanks tons for looking into this!

-Andrea
