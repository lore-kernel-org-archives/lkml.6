Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCWV2s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbeCWV2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:28:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A280A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 17:28:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
Message-ID: <20180323172843.763579a9@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 22:12:24 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> synchronize_rcu() lacks a might_sleep() check which would have caught that
> issue way earlier because it would trigger with the minimal debug options
> enabled.
> 
> Add a might_sleep() check to catch such cases.

I'm not against the patch, but really? I would think that
synchronize_rcu() would pretty much always schedule, and scheduling
from atomic would have triggered with minimal debug options enabled.

-- Steve
