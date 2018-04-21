Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AIpwx49IRfZlyla1q6ryZ0ariVFxJQBfFZfumDppuLKF9iWSuAWsWsS4mGf0ThMUuRdituAMSAFR
ARC-Seal: i=1; a=rsa-sha256; t=1524321273; cv=none;
        d=google.com; s=arc-20160816;
        b=JERtJoO4yMn0n+DRRNWQklji+Ym5Cdk3Z/TALtpeler71cqSYTN5syBohTN008cVYI
         N0ZYJtrfzbHUD9ElD5WjTbiaGr0TUf9HLh/78YvMQjGGu7PNGtJnMp7sTuzCjmUjODZU
         n9DGJ30AD1VUukgc+id/k+I41q6QK2o11QdzjpBnNsVSGS8Q7KrJQ1u32OqGI93EEMdc
         Z0ZFrBnlD3aNMvAyzsBOPqPYnmQbiI7HSmRSiwtV+HblG+XAQl2DlvwCHpEh8YelPXw2
         TRYJHrP1kHKgfuveiBV8WWqLXe+AauFFhPdgd+i4oqyEYTKzEz3YobDclHZi7iZnE+KG
         bsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Rq8Co3F0+Xsjo1ssJRDHqyKMQemj+w1Y6Dd4u9N+wBo=;
        b=FoN/WOEgQQe8w/9qr1Rx55wnNgYT69baWDsYNQxSQ6QilCEEjO8dSEcRlgbCaRKMsV
         lqr1+9AG1+AWH8mDGxTdC4pMnLaCPLi5NKL256X45zqh8HzXzTVanlfiWu+R4m+lBaWv
         iihENkbga8Z6XcI8m+T8S4lB2ON0FwPGfV46+KF3TjAOFCEvmCkO0eloFvrhuUr5EvkI
         PkNpMpzQqd8Q986xNkzrVkQCMqfyKGg50sdqReNn25cQOOByOzQB0B15xXQP2Rn41lv1
         sy1gwicOhU/5gE1rsmn6cx1LLqw3Ar0YHFEBm/inomN41GCnnmRpJWo2UP96P+DGz2Lr
         w5Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=wfW1kFlK;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=wfW1kFlK;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Sat, 21 Apr 2018 09:34:26 -0500
From: Bin Liu <b-liu@ti.com>
To: Paul Kocialkowski <contact@paulk.fr>
CC: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard
	<maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596219936239404188?=
X-GMAIL-MSGID: =?utf-8?q?1598366704043343410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 12:59:23PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> Le vendredi 20 avril 2018 à 09:25 -0500, Bin Liu a écrit :
> > On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> > > Hi,
> > > 
> > > On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > > > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > > > > This allows dual-role ports to be reported as having gadget mode
> > > > > by
> > > > > the
> > > > > musb_has_gadget helper. This is required to enable MUSB at all
> > > > > with
> > > > > MUSB
> > > > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE
> > > > > at
> > > > > init.
> > > > > 
> > > > > Most notably, this allows calling musb_start when needed in the
> > > > > virtual
> > > > > MUSB root HUB, regardless of whether the current mode should be
> > > > > gadget
> > > > > or host.
> > > > > 
> > > > > This fixes USB OTG on Allwinner devices that I could test it
> > > > > with,
> > > > > mainly A20 devices.
> > > > > 
> > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > 
> > > > Surely there's more to it than that. The gadget mode of A20 boards
> > > > have been working in the past, including when compiling with mUSB
> > > > setup as dual role.
> > > > 
> > > > Is this a regression since a particular commit? Or is there
> > > > another,
> > > > deeper issue overlooked in the commit log?
> > > 
> > > The root of the issue here is that musb_start is not called at any
> > > point
> > > without this patch. My understanding of the flow is the following:
> > > when
> > > the PHY detects that there was a VBUS/ID change, it will notify its
> > > listeners (mainly the musb sunxi glue layer). This will then
> > > schedule
> > > the driver's work (sunxi_musb_work), which does nothing since the
> > > SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
> > > calling sunxi_musb_enable, which is called from
> > > musb_platform_enable,
> > > that originates from musb_start.
> > > 
> > > Currently I see two places where musb_start is called:
> > > * musb_virthub
> > > * musb_gadget
> > > 
> > > In the latter case, it is in turn called from udc_start, which
> > > should
> > > probably (correct me if I'm wrong) happen later in the call chain
> > > than
> > > ID/VBUS change notification time.
> > 
> > I don't think it is correct that udc_start() is triggered by ID/VBUS
> > events, but I don't have an Allwinner platform to verify the callflow.
> 
> Yes you're right, I didn't make myself very clear here. I didn't
> investigate the udc_start call path much since it was apparently not the
> culprit.
> 
> > Have you tried to load with a gadget driver? When a gadget function is
> > bound to UDC, udc_start() is triggered, which in turn calls
> > musb_start().
> 
> It does work under that scenario, although my used case here is using
> musb with DUAL_ROLE but no gadget driver loaded. That it, I want the
> musb_start call to originate from the virtual hub, not from the gadget
> side.
> 
> > > In the former case, musb_start is called in the root controller hub
> > > control, when setting the USB_PORT_FEAT_POWER feature. This looks
> > > perfectly legit and IMO this is where it should be initially calling
> > > musb_start in the dual role case. The kernel is indeed setting the
> > 
> > No actually. A dual-role port should be in b_idle state by default, so
> > logically all actions should go to the gadget path until the port
> > switches to host mode.
> 
> It makes sense that the port should be in b_idle state by default, but
> here it fails to switch to host mode when the ID pin detects that it
> should. Or does b_idle state entail that a gadget must be loaded (per
> the USB spec), and thus nothing should (ever) happen until that happens?
> 
> I find it really odd to need a gadget device to trigger host mode.
> This patch does fix the issue, but I am puzzled as to why it is needed
> in the first place. The comment above it mentions that "In OTG mode we
> have to wait until we loaded a gadget. We don't really need a gadget if
> we operate as a host but we should not start a session as a device
> without a gadget or else we explode.", which is apparently compatible
> with my use case: a gadget is not really needed and I'm not trying to
> start a session as a device without a gadget loaded.
> 
> What do you think?

Okay, this came down to an argument that whether we should require
loading a gadget driver on a dual-role port to work in host mode,
which is currently required on musb since a long long time ago.

I understand the requirement is kinda unnecessary, but since it already
exists on musb stack for a long time, I don't plan to change it. Because I
cannot think of a use case in real products that doesn't automatically
load a gadget function on the dual-role port.

If you can explain a use case in real world (not a engineering lab) that
the gadget driver will not be loaded at linux booting up, but later
based on user's input, I will reconsider my decision. To remove this
requirement from musb stack, the work is more than this patch.

Regards,
-Bin.
