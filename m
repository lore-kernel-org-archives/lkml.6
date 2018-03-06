Date: Tue, 6 Mar 2018 09:25:25 -0800
From: Greg KH <greg@kroah.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Shi <alex.shi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180306172525.GA6618@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
 <20180306142634.GC13586@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306142634.GC13586@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 02:26:34PM +0000, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 02:08:59PM +0100, Greg KH wrote:
> 
> > I know there is lots more than Android to ARM, but the huge majority by
> > quantity is Android.
> 
> > What I'm saying here is look at all of the backports that were required
> > to get this working in the android tree.  It was non-trivial by a long
> > shot, and based on that work, this series feels really "small" and I'm
> > really worried that it's not really working or solving the problem here.
> 
> Unfortunately what's been coming over was just the bit about using
> android-common, not the bit about why you're worried about the code.  :(

Sorry, it's been a long few months, my ability to communicate well about
this topic is tough at times without assuming everyone else has been
dealing with it for as long as some of us have.

> > There are major features that were backported to the android trees for
> > ARM that the upstream features for Spectre and Meltdown built on top of
> > to get their solution.  To not backport all of that is a huge risk,
> > right?
> 
> I'm not far enough into the details to comment on the specifics here;
> there's other people in the CCs who are.  Let's let people look at the
> code and see if they think some of the fixes are useful in LTS.  The
> Android tree does have things beyond what's in LTS and there's been more
> time for analysis since the changes were made there.

I suggest looking at the backports in the android-common tree that are
needed for this "feature" to work properly, and pull them out and test
them if you really want it in your Linaro trees.  If you think some of
them should be added to the LTS kernels, I'll be glad to consider them,
but don't do a hack to try to work around the lack of these features,
otherwise you will not be happy in the long-run.

Again, look at the mess we have for x86 in 4.4.y and 4.9.y.  You do not
want that for ARM for the simple reason that ARM systems usually last
"longer" with those old kernels than the x86 systems do.

> > So that's why I keep pointing people at the android trees.  Look at what
> > they did there.  There's nothing stoping anyone who is really insistant
> > on staying on these old kernel versions from pulling from those branches
> > to get these bugfixes in a known stable, and tested, implementation.
> 
> I think there's enough stuff going on in the Android tree to make that
> unpalatable for a good segment of users.

Really?  Like what?  Last I looked it's only about 300 or so patches.
Something like less than .5% of the normal SoC backport size for any ARM
system recently.  There were some numbers published a few months ago
about the real count, I can dig them up if you are curious.

> > Or just move to 4.14.y.  Seriously, that's probably the safest thing in
> > the long run for anyone here.  And when you realize you can't do that,
> > go yell at your SoC for forcing you into the nightmare that they conned
> > you into by their 3+ million lines added to their kernel tree.  You were
> > always living on borowed time, and it looks like that time is finally
> > up...
> 
> Yes, there are some people who are stuck with enormous out of tree patch
> sets on most architectures (just look at the enterprise distros!) - but
> there are also people who are at or very close to vanilla and just
> trying to control their validation costs by not changing too much when
> they don't need to.

Great, then move to 4.14.y :)

And before someone says "but it takes more to validate a new kernel
version than it does to just validate a core backport for the
architecture code", well...

> There's a good discussion to be had about it being sensible for people
> to accept more change in that segment of the market but equally those
> same attitudes have been an important part of the pressure that's been
> placed on vendors long term to get things in mainline.
> 
> > [1] It's also why I keep doing the LTS merges into the android-common
> >     trees within days of the upstream LTS release (today being an
> >     exception).  That way once you do a pull/merge, you can just keep
> >     always merging to keep a secure device that is always up to date
> >     with the latest LTS releases in a simple way.  How much easier can I
> >     make it for the ARM ecosystem here, really?
> 
> That's great for the Android ecosystem, it's fantastic work and is doing
> a lot to overcome resistances people had there to merging up the LTS
> which is going to help many people.  While that's a very large part of
> ARM ecosystem it's not all of it, there are also chip vendors and system
> integrators who have made deliberate choices to minimize out of tree
> code just as we've been encouraging them to.

Again great, go use 4.14.y for those systems please.  It's better in the
long run.

thanks,

greg k-h
