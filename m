Return-Path: <SRS0=YUeZ=IJ=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZpjmWIkP9Z4+J1AYf4MmBFlXewuAkyr7nKMG/FcDUpTBpQBkXCNzkN89CIdCbDbUM4vV7tQ
ARC-Seal: i=1; a=rsa-sha256; t=1527003210; cv=none;
        d=google.com; s=arc-20160816;
        b=tomzpIJZV97BpM3lG+PA7lFxvN5YLoCkf4RKnvNApc+Tzoz2gzBaq/4AbGgmaQagNp
         ZHGhtH8Co+INdcITeWxOhmV/Q7Tkdw7EIbM/RGhG5Idlfdidm3GDnDtVHF/rkQOakGeE
         dvkWkGbIiQs5R7913axtGj4RxxoRjwr8BM7yJNNMfuiyl+s3M+Iy8c5CTP2OfWF9bb62
         8HUSDDX4tj0NQT98XSBUHr4/shr+yIOPtuAkwqWVXTLizbUUMbpuAetBJ45s9BL8LKko
         Ra5xWNgJywglDleiw7/vrjRGAZ+/yLZo7zI8BeHN/WE0QsNzG2FWq7HD43+75Guv7dzO
         7QzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0qbathbQW32+joFxQ2y9ZsRZHX6U17pdk1zunfLG36o=;
        b=IyCvrUCyhcPyLjfoca1QEbDW9r8Kc/G3AT0bWrACKGRwM1IOUITPNenQ33V/NUTCyD
         xnfOgnGT9bYkzlPYYy9rP4Tugp11uwAhwRpGlY6hNowEUx+EEJYFlg+MUQuvzy4fAYtx
         SIYiKVAyKlNbIvZC1M4KCpHeKctcmKm5ZUWK89QujmDlr6n9Kj1L/XwpZIGK3oVFhPTJ
         pkJTIqFz31ekrwGThwxZkMDlEhOSvW076LZfQQB7ZGBMXATRo/8Mc8NccjqQuNAiweyH
         r1iXHgptr/JxfaA2969RLdkW5xYnwnBWNT9U69r9PfD27K4don/w6qQexLrtIyMr1O+d
         0rGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=yuez=ij=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=YUeZ=IJ=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=yuez=ij=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=YUeZ=IJ=goodmis.org=rostedt@kernel.org
Date: Tue, 22 May 2018 11:33:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Theodore Ts'o <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] enable early printing of hashed pointers
Message-ID: <20180522113327.4b003fff@gandalf.local.home>
In-Reply-To: <20180516224158.GD25268@eros>
References: <1526426259-23012-1-git-send-email-me@tobin.cc>
	<20180516111348.1abf69a1@gandalf.local.home>
	<20180516224158.GD25268@eros>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600573966123035587?=
X-GMAIL-MSGID: =?utf-8?q?1601178918473816598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


[ Steve is back from vacation ]

On Thu, 17 May 2018 08:41:58 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> On Wed, May 16, 2018 at 11:13:48AM -0400, Steven Rostedt wrote:
> > 
> > I think the series looks good, although if Linus takes my last patch,
> > it may conflict badly with the third patch. I'll have to look into that.  
> 
> I applied your PR patch ontop of mainline (imitating Linus pulling) any
> yes patch 3 of this set has a merge conflict.
> 
> > Anyway, Andrew, you want to take this in your tree?  
> 
> I split this set up into it's current form because Ted offered to take
> it through his tree.  There has been no response from him though since
> doing so.  He has ack'ed the first 2 patches (that touch
> drivers/char/random.c and include/linux/random.c).

Hopefully Ted takes this then.

> 
> Since this is not overly urgent stuff is it easier for everyone involved
> if I wait until the PR to Linus goes through then rebase this, add the
> other vsprintf patch back onto the set and send it all to Andrew?

Linus already pulled my commit in his tree. You can base your latest
work on top of it and post it again. I'm sure Andrew could take it
after that.

> 
> Usual disclaimer about being a massive noob, please correct me if I am
> out of line.  My aim is to make the job of others more simple.

No worries, you're doing a fine job ;-)

-- Steve
