Date: Tue, 13 Feb 2018 09:54:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark D Rustad <mrustad@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180213085429.GB10278@kroah.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
 <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl>
 <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 09:40:41AM -0800, Mark D Rustad wrote:
> > On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> > 
> >> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
> >> 32-bit install?
> > 
> > Quite easy, yeah.  Crossgrading userspace is not for the faint of the heart,
> > but changing just the kernel is fine.
> 
> ISTR that iscsi doesn't work when running a 64-bit kernel with a
> 32-bit userspace. I remember someone offered kernel patches to fix it,
> but I think they were rejected. I haven't messed with that stuff in
> many years, so perhaps the userspace side now has accommodation for
> it. It might be something to check on.

IPSEC doesn't work with a 64bit kernel and 32bit userspace right now.

Back in 2015 someone started to work on that, and properly marked that
the kernel could not handle this with commit 74005991b78a ("xfrm: Do not
parse 32bits compiled xfrm netlink msg on 64bits host")

This is starting to be hit by some Android systems that are moving
(yeah, slowly) to 4.4 :(

thanks,

greg k-h
