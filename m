Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521177519; cv=none;
        d=google.com; s=arc-20160816;
        b=yC3p3AVMcrh/A4IGUmvBmHjPEHngqkdXdPZzBcIbzewQa78JNJ5k3QeFiy1y0xresM
         A34o1HOTlUdDXFyt7XjyRwwjSYxvukt4Sg/OHASNVYoc7YQiDazPLug9+KcqoxEAsq7L
         QjIuDn+7g+ZUZ8l5A2Yqkmm3Vq7soPUfAX6ZN2e0HtDb+KTs3IFG0Ad15DkOJZ44O5R6
         9uAW7mIZxQq5QzLPnRhJGqaPQE3u+wrL+tgaP/F9rIUTBFt9Gxr0uYZ2d9W1cXTg4a7e
         m59X18UpoaCz2+edOm7mv1KZ/cgh37Zgoyokko5VQHiqGYZK/rJq9uVpAA5aEfJ8sNS5
         dztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=cHenr9AUA0PPmScRH3/JvSRgnmIJAmINdRc1wTO85Lw=;
        b=RnFRy1OnOmhgKhzmY9rwsObKT6wFq4wKZB4NpxgBLQJd5M8yEw1RIeryWZ5Sr2t5vW
         6YvKvsTjXjguYH0a93ZyfIIFu4AkHuULkcKt2rxCoVO2+xpYIRJWhQ5PoVwNjO8rWlNB
         ypSzwBfumB/xjb4QtgpaPVdpEkuWoT8HwfdJK+YupgBZiIEtQy1JzTrutFjtrNuQ3aba
         nnQWlXUhVf24TJxOQ9z9W0gIuP6xZSPi7RPF91YKGTS/OJz4Di57lOn7e+jjpvA4F7Au
         GbQUbhnaGzdLauPR1ui5xWHZ17KTDscTM+AEdmgO2kw5ODUZAKanLPPohYi/+W2GBug8
         VWQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EK+9dIpG;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EK+9dIpG;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuGVo9AaBiZZ87s8TRHV4m7J3nVZRZrAVTL10QgORHmtinbQSfJV+/r4fQgKqONlrccNJ0m3g==
Date: Fri, 16 Mar 2018 15:18:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Kate Stewart
 <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael
 Neuling <mikey@neuling.org>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>, Al Viro
 <viro@zeniv.linux.org.uk>, David Gibson <david@gibson.dropbear.id.au>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, =?UTF-8?B?Q8OpZHJpYw==?=
 Le Goater <clg@kaod.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew
 Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
 <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Tobin C.
 Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in
 syscall entry
Message-ID: <20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
In-Reply-To: <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
	<cover.1521141122.git.msuchanek@suse.de>
	<b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347539334628?=
X-GMAIL-MSGID: =?utf-8?q?1595070238542521721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 20:15:52 +0100
Michal Suchanek <msuchanek@suse.de> wrote:

> On powerpc syscall entry is done in assembly so patch in an explicit
> barrier_nospec.

Same comment as Linus for this -- the barriers are before the branch here,
so is it possible the branch instruction can be speculative while the index
is used to load the syscall table?

Thanks,
Nick

> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/powerpc/kernel/entry_64.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 2cb5109a7ea3..7bfc4cf48af2 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -36,6 +36,7 @@
>  #include <asm/context_tracking.h>
>  #include <asm/tm.h>
>  #include <asm/ppc-opcode.h>
> +#include <asm/barrier.h>
>  #include <asm/export.h>
>  #ifdef CONFIG_PPC_BOOK3S
>  #include <asm/exception-64s.h>
> @@ -159,6 +160,7 @@ system_call:			/* label this so stack traces look sane */
>  	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
>  	bne	.Lsyscall_dotrace		/* does not return */
>  	cmpldi	0,r0,NR_syscalls
> +	barrier_nospec
>  	bge-	.Lsyscall_enosys
>  
>  .Lsyscall:
> @@ -319,6 +321,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	ld	r10,TI_FLAGS(r10)
>  
>  	cmpldi	r0,NR_syscalls
> +	barrier_nospec
>  	blt+	.Lsyscall
>  
>  	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
