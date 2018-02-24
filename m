Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeBXSpz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:45:55 -0500
Received: from imap.thunk.org ([74.207.234.97]:51580 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbeBXSpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:45:53 -0500
Date: Sat, 24 Feb 2018 13:45:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Borislav Petkov <bp@suse.de>
Cc: Gustavo Leite <gustavoleite.ti@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>, Randy Dunlap <rdunlap@infradead.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH] linux/kernel.h: break long lines
Message-ID: <20180224184530.GC31264@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <20180224181003.29604-1-gustavoleite.ti@gmail.com>
 <20180224183044.GB29374@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224183044.GB29374@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 07:30:44PM +0100, Borislav Petkov wrote:
> 
> And, for the record, if we have to break a function signature, we align the
> arguments at the opening brace like this:
> 
> static inline int __must_check kstrtou64_from_user(const char __user *s,
> 						   size_t count, unsigned int base, u64 *res)
>

An alternate approach is this:

static inline int __must_check
kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)

Which yes, is still longer than 80 characters.  But this is where
blindly following coding guidelines as if they are fundamentalist
biblical doctrine is not really a great idea.  The goal is to make the
code easier to read, and very often it's important to apply _judgement_.
(Which is one of the reasons why I generally don't really like newbies
trying to apply checkpatch.pl to existing source files.)

Cheers,

					- Ted
