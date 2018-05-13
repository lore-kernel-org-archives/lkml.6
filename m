Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526209542; cv=none;
        d=google.com; s=arc-20160816;
        b=r3kpmXaL6SjRk4xOlD7K6R2B5Fdm5q9R9Nmx0p9pTpmRfq2i1EVX0OFo1x955hNi1Y
         7/nTiApniR+d6vkuZpCwuIS3Z9mxQ7+CnMz7DXhKy1DkkVo/mlAps+qkhhyslbOvflVb
         IKWGnRlhCHxnh7aCmFHjt/JSNRcLzOTOher0t/MdHrR+FBkb4IajyEAdcDGz7Xe5cWGS
         rXmIG8kypeF2k/DUaVfuZ2k6SDk5GH+FjejDrn7cLu7JycMEugSCMu54kYtVm78eSyBJ
         HF8bEUjDmz4r861ZZdIiN+tVYHngLDEhH8OooFCiZmxYI23gqiDR6TGlUcYHIygSQZu1
         6rUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7uYYOAxTomyysc56MdJ3f3j9MMF5JD9RJoonLICa/co=;
        b=ipVte3hQHj/AocppwxhcXNxMvu/ZqnUTZg/3otmiv9uVTAeSy4YMdzSMGMFzwTnK86
         W45tXoZhs1VQks4uBR5vTW77rS9XuemY69RXiokv20ODAk9oQ6Nkh2mG933BJz7TVdKq
         h09P+qDcAyLgQxDwMHbleTnQVcEJ4BQr7KcmU23sqbVgEk1PmnNxtm3HVeRKMFyDBCmJ
         pQWdX3o6SdGHMkf6YNal7QTfp3P1O3//ryDS4QqrYmLmo+I+IBp6IodKMy4qPkz7m2QN
         tMWp4+Eef2SEy8R1ERIwutd6XBLcGGIpN4O509zrdXgVg0M0p4eo566HrDdzWGsamn5g
         E3Kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZqq6+rdHcfxvfPH5gmwxPUEFZefAA9G2JUs0OhxZ6qkCEyIMmLAzx0uU8LAmFXmuFr2jTe7Qw==
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Jones <pjones@redhat.com>, dave@bewaar.me,
 Will Deacon <will.deacon@arm.com>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Martin Fuzzey <mfuzzey@parkeon.com>, Kalle Valo <kvalo@codeaurora.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, duwe@suse.de,
 Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>
References: <20180429093558.5411-1-hdegoede@redhat.com>
 <20180429093558.5411-3-hdegoede@redhat.com>
 <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
 <59023265-bfca-fe5d-e047-4c69404a0dd1@redhat.com>
 <20180503223126.GE27853@wotan.suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <306d98d9-b489-b98b-a0b3-27539aca167a@redhat.com>
Date: Sun, 13 May 2018 12:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503223126.GE27853@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1600346696877612800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/03/2018 11:31 PM, Luis R. Rodriguez wrote:
> On Wed, May 02, 2018 at 04:49:53PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 05/01/2018 09:29 PM, Andy Lutomirski wrote:
>>> On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>> +The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE
>>> memory
>>>> +segments for an eight byte sequence matching prefix, if the prefix is
>>> found it
>>>> +then does a crc32 over length bytes and if that matches makes a copy of
>>> length
>>>> +bytes and adds that to its list with found firmwares.
>>>> +
>>>
>>> Eww, gross.  Is there really no better way to do this?
>>
>> I'm afraid not.
>>
>>>   Is the issue that
>>> the EFI code does not intend to pass the firmware to the OS but that it has
>>> a copy for its own purposes and that Linux is just going to hijack EFI's
>>> copy?  If so, that's brilliant and terrible at the same time.
>>
>> Yes that is exactly the issue / what it happening here.
>>
>>>
>>>> +       for (i = 0; i < size; i += 8) {
>>>> +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
>>>> +                       continue;
>>>> +
>>>> +               /* Seed with ~0, invert to match crc32 userspace utility
>>> */
>>>> +               crc = ~crc32(~0, mem + i, desc->length);
>>>> +               if (crc == desc->crc)
>>>> +                       break;
>>>> +       }
>>>
>>> I hate to play the security card, but this stinks a bit.  The kernel
>>> obviously needs to trust the EFI boot services code since the EFI boot
>>> services code is free to modify the kernel image.  But your patch is not
>>> actually getting this firmware blob from the boot services code via any
>>> defined interface -- you're literally snarfing up the blob from a range of
>>> memory.  I fully expect there to be any number of ways for untrustworthy
>>> entities to inject malicious blobs into this memory range on quite a few
>>> implementations.  For example, there are probably unauthenticated EFI
>>> variables and even parts of USB sticks and such that get read into boot
>>> services memory, and I see no reason at all to expect that nothing in the
>>> so-called "boot services code" range is actually just plain old boot
>>> services *heap*.
>>>
>>> Fortunately, given your design, this is very easy to fix.  Just replace
>>> CRC32 with SHA-256 or similar.  If you find the crypto api too ugly for
>>> this purpose, I have patches that only need a small amount of dusting off
>>> to give an entirely reasonable SHA-256 API in the kernel.
>>
>> My main reason for going with crc32 is that the scanning happens before
>> the kernel is fully up and running (it happens just before the rest_init()
>> call in start_kernel() (from init/main.c) I'm open to using the
>> crypto api, but I was not sure if that is ready for use at that time.
> 
> Not being sure is different than being certain. As Andy noted, if that does
> not work please poke Andy about the SHA-256 API he has which would enable
> its use in kernel.
> 
> Right now this is just a crazy hack for *2* drivers. Its a lot of hacks for
> just that, so no need to rush this in just yet.

I agree that there is no rush to get this in. I will rebase this on top
of the "[PATCH v7 00/14] firmware_loader changes for v4.18" series you recently
send as well as try to address all the remarks made sofar. I'm not entirely
sure when I will get around to this.

Regards,

Hans
