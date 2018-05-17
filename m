Return-Path: <heikki.krogerus@linux.intel.com>
X-Cyrus-Session-Id: sloti22d1t05-1793992-1526547578-2-5450226732355642140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.115', Host='mga14.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: heikki.krogerus@linux.intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526547577; b=WQUlnyHlDqTsQE1IdwJwHw8SefDavePEUVQUAF1rekbU2+aUeZ
    IEXoeNpCIdVbTOG8UuuuFYCOJ0MyZHV2wJObO6nyyn6B7mldcNkhSsI2R1EbJkNM
    FVtJXxxzV/zVa2QmFV2o+1SgM7LV8rHu95uxzysrDP+4T4LjPG9sD6iAtGEYxQLg
    yK2tvTt+ejqgc0eHEGA/z9bGdIxLNEICiKkKF983Cwiu+JxIk65f98wO5G5IrXAE
    MLXNoPy91kehO5IGKJp+hNbs0A1zQtfFlr0b6hLUM1yh69fMxTbOOgAKHE+IKahA
    sUmbZ11OoHY+F9XKgJaBC/fVrf5bm88a4ygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1526547577; bh=P4aBcbsKFT/u+lktdgK9jIz5ikqZHm6/HIxCebcjcC8=; b=X
    y3KHQ+hqbFv01thtpZh63t850dbQG70EkSg53mZw3l1j7lyvDizAwT8M6Do0WLRo
    t5ciIspIi/x66Pu3pcKVdmZcK0tmU3Fs1ZKSBBXOeeqBL/y5tfz6aKHgo9ooasI4
    c5zBuGNzoLl4F4Ym1en0Lfsa47cnh7tXNg55mjO0OJU12kjvXVUz3itSNG3vWEuI
    pk3+Qbql3C0ifXKyoft/xB/HEB49c967JeVeYcYQDujes595c5OfH1e2H53ukYwp
    BSl4vmyV4rsU4gnxq3R99mxSwdsm5jb/DIJ9nU0LD3lxWc3w0aCBYIb4Ifb4tzl9
    D1LiJIX4uzAaQ33dFMOmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.115 (mga14.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com
    smtp.helo=mga14.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga14.intel.com x-ptr-lookup=mga14.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
    smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.115 (mga14.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com
      smtp.helo=mga14.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga14.intel.com x-ptr-lookup=mga14.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
      smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK45axv4p8c4iCsIl2jOtl40zePxNM2M+AQJ4Y282WVsKGDBMeGGcL0fDWblhe8etPo1d8n/jWI8viMyAi+6Vw/yNNHJYp1pllspOF9kfo/AaLNHuF5K
    AypZYBfUOgPjK2cWUaAx3g2LLb9I1WSdbRUZ9s1PyKixLdnusIILG57GWI+uIyp6jp0rRLSu/nOigfCbi/A56eOd02ZQxl8YYzo=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=yPSvGpHfZI9xrpk/7ex/9g==:117
    a=yPSvGpHfZI9xrpk/7ex/9g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=rjT2J9Hn4RHZn3hHkGIA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="56034644"
Date: Thu, 17 May 2018 11:59:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Mario.Limonciello@dell.com
Cc: greg@kroah.com, pmenzel+linux-usb@molgen.mpg.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <20180517085930.GD11469@kuha.fi.intel.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, May 16, 2018 at 04:13:31PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com]
> > Sent: Wednesday, May 16, 2018 6:58 AM
> > To: Greg KH; Paul Menzel
> > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello, Mario
> > Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell XPS 13
> > 9370
> > 
> > Hi,
> > 
> > On Wed, May 16, 2018 at 10:02:26AM +0200, Greg KH wrote:
> > > On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:
> > > > Dear Greg,
> > > >
> > > >
> > > > As always, thank you for the prompt response.
> > > >
> > > >
> > > > On 05/15/18 18:00, Greg KH wrote:
> > > > > On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> > > >
> > > > > > Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with Debian
> > > > > > Sid/unstable.
> > > > > >
> > > > > > ```
> > > > > > [???]
> > > > > > [    0.440240] usb: port power management may be unreliable
> > > > > > [    0.441358] usbcore: registered new interface driver usb-storage
> > > > > > [    0.441367] usbcore: registered new interface driver usbserial_generic
> > > > > > [    0.441369] usbserial: USB Serial support registered for generic
> > > > > > [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0x2, got
> > > > > > 0x0
> > > > > > [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12
> > > > > > [???]
> > > > > > ```
> > > > > >
> > > > > > 1.  Are the ioremap and ucsi_acpi error related or is a separate report
> > > > > > needed?
> > > > >
> > > > > The ioremap error is what causes ucsi_acpi to fail the probe call (-12
> > > > > is "out of memory".)
> > > > >
> > > > > > 2.  Do you know the reason for the ucsi_acpi error?
> > > > >
> > > > > the call to ioremap failed.
> > > > >
> > > > > Does this device really have a working typec connector?
> > > >
> > > > Just to avoid misunderstandings, no device was connected to the laptop
> > > > during my test.
> > > >
> > > > But, from other boots, the Dell docking station TB16 kind of works with it,
> > > > so I???d say the USB Type-C connector is working.
> > >
> > > Ok, good, this might just be the acpi tables not set up properly for
> > > this type of connection.  Odd that the tables show it should work,
> > > Heikki should know more about this.
> > 
> > The firmware probable has not implemented UCSI on this board. I think
> > Dell always supplies the ACPI device node for UCSI in their acpi
> > tables. The _STA method in that device node is then used to inform the
> > OS if the interface exists or not. The return value for _STA comes
> > probable from BIOS, so this is most likely a BIOS problem.
> 
> Heikki,
> 
> I confirmed with internal team that UCSI is implemented on XPS 9370
> and was confirmed to be working properly with Windows 10 RS2+.

Just to double check: "UCSI was confirmed working properly", so not
"the Type-C ports were confirmed working properly"?

> The reason that _STA is responding on this device node now but wasn't
> previously is it wasn't exposed in Linux until 4.16 when the Win 10 RS2
> OSI string started to respond.

OK.

> Intel should internally have some XPS 9370 you can remotely access if
> you would like to poke around ACPI tables some.

I will try get access to XPS 9370, but with the acpi tables, if
somebody could just send me acpidump, that would be enough:

        % acpidump -o xps9370_acpi.dump

> > Please note that UCSI will only supply status information to the
> > operating system, so the USB Type-C ports will function normally even
> > without it. The ports are handled in firmware on these platforms.
> > 
> > Paul, do you have the latest BIOS?
> > 
> > 
> > > > > Does normal USB devices work with it?
> > > >
> > > > Sorry for being ignorant, but could you please tell me what normal USB
> > > > devices are?
> > >
> > > If you plug a USB typeC device into this port, does it work?  A docking
> > > station is a little bit "different" in that it usually uses the PCIe
> > > connection, not the USB connectors.  Or at least that's how my Dell
> > > docking station works last time I tried it[1]
> 
> I think the best description here is "Non-Thunderbolt" USB type C device.
> Some examples:
> There are Dell docking stations with Thunderbolt (TB16) or without (WD15).
> 
> You can also pick up little dongles for ethernet or combo dongles for
> ethernet/VGA/HDMI/etc.
> 
> Anything non-Thunderbolt would satisfy what Greg was looking for.

Anything non-Thunderbolt and non-display.

With the display adapters you would be in DisplayPort alternate mode,
and you would again not be testing a normal USB device.

It never hurts to check that, but I think it's safe to assume that the
ports are functioning normally if the Thunderbolt dock was working.
Unless I'm mistaken, even the xHCI USB host controller behind the
USB Type-C (thunderbolt) ports is actually part of the thunderbolt
controller.


Br,

-- 
heikki
