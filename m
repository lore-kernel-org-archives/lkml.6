Date: Sun, 18 Mar 2018 11:05:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pravin Shedge <pravin.shedge4linux@gmail.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/gyro/bmg160_core: Improve unlocking of a mutex in
 five functions
Message-ID: <20180318100515.GA13276@kroah.com>
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
 <20180317195422.037a8b57@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180317195422.037a8b57@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 07:54:22PM +0000, Jonathan Cameron wrote:
> On Wed, 14 Mar 2018 16:15:32 +0100
> SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 14 Mar 2018 16:06:49 +0100
> > 
> > * Add jump targets so that a call of the function "mutex_unlock" is stored
> >   only once in these function implementations.
> > 
> > * Replace 19 calls by goto statements.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Hi Markus,
> 
> Some of these are good and sensible changes - others break the code.
> Please be careful to fully check all the resulting paths and ensure
> we don't change wether the lock is still held in all exit paths.
> Note a function that isn't lockdep annotated should not be holding
> any locks, that it took, upon exit.

Please note that you are dealing with someone who is on many kernel
maintainer's email-blacklist, including my own.  I've found it's just
not worth the time and energy in responding to these emails, it's a
time-sink you will never find your way out of.

good luck!

greg k-h
