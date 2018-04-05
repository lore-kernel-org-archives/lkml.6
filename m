Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AIpwx49NG4VGte2f7y+ygOyhSA+n7uGuiVtMIRfSgtIffJ/HydK9LiYUWl2N115ZVjQqssmfGBCU
ARC-Seal: i=1; a=rsa-sha256; t=1522907031; cv=none;
        d=google.com; s=arc-20160816;
        b=Th2a+/J/n8A030rL0UPcBmi2+S7uNhdUsW6F++Yb6UHUME/uqPgYsdz2LvI6y/Vzvk
         rc2j/sIHfGVyX96bw/SXfcZpYSCBh/PHLZJckMzI9Lz9eGwXEK+HD1GzXslvDVOF9XPN
         BuHRcEL2n1cmF53eFy48i7ryIpsYrBfonjWTa5iFv2KerawM3I4Cg9wIp/GS5QGhkoLK
         i0vvvhQbeeYKrbRtjSKX1UzBGa6aKyiqqHnalPzKuktTgHzRaI2pdwKcFMXeqZocSBYw
         txgYiou6e9RVw2IwsqbkJmOzq1VEsjVBwOGe/Nyg6Yig1B8il4AAyttOZmR1wiZcwdK0
         s3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=u3Ht/7OLdPl4lKf672vGaoT2qmxkPiXuGGHN8MCHe/E=;
        b=NQIoyzds8hjPPhaiEhJjXgG9vIP1kS/LZSSTbHzqGGEXZjEJulEDCv3TPtXkm7RJmh
         wzG5w4GpFwXDJ14LgSv2oed+yt7FBbNRPLGXfcR1FoChYKTAqgiiokzkTM6pFjO+5GeK
         1IJIjBKSiylWq6fAoIgASbs94EWiRFXtZDwT8cKv8iVQBxs0i802zwcm0uwHHD70tdt1
         oVcle6DZAWVB+8FifXMeTgcTHoosrNZu8cGT4Fs7pWdubohMXuTRwzbeVL1CvvqGjqtk
         Yezsbjbzysy9JjvhWUkVoIJCLvNGL2wk2jIywG1Z4u640Bgz+MXm6y8M1qRclGNeaRex
         a/zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Thu, 5 Apr 2018 07:43:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Peter Jones <pjones@redhat.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20180405054349.GA25653@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ae4d18-8964-5748-a69f-0017d0dca5f7@redhat.com>
 <20180404171835.xvllgcqirl3b5gd5@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1596883763000630274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 01:18:36PM -0400, Peter Jones wrote:
> > On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
> > > * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
> > >   https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
> > > 
> > > * Amend arch/x86/boot/compressed/eboot.c to read the files with the
> > >   GUIDs you're interested in into memory and pass the files to the
> > >   kernel as setup_data payloads.
> 
> To be honest, I'm a bit skeptical about the firmware volume approach.
> Tools like UEFITool[0] and uefi-firmware-parser[1] have existed for
> years, still don't seem to reliably parse firmware images I see in the
> wild, and have a fairly regular need for fixes.  These are tools
> maintained by smart people who are making a real effort, and it still
> looks pretty hard to do a good job that applies across a lot of
> platforms.
> 
> So I'd rather use Hans's existing patches, at least for now, and if
> someone is interested in hacking on making an efi firmware volume parser
> for the kernel, switch them to that when such a thing is ready.

Hello?  As I've written in the above-quoted e-mail the kernel should
read the files using EFI_FIRMWARE_VOLUME_PROTOCOL.ReadFile().

*Not* by parsing the firmware volume!

Parsing the firmware volume is only necessary to find out the GUIDs
of the files you're looking for.  You only do that *once*.

I habitually extract Apple's EFI Firmware Volumes and found the
existing tools always did a sufficiently good job to get the
information I need (such as UEFIExtract, which I've linked to,
and which is part of the UEFITool suite, which you've linked to
once more).


On Wed, Apr 04, 2018 at 10:25:05PM +0200, Hans de Goede wrote:
> Lukas, thank you for your suggestions on this, but I doubt that these
> devices use the Firmware Volume stuff.

If they're using EFI, they're using a Firmware Volume and you should
be able to use the Firmware Volume Protocol to read files from it.

If that protocol wasn't supported, the existing EFI drivers wouldn't
be able to function as they couldn't load files from the volume.


> What you are describing sounds like significantly more work then
> the vendor just embedding the firmware as a char firmware[] in their
> EFI mouse driver.

In such cases, read the EFI mouse driver from the firmware volume and
extract the firmware from the offset you've pre-determined.  That's
never going to change since the devices never receive updates, as
you're saying.  So basically you'll have a struct with GUID, offset,
length, and the name under which the firmware is made available to
Linux drivers.


> That combined with Peter's worries about difficulties parsing the
> Firmware Volume stuff, makes me believe that it is best to just
> stick with my current approach as Peter suggests.

I don't know why you insist on a hackish solution (your own words)
even though a cleaner solution is suggested, but fortunately it's
not for me to decide what goes in and what doesn't. ;-)

Thanks,

Lukas
