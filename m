Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCWVde (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:33:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeCWVdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:33:31 -0400
Date: Fri, 23 Mar 2018 22:33:29 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
In-Reply-To: <20180323172843.763579a9@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1803232232410.1481@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de> <20180323172843.763579a9@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Steven Rostedt wrote:

> On Fri, 23 Mar 2018 22:12:24 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > synchronize_rcu() lacks a might_sleep() check which would have caught that
> > issue way earlier because it would trigger with the minimal debug options
> > enabled.
> > 
> > Add a might_sleep() check to catch such cases.
> 
> I'm not against the patch, but really? I would think that
> synchronize_rcu() would pretty much always schedule, and scheduling
> from atomic would have triggered with minimal debug options enabled.

Dunno. The reported splat is here:

       https://pastebin.com/raw/puvh0cXE
