Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524778545; cv=none;
        d=google.com; s=arc-20160816;
        b=TOA4gxRKQA8o28oUoJS4Q/jN7w9VI5XvcVrB9TsO7xycPz8FrYV5bRDtKf+4vSsoh4
         qBsvqIdWYh6Z4e2FGFEcV7V08WS86J2Qd+p6A9Ul0qX2GNWwlWq+HwP3RoNXcNYAru+j
         KPB14ZKhBH3R/N610IkDbzwe7MCNW+4YAt270iX8bzMUNOkS/1AH+2EfUcbpIghThiLB
         0blaXO3rC4nzHqKgdlgqjVDeEf4D7qtNJLA337Y46/z9SMGyicW3wmpJ+ULR6B1UbHCY
         MRgX3Ky6zhNv3QuagaCGCzAhAgx9NqeQU5ZGwVXGfIbIW77rUSGEoR3F/XMpkFI11GN+
         D/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=s1EYvfx0vsJnGmqo0jIJMKxzm3MpNbSHQoZ1znGhqVw=;
        b=gnt8oSjWx5Gy9YdTuhoX4cO6DZMXj6F3LoUuDahilAlzbWcT6uTqdIbNCrY8D09H2V
         /edHqSGDHBEugT0RNKmTwd1St44GL9FjRoDDZDTuIUFD0SgkE/Dia82LVnFeTbSDBf4h
         +tKDcWyjXvDR6FrgyGg2q3pUU9HFD18MaQ8gA3/zUBKjbhJmRuy0rrvm5b2CzTcHMXPJ
         RAU8+egv7pFi+oiNcr0fy+3NfuOeMzU9R8Jc9muiRyQDMMhRu06DdRDLeGs+ByXx6X21
         QM968yPQVHpvIwyIg5ukQNywPkv42MzD/HnfgQ/v1CDbEyC/SPYsehaVNUsNjecJumdd
         NoaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=b0uwnNo6;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=b0uwnNo6;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqo/iV0dvIEFIhdN3hKfl6zOGquiEhCk0xzQjmDgzAUc4CyATb8rSVpoie8Ej/+X4XYhOwBeIjgDezDHBeZv80=
MIME-Version: 1.0
In-Reply-To: <d587af46-72cb-8fc7-8432-36473b67de47@redhat.com>
References: <20180426120637.21258-1-hdegoede@redhat.com> <20180426120637.21258-2-hdegoede@redhat.com>
 <CAKv+Gu9sx_TnSvxdO9eGLCqsQufKW6z9p0K8nYWF_KuDBuUwag@mail.gmail.com> <d587af46-72cb-8fc7-8432-36473b67de47@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 26 Apr 2018 23:35:43 +0200
Message-ID: <CAKv+Gu9C09Qn6vxo1SaCtEP3KDTT3--JbybkvTaNF+N_G2HyOw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] efi: Export boot-services code and data as debugfs-blobs
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Broeking <nbroeking@me.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Torsten Duwe <duwe@suse.de>,
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>, linux-efi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598810391211983074?=
X-GMAIL-MSGID: =?utf-8?q?1598846187589118073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 April 2018 at 23:02, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 26-04-18 18:51, Ard Biesheuvel wrote:
>>
>> On 26 April 2018 at 14:06, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Sometimes it is useful to be able to dump the efi boot-services code and
>>> data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
>>> but only if efi=debug is passed on the kernel-commandline as this
>>> requires
>>> not freeing those memory-regions, which costs 20+ MB of RAM.
>>>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v4:
>>> -Add new EFI_BOOT_SERVICES flag and use it to determine if the
>>> boot-services
>>>   memory segments are available (and thus if it makes sense to register
>>> the
>>>   debugfs bits for them)
>>>
>>> Changes in v2:
>>> -Do not call pr_err on debugfs call failures
>>> ---
>>>   arch/x86/platform/efi/efi.c    |  1 +
>>>   arch/x86/platform/efi/quirks.c |  4 +++
>>>   drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
>>>   include/linux/efi.h            |  1 +
>>>   4 files changed, 59 insertions(+)
>>>
>>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>>> index 9061babfbc83..568b7ee3d323 100644
>>> --- a/arch/x86/platform/efi/efi.c
>>> +++ b/arch/x86/platform/efi/efi.c
>>> @@ -208,6 +208,7 @@ int __init efi_memblock_x86_reserve_range(void)
>>>               efi.memmap.desc_version);
>>>
>>>          memblock_reserve(pmap, efi.memmap.nr_map *
>>> efi.memmap.desc_size);
>>> +       set_bit(EFI_BOOT_SERVICES, &efi.flags);
>>>
>>
>> I think it would be better if the flag conveys whether boot services
>> regions are being preserved, because they will always exist when
>> EFI_BOOT is set.
>> The name should then reflect that as well, e.g., EFI_PRESERVE_BS_REGIONS.
>
>
> Ok, I will rename the flag to EFI_PRESERVE_BS_REGIONS for v5
> (I'm going to wait a bit with sending out v5 to give others a change
>  to comment on v4).
>
>>>          return 0;
>>>   }
>>> diff --git a/arch/x86/platform/efi/quirks.c
>>> b/arch/x86/platform/efi/quirks.c
>>> index 36c1f8b9f7e0..16bdb9e3b343 100644
>>> --- a/arch/x86/platform/efi/quirks.c
>>> +++ b/arch/x86/platform/efi/quirks.c
>>> @@ -376,6 +376,10 @@ void __init efi_free_boot_services(void)
>>>          int num_entries = 0;
>>>          void *new, *new_md;
>>>
>>> +       /* Keep all regions for /sys/kernel/debug/efi */
>>> +       if (efi_enabled(EFI_DBG))
>>> +               return;
>>> +
>>
>>
>> Why is this only necessary when EFI_DBG is enabled? How are you
>> ensuring that the firmware is still in memory when the subsequent
>> patches start relying on that?
>
>
> The 2nd patch in this series makes init/main.c call
> efi_check_for_embedded_firmwares() before efi_free_boot_services(),
> efi_check_for_embedded_firmwares() then walks the dmi_system_id-s
> "registered" (its a static list) by drivers and if their is a dmi_match
> searches for the firmware described by the dmi_system_id.driver_data
> ptr. If a firmware gets found it gets memdup-ed, so that we do not
> have to keep all of the boot-services code around.
>

Right, thanks for clearing that up.

So that means that preserving the boot regions is really only
necessary if you want to inspect them via debugfs, and the firmware
loader does not rely on that. I missed that part.

That means the only reason we have the new flag is to ensure that the
shared debugfs code only exposes the boot services regions if they
were preserved to begin with by the arch code, right?

If so, after the flag rename:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

(for the series)
