Date: Thu, 5 Apr 2018 16:19:33 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Stuart Yoder <stuyoder@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180405141933.GA29178@kroah.com>
References: <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
 <20180405123018.GA17751@kroah.com>
 <5AC62E2A.90900@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AC62E2A.90900@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 02:09:47PM +0000, Laurentiu Tudor wrote:
> Hi Greg,
> 
> On 04/05/2018 03:30 PM, gregkh wrote:
> > On Thu, Apr 05, 2018 at 10:30:01AM +0000, Laurentiu Tudor wrote:
> >> Hello,
> >>
> >> My 2c below.
> >>
> >> On 04/04/2018 03:42 PM, Andrew Lunn wrote:
> >>>> I hear you.  It is more complicated this way...having all these individual
> >>>> objects vs just a single "bundle" of them that represents a NIC.  But, that's
> >>>> the way the DPAA2 hardware is, and we're implementing kernel support for
> >>>> the hardware as it is.
> >>>
> >>> Hi Stuart
> >>>
> >>> I see we are not making any progress here.
> >>>
> >>> So what i suggest is you post the kernel code and configuration tool
> >>> concept to netdev for a full review. You want reviews from David
> >>> Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.
> >>>
> >>
> >> I think that the discussion steered too much towards networking related
> >> topics, while this ioctl doesn't have much to do with networking.
> >> It's just an ioctl for our mc-bus bus driver that is used to manage the
> >> devices on this bus through userspace tools.
> >> In addition, I'd drop any mention of our reference user space app
> >> (restool) to emphasize that this ioctl is not added just for a
> >> particular user space app. I think Stuart also mentioned this.
> >
> > I'm not going to take a "generic device configuration ioctl" patch
> > unless it is documented to all exactly what it does, and why it is
> > there.
> 
> The ioctl() is just a simple pass-through interface to the firmware.

Ah, so a new syscall?  :)

> It passes commands to the firmware and returns the response back to the 
> userspace. Thus the ABI used by the firmware applies for this ioctl() 
> and it is documented in detail here:
> 
> https://www.nxp.com/docs/en/user-guide/DPAA2_UM.pdf

Let's wait on this until people all agree that it's ok to expose this
directly.

thanks,

greg k-h
