Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936812AbeCSWnl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:43:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36206 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936802AbeCSWnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:43:37 -0400
X-Google-Smtp-Source: AG47ELsQXVUeaXhpCiI8MlE+Ri6zcFIUhPB7lkV7jio8DipoJdcqr9l/vMxVA7UmCB2kj6yb5kmSZg==
Date: Tue, 20 Mar 2018 09:43:20 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  2/2] powerpc/mm: Trace tlbia instruction
Message-ID: <20180320094320.03ae264d@balbir.ozlabs.ibm.com>
In-Reply-To: <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
        <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018 11:32:40 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Add a trace point for tlbia (Translation Lookaside Buffer Invalidate
> All) instruction.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/trace.h | 15 +++++++++++++++
>  arch/powerpc/mm/mmu_decl.h       |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
> index 33f3b479138b..d1d63b173dd7 100644
> --- a/arch/powerpc/include/asm/trace.h
> +++ b/arch/powerpc/include/asm/trace.h
> @@ -202,6 +202,21 @@ TRACE_EVENT(tlbie,
>  		__entry->r)
>  );
>  
> +TRACE_EVENT(tlbia,
> +
> +	TP_PROTO(unsigned long lpid),
> +	TP_ARGS(lpid),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, lpid)
> +		),
> +
> +	TP_fast_assign(
> +		__entry->lpid = lpid;
> +		),
> +
> +	TP_printk("lpid=%ld", __entry->lpid)
> +);


Do we want to call this lpid?

Balbir Singh.
