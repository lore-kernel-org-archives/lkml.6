Return-Path: <kernel-hardening-return-12248-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv9g729C3niDeiSzo02gwyczmtlPplH4WYfneCrn0MJOjF4imN5KS98FJ52AQGGtc/z6gs0
ARC-Seal: i=1; a=rsa-sha256; t=1520532926; cv=none;
        d=google.com; s=arc-20160816;
        b=GDqcgSk7ntp3rRJiI5h7i8/u6Ei7SmsGB0BnccbXit/36JsPxa3LMUd+hun0lQfrlC
         KfJFH8ShZkOdBBxjlKi8LlgFS2sy1yid/9BT8oSUUCaMqeqpJ/XgWPuOUgBPpAzaFoR4
         T++bBWxakGQ3cYBPp0e2LjT6IjVbUD48UH6NgNVMXYgLQiHvZRVZcgmW6D3D/y6H5CN9
         8kaV3ypev+j3KAoxVwYsyWr5asmo2SWBBzRPw8mU6C/rZF+D2i6Ci1ZW0/T6Itxvk8n4
         UX5oKag+1dQ81FCSTzSdGoz4Fb0X4UWfFsC8ctRSYVDSD9fXD0IZgNj20pYkuhn6hfeQ
         HqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=uQSilwdMtsWWBKjGzKOfAWWvV32qG+iVxnABFNgwT04=;
        b=jsKV5SoA0XYFSG96f3Y9pF5ELyN6p7gobm4ZOYD0/tszGhbDMqRBz/z3A73J9aaN2y
         zxbhf7Xb9+dM/znaSck1BW5JrqkM6uwohT4j62b/fP+yy3wy+x1kqs48Jq0tDUI88fzb
         E2Fsnqgd0s9OOcs7DtxBIPwtIHiklpK4agHY3mFjWk40TEmzFIkxS0c0EWuQf2LksGVI
         YSTdUolGYXgHvIWL2PpZW7g8VDfA4OvkssDA3Z1dUl+zkt+5XqU86fgp6fAEC1gaseMg
         sWkFvXZTORvyux/8FLSkG0i0SIZ5a5WZF0e3ALuQL8XYnpgCeQDKGmOwjOZY9g1jy2op
         EBLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12248-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12248-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12248-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12248-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2929220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Mar 2018 13:06:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, corbet@lwn.net,
 gustavo@embeddedor.com, Chris Mason <clm@fb.com>, Josef Bacik
 <jbacik@fb.com>, David Sterba <dsterba@suse.com>, "David S. Miller"
 <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov
 <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>, Ian Abbott
 <abbotti@mev.co.uk>, "Tobin C. Harding" <me@tobin.cc>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, linux-btrfs@vger.kernel.org,
 netdev@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 0/3] Remove accidental VLA usage
Message-ID: <20180308130633.0d819f44@vmware.local.home>
In-Reply-To: <20180308150236.5tysfbm3xdouii5n@treble>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
	<20180308150236.5tysfbm3xdouii5n@treble>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594394334638231271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018 09:02:36 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 07, 2018 at 07:30:44PM -0800, Kees Cook wrote:
> > This series adds SIMPLE_MAX() to be used in places where a stack array
> > is actually fixed, but the compiler still warns about VLA usage due to
> > confusion caused by the safety checks in the max() macro.
> > 
> > I'm sending these via -mm since that's where I've introduced SIMPLE_MAX(),
> > and they should all have no operational differences.  
> 
> What if we instead simplify the max() macro's type checking so that GCC
> can more easily fold the array size constants?  The below patch seems to
> work:

Nice. Have you tried to do a allmodconfig and build on various archs?

Of course pushing it to kernel.org will have the zero day bot do it for
you ;-)

-- Steve
