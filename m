Date: Tue, 24 Apr 2018 09:16:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
	linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <20180424071618.GB17825@kroah.com>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
 <20180423135024.GA2337@kroah.com>
 <7e2dbb73-f93d-7b87-2fa0-d8b40f4a11a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2dbb73-f93d-7b87-2fa0-d8b40f4a11a5@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 02:35:50AM +0200, Kirill Marinushkin wrote:
> On 04/23/18 15:50, Greg Kroah-Hartman wrote:
> > On Tue, Apr 17, 2018 at 07:00:28AM +0200, Kirill Marinushkin wrote:
> >> In the current implementation, vchi_instance is inited during the first
> >> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> >> memory leak when the module `snd_bcm2835` is removed.
> >>
> >> Here is how this commit fixes it:
> >>
> >> * the VCHI context (including vchi_instance) is created once in the
> >>   platform's devres
> >> * the VCHI context is allocated and connected once during module_init()
> >> * all created bcm2835_chips have a pointer to this VCHI context
> >> * bcm2835_audio_open_connection() can access the VCHI context through the
> >>   associated bcm2835_chip
> >> * the VCHI context is disconnected and freed once during module_exit()
> >>
> >> After this commit is applied, I don't see other issues with the module's
> >> init/exit, so I also remove the associated TODO task.
> >>
> >> Steps to reproduce the memory leak before this commit:
> > <snip>
> >
> > Patch dropped due to kbuild complaints.
> >
> > Please fix up and resend.
> >
> > thanks,
> >
> > greg k-h
> 
> Hello Greg,
> 
> Due to which complains of kbuild is the patch dropped?
> I would like to fix the complains, but I don't see any errors or warnings on my
> side.
> Are you sure that the kbuild test robot did it's job correctly? The log says:
> 
> >> it may well be a FALSE warning
> 
> Please show me what is wrong in my patch.

I have no idea as the patch is long gone from my queue now.  If you
think all is fine, please resend it and I will be glad to review it
again.

thanks,

greg k-h
