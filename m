Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522873507; cv=none;
        d=google.com; s=arc-20160816;
        b=wNqQtYrRES3SiXwgxur+zwSiR3fjjWrew0qvlRBflvg+f4d1Qmc6gCTkdDtQdU7zL3
         WradLW3z0rj3U+fdUve5kBkazfuanxVDhwjCE8kYKkPAsYrZE7N89YTLrSmtXIoz6DEY
         vq3g4zgfJgK4rkHMkdGPNbf7V/Zts0ap3qVTHG85WRkV9YMfrCqiDEu3zEOz1e4jeHKb
         g7PHZADvZcXHOcwJmmX3+geUNFQCbgiXl16iOyvWdphBgBqJg9JgL1Ds+T2Va31O+hWe
         YE3LAfkb6nEU7/UMYHFPOO0cFxWJSELggya+N+O4Ydbb8p4/c0V7hSYlQla2xlkR1hUl
         NeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bqGLJakraVJeqzeYK3iXrzfiPrUdBcFNdDkc0bQaUHs=;
        b=HnE5QFwHAS6jCevOE6fFZisCIxWp6aj4ZHZPZNgDrTsPbIqFalFmm1zLaJ0HR4pTTc
         hDiCl5n64GOCzkEB8le52fJQkoG14tcGqeCq6bnFvKG8a3GlMCzapQT1B88rav8G99pt
         OoVQaOj1o7BpSaUML9whBnuW3rU8AiLIXILpCpgxnu+uIjWEZGSVettCpaf086DrJR3K
         sN4ktmpiVzwMlzm6N2tGGQskSZIIbruCChQi5oCLHjuzp2n4kLIPOon1qdsXq8w/3qch
         ZYDH47UTc2u8hJ2zHO4hLPFPIQiG1aipyqrl8vEpptApCRVGUpmoM5f6fbZ2x+Q+/PX4
         yxYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx48DRMRbuVDMwxY3S//ENh1gmaoHKjB5L2aJmLsRYlgsBvPSK5JeChQHQY8UhwXRHCQ1kGwfyw==
Subject: Re: [PATCH 2/2] efi: Add embedded peripheral firmware support
To: Peter Jones <pjones@redhat.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Kalle Valo <kvalo@codeaurora.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Dave Olsthoorn <dave@bewaar.me>,
 x86@kernel.org, linux-efi@vger.kernel.org, Will Deacon
 <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>, David Howells
 <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>, Matthew Garrett
 <mjg59@srcf.ucam.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>, dmitry.torokhov@gmail.com,
 mfuzzey@parkeon.com, keescook@chromium.org, nbroeking@me.com,
 bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>
References: <20180331121944.8618-1-hdegoede@redhat.com>
 <20180331121944.8618-2-hdegoede@redhat.com>
 <20180402232333.GU30543@wotan.suse.de>
 <17fb3c28-78ff-2e1f-2ada-d33320567761@redhat.com>
 <20180403180711.GA7957@wunner.de> <20180403185848.GD30543@wotan.suse.de>
 <20180404171835.xvllgcqirl3b5gd5@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <78ae4d18-8964-5748-a69f-0017d0dca5f7@redhat.com>
Date: Wed, 4 Apr 2018 22:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404171835.xvllgcqirl3b5gd5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1596848611031359970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

HI,

On 04-04-18 19:18, Peter Jones wrote:
> On Tue, Apr 03, 2018 at 06:58:48PM +0000, Luis R. Rodriguez wrote:
>> On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
>>> On Tue, Apr 03, 2018 at 10:33:25AM +0200, Hans de Goede wrote:
>>>> I asked Peter Jones for suggestions how to extract this during boot and
>>>> he suggested seeing if there was a copy of the firmware in the
>>>> EFI_BOOT_SERVICES_CODE memory segment, which it turns out there is.
>>>>
>>>> My patch to add support for this contains a table of device-model (dmi
>>>> strings), firmware header (first 64 bits), length and crc32 and then if
>>>> we boot on a device-model which is in the table the code scans the
>>>> EFI_BOOT_SERVICES_CODE for the prefix, if found checks the crc and
>>>> caches the firmware for later use by request-firmware.
>>>>
>>>> So I just do a brute-force search for the firmware, this really is hack,
>>>> nothing standard about it I'm afraid. But it works on 4 different x86
>>>> tablets I have and makes the touchscreen work OOTB on them, so I believe
>>>> it is a worthwhile hack to have.
>>>
>>> The EFI Firmware Volume contains a kind of filesystem with files
>>> identified by GUIDs.  Those files include EFI drivers, ACPI tables,
>>> DMI data and so on.  It is actually quite common for vendors to
>>> also include device firmware on the Firmware Volume.  Apple is doing
>>> this to ship firmware updates e.g. for the GMUX controller found on
>>> dual GPU MacBook Pros.  If they want to update the controller's
>>> firmware, they include it in a BIOS update, and an EFI driver checks
>>> on boot if the firmware update for the controller is necessary and
>>> if so, flashes it.
>>>
>>> The firmware files you're looking for are almost certainly included
>>> on the Firmware Volume as individual files.
>>
>> What Hans implemented seems to have been for a specific x86 hack, best if we
>> confirm if indeed they are present on the Firmware Volume.
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
> 
> [0] git@github.com:LongSoft/UEFITool.git
> [1] git@github.com:theopolis/uefi-firmware-parser.git
> 
>>> Rather than scraping
>>> the EFI memory for firmware, I think it would be cleaner and more
>>> elegant if you just retrieve the files you're interested in from
>>> the Firmware Volume.
>>>
>>> We're doing something similar with Apple EFI properties, see
>>> 58c5475aba67 and c9cc3aaa0281.
>>>
>>> Basically what you need to do to implement this approach is:
>>>
>>> * Determine the GUIDs used by vendors for the files you're interested
>>>    in.  Either dump the Firmware Volume or take an EFI update as
>>>    shipped by the vendor, then feed it to UEFIExtract:
>>>    https://github.com/LongSoft/UEFITool
>>>    
>>> * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
>>>    https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
>>>
>>> * Amend arch/x86/boot/compressed/eboot.c to read the files with the
>>>    GUIDs you're interested in into memory and pass the files to the
>>>    kernel as setup_data payloads.
>>>
>>> * Once the kernel has booted, make the files you've retrieved
>>>    available to device drivers as firmware blobs.
>>
>> Happen to know if devices using Firmware Volumes also sign their firmware
>> and if hw checks the firmware at load time?
> 
> It varies on a per-device basis, of course.  Most new Intel machines as
> of Haswell *should* be verifying their system firmware via Boot Guard,
> which both checks an RSA signature and measures the firmware into the
> TPM, but as with everything of this nature, there are certainly vendors
> that screw it up. (I think AMD has something similar, but I'm really not
> sure.)

Lukas, thank you for your suggestions on this, but I doubt that these
devices use the Firmware Volume stuff.

These are really cheap x86 Windows 10 tablets, everything about them is
simply hacked together by the manufacturer till it boots Windows10 and
then it is shipped to the customer without receiving any update
afterwards ever.

What you are describing sounds like significantly more work then
the vendor just embedding the firmware as a char firmware[] in their
EFI mouse driver.

That combined with Peter's worries about difficulties parsing the
Firmware Volume stuff, makes me believe that it is best to just
stick with my current approach as Peter suggests.

Regards,

Hans
