Date: Thu, 8 Mar 2018 17:09:28 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.4 16/34] led: core: Fix brightness setting when setting
 delay_off=0
Message-ID: <20180309010928.GB24548@kroah.com>
References: <20180302084435.842679610@linuxfoundation.org>
 <20180302084437.007951262@linuxfoundation.org>
 <1520436743.23626.33.camel@codethink.co.uk>
 <86d4536e-11d5-40c4-4186-21955f809005@gmail.com>
 <20180308172401.GB22224@kroah.com>
 <57e2a60a-34c6-cd8d-adaa-dedcd8e5257c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e2a60a-34c6-cd8d-adaa-dedcd8e5257c@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 09:48:08PM +0100, Jacek Anaszewski wrote:
> On 03/08/2018 06:24 PM, Greg Kroah-Hartman wrote:
> > On Wed, Mar 07, 2018 at 09:39:08PM +0100, Jacek Anaszewski wrote:
> >> Hi Ben,
> >>
> >> On 03/07/2018 04:32 PM, Ben Hutchings wrote:
> >>> On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
> >>>> 4.4-stable review patch.  If anyone has any objections, please let me
> >>>> know.
> >>>>
> >>>> ------------------
> >>>>
> >>>> From: Matthieu CASTET <matthieu.castet@parrot.com>
> >>>>
> >>>>
> >>>> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> >>>>
> >>>> With the current code, the following sequence won't work :
> >>>> echo timer > trigger
> >>>>
> >>>> echo 0 >  delay_off
> >>>> * at this point we call
> >>>> ** led_delay_off_store
> >>>> ** led_blink_set
> >>> [...]
> >>>
> >>> The commit message got cut truncated here, which resulted in addresses
> >>> being omitted when it was sent out for review.  The upstream commit
> >>> message refers to a LED_BLINK_SW flag which is not used in 4.4.  So
> >>> this fix probably isn't needed, though I can't tell whether it does any
> >>> harm.
> >>
> >> We discussed it in [0]. This patch is not needed for 4.4 and what's
> >> more more it is harmful. It introduces a bug, fixed in [1].
> >>
> >> [0] https://lkml.org/lkml/2018/2/6/726
> >> [1[ https://patchwork.kernel.org/patch/10253933/
> > 
> > So, did I mess something up here?  Am I missing some patch that I need
> > to apply, or do I need to revert something?
> > 
> > confused,
> 
> It needs to be reverted in 4.4-stable, and Ben's patch [0] does what's
> needed.
> 
> [0] https://www.spinics.net/lists/stable/msg223656.html

Ah great, that's now queued up.

thanks,

greg k-h
