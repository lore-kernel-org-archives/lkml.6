Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525413269; cv=none;
        d=google.com; s=arc-20160816;
        b=UJeRiCsM9NP5+B9ZSlLpLS4eZIEFOKbKtJGish2shmS/ER9IVceLdinH9w6A/6GGs5
         UEWZ+Rhe6n9g3eKgkn4BQ0mC5QPleJrYx8bw/MpCVSd6TwQFCJO5qUN4D+rNgjbGZaVa
         PQbsU8YFPQe3mtwHf84P5UMMD/Zapzf8chf1+chFmubQOAm50rr4vhVgzkqTk55xsFAg
         bY8onbMROdAQwp4A8T0aZgOT1CEEUFsyHSNwUeyamM0XCRLDY//VEL2IAWb3O7D8cDAx
         Oy7mSncUb5TMpG/3u/qpfNVT2bHktQ11WPNuxHdzdr2rXz0b4QF6JTtQEL4TLnqSjYhX
         YVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HIrmFW9ku3etRKOJwHe5zRB/bP3STB0V98hhCrc/S/g=;
        b=grFD/mLkEpG/19OVafc88rSXJKN+SKIXfXDUsDr+tgcIPVPEHQfbrYFl+UCnwrJ52/
         6BYKmfcuBBVAAQ3FyiQ27TNiB5eIV5bRupLoTrNUUK/UK0NABqsDb4as0T83I175iiyM
         Hhpyp8MJdI/82q0cD8nkMIcbGAwX/LpO5sK4u8YcRlcGgN/DOuhQoJ7b2TIEc3/i5rUR
         PYBoLdr5soCq6k6brN237pPbHNSUjArcp9gLiDtRXqfkaL/xdpWP6k0pjyNU/WPNgO6c
         YjsGD3WOEiDowheJO6zlN6DH3j1GyDK2ul6DFGxYWx61Xfrlv0MhKu3VtF0iXE+x1yI9
         G11A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=B3FpCclm;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=B3FpCclm;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqyfP7tO68ki5HdrNvkPw0/zkqKfBkJQ4Nk7r6ZV734/NYSDAQyc0CShf3h/mlDOgCAeHRidYIzGxSs+mW4Hhk=
MIME-Version: 1.0
In-Reply-To: <20180503232920.GF27853@wotan.suse.de>
References: <20180429093558.5411-1-hdegoede@redhat.com> <20180429093558.5411-3-hdegoede@redhat.com>
 <20180503232920.GF27853@wotan.suse.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 4 May 2018 07:54:28 +0200
Message-ID: <CAKv+Gu94HNK3vDa2-ro+mb9L6XfWQQgR2qneEmtpA0WqS5SqGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
	andresx7@gmail.com, Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Kalle Valo <kvalo@codeaurora.org>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Broeking <nbroeking@me.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Torsten Duwe <duwe@suse.de>,
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>, linux-efi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599511744914186217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4 May 2018 at 01:29, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Sun, Apr 29, 2018 at 11:35:55AM +0200, Hans de Goede wrote:
[...]
>> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
>> index c8bddbdcfd10..560dfed76e38 100644
>> --- a/Documentation/driver-api/firmware/request_firmware.rst
>> +++ b/Documentation/driver-api/firmware/request_firmware.rst
>> @@ -73,3 +73,69 @@ If something went wrong firmware_request() returns non-zero and fw_entry
>>  is set to NULL. Once your driver is done with processing the firmware it
>>  can call call firmware_release(fw_entry) to release the firmware image
>>  and any related resource.
>> +
>> +EFI embedded firmware support
>> +=============================
>
> This is a new fallback mechanism, please see:
>
> Documentation/driver-api/firmware/fallback-mechanisms.rst
>
> Refer to the section "Types of fallback mechanisms", augument the list there
> and then move the section "Firmware sysfs loading facility" to a new file, and
> then add a new file for your own.
>
>> +
>> +On some devices the system's EFI code / ROM may contain an embedded copy
>> +of firmware for some of the system's integrated peripheral devices and
>> +the peripheral's Linux device-driver needs to access this firmware.
>
> You in no way indicate this is a just an invented scheme, a custom solution and
> nothing standard.  I realize Ard criticized that the EFI Firmware Volume Protocol
> is not part of the UEFI spec -- however it is a bit more widely used right?
> Why can't Linux support it instead?
>

Most implementations of UEFI are based on PI, and so it is likely that
the protocols are available. However, the PI spec does not cover
firmware blobs, and so it is undefined whether such blobs are self
contained (i.e., in separate files in the firmware volume), statically
linked into the driver or maybe even encrypted or otherwise
encapsulated, and the actual loadable image only lives in memory.

Hans's case is the second one, i.e., the firmware is at an arbitrary
offset in the driver image. Using the FV protocol in this case would
result in a mix of both approaches: look up the driver file by GUID
[which could change btw between different versions of the system
firmware, although this is unlikely] and then still use the prefix/crc
based approach to sift through the image itself.

But my main objection is simply that from the UEFI forum point of
view, there is a clear distinction between the OS visible interfaces
in the UEFI spec and the internal interfaces in the PI spec (which for
instance are not subject to the same rules when it comes to backward
compatibility), and so I think we should not depend on PI at all. This
is all the more important considering that we are trying to encourage
the creation of other implementations of UEFI that are not based on PI
(e.g., uboot for arm64 implements the required UEFI interfaces for
booting the kernel via GRUB), and adding dependencies on PI protocols
makes that a moving target.

So in my view, we either take a ad-hoc approach which works for the
few platforms we expect to support, in which case Hans's approach is
sufficient, or we architect it properly, in which case we shouldn't
depend on PI because it does not belong in a properly architected
OS<->firmware exchange.

-- 
Ard.
