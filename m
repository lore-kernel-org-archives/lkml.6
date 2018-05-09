Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935205AbeEINCA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934897AbeEINB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:01:59 -0400
Date: Wed, 9 May 2018 22:01:54 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 0/2] uprobes: kprobes: x86: Reject probing MOV SS/POP SS
Message-Id: <20180509220154.b6186fb0c3a8d9a9189f5dfe@kernel.org>
In-Reply-To: <152587066475.17316.3035446966107675608.stgit@devbox>
References: <152587066475.17316.3035446966107675608.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I missed adding kprobes: and POP SS on subject...
	

On Wed,  9 May 2018 21:57:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> I found the CVE-2018-1087 and CVE-2018-8897 should
> be related to kprobes and uprobes too, since both
> are using #DB for single stepping.
> 
> I decided to just reject probes on MOV SS and POP SS
> because those are not recommended to use (Intel SDM
> recommend to use LSS instead), thus it might be
> rare case.
>
> Oleg, could you review the uprobes patch?
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       kprobes: x86: Prohibit probing on exception masking instructions
>       uprobes: x86: Prohibit probing on MOV SS instruction
> 
> 
>  arch/x86/include/asm/insn.h    |   18 ++++++++++++++++++
>  arch/x86/kernel/kprobes/core.c |    4 ++++
>  arch/x86/kernel/uprobes.c      |    4 ++++
>  3 files changed, 26 insertions(+)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
