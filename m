Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525272595; cv=none;
        d=google.com; s=arc-20160816;
        b=QDtGIcpEwoO1ecrPfHul57ruCWPBY5nwPNAycIlmSRBxpYMrDgp1PKVUUKMMSRgDII
         Nea4ETBDMJIspSj/7+XRxB0iQ33GfPtxFpbuLsxfo+BBreilKzzzR9ufmfKxUCE/hK/8
         ckbRtk2uqLyDxJkRxrYOaq6qJkLbu6kHLa5zxAddld+gcR/CWGK0iUc2fetCjDIAusB4
         QDtffzc7Nsfg+9krtMe8Gs9fvC5YbEAkW0BgHCRMablhEIFhuTF3UoxTDSLw8HJ+14hV
         VpeVkI2hxtgWv95C39fk4mR6Ip5w/kw2bz0BdMFDnbDJEuihbn/zrWCX/k4RUfhhPzxt
         zv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=uTAUkX/R6Pq3IV3s8MiSgDKEf2H+6+anYk1fV+yMVik=;
        b=x8i9f+C6Au2YZzSkGLYS5mQsR8sJQsE4fXec2cuWmE5Ei0PYsh21SjEWqImlrCu30X
         Z8bR5o0kZZRjlFLx73LVSkBB6IfzEWgLNqWUVkTg9SBXpsz6urAkjQgjlQh3JpoQWdr7
         tF5DpCgGbyU/3NU0vvjgD2ysbadPk+EmhSc4VtYsUDxF9cICP6o3BfQr5p2aoUhAbkxf
         WmYB+SOU5myMyrWFo7XTv8vRpefn1IsysvWzjHGHs2WAADsSml618tsbPTtHFy+zROfp
         s1udhFguAw9KxW07ynXgSVY8di2V2WEIXTTxspT6UMtO4mP9yUkhP+jj/GXz3NeVXDWq
         uEug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZpFe9BqnuPSa9rPFlnUio6O7k1onO+NG8pyD5SAfDTe57sUtgG/dj14PCmMY24Xwixbe9UZyQ==
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
To: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
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
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <59023265-bfca-fe5d-e047-4c69404a0dd1@redhat.com>
Date: Wed, 2 May 2018 16:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599364237194300524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/01/2018 09:29 PM, Andy Lutomirski wrote:
> On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> +The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE
> memory
>> +segments for an eight byte sequence matching prefix, if the prefix is
> found it
>> +then does a crc32 over length bytes and if that matches makes a copy of
> length
>> +bytes and adds that to its list with found firmwares.
>> +
> 
> Eww, gross.  Is there really no better way to do this?

I'm afraid not.

>  Is the issue that
> the EFI code does not intend to pass the firmware to the OS but that it has
> a copy for its own purposes and that Linux is just going to hijack EFI's
> copy?  If so, that's brilliant and terrible at the same time.

Yes that is exactly the issue / what it happening here.

> 
>> +       for (i = 0; i < size; i += 8) {
>> +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
>> +                       continue;
>> +
>> +               /* Seed with ~0, invert to match crc32 userspace utility
> */
>> +               crc = ~crc32(~0, mem + i, desc->length);
>> +               if (crc == desc->crc)
>> +                       break;
>> +       }
> 
> I hate to play the security card, but this stinks a bit.  The kernel
> obviously needs to trust the EFI boot services code since the EFI boot
> services code is free to modify the kernel image.  But your patch is not
> actually getting this firmware blob from the boot services code via any
> defined interface -- you're literally snarfing up the blob from a range of
> memory.  I fully expect there to be any number of ways for untrustworthy
> entities to inject malicious blobs into this memory range on quite a few
> implementations.  For example, there are probably unauthenticated EFI
> variables and even parts of USB sticks and such that get read into boot
> services memory, and I see no reason at all to expect that nothing in the
> so-called "boot services code" range is actually just plain old boot
> services *heap*.
> 
> Fortunately, given your design, this is very easy to fix.  Just replace
> CRC32 with SHA-256 or similar.  If you find the crypto api too ugly for
> this purpose, I have patches that only need a small amount of dusting off
> to give an entirely reasonable SHA-256 API in the kernel.

My main reason for going with crc32 is that the scanning happens before
the kernel is fully up and running (it happens just before the rest_init()
call in start_kernel() (from init/main.c) I'm open to using the
crypto api, but I was not sure if that is ready for use at that time.

> (To be clear, I don't love my own suggestion here.  What I'd *really* like
> to see is a better interface and no attempt to match the data to some
> built-in hash at all.  In particular, there are plenty of devices for which
> the driver wants access to a genuinely device-specific blob.  For example,
> I'm typing this email while connected to a router that is running ath10k
> and is using a calibration blob awkwardly snarfed out of flash somewhere.
> It would be really nice if there was a way to pull a blob out of EFI space
> that is marked, by EFI, as belonging to a particular device.  Then the
> firmware could just pass it over without any particular verification.  But
> since your code is literally scanning a wide swath of physical memory for
> something that looks like a valid blob, I think you need to use a
> cryptographically strong concept of validity.)

Yes ideally this would not be needed at all and/or use a well defined
interface, but alas we don't live in an ideal world :)

Regards,

Hans
