Date: Thu, 24 May 2018 13:05:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
Message-ID: <20180524110546.GA16171@kroah.com>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 12:50:11PM +0200, Jan Kara wrote:
> On Thu 24-05-18 11:38:27, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> Just one objection: Why does stable care about this (and the previous
> patch)? I've checked the stable queue and I don't see anything that would
> have these patches as a prerequisite. And on their own, they are only
> cleanups without substantial gains.

There's a small gain here:

> > paralleldd
> >                                     4.4.0                 4.4.0
> >                                   vanilla             avoidlock
> > Amean    Elapsd-1          5.28 (  0.00%)        5.15 (  2.50%)
> > Amean    Elapsd-4          5.29 (  0.00%)        5.17 (  2.12%)
> > Amean    Elapsd-7          5.28 (  0.00%)        5.18 (  1.78%)
> > Amean    Elapsd-12         5.20 (  0.00%)        5.33 ( -2.50%)
> > Amean    Elapsd-21         5.14 (  0.00%)        5.21 ( -1.41%)
> > Amean    Elapsd-30         5.30 (  0.00%)        5.12 (  3.38%)
> > Amean    Elapsd-48         5.78 (  0.00%)        5.42 (  6.21%)
> > Amean    Elapsd-79         6.78 (  0.00%)        6.62 (  2.46%)
> > Amean    Elapsd-110        9.09 (  0.00%)        8.99 (  1.15%)
> > Amean    Elapsd-128       10.60 (  0.00%)       10.43 (  1.66%)
> > 
> > The impact is small but intuitively, it makes sense to avoid unnecessary
> > calls to lock_page.

Yes, it's small, but it's marked in the SLES kernel as "needs to be
merged into stable", so obviously it matters to someone :)

thanks,

greg k-h
