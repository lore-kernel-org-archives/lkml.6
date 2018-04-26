Date: Thu, 26 Apr 2018 09:04:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
Message-ID: <20180426070410.GM14025@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
 <20180425160645.GA16732@kroah.com>
 <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 07:53:06PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
> >> The driver_override implementation is susceptible to a race condition
> >> when different threads are reading vs storing a different driver
> >> override.  Add locking to avoid this race condition.
> >>
> >> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
> >> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
> >> condition with driver_override").
> >>
> >> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Reviewed-by: Todd Kjos <tkjos@google.com>
> >> Cc: stable <stable@vger.kernel.org>
> 
> > As this should go to stable kernels, I've fixed it up to apply without
> > patch 1 as that's not a real "fix" that anyone needs...
> >
> > Please try to remember to put fixes first, and then "trivial" things
> > later on in a series.
> 
> I did it on purpose, as the fix is much more ugly without patch 1 applied.
> Can't you just take patch 1, too? More consistency is always nice, even for
> stable ;-)

Consistency is nice, but when you have bug fixes that rely on "trivial"
patches, it's usually not nice :(

I already committed patch 2 to my tree without 1, so let's leave it
as-is for now.

thanks,

greg k-h
