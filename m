Date: Thu, 15 Feb 2018 17:43:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/mm/kaiser: avoid 32-bit/PAE build warning
Message-ID: <20180215164343.GA6230@kroah.com>
References: <20171206141627.688219-1-arnd@arndb.de>
 <CAK8P3a0ZN2ALu1tj9sm8-Lt9SsRgpbQtz91zR4MhY-Np7TQNyg@mail.gmail.com>
 <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com>
 <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
 <20180215054357.GC7377@kroah.com>
 <CAK8P3a0hTbb+zRPH6nXVEdxP7zJyu5mYcjLqnWd4AfG_=Yrm-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0hTbb+zRPH6nXVEdxP7zJyu5mYcjLqnWd4AfG_=Yrm-w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 04:37:10PM +0100, Arnd Bergmann wrote:
> On Thu, Feb 15, 2018 at 6:43 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Feb 14, 2018 at 11:12:24PM +0100, Arnd Bergmann wrote:
> >> On Wed, Dec 6, 2017 at 4:08 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> 
> >>
> >> I also saw another warning:
> >>
> >> /git/arm-soc/arch/x86/mm/kaiser.c: In function 'kaiser_init':
> >> /git/arm-soc/arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot'
> >> undeclared (first use in this function); did you mean
> >> 'massage_pgprot'?
> >>
> >> I can send this as proper patches for inclusion in 4.9-stable, unless
> >> someone has a better idea or finds a problem
> >
> > proper patches would be good :)
> 
> Sent two patches now. I want to make sure I haven't missed anything there,
> especially as my first approach at fixing it ended up causing other build
> failures.
> 
> In order to test this, I backported some 35 other (mostly trivial) patches later
> kernels, and now I have a 4.9.80 based tree that produces a clean randconfig
> build every time on arm64 and x86_64. If you want, I'll send you the list
> of the required backports as well. From what I can tell, they are all
> harmless (unused functions, missing Kconfig dependencies etc), but
> being able to do randconfig builds reliable gives us an additional tool for
> regression testing the stable kernels.

Sure, I'll be glad to take those.

> For 4.14-stable, we only need a handful of patches, but only one of those
> is upstream, I'll try my best to get the others merged with a Cc stable tag
> so 4.14 randconfig should build cleanly soon.

Again, I'll be glad to take them as well.

> I suspect 4.4 would require even more patches, but I have not looked.

If the above doesn't clean up 4.4 as well, that would be surprising :)

Anyway, 4.4 might be nice to have "clean" if possible, and it's not too
much trouble.

thanks,

greg k-h
