Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeEROOg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeEROOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:14:32 -0400
Date: Fri, 18 May 2018 23:14:28 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v3 4/7] kprobes: Ignore break_handler
Message-Id: <20180518231428.e11eac5fe4d825b3ece37590@kernel.org>
In-Reply-To: <20180518062034.GB27960@gmail.com>
References: <152651499561.25583.14488389770693278906.stgit@devbox>
        <152651511510.25583.17622383189254834099.stgit@devbox>
        <20180518062034.GB27960@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 08:20:34 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Ignore break_handler related code because it was only
> > used by jprobe and jprobe is removed.
> 
> I changed this description to:
> 
>  ============
>  Subject: kprobes: Don't call the ->break_handler() in generic kprobes code
> 
>  Don't call the ->break_handler() from the core kprobes code, because it was only 
>  used by jprobes which got removed.
> 
>  ( In a followup patch we'll remove the remaining calls in low level 
>    arch handlers as well and remove the callback altogether. )
>  ============
> 
> Please try to be a lot less vague in changelogs when it's possible and relevant!
> 
> I.e. saying "Ignore break_handler related code" is annoyingly vague, it doesn't 
> explain things well at all. Saying "Don't call the ->break_handler()" is just as 
> compact, yet it also makes it very clear what's done in the patch...

OK, I'll try to describe more concretely and straightforwardly.

Thank you for telling me your advice!!

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
