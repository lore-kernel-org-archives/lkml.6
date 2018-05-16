Date: Wed, 16 May 2018 17:38:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] driver-core: print bus registration error value
Message-ID: <20180516153818.GC23725@kroah.com>
References: <20180516120527.29403-1-flo@geekplace.eu>
 <20180516120527.29403-4-flo@geekplace.eu>
 <b49cf013-79ca-3ad3-14e2-9227fde5b080@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49cf013-79ca-3ad3-14e2-9227fde5b080@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 02:09:54PM +0200, Florian Schmaus wrote:
> On 16.05.2018 14:05, Florian Schmaus wrote:
> > Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> > ---
> > 
> > Notes:
> >     - Use correct member name 'bus_register_error'
> >     - Only print out error code if it is non-zero
> > 
> >  drivers/base/bus.c    |  4 +++-
> >  drivers/base/driver.c | 13 ++++++++++---
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index dce677dddba4..5814ecb07648 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -849,8 +849,10 @@ int bus_register(struct bus_type *bus)
> >  	struct lock_class_key *key = &bus->lock_key;
> >  
> >  	priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
> > -	if (!priv)
> > +	if (!priv) {
> > +		bus->bus_register_error = -ENOMEM;
> >  		return -ENOMEM;
> > +	}
> >  
> >  	priv->bus = bus;
> >  	bus->p = priv;
> 
> I'm sorry, this change was meant to be part of 2/3 (and not 3/3). Shall
> I send a v5 where this is fixed?

Well, I can't take it as-is, so of course :)

thanks,

greg k-h
