Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F001C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD8B2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3MI8N2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBLC6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:58:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38448 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLC6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:58:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so551492pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 18:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruZ6nZoB212cQk8ZfpnwXmAZDwAfXgtClZLmFa6dIfM=;
        b=O3MI8N2yj/0qabQgDjWj/Qg9jgQ9sOpOzQPFRhRIEPcnXq817beEOedYGW+lKPBB2T
         spEzAPcU/BtKYYW9vs6sF7JA+6wt897fo07Nfhfj/YD43mSWMiwTXkIKAcIjirYvGs5G
         JRjo3RK3OWywmuC5JcTL4+gFSgyfmXhIOsRDYT6rLIeY0rInHTRxvzVExwHdQryziXyU
         TCr4fhguvhOjgpbLUDaytxOpXv//m2YAhD992pdtlXNTgGQSiWDWGc4gZ/tsDAr+t6/1
         5QWMozh8yKbAlyMSNZmqOxvXgcuJ4NKtJ7419R0KhRfJqgGG0gx2ZGp75zKFky+vtGTr
         tXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruZ6nZoB212cQk8ZfpnwXmAZDwAfXgtClZLmFa6dIfM=;
        b=jkCq0GILcxTL3Ra3QsUYEokGIAFaJsdPsPH5mGG415r7tyKn3gh52CbZYECsfpU0Qv
         3bWvH0K9hFUfZAmz/b1qqozveY5dU2D2lpP+SaPi8swrq6sqbrQK0xD7qVSKlLCrCo7g
         5g4BGiGV2VNIvnlpUmcX/ip3M+dlgeBYVi01FjtEOPFZJcvFvonec3C75YcOqSkEMdpi
         sRpsxFNlEULExxmiPVxGIuX/xUWUks+Xkytyf7igVUJ9XpAwPADEY3FcrZ2NsdDxJSsA
         kH+X/qOJ4XttEO5N2aerlv6rwoSoEoQXPPvAZOh8FoQrOpWdP1zuxKg/j2bfc7P+UwTB
         dNdA==
X-Gm-Message-State: AHQUAual+gIm0uYgZmrbvB9Oh9e4ymQ6f154q3fyLUdZTqOQa+f4WKCz
        Rkjs+0PhkIUv7qsWaxjsjj4=
X-Google-Smtp-Source: AHgI3IYJ6kyryIf9jruhXLgIMNjfidEYxFeTT38/oVLJbWVJPRY3HHGZIQt9UwXEX9z0BxmMQUwRAw==
X-Received: by 2002:a63:4d:: with SMTP id 74mr1562050pga.248.1549940302208;
        Mon, 11 Feb 2019 18:58:22 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u8sm21610218pfl.16.2019.02.11.18.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 18:58:21 -0800 (PST)
Date:   Tue, 12 Feb 2019 02:58:20 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: print function names instead of just address
Message-ID: <20190212025819.tremtds3coufd5ga@mail.google.com>
References: <20190209161919.32350-1-changbin.du@gmail.com>
 <20190211145532.75d82308@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211145532.75d82308@gandalf.local.home>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:55:32PM -0500, Steven Rostedt wrote:
> On Sun, 10 Feb 2019 00:19:19 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Here is an example for this change.
> > 
> > $ sudo perf record -e 'ftrace:function' --filter='ip==schedule'
> > $ sudo perf report
> 
> I took this but changed the subject as it only affects perf (the kernel
> doesn't use the format field for output, and trace-cmd has an internal
> plugin that overrides it too).
>
Thanks. You explained why I can't find the usage for the other entries.
I was looking for it before... :)

> -- Steve
> 
> > 
> > The output of perf before this patch:
> > 
> > \# Samples: 100  of event 'ftrace:function'
> > \# Event count (approx.): 100
> > \#
> > \# Overhead  Trace output
> > \# ........  ......................................
> > \#
> >     51.00%   ffffffff81f6aaa0 <-- ffffffff81158e8d
> >     29.00%   ffffffff81f6aaa0 <-- ffffffff8116ccb2
> >      8.00%   ffffffff81f6aaa0 <-- ffffffff81f6f2ed
> >      4.00%   ffffffff81f6aaa0 <-- ffffffff811628db
> >      4.00%   ffffffff81f6aaa0 <-- ffffffff81f6ec5b
> >      2.00%   ffffffff81f6aaa0 <-- ffffffff81f6f21a
> >      1.00%   ffffffff81f6aaa0 <-- ffffffff811b04af
> >      1.00%   ffffffff81f6aaa0 <-- ffffffff8143ce17
> > 
> > After this patch:
> > 
> > \# Samples: 36  of event 'ftrace:function'
> > \# Event count (approx.): 36
> > \#
> > \# Overhead  Trace output
> > \# ........  ............................................
> > \#
> >     38.89%   schedule <-- schedule_hrtimeout_range_clock
> >     27.78%   schedule <-- worker_thread
> >     13.89%   schedule <-- schedule_timeout
> >     11.11%   schedule <-- smpboot_thread_fn
> >      5.56%   schedule <-- rcu_gp_kthread
> >      2.78%   schedule <-- exit_to_usermode_loop
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  kernel/trace/trace_entries.h | 41 +++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 22 deletions(-)
> > 
> > 

-- 
Cheers,
Changbin Du
