Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AIpwx48moKd07BXfvJdk/cg1LD7olliuZb2fx08LIuxmvJuxfofnk5B2RTpRAuNSdeyoy4Z6NZ43
ARC-Seal: i=1; a=rsa-sha256; t=1523094683; cv=none;
        d=google.com; s=arc-20160816;
        b=KCGL5Koi8/UCbbZwCnCzVYsZmrF7RzCHhnirPAYqeqruziN5aYazFttC7byTIFfmDp
         v913/3KQriHBulHaItD9zRMuuR6h85URWGx/oZhPEEX8wW1ik2aRriC1vi/CntX9EuC+
         oUNik4umutclteOI+6iOzshd9CSYYNNgQlTBf1bv33rsdheM5q4RlF4BzT1yAk9NzjD0
         Fvaha/ctkmb9Zx15SFAhExV2R0eeed2tWo2KjD/MJOJuaIfD26u1c16M942AYqk0wJhd
         OgagUbdi3fL8WlhZ49MUw17UOz3/QpEXngDn30EYDEsx24OGMIALo8ALRayUBSeFZISY
         XzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=UnDrxOe4mHuLAT03r09uITWAaSV9xrgYglf+mLPN+eM=;
        b=W7ZZTxCXvJPdSYjQeFWd4iuVbnQjPzulgyrYPmUaiAgFyWULp38swLzcTc7Psv6lJD
         ErVFLJ+0PBxC2gm9xT+vFFgRo9MgyamuHKOl/teqoRJW3kugwC4ZpvKbPincy2Y7t0Ln
         wjgeJBG65YfIyeUFTQZMPbbLvrTqcnDw0I9VQvr0l/HoXKEKyoNlsWg8kqnfjo87YWlK
         CN/DjwGGDlZLnIB+YEkAq/Gax3oP45GW3vh9HliLsYkM8RmUbM1oT9FFSFg48Vw4UdGJ
         pe5hf33xEjEb5R+NmhqVHFC8frDcjhjPRN1Qr73JP/UGemHHD8Lgs5yCnCRjmUg5692M
         DnIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Sat, 7 Apr 2018 11:51:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Peter Jones <pjones@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <20180407095122.GA21479@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9SH9a_e_Zen7QMbyrY3NbEVji8ZCsNvDoy8EdbP5yy=Q@mail.gmail.com>
 <20180406141642.23xfaub52gv3zpio@redhat.com>
 <20180406140832.GF30543@wotan.suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1597080530548476459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 02:08:32PM +0000, Luis R. Rodriguez wrote:
> How do you get the GUIDs for each driver BTW?

They're used as filenames when extracting a Firmware Volume with
UEFIExtract.

E.g. let's say I'm looking for the EFI driver containing the UCS-2
string "ThunderboltDROM" in the MacBookPro9,1 Firmware Volume:

$ UEFIExtract MBP91_00D3_B0C_LOCKED.scap
$ grep -rl T.h.u.n.d.e.r.b.o.l.t.D.R.O.M MBP91_00D3_B0C_LOCKED.scap.dump
MBP91_00D3_B0C_LOCKED.scap.dump/0 UEFI image/0 7A9354D9-0468-444A-81CE-0BF617D890DF/4 283FA2EE-532C-484D-9383-9F93B36F0B7E/0 7A9354D9-0468-444A-81CE-0BF617D890DF/0 77AD7FDB-DF2A-4302-8898-C72E4CDBD0F4/0 Compressed section/0 FC1BCDB0-7D31-49AA-936A-A4600D9DD083/0 Volume image section/0 7A9354D9-0468-444A-81CE-0BF617D890DF/97 9D1A8B60-6CB0-11DE-8E91-0002A5D5C51B/0 Compressed section/0 FC1BCDB0-7D31-49AA-936A-A4600D9DD083/0 PE32 image section/body.bin

That file can then be examined with a hex editor, disassembler, etc.

Since Hans knows the 8 byte signature of the file he's looking for,
he'd just use:

$ grep -rl '\x01\x23\x34\x56\x78\x9a\xbc\xde' ...

(The \x syntax works with BSD grep shipping with macOS, but not with
GNU grep.  pcregrep should work, or grep -P, though the latter has
been unreliable for me.)

Pretty trivial obviously, the problem is how do you get the Firmware
Volume?  Apple ships firmware blobs for all supported machines as part
of their OS updates, but if the vendor never provides updates (as Hans
wrote), your only chance is to dump the ROM.  On Macs the ROM is at
physical address 0xffe00000.  The rEFIt bootloader contains a "fvdump"
tool which can be used to dump the Firmware Volume at this address to
the ESP:
https://github.com/yep/refit/blob/master/refit/dumpfv/dumpfv.c

The tool dumps only 2 MByte, but contempary Macs use considerably larger
firmware blobs (8 MByte+).  A quick Google search turns up these
alternative addresses where the ROM may be located:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/README

   "The base address for the 1MB image in QEMU physical memory is
    0xfff00000. The base address for the 2MB image is 0xffe00000.
    The base address for the 4MB image is 0xffc00000."


> Otherwise it would be wise to provide a technical reason for why
> we'd choose one custom mechanism which would only serve a few tablets
> over a mechanism which could serve more devices.

An advantage of the approach I'm suggesting is that it also catches
firmware even if the EFI driver wasn't loaded.  There may even be
firmware for devices that aren't present, vendors ship lots of
surprising stuff on Firmware Volumes.  (I've found a FireWire driver
on the 12" MacBook8,1 volume, even though the machine has neither a
FireWire port, nor a Thunderbolt port that you could connect a
FireWire adapter to.  They were probably just too lazy to constrain
the firmware contents to what's actually needed on a specific machine.)


On Fri, Apr 06, 2018 at 10:16:44AM -0400, Peter Jones wrote:
> That said, EFI_FIRMWARE_VOLUME_PROTOCOL is part of the
> PI spec, not the UEFI spec.  It's not required in order to implement UEFI,
> and some implementations don't use it.  Even when the implementation
> does include PI, there's no guarantee PI protocols are exposed after the
> "End of DXE" event (though edk2 will expose this, I think).

Thanks for pointing that out, I wasn't aware of it.


On Fri, Apr 06, 2018 at 04:28:49PM +0200, Ard Biesheuvel wrote:
> > EFI_FIRMWARE_VOLUME_PROTOCOL is not part of the UEFI spec but
> > of the PI spec, and so we will be adding dependencies on
> > implementation details of the firmware. I am aware we may already have
> > done so for the Apple properties support
> 
> ... or maybe not: I thought Lukas alluded to that in this thread, but
> I can't actually find any traces of that in the code so I must have
> misunderstood.

Retrieval of Apple device properties is done using a custom Apple
protocol, it doesn't involve the EFI_FIRMWARE_VOLUME_PROTOCOL.

What I meant to say is, the EFI stub already stashes PCI ROMs and
Apple device properties in setup_data payloads for consumption by
the kernel proper, so extending that pattern to retrieval of
device firmware (using EFI_FIRMWARE_VOLUME_PROTOCOL) seems kind of
natural.

Thanks,

Lukas
