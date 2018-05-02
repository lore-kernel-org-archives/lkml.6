Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AB8JxZpeJk63PJB3eiCx7phJTf5JEwuw9zWKeEO6QRI51+CuA9QMsf3R4WP1/klccasbLj4wX8+T
ARC-Seal: i=1; a=rsa-sha256; t=1525298207; cv=none;
        d=google.com; s=arc-20160816;
        b=dQweoqiNOrP3pPxs2gl7SFxboiAVWFlZKACp7yAhq0+EYxU7JpCikMqVgFgoWR5KJR
         IUFOTT7dMhP1+k2JF6yqgvWiHmPJ68WRtGn+ldAvbXX4EfOCKmxWgnPMINIldlfdbAVv
         Sftc1DevIFM27AVGXWl68WnwVp3jq1u/XHisuhe0GCDesAtlAMW+1Fuh1uV4X1A0HsJv
         EG7HtxtSNsSGxmv11oaF70H3fH4ojq17KfsyPvM8WwvJ1eQl+o7hfe5+ESdpMFbkX4yg
         3Y04Ar0F3WosHVVIdCzmBYfseTorfElPp3BqwiBKfY1kkMJya3Mq8gjTGtY5G0uvc2Pz
         eoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=CObdZbbgd6njYagf1O8hFrSs5a7+wZSPlTAO9hxgJQ4=;
        b=Zk93KJG6WbuUI4UU+b55TNHrZp1/cv+FUlzxyXISA9/lB0V5L45iCy6aleXBwXWGJB
         Z1tGBxno+5xDVLDbWye8aWax/xnLNG0giV6Qw3u7ft3k9HkZkT26cCbynaiRpu0W0tv4
         voIK9ZkXS/ov9NEEZSrxn/J5vA6RVhbDEvPEczVmSrjg+TaI0vTA14ouAt/2y+VbvlBd
         8LScsERDB2TrrBAUNwbeTwVsR7QtVbwWE5NYX2fua2kJQc8rgqkdk1eP9I0GRPWhZlqF
         hYVknSjjKaGyMAbKLhREfqmwdGgZ5ZUeE0vUk5O5w3/DIzCTUcpo7IrVJF+Bfw9Iof5Q
         qJpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Wed, 2 May 2018 14:56:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>, "Theodore Ts'o"
 <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line
 option
Message-Id: <20180502145645.a1fa72b86f2501432f003edc@linux-foundation.org>
In-Reply-To: <1525217620-4107-4-git-send-email-me@tobin.cc>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
	<1525217620-4107-4-git-send-email-me@tobin.cc>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599391093336177714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed,  2 May 2018 09:33:40 +1000 "Tobin C. Harding" <me@tobin.cc> wrote:

> Currently if an attempt is made to print a pointer before there is
> enough entropy then '(____ptrval____)' is printed.  This makes debugging
> early stage stack traces difficult.  We can relax the requirement for
> cryptographically secure hashing when debugging while still maintaining
> pointer hashing behaviour.
> 
> Add a command line option 'use-early-random-bytes'.  When enabled get
> key material from the hw RNG if available.

Documentation/admin-guide/kernel-parameters.rst, please.

> This option should NOT be enabled on production kernels.

And the documentation should explain why this recommendation is made. 
Here was I scratching my head wondering why this feature isn't just
permanently enabled.  Still scratching away...
