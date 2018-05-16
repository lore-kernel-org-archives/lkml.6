Date: Wed, 16 May 2018 09:52:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Lihao Liang <lianglihao@huawei.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 3/3] types: use fixed width types without
 double-underscore prefix
Message-ID: <20180516075249.GA3536@kroah.com>
References: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
 <1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com>
 <20180515155925.9c16962e2b416e5f507c07b1@linux-foundation.org>
 <CAK7LNAQJA2WJ6QO8H7dGi3D3=pHFfXLU=o8eBPcC+wxq-v7TqQ@mail.gmail.com>
 <20180516062623.GA32694@kroah.com>
 <CAK7LNASHZpTW5VWOPdEqwuACN_K7HNKjar51iTbb-Y6+cJwCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASHZpTW5VWOPdEqwuACN_K7HNKjar51iTbb-Y6+cJwCyw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 03:59:01PM +0900, Masahiro Yamada wrote:
> 2018-05-16 15:26 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > On Wed, May 16, 2018 at 10:07:50AM +0900, Masahiro Yamada wrote:
> >> Hi Andrew,
> >>
> >> 2018-05-16 7:59 GMT+09:00 Andrew Morton <akpm@linux-foundation.org>:
> >> > On Tue, 15 May 2018 11:22:05 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >> >
> >> >> This header file is not exported.  It is safe to reference types
> >> >> without double-underscore prefix.
> >> >>
> >> >
> >> > It may be safe to do this, but why is it desirable?
> >>
> >>
> >> It is shorter. That's all.
> >> If it is a noise commit, please feel free to drop it.
> >>
> >>
> >> BTW, a large amount of kernel-space code
> >> uses underscore-prefixed types.
> >
> > Sometimes it can/should do that.
> 
> I agree that UAPI headers must do that.
> 
> If you mean "it should even for non-exported code",
> I have no idea why.
> 
> 
> 
> >> I wonder if we could check it by checkpatch.pl or something...
> >
> > You do understand the difference between the two types and why/when they
> > are needed, right?  I don't think checkpatch.pl can determine if data is
> > coming from userspace or not very easily to make this a simple perl
> > script check :(
> 
> 
> I am getting puzzled...
> 
> It sounds like you are talking about __user or __kernel.
> If so, it is a matter of sparse tool
> but I believe it is a different topic.
> 
> 
> If I understand correctly,
> using 'u32' is safe outside of 'include/uapi/' and
> arch/$(SRCARCH)/include/uapi/
> 
> Why can't a simple script do that?
> 
> Am I missing something?

I think we are talking past each other here :)

__ types are for when the variable crosses the user/kernel boundry,
that's all.  ioctl structures are one such example, as are some of these
specific userspace-facing types that you are changing here.

We have loads of ioctl structures that are _not_ in uapi/ which is a
totally different problem that I know some people are looking at fixing
up, so a checkpatch.pl rule would not be good here.

There's also places where data comes in from hardware that use the __
types, but those are usually a bit more rare.

thanks,

greg k-h
