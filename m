Date: Wed, 25 Apr 2018 14:30:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Message-ID: <20180425123045.GA22950@kroah.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <20180424135749.GA21610@kroah.com>
 <20180424232633.s475bsccxjhm7lpy@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424232633.s475bsccxjhm7lpy@earth.universe>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 01:26:33AM +0200, Sebastian Reichel wrote:
> Hi Greg,
> 
> On Tue, Apr 24, 2018 at 03:57:49PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> > > This patch set adds sink side support for the PPS feature introduced in the
> > > USB PD 3.0 specification.
> > > 
> > > The source PPS supply is represented using the Power Supply framework to provide
> > > access and control APIs for dealing with it's operating voltage and current,
> > > and switching between a standard PDO and PPS APDO operation. During standard PDO
> > > operation the voltage and current is read-only, but for APDO PPS these are
> > > writable as well to allow for control.
> > > 
> > > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > > expectation is that the external user will be required to ensure re-requests
> > > occur regularly to ensure PPS remains and the source does not hard reset.
> > 
> > Sebastian, any objection from me taking this series through my USB tree?
> 
> I currently have the power-supply bits in a local branch for
> testing. I would like to have this in the power-supply
> tree, since there is at least one pending driver which could
> directly use the newly introduced usb_type.
> 
> I can either provide an immutable branch with a signed tag, or
> you can merged it and provide me an immutable branch.
> 
> If you merge it via the USB tree patch 2-4 are
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

I've applied these to a testing branch in my usb tree, and if they
survive the 0-day bot, I'll move them to a branch that you can pull from
that will not change.

Oh, I had to add a follow-on patch to fix up a gcc warning that really
wasn't a warning, but it saves us problems of people complaining about
it.

thanks,

greg k-h
