Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeCZP7I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbeCZP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:59:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EA62172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 11:59:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: joe.korty@concurrent-rt.com
Cc: Julia Cartwright <julia@ni.com>, <bigeasy@linutronix.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Message-ID: <20180326115904.492a3bad@gandalf.local.home>
In-Reply-To: <20180326155451.GA16545@zipoli.concurrent-rt.com>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
        <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
        <20180323172131.GA2670@zipoli.concurrent-rt.com>
        <20180326113515.720e7fb3@gandalf.local.home>
        <20180326155451.GA16545@zipoli.concurrent-rt.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 11:54:51 -0400
joe.korty@concurrent-rt.com wrote:

> Oh well.  Makes me wonder why might_sleep is testing for
> !TASK_RUNNABLE though.

Because might_sleep() is used when the function might call schedule()
directly. And schedule() *will* change the task state to TASK_RUNNING.
might_sleep() has nothing to do with preemption.

-- Steve
