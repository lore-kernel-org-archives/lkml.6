Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeBLReg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbeBLRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:34:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69F21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Feb 2018 12:34:30 -0500
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
Message-ID: <20180212123430.6f8e4d6e@gandalf.local.home>
In-Reply-To: <20180212134030.12846-2-juri.lelli@redhat.com>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
        <20180212134030.12846-2-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 14:40:28 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:

> + *  - dl_bw (< 100%) is the bandwidth of the system (domain) on each CPU;
> + *  - dl_total_bw array contains the currently allocated bandwidth on the
> + *    i-eth CPU.

The comment for dl_total_bw doesn't make sense. You mean that
dl_total_bw is the cpu's bandwidth? If so, let's not call it total,
because that would suggest it's the bandwidth of all CPUs. What about
dl_cpu_bw?

-- Steve
