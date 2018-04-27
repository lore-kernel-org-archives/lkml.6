Date: Fri, 27 Apr 2018 10:30:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: stable 4.16.5 hmm build error
Message-ID: <20180427083006.GB25242@kroah.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
 <20180427073004.GA12770@kroah.com>
 <CAK8P3a37b+3oW8vKS=pYi897uK3qySt0Cd=jvufqLc+h+ATkBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a37b+3oW8vKS=pYi897uK3qySt0Cd=jvufqLc+h+ATkBA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:17:42AM +0200, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 9:30 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Apr 27, 2018 at 02:19:24AM +0300, Михаил Носов wrote:
> >> Oh. Yes. Tag v4.16.5 without commit
> >> 9d8a463a7016e9e5578a561588a18acef139919c.
> >> It's in v4.17-rc1/2.
> >> Thank you.
> >
> > That patch does not apply to the stable trees.  I'm also confused by the
> > lack of "real" git commit ids that are being referred to here, that
> > commit refers to one that is not valid.
> >
> >> 2018-04-27 0:52 GMT+03:00 Randy Dunlap <rdunlap@infradead.org>:
> >>
> >> > https://bugzilla.kernel.org/show_bug.cgi?id=199515
> >> >
> >> > kernel/fork.o: In function `__mmdrop':
> >> > /kernel/build_kernel/linux-4.16.4/kernel/fork.c:600: undefined reference
> >> > to `hmm_mm_destroy'
> >
> > What .config is creating this?  I have not seen any kbuild reports of
> > this in the past.
> 
> I only got this through randconfig builds on mainline.
> 
> >> >
> >> > "It is also reproduced in linux-4.16.5"
> >> >
> >> >
> >> > There have been a few attempts to fix this build error.  The kernel
> >> > mainline
> >> > repo seems to have it fixed, but it looks to me like Arnd's latest patch
> >> > (9d8a463a7016e: "mm/hmm: fix header file if/else/endif maze, again")
> >> > was mis-merged to 4.16.5 stable.
> >> >
> >> > Please take a look.  Do you already have a fixup for this?
> 
> Jérôme initially created
> 
> 6b368cd4a44c ("mm/hmm: avoid bloating arch that do not make use of HMM")
> 
> which is part of v4.16. He noticed a build error that he fixed up with commit
> 
> b28b08de436a ("mm/hmm: fix header file if/else/endif maze")
> 
> which you backported as 25df8b83e867 into linux-4.16.y after v4.16.4.
> After that originally landed in mainline, I found another build error that
> I fixed with commit
> 
> 9d8a463a7016 ("mm/hmm: fix header file if/else/endif maze, again")

Why does that commit reference:
    Fixes: 8900d06a277a ("mm/hmm: fix header file if/else/endif maze")

when there is no such commit in the tree?

> This fixes the issue that Randy is reporting now, please add that into
> v4.16.5.

I tried, but it does not apply cleanly:
	$ p1 < ../mm-hmm-fix-header-file-if-else-endif-maze-again.patch
	checking file include/linux/hmm.h
	Hunk #1 FAILED at 376.
	Hunk #2 succeeded at 498 (offset -52 lines).
	1 out of 2 hunks FAILED

Am I missing some other commit that went in inbetween the above patches?

thanks,

greg k-h
