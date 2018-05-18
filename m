Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeERGXt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:23:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38063 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:23:47 -0400
X-Google-Smtp-Source: AB8JxZrKsTQJHMmBqpbCwXdvviam3FeM/gyRQm6hm3mPYLLmflqfGnpg46/l3NgaivakPbJQXQdOEA==
Date: Fri, 18 May 2018 08:23:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v3 0/7] kprobes: x86: Cleanup jprobe implementation
 on x86
Message-ID: <20180518062343.GC27960@gmail.com>
References: <152651499561.25583.14488389770693278906.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152651499561.25583.14488389770693278906.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

>       x86: kprobes: Remove jprobe implementation
>       x86: kprobes: Ignore break_handler
>       x86: kprobes: Do not disable preempt on int3 path

So this is another annoyance. Do you ever compare the changelogs and titles you 
write with the ones I actually commit? They are almost never the same, for example 
the titles to x86 level kprobes code are always trying to use this kind of prefix:

b664d57f39d0: kprobes/x86: Remove IRQ disabling from jprobe handlers
ee213fc72fd6: kprobes/x86: Set up frame pointer in kprobe trampoline
a19b2e3d7839: kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes
5bb4fc2d8641: kprobes/x86: Disable preemption in ftrace-based jprobes
9a09f261a4fa: kprobes/x86: Disable preemption in optprobe
cd52edad55fb: kprobes/x86: Move the get_kprobe_ctlblk() into irq-disabled block
a8976fc84b64: kprobes/x86: Remove addressof() operators

Not "x86: kprobes:" which is the wrong order anyway...

Could you please be more careful about all this in the future?

Thanks,

	Ingo
