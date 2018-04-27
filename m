Date: Fri, 27 Apr 2018 13:51:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: stable 4.16.5 hmm build error
Message-ID: <20180427115147.GA29227@kroah.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
 <20180427073004.GA12770@kroah.com>
 <CAK8P3a37b+3oW8vKS=pYi897uK3qySt0Cd=jvufqLc+h+ATkBA@mail.gmail.com>
 <20180427083006.GB25242@kroah.com>
 <CAK8P3a2b81P_i2fX+RukhKiVwSUah2y5yPkQYUYU-Tr7yM3cog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2b81P_i2fX+RukhKiVwSUah2y5yPkQYUYU-Tr7yM3cog@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:44:58AM +0200, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 10:30 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Apr 27, 2018 at 10:17:42AM +0200, Arnd Bergmann wrote:
> >> On Fri, Apr 27, 2018 at 9:30 AM, Greg Kroah-Hartman
> >>
> >> which you backported as 25df8b83e867 into linux-4.16.y after v4.16.4.
> >> After that originally landed in mainline, I found another build error that
> >> I fixed with commit
> >>
> >> 9d8a463a7016 ("mm/hmm: fix header file if/else/endif maze, again")
> >
> > Why does that commit reference:
> >     Fixes: 8900d06a277a ("mm/hmm: fix header file if/else/endif maze")
> >
> > when there is no such commit in the tree?
> 
> This must have happened when the commit that introduced it came through
> the -mm tree and got a new commit ID between the time I sent the fix
> and Linus picking up the patch from Andrew. I try to hand-edit the
> 'Fixes' line when I know it's a patch in -mm to say 'Fixes: mmotm ("...")'
> but I missed that his time.
> 
> >> This fixes the issue that Randy is reporting now, please add that into
> >> v4.16.5.
> >
> > I tried, but it does not apply cleanly:
> >         $ p1 < ../mm-hmm-fix-header-file-if-else-endif-maze-again.patch
> >         checking file include/linux/hmm.h
> >         Hunk #1 FAILED at 376.
> >         Hunk #2 succeeded at 498 (offset -52 lines).
> >         1 out of 2 hunks FAILED
> >
> > Am I missing some other commit that went in inbetween the above patches?
> 
> There were several other commits from Jérôme inbetween. I don't
> immediately see where the conflict came from, but as my patch is
> basically a revert of Jérôme's, and it was working in v4.16.4, maybe
> it's best if you drop the backport of b28b08de436a for now, let him
> comment on whether we still need it. I had not seen the build error
> he referred to in his commit and we know that it does cause a
> new one.

That's a good idea, now reverted, thanks.

greg k-h
