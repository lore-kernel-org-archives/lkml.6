Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeDWPt2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:49:28 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52364 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbeDWPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:49:18 -0400
X-Google-Smtp-Source: AIpwx48SzmFp1wNuiL3CXmBox/tGTfaonRz6t+iMW2Ke5ALfnoJOJUXWqb2vfTaj7U0Mlgf+8E3j/ksUQWNcGEQMOgs=
MIME-Version: 1.0
In-Reply-To: <20180423105325.7d5d245b@gandalf.local.home>
References: <20180417040748.212236-1-joelaf@google.com> <20180417040748.212236-4-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org> <20180419054302.GD13370@sejong>
 <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
 <20180423031926.GF26088@linux.vnet.ibm.com> <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
 <20180423105325.7d5d245b@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 23 Apr 2018 08:49:16 -0700
Message-ID: <CAJWu+oqVo54cMN6-wZk8D1=Uq-wx3-RMTjg1g6txkS15YQSZVw@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 23, 2018 at 7:53 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 23 Apr 2018 10:31:28 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
[..]
>> I would be tempted to proceed carefully and introduce a new kind of SRCU
>> tracepoint rather than changing all existing ones from sched-rcu to SRCU
>> though.
>
> Agreed.
>
>>
>> So the lockdep stuff could use the SRCU tracepoint flavor, which I guess
>> would be faster than the rcu_irq_enter_*().
>
> Also agree.

I also agree about careful proceeding with separate SRCU flavor and
using that for few places first. Perhaps, if it works well once we can
benchmark it then we can slowly convert the _rcuidle API users to
this, since it seems from my testing those will benefit the most.

thanks,

- Joel
