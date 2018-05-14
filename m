Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeENADm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeENADl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:03:41 -0400
Date: Mon, 14 May 2018 09:03:36 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH -tip 2/4] kprobes: Remove jprobe generic code
Message-Id: <20180514090336.e6f3ec9e750cc14faf38714c@kernel.org>
In-Reply-To: <alpine.DEB.2.21.1805132154220.1582@nanos.tec.linutronix.de>
References: <152578658468.31022.8952561651556318637.stgit@devbox>
        <152578664349.31022.13591383815605124106.stgit@devbox>
        <alpine.DEB.2.21.1805132154220.1582@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018 21:55:38 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 8 May 2018, Masami Hiramatsu wrote:
> 
> > Remove jprobe arch independent generic code
> > from kernel/kprobes.c.
> 
> # git grep register_jprobes
> include/linux/kprobes.h:static inline int register_jprobes(struct jprobe **jps, int num)
> include/linux/kprobes.h:static inline void unregister_jprobes(struct jprobe **jps, int num)
> kernel/test_kprobes.c:  ret = register_jprobes(jps, 2);
> kernel/test_kprobes.c:          pr_err("register_jprobes returned %d\n", ret);
> kernel/test_kprobes.c:  unregister_jprobes(jps, 2);
> 
> You forgot to remove a few things ...

Ah, thoes are already disabled (with #if 0) but it is better to remove it first.

Thanks!

> 
> Thanks,
> 
> 	tglx


-- 
Masami Hiramatsu <mhiramat@kernel.org>
