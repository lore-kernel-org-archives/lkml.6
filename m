Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeC3Ohl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbeC3Ohk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:37:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93399217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 30 Mar 2018 10:37:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] trace: Default to using trace_global_clock if
 sched_clock is unstable
Message-ID: <20180330103738.7f8a959b@gandalf.local.home>
In-Reply-To: <152241887306.28244.3237898674442763768@mail.alporthouse.com>
References: <20180329222557.6274-1-chris@chris-wilson.co.uk>
        <20180330094845.068a9a81@gandalf.local.home>
        <152241887306.28244.3237898674442763768@mail.alporthouse.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 15:07:53 +0100
Chris Wilson <chris@chris-wilson.co.uk> wrote:


> Sure, I was mainly floating the idea of trying to pick sensible
> defaults. Unstable clocks are quite rare nowadays, the ones we have in
> the lab are a pair of Core2 Duo.

I still have a box too ;-)

I'm not so against having global_clock become default if the TSC is
unstable. But there needs to be a printk warning (not a WARN, but
something like: 

 Warning: TSC unstable, switching tracing_clock default to "global"
 If you want to keep local, then add "trace_clock=local" on the
  kernel command line.

-- Steve
