Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523024931; cv=none;
        d=google.com; s=arc-20160816;
        b=UlEIPM5bBbkXCzHT6vfUz8v8z3jtm97oam7PAEzeLmx921CHF1yuuYqpwUYwY5bT4M
         ZVu4kjlaP0mxJy619GpxHPzS8vfvc27bhEpA9c67RuKC7nQ+2G8TamOaC/mpHpyU0bpJ
         9izNjdmj/mggY1qnYm8EbUCBj0LEpTD/FYyusoBoSurs61PHlQCtuscgkMT0YHRfMDI9
         6MWTF/z/WDoR1ycxtHX+BdHHymjtiUwguNEUnyD9+SZoI/P5X48Wavecss8NiMomno56
         ZDckt7BE62Wx6FX38bZVZbTjLpIMa7M4Ssm4iUgl0v94ztXHuK/YK1KEdvhTMPBk+IMS
         qVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XOdBtSYADHYdXp5Fg39L/KynQDB3LAThxw9WcOEdfdk=;
        b=ZU6dDWWwHk5AbdKvmBv53+xL+UlooADZ0VlIeKEMqun4MjTMK8KcLC8eTFi1vHrYuO
         wjd9VCl/zBhoor296MpnRQzu+iA7X7xPTwvH+3Noom6mi/XUZsEw5i+gxJufqp5YJZLW
         Z0G3b8ApETIF4pRI3MUds0OGlhi07xuS2yHQTXP83I0Fo0+h73COffVyVki0r93gX8Gz
         MeOq8hTD6oEjNNdsPB8NgA38csy4oqNCzEE01PdJMy+jViX9s+52LkHfbYESqpV5s0FS
         /cAcZ1dhYsO36Am6VjenkP5xTqVOO4dF3+8tEwnqihpGPFRMUC02qlfaYlq4X6ebbRVa
         bP5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OMAy3RrU;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OMAy3RrU;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48/rb7IQ07inz8/uyK5jJwXLV0FV9jmjOj7c8tj6J7scBOLbVyx5OsgJv96mus4KZxHFtd6mEUjzFbH+PD1OYo=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8R2YfjWjSQkyvLv78C-ixFqYDaZ7qwNje53_S9yTJ83g@mail.gmail.com>
References: <78ae4d18-8964-5748-a69f-0017d0dca5f7@redhat.com>
 <20180404171835.xvllgcqirl3b5gd5@redhat.com> <20180405054349.GA25653@wunner.de>
 <20180406140832.GF30543@wotan.suse.de> <CAKv+Gu8R2YfjWjSQkyvLv78C-ixFqYDaZ7qwNje53_S9yTJ83g@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 6 Apr 2018 16:28:49 +0200
Message-ID: <CAKv+Gu9SH9a_e_Zen7QMbyrY3NbEVji8ZCsNvDoy8EdbP5yy=Q@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1597007390357533938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 April 2018 at 16:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 6 April 2018 at 16:08, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> On Thu, Apr 05, 2018 at 07:43:49AM +0200, Lukas Wunner wrote:
>>> On Wed, Apr 04, 2018 at 01:18:36PM -0400, Peter Jones wrote:
>>> > > On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
>>> > > > * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
>>> > > >   https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
>>> > > >
>>> > > > * Amend arch/x86/boot/compressed/eboot.c to read the files with the
>>> > > >   GUIDs you're interested in into memory and pass the files to the
>>> > > >   kernel as setup_data payloads.
>>> >
>>> > To be honest, I'm a bit skeptical about the firmware volume approach.
>>> > Tools like UEFITool[0] and uefi-firmware-parser[1] have existed for
>>> > years, still don't seem to reliably parse firmware images I see in the
>>> > wild, and have a fairly regular need for fixes.  These are tools
>>> > maintained by smart people who are making a real effort, and it still
>>> > looks pretty hard to do a good job that applies across a lot of
>>> > platforms.
>>> >
>>> > So I'd rather use Hans's existing patches, at least for now, and if
>>> > someone is interested in hacking on making an efi firmware volume parser
>>> > for the kernel, switch them to that when such a thing is ready.
>>>
>>> Hello?  As I've written in the above-quoted e-mail the kernel should
>>> read the files using EFI_FIRMWARE_VOLUME_PROTOCOL.ReadFile().
>>>
>>> *Not* by parsing the firmware volume!
>>>
>>> Parsing the firmware volume is only necessary to find out the GUIDs
>>> of the files you're looking for.  You only do that *once*.
>>
>> How do you get the GUIDs for each driver BTW?
>>
>> Hans, I do believe we should *try* this approach at the very least.
>>
>> Why not?
>>
>> Otherwise it would be wise to provide a technical reason for why
>> we'd choose one custom mechanism which would only serve a few tablets
>> over a mechanism which could serve more devices.
>>
>
> Because EFI_FIRMWARE_VOLUME_PROTOCOL is not part of the UEFI spec but
> of the PI spec, and so we will be adding dependencies on
> implementation details of the firmware. I am aware we may already have
> done so for the Apple properties support

... or maybe not: I thought Lukas alluded to that in this thread, but
I can't actually find any traces of that in the code so I must have
misunderstood.

, but I think it makes sense
> to make an exception there, given that Mac UEFI firmware is 'special'
> already.
