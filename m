Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48UQSe9VyjCTzzKmWiJioQycqcwFvyn/7dofb/jCCEBUey/Z/JL+4D7OnVkZhQG+hAi4vcE
ARC-Seal: i=1; a=rsa-sha256; t=1523023714; cv=none;
        d=google.com; s=arc-20160816;
        b=rXkqONrw+LD5O30kSg1sePOYD4jat1qac3MdTHwxLv0U2AaUtkuW5PAcAeVLxbysF/
         kPudH3uJnykl0afFJFaddSHEtSD0Xibivua9n4wGSTHw/ggxxxTiArkDXRbesBJDcbXq
         S1r+WpPQlpk1zcsF88OHBOxiTCFfb5l8sS9E5MkFZMshmVp6eRTBui3zqlbjUwFb/3R0
         ePNTuYsW3MBV2LfG7PHnZMmkr3fvD/2ZDAEwnFZZdNfMCRCFfl76nAFpojz+JZYkl6sQ
         mmytjbep4H2Mn2y9vhDBdsoa4X6zF5awpSHpgbWFz+8digSyBpeSBOdG/myRIoCSa0ft
         6DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ghNSbWmTo8n1gdPIa9xtAK+sNZgxkRBCTpcsGD32W/I=;
        b=z+m+JrS0bn0PH8p0jq8mPGLey9I2ok7+N8tdBGzhbrF8pK0RhA2M2RVF03fc8LuAHx
         Zi5zqOUa2vT/E4X0gonRjZRBR6+39umMV93MnJhdNLAyghFg7e0Fd5RHsyDQt2aVRlHh
         8uiPRW03qhDsJ404GyURBxjtckmwVf7Hude4TInkN94XRSgfOooIXx5IvXSb4s9kXayx
         6kZAEQsxOk5pOexpe99u9uM6WF8SFmbrxYe3G1eRespSg8jA8MhrsJ5TPLyaQBC9SLbo
         Uzq/+29oah1MKhJbyqxQ5WRPcp4O1DmMZIV3nXEarQLdKAbPcC5tuyAb+892Qbdvr2qO
         J7Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Fri, 6 Apr 2018 14:08:32 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Peter Jones <pjones@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20180406140832.GF30543@wotan.suse.de>
References: <78ae4d18-8964-5748-a69f-0017d0dca5f7@redhat.com>
 <20180404171835.xvllgcqirl3b5gd5@redhat.com>
 <20180405054349.GA25653@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405054349.GA25653@wunner.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1597006115256349059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 07:43:49AM +0200, Lukas Wunner wrote:
> On Wed, Apr 04, 2018 at 01:18:36PM -0400, Peter Jones wrote:
> > > On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
> > > > * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
> > > >   https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
> > > > 
> > > > * Amend arch/x86/boot/compressed/eboot.c to read the files with the
> > > >   GUIDs you're interested in into memory and pass the files to the
> > > >   kernel as setup_data payloads.
> > 
> > To be honest, I'm a bit skeptical about the firmware volume approach.
> > Tools like UEFITool[0] and uefi-firmware-parser[1] have existed for
> > years, still don't seem to reliably parse firmware images I see in the
> > wild, and have a fairly regular need for fixes.  These are tools
> > maintained by smart people who are making a real effort, and it still
> > looks pretty hard to do a good job that applies across a lot of
> > platforms.
> > 
> > So I'd rather use Hans's existing patches, at least for now, and if
> > someone is interested in hacking on making an efi firmware volume parser
> > for the kernel, switch them to that when such a thing is ready.
> 
> Hello?  As I've written in the above-quoted e-mail the kernel should
> read the files using EFI_FIRMWARE_VOLUME_PROTOCOL.ReadFile().
> 
> *Not* by parsing the firmware volume!
> 
> Parsing the firmware volume is only necessary to find out the GUIDs
> of the files you're looking for.  You only do that *once*.

How do you get the GUIDs for each driver BTW?

Hans, I do believe we should *try* this approach at the very least.

Why not?

Otherwise it would be wise to provide a technical reason for why
we'd choose one custom mechanism which would only serve a few tablets
over a mechanism which could serve more devices.

  Luis
