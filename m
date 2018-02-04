Date: Sun, 4 Feb 2018 12:15:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180204111500.GB14797@kroah.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
 <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204090531.GA29468@amd>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 10:05:31AM +0100, Pavel Machek wrote:
> On Sun 2018-02-04 00:30:36, Sasha Levin wrote:
> > On Sat, Feb 03, 2018 at 09:35:26PM +0100, Pavel Machek wrote:
> > >On Sat 2018-02-03 18:00:59, Sasha Levin wrote:
> > >> From: Matthieu CASTET <matthieu.castet@parrot.com>
> > >>
> > >> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> > >>
> > >> With the current code, the following sequence won't work :
> > >> echo timer > trigger
> > >>
> > >> echo 0 >  delay_off
> > >> * at this point we call
> > >> ** led_delay_off_store
> > >> ** led_blink_set
> > >> *** stop timer
> > >> ** led_blink_setup
> > >> ** led_set_software_blink
> > >> *** if !delay_on, led off
> > >> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW is set but timer is stop
> > >> *** otherwise start timer/set LED_BLINK_SW flag
> > >>
> > >> echo xxx > brightness
> > >> * led_set_brightness
> > >> ** if LED_BLINK_SW
> > >> *** if brightness=0, led off
> > >> *** else apply brightness if next timer <--- timer is stop, and will never apply new setting
> > >> ** otherwise set led_set_brightness_nosleep
> > >>
> > >> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
> > >
> > >Can you run the tests on the affected stable kernels? I have feeling
> > >that the problem described might not be present there.
> > 
> > Hm, I don't seem to have HW to test that out. Maybe someone else does?
> 
> Why are you submitting patches you have no way to test?

What?  This is stable tree backporting, why are you trying to make a
requirement for something that we have never had before?

This is a backport of a patch that is already upstream.  If it doesn't
belong in a stable tree, great, let us know that, saying why it is so.

thanks,

greg k-h
