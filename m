Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523024044; cv=none;
        d=google.com; s=arc-20160816;
        b=zjSccA8r3JoaCfnxaGHxVOXZ93BT1bqbJ9X+CLbZGX4HnkmSLlVesY3ozz8C6SQkHj
         ySsXgltM9FiLXbDGvWXLVJQc3pKk3IlSuzCSl2x83pwqedx0gTqRebpsKp38lvpf3STf
         6mUEhx8o2jenSOcuedTdgmeC60Vm64tihKPfBGCnEZQ+045I6RXD909m3hgU38R47cb8
         PVJL+sfDEaH2h2yEgmMbhjqtvBYQc9VKdYtMFz/v/GRM5x2tMhhNlQEqJpmwwn1bXVdW
         rh/eSC9WxSnalQVFLVxqK77oXMPzJLcqyT5R6ZePdndrxLVbmWsHO512K6uVRoMkdGRu
         lSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Y4ne8D5PpMhjK21P9wY/BV/HlonFVsVqfmzaNnJek+Y=;
        b=a/G0V86L+T/yD0jjB6qcGHj2Gq66LzWaQLgMDkxorAPPVy8cy6RZDnPFTfAivnQimm
         ljMbAWhW4whbHl9qLPwRy33/T/RiFtkVI3NwGPRw5Mt9NzqwizVaBlp1iRZC9QWJNnpw
         ulePzasp3pslE5i5SkAQuCfwbtZ1qjifW1wLYP19B157SMAvPF34imcYCmQD6XJ5MNr8
         gOryUYrckrYUBsV9UbiZJmaLT9NLphwOeJBwmi0D2LyZbTjTbtS11GiTkrkBR/izw85+
         6pueUCVM3NgVA0gcKjW2Z65t4M7+IrT5uRnQxKJNMAEHaUXZRtngt8ZoqFLEWHLgZ89q
         I3IA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JRPCc61T;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JRPCc61T;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49fppGH6ZyEjAEpigO8AFSoIO2hXezU9WqhkUo+ryNXckiW1tWAY0WrfOVt6LetGfXT998Yc+0U8K42n6itrwU=
MIME-Version: 1.0
In-Reply-To: <20180406140832.GF30543@wotan.suse.de>
References: <78ae4d18-8964-5748-a69f-0017d0dca5f7@redhat.com>
 <20180404171835.xvllgcqirl3b5gd5@redhat.com> <20180405054349.GA25653@wunner.de>
 <20180406140832.GF30543@wotan.suse.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 6 Apr 2018 16:14:03 +0200
Message-ID: <CAKv+Gu8R2YfjWjSQkyvLv78C-ixFqYDaZ7qwNje53_S9yTJ83g@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Jones <pjones@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dave Olsthoorn <dave@bewaar.me>, "the arch/x86 maintainers" <x86@kernel.org>, linux-efi@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Kees Cook <keescook@chromium.org>,
	Nicolas Broeking <nbroeking@me.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	Torsten Duwe <duwe@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1597006460493313554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 April 2018 at 16:08, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Thu, Apr 05, 2018 at 07:43:49AM +0200, Lukas Wunner wrote:
>> On Wed, Apr 04, 2018 at 01:18:36PM -0400, Peter Jones wrote:
>> > > On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
>> > > > * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
>> > > >   https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
>> > > >
>> > > > * Amend arch/x86/boot/compressed/eboot.c to read the files with the
>> > > >   GUIDs you're interested in into memory and pass the files to the
>> > > >   kernel as setup_data payloads.
>> >
>> > To be honest, I'm a bit skeptical about the firmware volume approach.
>> > Tools like UEFITool[0] and uefi-firmware-parser[1] have existed for
>> > years, still don't seem to reliably parse firmware images I see in the
>> > wild, and have a fairly regular need for fixes.  These are tools
>> > maintained by smart people who are making a real effort, and it still
>> > looks pretty hard to do a good job that applies across a lot of
>> > platforms.
>> >
>> > So I'd rather use Hans's existing patches, at least for now, and if
>> > someone is interested in hacking on making an efi firmware volume parser
>> > for the kernel, switch them to that when such a thing is ready.
>>
>> Hello?  As I've written in the above-quoted e-mail the kernel should
>> read the files using EFI_FIRMWARE_VOLUME_PROTOCOL.ReadFile().
>>
>> *Not* by parsing the firmware volume!
>>
>> Parsing the firmware volume is only necessary to find out the GUIDs
>> of the files you're looking for.  You only do that *once*.
>
> How do you get the GUIDs for each driver BTW?
>
> Hans, I do believe we should *try* this approach at the very least.
>
> Why not?
>
> Otherwise it would be wise to provide a technical reason for why
> we'd choose one custom mechanism which would only serve a few tablets
> over a mechanism which could serve more devices.
>

Because EFI_FIRMWARE_VOLUME_PROTOCOL is not part of the UEFI spec but
of the PI spec, and so we will be adding dependencies on
implementation details of the firmware. I am aware we may already have
done so for the Apple properties support, but I think it makes sense
to make an exception there, given that Mac UEFI firmware is 'special'
already.
