Return-Path: <kernel-hardening-return-12551-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELue+tnWcoBNnSzkVlm4MQhoPUdW7wuT3zktin602kRs8h1ZSB6tyrsNc8G6ReDfjk8oZEWs
ARC-Seal: i=1; a=rsa-sha256; t=1520975334; cv=none;
        d=google.com; s=arc-20160816;
        b=0w48D8JnUGktglclK59KE/jTh8WCnhkU7GZJ/9LWMWBBKJIPoQtY4d4RikkqWJNmaW
         nHdA4NT5acQFAYzeK3Ej5AqM++J4T30cT/8AjEkd/68QzeuCq+4pB9XF6vQho5muzacv
         jl4uja78ZhufhDKr9Aw8M904PPweCp5ypunDeA3htaYuwXsAnG4LnmjArEK9arxa2qhA
         H2M7+/xye+BR32trcvRGKVRjpjqmDec1PqKGKoUUR+GWUXaHL7DMEWpFLIIolQvyE5Sl
         q02pqFCT9MAQo9GoKO1ocSAJDxT6sqWizCiad2fH/qxABGrG01tiLxBSiaPx1WShDHcf
         y3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Ad3861/tJ6x5m8ls0cS6Vnp/Q7x9f1S70ViK+gSOMag=;
        b=iYtNOSdbrkYkzOt/wY4x6kmEd7Mj94LpxkjGU6+DRv8ANCebZ4zhF+/OL7HICqssoO
         dCcE86Bmy+sCay6nbJxhgvdPeg4Uj56KyiOAuRnVOhKNWfUfEyFSWCPZdfLhq1raqm2j
         1FbI5d6WP9on6O1IlzILgGdlUSDvo0nzmdEZyxGw18Zzs9MiyV65w8Vlx/fXZ5+HSSG1
         gKdyjDpk1Q9hf+S00wxF/O1JNrs9T1Z7O6CdkJeonsNadzzohXuYd4M+FiXPPvkHSaPw
         7+40f6G1EDUo1p0TXuv+yv6NEiI8pfVyXjOhxWS1TUWS3bdy0i7tqoCH9CODCehfmRk/
         /uIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12551-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12551-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12551-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12551-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 14:02:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt
 <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason
 <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo
 Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, Linux Btrfs
 <linux-btrfs@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-Id: <20180313140248.7fdb0d0cee044cd7c7fc7b93@linux-foundation.org>
In-Reply-To: <CAGXu5j+M0qbBS0og8buXHdubA=oi=jMcK=ehLGDeevFd2H7JmA@mail.gmail.com>
References: <20180309200536.GA5670@beast>
	<20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
	<CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
	<20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
	<CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
	<CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
	<20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org>
	<CA+55aFwK7W0SsaP5eR+2TxOj-j_Mu_E11fRw2Gk8ptV71ebvww@mail.gmail.com>
	<CAGXu5j+M0qbBS0og8buXHdubA=oi=jMcK=ehLGDeevFd2H7JmA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594858232047657741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Mar 2018 21:28:57 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Mon, Mar 12, 2018 at 4:57 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Mar 12, 2018 at 3:55 PM, Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >>
> >> Replacing the __builtin_choose_expr() with ?: works of course.
> >
> > Hmm. That sounds like the right thing to do. We were so myopically
> > staring at the __builtin_choose_expr() problem that we overlooked the
> > obvious solution.
> >
> > Using __builtin_constant_p() together with a ?: is in fact our common
> > pattern, so that should be fine. The only real reason to use
> > __builtin_choose_expr() is if you want to get the *type* to vary
> > depending on which side you choose, but that's not an issue for
> > min/max.
> 
> This doesn't solve it for -Wvla, unfortunately. That was the point of
> Josh's original suggestion of __builtin_choose_expr().
> 
> Try building with KCFLAGS=-Wval and checking net/ipv6/proc.c:
> 
> net/ipv6/proc.c: In function ‘snmp6_seq_show_item’:
> net/ipv6/proc.c:198:2: warning: ISO C90 forbids array ‘buff’ whose
> size can’t be evaluated [-Wvla]
>   unsigned long buff[SNMP_MIB_MAX];
>   ^~~~~~~~

PITA.  Didn't we once have a different way of detecting VLAs?  Some
post-compilation asm parser, iirc.

I suppose the world wouldn't end if we had a gcc version ifdef in
kernel.h.  We'll get to remove it in, oh, ten years.
