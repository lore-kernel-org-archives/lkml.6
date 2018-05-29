Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965070AbeE2QH4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:07:56 -0400
Received: from imap.thunk.org ([74.207.234.97]:40928 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934877AbeE2QHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:07:54 -0400
Date: Tue, 29 May 2018 12:07:43 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH] x86, random: Fix get_random_bytes() warning in x86
 start_kernel
Message-ID: <20180529160743.GA7381@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180529123800.19627-1-prarit@redhat.com>
 <CAGXu5jJvJbTZT5=u7TJtLsN-TsuSEfw8h2EwV8w-oefJkADoBg@mail.gmail.com>
 <71b5df93-2e21-f3c3-fa22-4488729daeb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b5df93-2e21-f3c3-fa22-4488729daeb5@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:01:07AM -0400, Prarit Bhargava wrote:
> Kees, in early boot no pool is available so the stack canary is initialized from
> the TSC.  Later in boot, the stack canary will use the the crng.
> 
> ie) in early boot only TSC is okay, and late boot (when crng_ready() is true)
> the pool will be used.

But that means all of the kernel threads (e.g., workqueues, et. al)
would not be well protected by the stack canary.  That
seems.... rather unfortunate.

      	     	  	      	   	     - Ted
