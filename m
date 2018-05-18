Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERG0o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:26:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44212 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeERG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:26:42 -0400
X-Google-Smtp-Source: AB8JxZpFKdBBiTgBnM9xiocq+Dqb+HwW4c/K6qMOXW5vOASg4mDtUk0cJ/XBxu9Edz/Fa/kkOdr8AQ==
Date: Fri, 18 May 2018 08:26:38 +0200
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
Subject: Re: [PATCH -tip v3 5/7] x86: kprobes: Ignore break_handler
Message-ID: <20180518062638.GD27960@gmail.com>
References: <152651499561.25583.14488389770693278906.stgit@devbox>
 <152651514451.25583.15475048007255467863.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152651514451.25583.15475048007255467863.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Remove break_handler related code since that was used
> only for jprobe and jprobe is removed now.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/kprobes/common.h |   10 ----------
>  arch/x86/kernel/kprobes/core.c   |   13 ++-----------
>  arch/x86/kernel/kprobes/ftrace.c |   16 ++--------------
>  3 files changed, 4 insertions(+), 35 deletions(-)

Even after this change there's a stale reference to ->break_handler():

  arch/x86/include/asm/kprobes.h:  * a post_handler or break_handler).

Please use 'git grep'!

Also, there's no reason to send an incomplete series: please remove _all_ 
->break_handler() references so that it's 100% gone! The pain of having and not 
having ->break_handler() is completely unnecessary.

Thanks,

	Ingo
