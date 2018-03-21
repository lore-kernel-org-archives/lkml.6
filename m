Date: Wed, 21 Mar 2018 17:04:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: 4.9.80 compile failure with X86_VSYSCALL_EMULATION=n due to
 9a0be5af
Message-ID: <20180321160424.GF18454@kroah.com>
References: <20180212154325.ge4walt2m6u3ef7g@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212154325.ge4walt2m6u3ef7g@csclub.uwaterloo.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 10:43:25AM -0500, Lennart Sorensen wrote:
> Commit 9a0be5af added a reference to vsyscall_pgprot in
> arch/x86/mm/kaiser.c but that is undefined if X86_VSYSCALL_EMULATION=n
> which on an embedded system where you know how all your software is
> compiled is quite likely.
> 
> Of course the condition is always false with that config so the code
> will never be run, but the compiler is unhappy.

What is the compiler error?  I have not had any reports of this with all
of the varied builds that we currently run on the stable trees.

thanks,

greg k-h
