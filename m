Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeBEQuD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752986AbeBEQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:49:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0703821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 11:49:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180205114952.6af99dff@gandalf.local.home>
In-Reply-To: <20180205152218.hxgozi67zka4hgkf@angband.pl>
References: <20180204174521.21383-1-kilobyte@angband.pl>
        <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
        <20180205100305.GO29988@eros>
        <20180205152218.hxgozi67zka4hgkf@angband.pl>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 16:22:19 +0100
Adam Borowski <kilobyte@angband.pl> wrote:

> My change touches %px only, where your concern doesn't apply.
> 
> You're right, though, when it comes to %pK:
>     printk("%%pK: %pK, %%px: %px\n", 0, 0);
> says
>     %pK: 00000000ba8bdc0a, %px: 0000000000000000
> 
> So what should we do?  Avoid hashing 0?  Print a special value?

My personal opinion is that NULL should stay NULL and not be hashed.
What security issue could be leaked by a NULL? I'm not a security
person, that's a real question.

-- Steve
