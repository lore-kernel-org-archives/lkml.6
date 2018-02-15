Date: Thu, 15 Feb 2018 15:03:15 +0100
From: Greg KH <greg@kroah.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
Message-ID: <20180215140315.GA31443@kroah.com>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214222412.arg77l6vjpkje6pj@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
> > Hi Josh,
> > 
> > I recently did some randconfig testing with a plain 4.14-stable kernel
> > and gcc-7.3.0, and came across three distinct objtool warnings:
> > 
> > drivers/misc/lkdtm_bugs.o: warning: objtool:
> > lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame
> > 
> > crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool:
> > x509_note_pkey_algo()+0xa4: sibling call from callable instruction
> > with modified stack frame
> > 
> > drivers/infiniband/hw/bnxt_re/qplib_fp.o: warning: objtool:
> > bnxt_qplib_poll_cq()+0x106: sibling call from callable instruction
> > with modified stack frame
> > 
> > It's likely that this is the complete set at the moment, I saw each
> > one multiple times,
> > but did not see any others. I'll reply with the respective object
> > files for your reference,
> > in case these are so far unknown to you. There are only a handful of randconfig
> > warnings we see overall in the kernel these days (at least on x86 and arm64), so
> > even if they are false-positive, it would be great to get rid of the
> > output so we can
> > do randconfig testing on 4.14.y and treat any output from 'make -s' as
> > a regression.
> > I did not check
> 
> The third one has been fixed upstream with
> 
>   99ce7962d52d ("objtool: Fix switch-table detection")
> 
> ... so we should put that one into stable.

Now queued up, thanks.

greg k-h
