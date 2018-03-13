Return-Path: <kernel-hardening-return-12513-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELutctlntSUBcCXVm3uZDBEXWzTM/K88Y+h5XxVcasTrr1n5NRq5KxqiU7liC6H+bGepXFIx
ARC-Seal: i=1; a=rsa-sha256; t=1520966166; cv=none;
        d=google.com; s=arc-20160816;
        b=L2igzAbBc5E1GpHlaRWhKWd/37nNcbkEAvhIbkDiyxmQZ8pIGCuD5Ee9AGn28Z91ae
         gYd7CUKJwe8PQDa5HNm+J+reLBMU/7AjxfYqmmeajZyjg2bXSJehY8QZJsSPy5TxaiXg
         6/ByGuBUlZ1XNQS55qHlEW+2WuyZAWu1wSUsFGvnovcPU49WXmjZXloEIWsw6XvjZuuA
         cRzLuso+UpklaUklZ3da+qZ3WbnjMZu8MTfC0aUPyjDAvc0iHoBFbPOMEa/78prq9FJK
         QTVa1VuzAJRRg3NxNiaCKgsxp2Fm3tYxrxP2e6CMWrGrZdia1SwJvM0w6dhCcm1KKg1C
         YHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=DWWMlZYO5QLmnXX+gDp56seHKi28oyjj1YBM3lD1/7M=;
        b=ifXXWJ71tyRpIjvB4qET+7PhpUKBxAYFoNUFKzEUwvzfTvt6lq/SLc6uye8vQaY7ZI
         /0EoYx/ZlG4iqq/vLRoK0HOAlzy3iTQoOQHvAViht4THcVUY+38jp7bLHorZkW/5DLqX
         7D+C2Zpf+NLcRqChAO7IVa+vgiFWoDrUTwoyz0bAf0TvaIrx6NIX5TV6tP61maQzdsrd
         c43OP2t4Uc7jw3mdN/CnfCO0o/o1F81uMzbBKr0+3zpRQWVFKryBhzWnH7ox1650cGdO
         JS5j5HiRQ5yrl1CV74PowDvxnsR8Ykcozl/zq/So7V2Ot6eJ3QyspTxL2BDPI4dxR5++
         d4IQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12513-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12513-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12513-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12513-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,466,1515452400";
   d="scan'208";a="258186036"
Date: Tue, 13 Mar 2018 19:35:44 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Matthew Wilcox <willy@infradead.org>
cc: Kees Cook <keescook@chromium.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    cocci@systeme.lip6.fr, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <20180313183220.GA21538@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1803131935160.3117@hadrien>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org> <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com> <alpine.DEB.2.20.1803072212160.2814@hadrien> <20180308025812.GA9082@bombadil.infradead.org>
 <alpine.DEB.2.20.1803080722300.3754@hadrien> <20180308230512.GD29073@bombadil.infradead.org> <alpine.DEB.2.20.1803131818550.3117@hadrien> <20180313183220.GA21538@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1594848619172478138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Tue, 13 Mar 2018, Matthew Wilcox wrote:

> On Tue, Mar 13, 2018 at 06:19:51PM +0100, Julia Lawall wrote:
> > On Thu, 8 Mar 2018, Matthew Wilcox wrote:
> > > On Thu, Mar 08, 2018 at 07:24:47AM +0100, Julia Lawall wrote:
> > > > Thanks.  So it's OK to replace kmalloc and kzalloc, even though they
> > > > didn't previously consider vmalloc and even though kmalloc doesn't zero?
> > >
> > > We'll also need to replace the corresponding places where those structs
> > > are freed with kvfree().  Can coccinelle handle that too?
> >
> > Is the use of vmalloc a necessary part of the design?  Or could there be a
> > non vmalloc versions for call sites that are already ok with that?
>
> We can also add kmalloc_struct() along with kmalloc_ab_c that won't fall
> back to vmalloc but just return NULL.

It could be safer than being sure to find all of the relevant kfrees.

julia
