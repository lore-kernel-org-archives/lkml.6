Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZoCDn6yXTM14We0vBPGe1OIXig/OADKpeIZHshFgMWDB4fpAbEAcHM8TXP3BtucxtKaPRAA
ARC-Seal: i=1; a=rsa-sha256; t=1525226721; cv=none;
        d=google.com; s=arc-20160816;
        b=KstjUE2KcFU5Fz8qPJswoeDpSpGWjokv097By7zo1uVGk2usvABBWrm/2Ijjhp1hho
         OGpL3guuWqlTa7epw5aEcav1hHuKHiWfz3HivOQrPTJlFKEhHzsLBgZbgCIah07EFuSb
         o1WOKOinyX5obU95mjSAxqJ3bXsIcI3YocmjrFPdFXIc7lsgND+QgUjWu7QhNdIzFRG/
         9dNjwQgwt+laHUcRjbZP2wqduTYhfOciJsg/gPp8ViEw5LrJ4Y2b4gMwR6VPI/rjNsEa
         z6le8fB9UWtcgViH2gsK2Yl5bdmBIHJMsKASkYCrij0Kd98u7m7VfRxk16ir6LjGCFac
         LMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=o+JxziL+4FlZd1MvmvKednLQXL6yn/elomlPuz+nRmI=;
        b=EDxJ1ILqF86nMuK1HKr7QsPnMJzIVscNMMoCS5+f6L+eqaDxM328oIbz42EDonLAzX
         xO8OdjAiYTTCei1FGiDDn7eHHHPs9fByPQAnyqJvUSa/LpKcz0lIN1Wd3x3Ji06n4rX+
         JV1FU6MzWZ3etivVvDV9VxifeDeQQ7HpW6dtN1yL3oM+x6OERWYf8JpV8eGGGf5zf9KV
         knpPAwWqyHm7jB0JnrKnQ3q2S735W8Yjy+yTelya9IqsDLwMiKjSv/mHW9TkmvYRlmYs
         Oxov6G7LNanG4jPZr+zQdX2QzK6nQlsFWlmwks+p/K+zKVLTV5+YPwEUryu3tuaaz47K
         ystA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=X1xTM0Im;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=QDmXbIbZ;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=X1xTM0Im;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=QDmXbIbZ;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:3xzpWi85sg96KZrurXR-j18JJFnrXhVdAyps3jEwB28RwpOiEGISgA>
Date: Wed, 2 May 2018 12:05:16 +1000
From: tcharding <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line option
Message-ID: <20180502020516.GE3791@eros>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-4-git-send-email-me@tobin.cc>
 <CA+55aFzuGrp3XGhsj989XS-vAw9S9bzFUX6mNpvPaMfew6v1iA@mail.gmail.com>
 <20180502012758.GD3791@eros>
 <20180501214507.22138131@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501214507.22138131@vmware.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599316134304494825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 09:45:07PM -0400, Steven Rostedt wrote:
> On Wed, 2 May 2018 11:27:58 +1000
> tcharding <me@tobin.cc> wrote:
> 
> > On Wed, May 02, 2018 at 01:02:34AM +0000, Linus Torvalds wrote:
> > > On Tue, May 1, 2018 at 4:34 PM Tobin C. Harding <me@tobin.cc> wrote:
> > > 
> > >   
> > > > This option should NOT be enabled on production kernels.  
> > > 
> > > I think with your fixes to get_random_bytes_arch(), it's perfectly fine to
> > > use on production kernels (and doesn't even need a kernel command line
> > > option).
> > > 
> > > It was only with the "use weak crypto" (that get_random_bytes_arch() used
> > > to fall back on) that it was a problem. That fixed "verify that
> > > get_random_bytes_arch() really uses hw crypto" is certainly not weak crypto.  
> 
> Except for where hardware vendors control what random bytes you
> actually get ;-)
> 
> > 
> > Ok, I'll wait to see if anyone with a more paranoid disposition adds to
> > this otherwise will implement as suggested.
> 
> I still test on a lot of old boxes (my old workstations turn into my
> test boxes). I haven't tried to see which machines have RDRAND support.
> But regardless, can we still have a command line option that forces
> early randomization even if RDRAND isn't supported?

This is now two different issues, right?

1) get_random_bytes_arch() was broken for this use case - this set fixes
   that.  We can just use the hw RNG if available for key material to
   hash pointers with.

2) Early stage debugging is still an issue on boxes without RDRAND.  If
   we are agreed that we don't need cryptographically secure hashing on
   test kernels then we could just use a simple hashing algorithm, for
   example multiply the address by a prime and take the high 32 bits (as
   long as it was guarded by a command line option).

thanks,
Tobin.
