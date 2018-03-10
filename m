Return-Path: <kernel-hardening-return-12368-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvZwkqRZwWthz7ujYI6T3lQrhlJ3oX9VbOcKwvHW8UzT0H2wMmhJYY5mVi46Dp3qi42JUae
ARC-Seal: i=1; a=rsa-sha256; t=1520664217; cv=none;
        d=google.com; s=arc-20160816;
        b=c9aE/5prsZOcqQCB2XheQMBu4HLng/V7c9m1s+QRhnYy728JzkcnYUxhwUUU62LV57
         3mGTny9L2KJ5m7Hbgrih9ucTl5XwcAbAzoZhOsxdHZkSuGAR6GaHz9DSfSyDJ7ft2mWS
         JETyLMUfeAbKP3UVCkZiCXl7XrNzW8nKAhxjw8IvHqfgBORwXba1qjSzoVoOqa4HsAJv
         bTmx8JrI5kub599sLtNLUzVUSlL7bGv+tSDVQYhQrcKzX3qK7yErTKmgNA0tRSldidNI
         SEijgzsXzSQmofLgN89+spdiP1EFvsnc/5CYB1I8QfuxAGXiPQPQYTWmm1bY7+57Oml2
         IFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=DEMQW1hvpudVCEXqngQwTujKUfTlqZ295b+jiZjPoAs=;
        b=cizce+fUXHrdYf0+JPF/z7m0EfuLx27JpjHDNH7u21/q816sgHrZJFBeIx4O0gVcDd
         xdBm9PeVK0Xw2gSaSnYW7qiDG+MCqorjGs5Hu9PyNMexmLvUGPjnfuNe5FwBrqBXn85w
         eEva00BHIpl9VTXSZ6TwGzxXQMqTiM2ViqwW7w5uMboMfHOuzsY0A7DyyGR7aT2s2m4k
         QiTzKz5nOZf95a3GAk611cuT2LV/r6SIfNI+iELmN7d/XNen2Lx3VmZGn4KCEE6vO3vS
         BoWyKA1gRHAaNuGBVI05Ai5KP8PG6CDic9H0zbZ1yYiI+gw2RftWuHLYBkw2fvuG/l9U
         awBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12368-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12368-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12368-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12368-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693512178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Mar 2018 22:15:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Tobin C. Harding"
 <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
 Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>, "David S.
 Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar
 <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>, Ian
 Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, Linux Btrfs
 <linux-btrfs@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180309221523.1fce7118@vmware.local.home>
In-Reply-To: <20180309221019.31c896a3@vmware.local.home>
References: <20180309200536.GA5670@beast>
	<20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
	<CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
	<20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
	<CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
	<CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
	<CAGXu5j+4_2vZF9uPy_agcGymbHbVqohSqApKZZxwcTz4OC_Skg@mail.gmail.com>
	<20180310023907.798690563@goodmis.org>
	<20180309221019.31c896a3@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531931322322791?=
X-GMAIL-MSGID: =?utf-8?q?1594532003167402572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I don't know what the hell happened, but claws mail just inserted a
ton of people into the Cc (I didn't add you). I noticed it just after I
hit send. The added Cc looks like it came from the email right after the
email I was replying to "Subject: Re: [PATCH v3] kernel.h: Skip
single-eval logic on literals in min()/max()".

Sorry for the spam.

-- Steve


On Fri, 9 Mar 2018 22:10:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 09 Mar 2018 21:34:45 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >  2 files changed, 1050 insertions(+), 1273 deletions(-)  
> 
> BTW, it's a bit bigger impact than 223 deletions. As I added a lot of
> comments to explain the logic better. Removing comments and white space
> from the modifications we have:
> 
>  649 insertions(+), 1035 deletions(-)
> 
> That's 386 lines of code removed.
> 
> -- Steve

'
