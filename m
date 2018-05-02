Return-Path: <kernel-hardening-return-13179-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqDRirx4jsm/4e/4Qu36WPzbQDJoFwmjRcvUn/bS8fTVbLXyVAzbuPBMw19tMApN2AaDPYd
ARC-Seal: i=1; a=rsa-sha256; t=1525250574; cv=none;
        d=google.com; s=arc-20160816;
        b=FvLFj2nNI1coE72QyAF4KIlKiA7wK14E2bU8IKz8Jk9SWCdzh0qUOIkrPwJafYtJxK
         X6nGOO3PT67z65jwZGb3lt/ZiGyjpu6UJpsfTWsS6xGOk3RpucV4vhqDZeGw3TTNVfCp
         0pD0KHy+2cLOMqBLRrgBmTh5utgxO8VZPLmdXWKZfsH8C8Fp76JX2dUbzd4K6Gc5zpA0
         qksJFCXIqfWucZ1mv/3gw254YLtWZSYW4UUNe4If0ZcauqiJzMOtqum/izV7XnL0oDUz
         j+18vzWqG6umgJAVrSrEu19okf7xtfqoh/D4yvq43BstUVZEYaMd/9qCwWFc56PSR6k8
         HM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=pPgv79tWXrPVwjb9fqhfHSjTofry29PPKLXj/whz5e4=;
        b=ORIkmDE6rZN9C65CwwQaRPFK8IdIxD4S7CVWEOeSluMhZ/rv4dPIoXNUxTxOjf1MG2
         emvgv8/3GZT8ETIWgwgekovnrrzS49WjSqvBsgw7jES1vdBwR3yHp9IiyKLBWs8M9N9I
         z0qXjlyH6ugDJp6WV0dTsnLFwrVcTdlLG85ysYT7YnnbGgqBCQSAHTo/jdsFdo+SviZG
         i1Tiq0i74hHFYAx1s3GnuRDuZzUEa+j5e9kMpc5Z4awRgWCU+CtCtbnHtxdgAwWlFP4N
         qlTQ/gIZZi/w67lusrzWe0ae4bh10Fqk2HsnZlsEPUW4d51TCfIYHQIksbTMzGbbPBrh
         FSlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13179-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13179-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13179-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13179-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 2 May 2018 10:42:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Alexander Popov <alex.popov@linux.com>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
    Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
    Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
    Mark Rutland <mark.rutland@arm.com>,
    Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
    Richard Sandiford <richard.sandiford@arm.com>,
    "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
    "Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrey Ryabinin <aryabinin@virtuozzo.com>,
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
    Thomas Garnier <thgarnie@google.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
    "David S . Miller" <davem@davemloft.net>,
    Ding Tianhong <dingtianhong@huawei.com>,
    David Woodhouse <dwmw@amazon.co.uk>, Josh Poimboeuf <jpoimboe@redhat.com>,
    Steven Rostedt <rostedt@goodmis.org>,
    Dominik Brodowski <linux@dominikbrodowski.net>,
    Juergen Gross <jgross@suse.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Dan Williams <dan.j.williams@intel.com>,
    Mathias Krause <minipli@googlemail.com>,
    Vikas Shivappa <vikas.shivappa@linux.intel.com>,
    Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
    Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
    Florian Weimer <fweimer@redhat.com>,
    Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
In-Reply-To: <CAGXu5jJ_0e63QSv0YZsQoT_=zN8U-83nwxrQ10h=QjszbHK-aQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805021041260.1668@nanos.tec.linutronix.de>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com> <1523024546-6150-3-git-send-email-alex.popov@linux.com> <4e668302-8754-3f4e-3372-d0d7ba30cfa3@linux.intel.com> <CAGXu5jJ_0e63QSv0YZsQoT_=zN8U-83nwxrQ10h=QjszbHK-aQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1599341146627482488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 30 Apr 2018, Kees Cook wrote:

> On Mon, Apr 23, 2018 at 9:23 PM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> > Hi Alexander,
> >
> > You can add:
> >
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > for this patch if you like.  I haven't taken a super close look at the
> > rest, but this is certainly minimally invasive from my point of view for
> > the entry code.  Thanks, again for reworking it.
> 
> Thanks Dave!
> 
> Given this improvement and your review, I'm going to start carrying
> this for linux-next. Linus, if you're still opposed to this even after
> the changes here in v11, please let us know. I'd rather hash things
> out now instead of during a NAK in the 4.18 merge window. :)

Kees, can we please route that x86/entry stuff through tip to avoid
conflicts as there are other changes in that area on the horizon.

Thanks,

	tglx
