Date: Tue, 27 Mar 2018 10:45:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Backlund <tmb@mageia.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Kash Pande <kash@tripleback.net>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180327084537.GA20469@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
 <20180319182032.GA23774@roeck-us.net>
 <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
 <20180327062808.GC28908@kroah.com>
 <7e14038c-23c2-80b6-9c93-7843cbb5c36f@roeck-us.net>
 <286aa785-7de8-ddf6-5fdb-55312aaa9422@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286aa785-7de8-ddf6-5fdb-55312aaa9422@mageia.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 11:33:00AM +0300, Thomas Backlund wrote:
> Den 27.03.2018 kl. 09:37, skrev Guenter Roeck:
> > On 03/26/2018 11:28 PM, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 26, 2018 at 01:54:18PM -0400, Kash Pande wrote:
> > > > On 2018-03-19 02:20 PM, Guenter Roeck wrote:
> > > > > Ryzen and Threadripper are only supported in v4.15+.
> > > > 
> > > > 
> > > > Nope, the offset for 1900X is not available in 4.15, I've had to
> > > > manually patch all systems otherwise monitoring complains they
> > > > idle at 53C.
> > > 
> > > I don't understand, what patch are you talking about here?
> > > 
> > 
> > 6509614fdd2d, but you'll also want aef17ca12719 if that isn't queued
> > already.
> > 
> > Guenter
> > 
> 
> And if you ant it to work in 4.14 longterm, you want the series:
> 
> 68546abf7a3a63f199e53d6dcaa7375df37a6aaa  hwmon: (k10temp) Move chip
> specific code into probe function
> 9af0a9aecdb945cd5513941ffdcbcc031009b402  hwmon: (k10temp) Add support for
> family 17h
> 1b50b776355fa6c6d7b3281a63c275d5c18d629d  hwmon: (k10temp) Add support for
> temperature offsets
> ab5ee24615f9dd8b0cd199403959f8b13309e7b1  hwmon: (k10temp) Correct model
> name for Ryzen 1600X
> 6509614fdd2d05c6926d50901a45d5dfb852b715  hwmon: (k10temp) Add temperature
> offset for Ryzen 1900X
> aef17ca1271948ee57cc39b2493d31110cc42625  hwmon: (k10temp) Only apply
> temperature offset if result is positive
> 
> 
> We have it in Mageia, and I've confirmed it works on a Ryzen 7 1700 and
> ThreadRipper 1950X

I'd like an ack from the hwmon maintainer before adding all of those, as
it really feels like a "backport new hardware support" type of request
that is a bit bigger than a normal "add some new device ids and quirks".

thanks,

greg k-h
