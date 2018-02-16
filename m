Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518804000; cv=none;
        d=google.com; s=arc-20160816;
        b=lQt5e1ClzWlu6r/fD7HWDyTvyyE4CI4I6j+GHrZsM3AbyNDb58GDzDKCyIY6B1Ystk
         ohGIxp1Xr9GsSO/AoU1GM7P0qwbyUKLI2FJOkDwzVdKC0xLVE+uyIuxs+ntOAoIGIjr5
         74NNJW10UnQF82oINFaZNnIZ10nNZj+bdF4rVt8pnCAKywSrrOXSuf8oPzvRRvrBJcyJ
         edxGu/bTQq4waBqfUkRktSk/ZnLCHc8kksAEIxlPmQE/rUAspL4TnJVWgycGluU1zRXy
         zEfpZYtlghmGJvgtVAt3OG46PCn93dGJ8mLElhHj+X0t28uboKOHqzk24H7BBKIYtsJa
         daaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RUnQDl8xQLsRDlnXnGSmOKF8m5xJZ/nxLab/v18Gka4=;
        b=yvT6haGLQkoLfMK6lsLDwTR25MSLIjO4l8XAp8j+iUPVys2+7G/nDRtUmu4ZTCWxDQ
         IR3OB3BdVwVy2+l6ZEdFb7g0GwGEIEmXYRLhvLaIelAfT+os4QlxK4mtvpFmg1DhFD12
         ZX3l0V0JCK6gA22MuixjI2srKvqUZurmA25j2lkloD3gk5eCiwqQjAzFLkPoLKurmv4d
         76ymp1o5ge4Ja41Fbzgj6+8qmxYaAb5wgQCBSPUZ/6pWuMLx1Fj2pdWrQzMh9Fh//JXw
         tx2ZyT5DC8V8MLf41MzSQL+oB7mLMjBBCPpAUO2U4muivsBm0mkL+TfiYwQ+65ZCuaJt
         NRgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Kjasevoj;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Kjasevoj;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225bCvWy9NCP4GzL1TNRDsJqj0Zy0Xo9v0zzLrTtE6UzsmvCCVcFZArxdGIj4/YKtl8tyuOEiA==
Date: Fri, 16 Feb 2018 09:59:57 -0800
From: Brian Norris <briannorris@chromium.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>,
	linux-serial@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Daniel Drake <drake@endlessm.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	matadeen@qti.qualcomm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Message-ID: <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592481108912063395?=
X-GMAIL-MSGID: =?utf-8?q?1592581423973850193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, Feb 16, 2018 at 01:10:20PM +0100, Hans de Goede wrote:
> On 16-02-18 12:45, Marcel Holtmann wrote:
> > Hi Hans,
> > 
> > > > > > > Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> > > > > > > removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
> > > > > > > instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
> > > > > > > 
> > > > > > > This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
> > > > > > > has several issues (see the original commit message). An added advantage
> > > > > > > of moving over to the USB-core reset-resume handling is that it also
> > > > > > > disables autosuspend for these devices, which is similarly broken on these.
> > > > > > 
> > > > > > Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
> > > > > > think so -- I'm using one now.
> > > > > 
> > > > > And have you manually enabled USB autosuspend for it, or are you
> > > > > running something which might have done so, e.g. powertop --auto-tune ?
> > > > > 
> > > > > Because if you did not do that then you're already not using autosuspend
> > > > > for your QCA devices and this patch will change nothing.
> > > > I use a set of udev rules that manually whitelist devices for
> > > > autosuspend. You can see it here:
> > > > https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
> > > > You'll find at least one Rome chip in there.
> > > > 
> > > > > > Thus, this is a poor solution, which
> > > > > > negatively affects my systems. However, I see that this patch was
> > > > > > applied regardless...
> > > > > 
> > > > > Note that there already is a quirk to handle broken suspend/resume
> > > > > behavior on ALL QCA devices in older kernels. Also note that the
> > > > Yes, and the quirk was broken, and I made sure it got reverted when it
> > > > broke my devices ;)
> > > 
> > > Note that the revert for this:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d06d5895c15
> > > 
> > > Says: "This commit causes a regression on some QCA ROME chips. The USB device reset happens
> > > in btusb_open(), hence firmware loading gets interrupted."
> > > 
> > > And says:
> > > 
> > > "If we really want to reset the USB device, we need to do it before btusb_open(). Let's
> > > handle it in drivers/usb/core/quirks.c."

Just a note: I didn't write that part ;) I also didn't have evidence to
say that *no* QCA chipset was broken. I just knew that on my platform
with my QCA ROME chipset, there was no problem.

> > > It does not mention that the quirk is not necessary on some devices only
> > > that the implementation of it we had before had issues.
> > > 
> > > And the original commit of the quirk:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=fd865802c66bc451dc515ed89360f84376ce1a56
> > > 
> > > Says: "There's been numerous reported instances where BTUSB_QCA_ROME
> > > bluetooth controllers stop functioning upon resume from suspend."
> > > 
> > > So it may be platform specific but it is not just limited to 1 or
> > > 2 platforms I think.

Understood for most of the above. But I'll stick a "citation needed" on
the "numerous reported instances" claim. As I note below, I believe that
is the crux of the problem: understanding what platforms actually
reported this problem. All attempts to "fix" it have broken things in
one way or another, which have just caused noise since then.

> > > Note I'm not saying that I don't believe you that the quirk is not
> > > necessary on your devices.
> > > 
> > > > > patches series which this commit builds on top of was already
> > > > > setting USB_QUIRK_RESET_RESUME for some devices in
> > > > > usb/core/quirks.c.
> > > > > 
> > > > > All my commit does is instead of duplicating all the QCA USB-ids in
> > > > > usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
> > > > > to btusb.c so that we don't need to duplicate the USB-id tables.
> > > > I was slightly more OK with marking specific IDs as broken, because
> > > > those IDs didn't happen to be ones that I knew were currently working.
> > > > Now you're breaking my systems again. But this time, it's more subtle
> > > > because bluetooth will still work, but we just suck more power leaving
> > > > our USB port active all the time.
> > > 
> > > I see, sorry about that. Ok, so we are going to need to make the
> > > reset-on-resume quirking more fine grained. I can see 3 ways to do this:
> > > 
> > > 1) Make it a separate per usb-id BTUSB_RESET_RESUME flag in the
> > > usb_device_id table inside btusb.c (I still believe duplicating most
> > > ids to usb/core/quirks.c is a bad idea).
> > > 
> > > 2) Use dmi based whitelisting to opt out of reset-resume behavior on
> > > QCA btusb devices.
> > > 
> > > 3) Use dmi based blacklisting which enables reset-resume behavior.
> > > 
> > > In retrospect I guess 3 would have been best, but if we do that now
> > > it will cause regressions.
> > > 
> > > I guess we should go with 1. adding the BTUSB_RESET_RESUME to all the
> > > QCA usb-ids except for the ones where you know things work and which
> > > only seem to be used in working devices (based on you not having
> > > objections against the additions of the quirk for some ids to
> > > drivers/usb/core/quirks.c).
> > > 
> > > And if then those usb-ids do turn out to have broken suspend on
> > > on some devices too I guess we need to move to 2.
> > 
> > actually if this is really platform related as Qualcomm is indicating, then we should just go with 3) and the two platforms that previously added quirks to usb/core/quirks.c and blacklist these. I am all for figuring out what is going on here. So lets blacklist these and see how this goes. Maybe there are only two bad platforms out there and we are making too much fuzz about this. Before we added quirks in the USB core these platforms were just plain broken as well. So not much different situation than before. We need to push the DMI blacklisting back into -stable as well and that means any impact of a 3rd broken platform briefly working and then be broken again is slim and also fixable via -stable.
> 
> Ok, I've asked the reporter of:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1514836

Are you even sure that this reporter is seeing the original symptom at
all (BT loses power, and therefore firmware)? Their report shows them
running 4.15, which had this commit:

fd865802c66b Bluetooth: btusb: fix QCA Rome suspend/resume

which is admittedly completely broken. It breaks even perfectly working
BT/USB devices, like mine. That's where I first complained, and we got
this into 4.16-rc1:

7d06d5895c15 Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Isn't it possible your reporter has no further problem, and none if this
is actually important to them? I'd just caution you to be careful before
assuming you need to add blacklist info for their DMI...

As I read it, you need to investigate who are the "numerous reported
instances" that generated commit fd865802c66b in the first place. That's
where this mess started, IIUC.

But otherwise, yes, option 3 sounds OK. FWIW, my systems are ARM based
and don't have DMI data, so option 2 wouldn't work.

> Which is how I got involved in this to provide DMI data and
> I will whip up a patch for his machine and ask him to test
> and once that is done submit upstream. This is the only machine
> I'm aware of though and looking at the history of this I think
> there will be others.
> 
> > I addition we can add a module option to btusb.ko that allows us to force this flag to be set. That way testing this is easy on a vendor kernel. A bunch of the btusb quirks (and also core quirks) can be tested via module options or debugfs.
> 
> Yes a module option for this is a good idea.

That too. Or, would be nice to be able to force it either way. So if
someone erroneously sticks the flag in this driver (yet again), we can
easily undo that.

Brian
