Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AH8x225Howj/np70MwheBVeCrNLhCVtYdtwWgqGf5hpfqtWHljI++cxWknUK9CzB8mfqsg/kUxGj
ARC-Seal: i=1; a=rsa-sha256; t=1519681156; cv=none;
        d=google.com; s=arc-20160816;
        b=fv8Y2xy/Jf/y4CwTCM+uTCK0sDs6W/4zbtDn0s/z9Yxlwck7pdEYSOqd4prT5KMz6e
         2ChmvsLEq9xvqxhI7l7u8urfqzlSSydNCqAcHn0rMQL+lBKUTddEGBWBeJGSmDoNznjf
         tZlRN1aoXyyk+d/U7P/ySLbtgwXZVJhq+Vx28mrzap7XzoPI1JThbWlJbdA3NQ/G924s
         EdrPS587B3aJfeavpGioJ/sKr/MctF9b4dbP76rXWwFzs1SpkM74wrcb5es1e0uyKkBr
         xBvi9tLx6XAwHMGGArX0HcbshstYZASqb7FkeogXxrbVb9+qRZsspmcgKkLRUXRIFQZI
         FKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=9w9dCQSwkUc7c4FLOehcc5MbgeS3Tw38hipu+tXue/w=;
        b=W6m2Ed0/rOaMOMmzUpL/1Fzb9Qu9WtyZ57TcvYYYi/Ts4vTXmzYhdNGZDHROxf7hDZ
         vua119iNmUucIidwcuVHO6ZTI/vQ+j3AAlM5Y5aNcMl/2+xQMp+WkOwewc+70A/hG/aJ
         XsBOB4ISPU0U+4ppI8wlOUVUMArOaO3xp+4Qki4mo1apqC3PQkMFRi5JU/qI8jqFgv4R
         VvR+w1RGMpg1mCtQK49oGE6puvlA6y3U8Av0A2LaSovcQRkb0PI/C8BZnjAVOuWsPq7I
         mywKRaPxMF4iJBT6fLbe9VH9qivL4WFAuzPMVazz0l2jkwxcG/TpBnlgFsqn80O03CC8
         rQRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 26 Feb 2018 22:38:53 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
 <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw
 Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan
 Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian
 Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 "Cyprian Wronka" <cwronka@cadence.com>, Suresh Punnoose
 <sureshp@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob
 Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Message-ID: <20180226223853.53163adc@bbrezillon>
In-Reply-To: <20180226214032.1c3f929a@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
	<20180223213000.407461d2@bbrezillon>
	<1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
	<20180226213607.7161bb0a@bbrezillon>
	<20180226214032.1c3f929a@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593501188368991771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Feb 2018 21:40:32 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Mon, 26 Feb 2018 21:36:07 +0100
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > > >>> +
> > > >>> +/**
> > > >>> + * struct i3c_master_controller_ops - I3C master methods
> > > >>> + * @bus_init: hook responsible for the I3C bus initialization. This
> > > >>> + *	      initialization should follow the steps described in the I3C
> > > >>> + *	      specification. This hook is called with the bus lock held in
> > > >>> + *	      write mode, which means all _locked() helpers can safely be
> > > >>> + *	      called from there
> > > >>> + * @bus_cleanup: cleanup everything done in
> > > >>> + *		 &i3c_master_controller_ops->bus_init(). This function is
> > > >>> + *		 optional and should only be implemented if
> > > >>> + *		 &i3c_master_controller_ops->bus_init() attached private data
> > > >>> + *		 to I3C/I2C devices. This hook is called with the bus lock
> > > >>> + *		 held in write mode, which means all _locked() helpers can
> > > >>> + *		 safely be called from there
> > > >>> + * @supports_ccc_cmd: should return true if the CCC command is supported, false
> > > >>> + *		      otherwise
> > > >>> + * @send_ccc_cmd: send a CCC command
> > > >>> + * @send_hdr_cmds: send one or several HDR commands. If there is more than one
> > > >>> + *		   command, they should ideally be sent in the same HDR
> > > >>> + *		   transaction
> > > >>> + * @priv_xfers: do one or several private I3C SDR transfers
> > > >>> + * @i2c_xfers: do one or several I2C transfers
> > > >>> + * @request_ibi: attach an IBI handler to an I3C device. This implies defining
> > > >>> + *		 an IBI handler and the constraints of the IBI (maximum payload
> > > >>> + *		 length and number of pre-allocated slots).
> > > >>> + *		 Some controllers support less IBI-capable devices than regular
> > > >>> + *		 devices, so this method might return -%EBUSY if there's no
> > > >>> + *		 more space for an extra IBI registration
> > > >>> + * @free_ibi: free an IBI previously requested with ->request_ibi(). The IBI
> > > >>> + *	      should have been disabled with ->disable_irq() prior to that
> > > >>> + * @enable_ibi: enable the IBI. Only valid if ->request_ibi() has been called
> > > >>> + *		prior to ->enable_ibi(). The controller should first enable
> > > >>> + *		the IBI on the controller end (for example, unmask the hardware
> > > >>> + *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
> > > >>> + *		to the I3C device
> > > >>> + * @disable_ibi: disable an IBI. First send the DISEC CCC command with the IBI
> > > >>> + *		 flag set and then deactivate the hardware IRQ on the
> > > >>> + *		 controller end
> > > >>> + * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI has been
> > > >>> + *		      processed by its handler. The IBI slot should be put back
> > > >>> + *		      in the IBI slot pool so that the controller can re-use it
> > > >>> + *		      for a future IBI
> > > >>> + *
> > > >>> + * One of the most important hooks in these ops is
> > > >>> + * &i3c_master_controller_ops->bus_init(). Here is a non-exhaustive list of
> > > >>> + * things that should be done in &i3c_master_controller_ops->bus_init():
> > > >>> + *
> > > >>> + * 1) call i3c_master_set_info() with all information describing the master
> > > >>> + * 2) ask all slaves to drop their dynamic address by sending the RSTDAA CCC
> > > >>> + *    with i3c_master_rstdaa_locked()
> > > >>> + * 3) ask all slaves to disable IBIs using i3c_master_disec_locked()
> > > >>> + * 4) start a DDA procedure by sending the ENTDAA CCC with
> > > >>> + *    i3c_master_entdaa_locked(), or using the internal DAA logic provided by
> > > >>> + *    your controller        
> > > >> You mean SETDASA CCC command?      
> > > > No, I really mean ENTDAA and DAA. By internal DAA logic I mean that
> > > > some controllers are probably automating the whole DAA procedure, while
> > > > others may let the SW control every step.      
> > > My understanding is that i3c_master_entdaa_locked() will trigger the DAA process
> > > and DAA can be done by SETDASA, ENTDAA and later after the bus initialization
> > > with SETNEWDA.    
> > 
> > No. Only ENTDAA can trigger a DAA procedure. SETDASA is here to assign
> > a single dynamic address to a device that already has a static address
> > but no dynamic address yet, and SETNEWDA is here to modify the dynamic
> > address of a device that already has one.
> >   
> > > 
> > > I think the DAA process should be more generic, right now is only made through
> > > the ENTDAA command with (cmd.ndests = 1).
> > > I mean, shouldn't this be made by the core? First doing DAA for the devices
> > > declared and them try do discover the rest of devices on the bus.    
> > 
> > Can you detail a bit more? If the only part you're complaining about is
> > pre-assignment of dynamic addresses with SETDASA when a device is
> > declared in the DT with a reg and dynamic-address property, then yes, I
> > think I can provide an helper for that. But this helper would still have
> > to be called from the master controller driver (from ->bus_init() or
> > after a Hot-Join).
> > 
> > Now, if the question is, is there a way we can automate things even more
> > and completely implement DAA from the core? I doubt it, because the way
> > the core will trigger DAA, expose discovered devices or allow you to
> > declare manually assigned addresses is likely to be
> > controller-dependent.
> > When I designed the framework I took the decision to base my work on the
> > spec rather than focusing on the I3C master controller I had to support
> > (Cadence). This is the reason I decided to keep the interface as simple
> > as possible at the risk of encouraging code-duplication (at first)
> > rather than coming up with an interface that is designed with a single
> > controller in mind and having to break things every time a new
> > controller comes out.
> > 
> > Thank you for you comments, but I'd like to know if some of my design
> > choices are blocking you to support your controller. What I've seen so
> > far is a collection of things that might be relevant to fix (though
> > most of them are subject to interpretation and/or a matter of taste),
> > but nothing that should really block you.  
> 
> Well, that's not entirely true: I agree that something is missing in
> ->priv_xfers() to let the controller know about the device limitations,  
> and this could be a blocking aspect.
> 

And I2C functionalities might differ between I3C master controllers, so
that's also something we should transfer to the I3C master driver
instead of imposing it in the core.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
