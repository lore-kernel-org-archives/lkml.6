Date: Wed, 4 Apr 2018 18:59:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>,
	groeck@chromium.org, Greg Hackmann <ghackmann@google.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180404165914.GA9034@kroah.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com>
 <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 04:53:52PM +0000, Nick Desaulniers wrote:
> (re-sending as plain text)
> 
> On Wed, Apr 4, 2018 at 2:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > There are known-bugs with building a kernel with clang right now (I
> > pointed one out a few days ago about NULL checks being deleted from the
> > clang output for no good reason, which really is scary for obvious
> > reasons).
> 
> Is this the thread you are referring to?
> https://lkml.org/lkml/2018/3/27/1286
> 
> It's definitely something curious that I'll need to sit down and
> investigate more.  If there are other known instances, it would be good to
> let me know.

Here is another horrible work around that was needed to get clang to
stop generating invalid code, beaec533fc27 ("llist: clang: introduce
member_address_is_nonnull()")  That one caused a lot of odd failures by
users, I wonder what else is lurking in that same code pattern.  It's a
hard one to debug...

thanks,

greg k-h
