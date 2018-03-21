Date: Wed, 21 Mar 2018 17:37:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: 4.9.80 compile failure with X86_VSYSCALL_EMULATION=n due to
 9a0be5af
Message-ID: <20180321163738.GA5269@kroah.com>
References: <20180212154325.ge4walt2m6u3ef7g@csclub.uwaterloo.ca>
 <20180321160424.GF18454@kroah.com>
 <1521649863.23626.130.camel@codethink.co.uk>
 <20180321163438.7q37vh7pncljib2a@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180321163438.7q37vh7pncljib2a@csclub.uwaterloo.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 12:34:38PM -0400, Lennart Sorensen wrote:
> On Wed, Mar 21, 2018 at 04:31:03PM +0000, Ben Hutchings wrote:
> > On Wed, 2018-03-21 at 17:04 +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 12, 2018 at 10:43:25AM -0500, Lennart Sorensen wrote:
> > > > Commit 9a0be5af added a reference to vsyscall_pgprot in
> > > > arch/x86/mm/kaiser.c but that is undefined if X86_VSYSCALL_EMULATION=n
> > > > which on an embedded system where you know how all your software is
> > > > compiled is quite likely.
> > > > 
> > > > Of course the condition is always false with that config so the code
> > > > will never be run, but the compiler is unhappy.
> > > 
> > > What is the compiler error?  I have not had any reports of this with all
> > > of the varied builds that we currently run on the stable trees.
> > 
> > You already applied a fix for this ("kaiser: fix compile error without
> > vsyscall").
> 
> Yeah the fix certainly works fine.  I was not the only one reporting it.

Ah, ok, sorry, was catching up on email...

greg k-h
