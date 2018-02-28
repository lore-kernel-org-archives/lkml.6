Date: Wed, 28 Feb 2018 10:49:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mei: remove dev_err message on an unsupported ioctl
Message-ID: <20180228094958.GA12946@kroah.com>
References: <20180227162105.14113-1-colin.king@canonical.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
 <20180227181005.GA19944@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A72C@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422A72C@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 09:44:41PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Feb 27, 2018 at 05:26:22PM +0000, Winkler, Tomas wrote:
> > > >
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > >
> > > > Currently the driver spams the kernel log on unsupported ioctls
> > > > which is unnecessary as the ioctl returns -ENOIOCTLCMD to indicate this
> > anyway.
> > > > I suspect this was originally for debugging purposes but it really
> > > > is not required so remove it.
> > > >
> > >
> > > This is rather strange as most of the legimit applications are using
> > > one IOCTL from kernel 3.0 Do you have any reference where this call is
> > originated from, frankly this is the first time I got such complain.
> > >
> > > In any case it would be maybe better to change it a warn once call.
> > 
> > Just drop the message, it should not be this easy for userspace to spam the
> > kernel log.  The patch looks fine to me.
> > 
> Fair enough, add my ack too.
> 
> Still I'm curious if this comes from the field.

fuzzers are "in the field" :)
