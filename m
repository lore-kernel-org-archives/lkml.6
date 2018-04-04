Return-Path: <pjones@redhat.com>
X-Google-Smtp-Source: AIpwx4838076HKC/6EboC6DCqke8U67w5j4mjY0MH6M5KHZDhmV6nrppkxlwvT/Vu3I/zJXtwsXO
ARC-Seal: i=1; a=rsa-sha256; t=1522862321; cv=none;
        d=google.com; s=arc-20160816;
        b=oqQ06JPUQ1TZULoC8gWCkY2seNB2Dji/GxLje/S16iKdFgVTTz5DBGYxyYO2suaz93
         fgmg2Z7wXp6OGvUxYaqIP9kFKt/n7CJetv6kLGFcIJCMW+mBMElDHxa7Jci7udM2BEff
         pNLsbJpBpMH3gAvRZAKjdQ0yUs5XTjjQTPzu0ITmMPSE9C51EnSXcPHCbqqEoINqjD3Z
         kdeoPQ+OlVYjtkcQFY3C6ugtMkpalPZ94lSRQ4YNU8goOkis6OCj5ev4MPD3m+4hTNjG
         JP/bQtIQfURKxW6w5O64TM/x5ZADJxCStPOviLr6uIC5Lg8D6iM18/p3WacxK1zhCi5N
         HKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=H72dnCec+fFeIUtByEiRE0tHT6gqa052i2swcaLBad4=;
        b=B9pvfZNXANrWT2CcaVnWuwBhK8wz8sD2jpr1OIVafUz3UNKD25isb9X5ZylNU0Hcpz
         UTKeULln0E0iWEOBhbL8ZhQUc6g/X5NyEZF8L9iUJDJuoa+ByFPSYKd2CPfqQg3pyj/8
         6fvY5CfkXBWI77JkiPNETzT+WySgAzdIQL0odjTm6h3OvgfIHgEfuAjGr66vkRdxlJPn
         z540Ecto1KSDzYPqQdxmV2ekoSBDAiKPNCrDbfeykuGyahegwosrQfh8erUVkz+5xfwx
         cn7R38+Vpz1zUh0pi4C6flVyz8r0T8qvxhlFsriyeSLGEI+excB7MkkPSQbH01Ciu0Nz
         YDzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pjones@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pjones@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pjones@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pjones@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 4 Apr 2018 13:18:36 -0400
From: Peter Jones <pjones@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, Dave Olsthoorn <dave@bewaar.me>,
	x86@kernel.org, linux-efi@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
	keescook@chromium.org, nbroeking@me.com, bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH 2/2] efi: Add embedded peripheral firmware support
Message-ID: <20180404171835.xvllgcqirl3b5gd5@redhat.com>
References: <20180331121944.8618-1-hdegoede@redhat.com>
 <20180331121944.8618-2-hdegoede@redhat.com>
 <20180402232333.GU30543@wotan.suse.de>
 <17fb3c28-78ff-2e1f-2ada-d33320567761@redhat.com>
 <20180403180711.GA7957@wunner.de>
 <20180403185848.GD30543@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403185848.GD30543@wotan.suse.de>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1596836882145385475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 06:58:48PM +0000, Luis R. Rodriguez wrote:
> On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
> > On Tue, Apr 03, 2018 at 10:33:25AM +0200, Hans de Goede wrote:
> > > I asked Peter Jones for suggestions how to extract this during boot and
> > > he suggested seeing if there was a copy of the firmware in the
> > > EFI_BOOT_SERVICES_CODE memory segment, which it turns out there is.
> > > 
> > > My patch to add support for this contains a table of device-model (dmi
> > > strings), firmware header (first 64 bits), length and crc32 and then if
> > > we boot on a device-model which is in the table the code scans the
> > > EFI_BOOT_SERVICES_CODE for the prefix, if found checks the crc and
> > > caches the firmware for later use by request-firmware.
> > > 
> > > So I just do a brute-force search for the firmware, this really is hack,
> > > nothing standard about it I'm afraid. But it works on 4 different x86
> > > tablets I have and makes the touchscreen work OOTB on them, so I believe
> > > it is a worthwhile hack to have.
> > 
> > The EFI Firmware Volume contains a kind of filesystem with files
> > identified by GUIDs.  Those files include EFI drivers, ACPI tables,
> > DMI data and so on.  It is actually quite common for vendors to
> > also include device firmware on the Firmware Volume.  Apple is doing
> > this to ship firmware updates e.g. for the GMUX controller found on
> > dual GPU MacBook Pros.  If they want to update the controller's
> > firmware, they include it in a BIOS update, and an EFI driver checks
> > on boot if the firmware update for the controller is necessary and
> > if so, flashes it.
> > 
> > The firmware files you're looking for are almost certainly included
> > on the Firmware Volume as individual files.
> 
> What Hans implemented seems to have been for a specific x86 hack, best if we
> confirm if indeed they are present on the Firmware Volume.

To be honest, I'm a bit skeptical about the firmware volume approach.
Tools like UEFITool[0] and uefi-firmware-parser[1] have existed for
years, still don't seem to reliably parse firmware images I see in the
wild, and have a fairly regular need for fixes.  These are tools
maintained by smart people who are making a real effort, and it still
looks pretty hard to do a good job that applies across a lot of
platforms.

So I'd rather use Hans's existing patches, at least for now, and if
someone is interested in hacking on making an efi firmware volume parser
for the kernel, switch them to that when such a thing is ready.

[0] git@github.com:LongSoft/UEFITool.git
[1] git@github.com:theopolis/uefi-firmware-parser.git

> > Rather than scraping
> > the EFI memory for firmware, I think it would be cleaner and more
> > elegant if you just retrieve the files you're interested in from
> > the Firmware Volume.
> > 
> > We're doing something similar with Apple EFI properties, see
> > 58c5475aba67 and c9cc3aaa0281.
> > 
> > Basically what you need to do to implement this approach is:
> > 
> > * Determine the GUIDs used by vendors for the files you're interested
> >   in.  Either dump the Firmware Volume or take an EFI update as
> >   shipped by the vendor, then feed it to UEFIExtract:
> >   https://github.com/LongSoft/UEFITool
> >   
> > * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
> >   https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
> > 
> > * Amend arch/x86/boot/compressed/eboot.c to read the files with the
> >   GUIDs you're interested in into memory and pass the files to the
> >   kernel as setup_data payloads.
> > 
> > * Once the kernel has booted, make the files you've retrieved
> >   available to device drivers as firmware blobs.
> 
> Happen to know if devices using Firmware Volumes also sign their firmware
> and if hw checks the firmware at load time?

It varies on a per-device basis, of course.  Most new Intel machines as
of Haswell *should* be verifying their system firmware via Boot Guard,
which both checks an RSA signature and measures the firmware into the
TPM, but as with everything of this nature, there are certainly vendors
that screw it up. (I think AMD has something similar, but I'm really not
sure.)

-- 
  Peter
