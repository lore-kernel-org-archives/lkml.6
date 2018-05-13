Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeEMTzw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:55:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeEMTzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:55:51 -0400
Date: Sun, 13 May 2018 21:55:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
cc: Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH -tip 2/4] kprobes: Remove jprobe generic code
In-Reply-To: <152578664349.31022.13591383815605124106.stgit@devbox>
Message-ID: <alpine.DEB.2.21.1805132154220.1582@nanos.tec.linutronix.de>
References: <152578658468.31022.8952561651556318637.stgit@devbox> <152578664349.31022.13591383815605124106.stgit@devbox>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2018, Masami Hiramatsu wrote:

> Remove jprobe arch independent generic code
> from kernel/kprobes.c.

# git grep register_jprobes
include/linux/kprobes.h:static inline int register_jprobes(struct jprobe **jps, int num)
include/linux/kprobes.h:static inline void unregister_jprobes(struct jprobe **jps, int num)
kernel/test_kprobes.c:  ret = register_jprobes(jps, 2);
kernel/test_kprobes.c:          pr_err("register_jprobes returned %d\n", ret);
kernel/test_kprobes.c:  unregister_jprobes(jps, 2);

You forgot to remove a few things ...

Thanks,

	tglx
