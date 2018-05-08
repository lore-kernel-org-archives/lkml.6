Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeEHNLq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeEHNLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:11:44 -0400
Date: Tue, 8 May 2018 09:11:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Greentime Hu <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: Re: [PATCH] riscv/ftrace: Fix the problem modules cannot find
 _mcount
Message-ID: <20180508091142.12b5231a@gandalf.local.home>
In-Reply-To: <1525749717-384-1-git-send-email-alankao@andestech.com>
References: <1525749717-384-1-git-send-email-alankao@andestech.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2018 11:21:57 +0800
Alan Kao <alankao@andestech.com> wrote:

> Enabling ftrace and module support at the same time fails the kernel
> build process, because modules cannot find the _mcount symbol.  This
> patch fixes this issue.

I think you have a much bigger issue.

> 
> Signed-off-by: Alan Kao <alankao@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/kernel/mcount.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
> index ce9bdc57a2a1..5721624886a1 100644
> --- a/arch/riscv/kernel/mcount.S
> +++ b/arch/riscv/kernel/mcount.S
> @@ -126,5 +126,5 @@ do_trace:
>  	RESTORE_ABI_STATE
>  	ret
>  ENDPROC(_mcount)
> -EXPORT_SYMBOL(_mcount)
>  #endif
> +EXPORT_SYMBOL(_mcount)

How does this work? How do you export _mcount if _mcount isn't even
defined?

-- Steve
