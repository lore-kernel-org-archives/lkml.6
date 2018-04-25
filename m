Date: Wed, 25 Apr 2018 08:12:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wei Wang <wvw@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Wei Wang <wei.vince.wang@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180425061235.GC595@kroah.com>
References: <20180424180812.215900-1-wvw@google.com>
 <20180424145056.7c29ea18@gandalf.local.home>
 <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 07:02:34PM +0000, Wei Wang wrote:
> We have seen many cases vendor have shipped kernel/drivers with it, and
> have to clean up that every year. This was brought up in an internal
> discussion and Greg suggested have some feedback from upstream about what
> should be taken to prevent this globally besides fixing individual drivers.
>  From him "I think this change makes sense at a high level, but there could
> be non-obvious reasons why this isn't the way things are handled right now."

I said that?  Heh, I normally say things like "fix all the stupid
drivers", you must have caught me on a good day :)

Anyway, the drivers should be fixed, if they are doing foolish things
like this, the core kernel should not be "protecting them from
themselves", that way lies madness, just talk to the Windows kernel
developers about the hoops they jump through for this type of stuff...

thanks,

greg k-h
