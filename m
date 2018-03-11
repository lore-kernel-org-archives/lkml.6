Return-Path: <kernel-hardening-return-12404-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuXrIJyg9uTlrRaDKIXerMeiy/Z7PM8wUMbMAWBDxdGO21TadaI9Ms7471aPC4BmV9AZ/pg
ARC-Seal: i=1; a=rsa-sha256; t=1520808398; cv=none;
        d=google.com; s=arc-20160816;
        b=AMq/B3npvyRO7a6FwU8prbj61mpIKdCA0/UhyYNRzE6Zm2LXkdw0OQXJzVtRVoQbMs
         imFMIZB+7Yu7c+hU2mEeqoGryjl0MeP0f21vduyZ9oQZ7bOgCbC9LbqOkC7iYkOb0VYj
         3Fsomul/8fixevfjuxgLB2zZrd/Kg5zkx2LfQAu4Z5lQWqXzkBFKYfiIkGIqKof61OQq
         Y/MDcDAl1/glvhiW40zatlqHAbgTV+R95u00n0tDrrG0kdIkUS2/AQF5XXbX80QE1Zib
         QulaajnAQOeLRlIW1Cl97NK0DsDyz/q7GWOJKev+lXNIyeHVyFR4aGBF2uru0GH5Y+rp
         5wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=CsK3umsdGeebcfBIS3kZcUSdXuzaZDg45BxJrDWUPmY=;
        b=ZCLjLeBenul8d+AsSk3LJyQue124nuRAJ3dQXW1QZLOuDDuR/BX4W4kFWwOXSdQVJf
         nH7rIqiPVF0t9gf3GvWlztPtCZQKgSpEZURMr8BlbJ+8W70yoo1oAmaVkmPG5RBMK5hO
         l1kAXfj9zucbb/rC+WJ3wLNg1u3BKwyYIOLDL6Skdg4ATqm/oDnsQSaMx0dAJvHLqWe8
         F9ZsKUXbIX6kChMEJKN8L41S+8WX9/OS3dgd0uxORk1IB8DXhYNuh3Fy2FVUON4tuhC6
         6Y/YLItuLmF0qz7cJz4+i5fJuDbe8p61QAZh22k7Ne5e05b4E8h7s/MlEUhpJNqG9a6w
         mE0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=U4re2OHl;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=lH9YHl0z;
       spf=pass (google.com: domain of kernel-hardening-return-12404-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12404-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=U4re2OHl;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=lH9YHl0z;
       spf=pass (google.com: domain of kernel-hardening-return-12404-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12404-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:vLGlWteIOyi8ucB8Nm6Lvh_-IxsV1yHUflEAiMjl-TUK6rFNJlRGkg>
Date: Mon, 12 Mar 2018 09:46:16 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Jonathan Corbet <corbet@lwn.net>,
 Chris Mason <clm@fb.com>,	Josef Bacik <jbacik@fb.com>,
 David Sterba <dsterba@suse.com>,	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ingo Molnar <mingo@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-ID: <20180311224616.GJ16734@eros>
References: <20180309200536.GA5670@beast>
 <CA+55aFy82Drgu2xm1GWaDz2Jyj5QBx3dW4AatXzmCx-b1YET5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy82Drgu2xm1GWaDz2Jyj5QBx3dW4AatXzmCx-b1YET5Q@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594683187579073934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 01:10:30PM -0800, Linus Torvalds wrote:
> On Fri, Mar 9, 2018 at 12:05 PM, Kees Cook <keescook@chromium.org> wrote:
> > When max() is used in stack array size calculations from literal values
> > (e.g. "char foo[max(sizeof(struct1), sizeof(struct2))]", the compiler
> > thinks this is a dynamic calculation due to the single-eval logic, which
> > is not needed in the literal case. This change removes several accidental
> > stack VLAs from an x86 allmodconfig build:
> 
> Ok, looks good.
> 
> I just have a couple of questions about applying it.
> 
> In particular, if this will help people working on getting rid of
> VLA's in the short term, I can apply it directly. But if people who
> are looking at it (anybody else than Kees?) don't much care, then this
> might be a 4.17 thing or at least "random -mm queue"?

It's easy enough to work on the other VLA removals without basing on
this, no rush.


thanks,
Tobin.
