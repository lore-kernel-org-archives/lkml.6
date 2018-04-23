Date: Mon, 23 Apr 2018 10:41:08 +0200
From: Greg KH <greg@kroah.com>
To: Johan Hovold <johan@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20180423084108.GA19889@kroah.com>
References: <20180423130444.0672fb80@canb.auug.org.au>
 <20180423083011.GP9198@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423083011.GP9198@localhost>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:30:11AM +0200, Johan Hovold wrote:
> On Mon, Apr 23, 2018 at 01:04:44PM +1000, Stephen Rothwell wrote:
> > Hi Greg,
> > 
> > Today's linux-next merge of the usb tree got a conflict in:
> > 
> >   drivers/usb/core/hcd.c
> > 
> > between commit:
> > 
> >   63cb03f5c11e ("usb: core: split usb_phy_roothub_{init,alloc}")
> > 
> > from the usb.current tree and commit:
> > 
> >   bc40f5341741 ("USB: core: hcd: drop support for legacy phys")
> > 
> > from the usb tree.
> > 
> > I fixed it up (see below - though I am not sure what happens to the
> > phy_roothub allocation when usb_phy_roothub_init fails) and can carry
> > the fix as necessary.
> 
> The resolution looks correct to me. The allocations done by
> usb_phy_roothub_alloc() are device managed and would be freed on probe
> failures (or unbind) so not explicit dealloc is needed. It might be a
> good idea to indicate that in the function name however (i.e. to add a
> devm_ prefix).

I'll take this same resolution when the branches get merged, thanks.

And yes, being more explicit would be a good idea for the function
name...

thanks,

greg k-h
