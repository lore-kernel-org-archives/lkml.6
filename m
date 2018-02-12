Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeBLSCp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752736AbeBLSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:02:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F8F21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Feb 2018 13:02:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, vincent.guittot@linaro.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com
Subject: Re: [RFC PATCH 1/3] sched/deadline: merge dl_bw into dl_bandwidth
Message-ID: <20180212130239.506cbce9@gandalf.local.home>
In-Reply-To: <20180212174312.GN12979@localhost.localdomain>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
        <20180212134030.12846-2-juri.lelli@redhat.com>
        <20180212123430.6f8e4d6e@gandalf.local.home>
        <20180212174312.GN12979@localhost.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 18:43:12 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:

> However, this surely needs to be fixed here. It's tracking the sum of
> all tasks' (across CPUs) bandwidth admitted on the system, so that's why
> it's called dl_total_bw. Incremented when a task passes sched_setattr()
> and decremented when it leaves the system or changes scheduling class.
> 
> Does it make a bit more sense? Would you still prefer a different name?

No the name is fine, the comment needs to change.

 - dl_total_bw - tracks the sum of all tasks' bandwidth across CPUs.

How's that?

-- Steve
