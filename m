Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757713AbeD0SLv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:11:51 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35814 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbeD0SLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:11:49 -0400
X-Google-Smtp-Source: AB8JxZrT9SI1FM1EtYvgZ5V4T+CFAQuzt2vDvrDGOYXDoLY+XrhTRM4ErmiqRQ0qqVRWo5K/zO5Hq4pGCnEwGYz74oc=
MIME-Version: 1.0
In-Reply-To: <20180427123759.0bc4b8de@gandalf.local.home>
References: <20180427042656.190746-1-joelaf@google.com> <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
 <20180427104747.2d965925@gandalf.local.home> <CAJWu+ortS=BQ98BSmExHPz_vQ6-rgcKQC7dhSR2_3e6714QVzA@mail.gmail.com>
 <20180427123759.0bc4b8de@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 27 Apr 2018 11:11:47 -0700
Message-ID: <CAJWu+ore5pOF9Ld7H2K=Y4JZiRvy8T86MA+dN8-8BTHPCsau1w@mail.gmail.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        fweisbec <fweisbec@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 9:37 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 27 Apr 2018 09:30:05 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> On Fri, Apr 27, 2018 at 7:47 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >
>> >> The general approach and the implementation look fine, except for
>> >> one small detail: I would be tempted to explicitly disable preemption
>> >> around the call to the tracepoint callback for the rcuidle variant,
>> >> unless we plan to audit every tracer right away to remove any assumption
>> >> that preemption is disabled in the callback implementation.
>> >
>> > I'm thinking that we do that audit. There shouldn't be many instances
>> > of it. I like the idea that a tracepoint callback gets called with
>> > preemption enabled.
>>
>> Here is the list of all callers of the _rcuidle :
>
> I was thinking of auditing who registers callbacks to any tracepoints.

Ok. If you feel strongly about this, I think for now I could also just
wrap the callback execution with preempt_disable_notrace. And, when/if
we get to doing the blocking callbacks work, we can considering
keeping preempts on.

thanks,

- Joel
