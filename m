Date: Wed, 4 Apr 2018 11:38:23 +0200
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
Message-ID: <20180404093823.GC25996@kroah.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 09:58:03PM +0000, Nick Desaulniers wrote:
> Speaking more with our internal LLVM teams, there ARE a few different
> approaches to implementing asm-goto in LLVM proposed, by external parties
> to Google.  These proposals haven't progressed to code review, so we've
> asked our LLVM teams to reignite these discussions with increased priority,
> if not implement the feature outright.  We (Google kernel AND llvm hackers)
> are committed to supporting the Linux kernel being built with Clang.
> 
> I can see both sides where eventually a long-requested feature-request
> should come to a head, especially with good evidence (
> https://lkml.org/lkml/2018/2/14/895), but just as you wouldn't accept a
> patch that doesn't compile with GCC, I'd like to request that we don't
> merge patches that fail to compile with Clang (or at least start to think
> what that might look like).  I realize that would increase the burden on
> patch authors and maintainers, so I'm interested in better approaches or
> ideas.
> 
> I've been in contact with the 0-day bot maintainers, kernel-ci maintainers,
> and even run my own run down version of 0-day bot on my workstation
> hourly.  I think those will help reduce the burden of testing patches with
> multiple different compilers.

There are known-bugs with building a kernel with clang right now (I
pointed one out a few days ago about NULL checks being deleted from the
clang output for no good reason, which really is scary for obvious
reasons).  So while it is great that small subsets of the kernel can
work properly (or hopefully properly), with clang, it still isn't ready
to be considered a "fully supported and we can't change the kernel if we
break using it" option, sorry.

And don't tie _anything_ to a LTS kernel, that's exactly what those
kernels are NOT for.  You implement features and things in the kernel
when they are ready, and I'll pick a random LTS kernel out of the air
when I feel like it.  Never should the two intersect and matter.

So please, work on fixing up clang for asm-goto and other "features"
that the kernel requires, and maybe when all build options/configs are
really solid and working well, will we be able to properly consider it
as a reason to implement, or not implement, something in the kernel
source.

thanks,

greg k-h
