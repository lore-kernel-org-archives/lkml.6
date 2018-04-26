Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524761589; cv=none;
        d=google.com; s=arc-20160816;
        b=GeNh3vNIdG6A3T7ll+cHTUXgzQxdj3zkgc9/dVkhK6EGEUaesNUwzXRAp0POUrC/yU
         No7Z8hMH5/ZpgDjq2HZTdNeQ4wcMMSHKMETOso7d6KzRWu5+yaXIljzr6+zdR0ufWZ/2
         v4FgWzynT/i1EqWaPBSxani1vuIzncwo+cVmLAC3u7bfSgGYLrFpQUQA3PueQMUappKf
         P2IoxROSPG3PfGQXQU3zbEyC5crx6FYv+R0iGI1b/rcH4rm/TNwm4CAJG/009M/l9e4Q
         a7XBkO0OnmyoRk+8jIM1Gnnw4ExR7aJwprceCt6nDOtyz3ouhf6e/OZgFY9sBo3wFYsL
         A0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EPkILPSZMkNbJjuG9Vb6gF+XlEhGF7RDQyKwh1WgJ5c=;
        b=CPgfnAuFbyGBCWw6/Phnrmjtj0eUoy4JnZ9fibPKYoIzSuriWi86dK99vAwiBe9Ttb
         lT8oOVy3zb/Yx0zciT+9cJwV0s4pZ81Rsk0EIXrSZapjm63jsEh78e649SZpWXyjhIux
         RTAHm20WwjnRHIcpRQlMOftaPHe5SxfKFJKMAu2qopB2NkSp22m/BPyB3cyE4KiVlzNO
         5sFnu7XDc0qPzxQsU4DNMhQKWDGiRv6OyLOI7YRqj+dqoC0PwlJ0QJRclYjygOtVZPPT
         tnC0JsVdjIdFEo/lAwqwm2clOT+VMfiBgbP7n6KxQjwEt+Hs68pC00nHILloCxqa51lG
         Utzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=V+Dx7nf+;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=V+Dx7nf+;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrGLqE2kHuVy4v5bU4rgIhnA5ZITSM0Mh7cZAiMtFnFPUxbD+uBn+aWZxMNG7UCDcNYZp0iGT2EDPOv7ZZCwmQ=
MIME-Version: 1.0
In-Reply-To: <20180426120637.21258-1-hdegoede@redhat.com>
References: <20180426120637.21258-1-hdegoede@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 26 Apr 2018 18:53:08 +0200
Message-ID: <CAKv+Gu8sxnt6rHOQ0LCnzhWv0vyVZX+G5EN9g2pZB4SnjghN-Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
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
X-GMAIL-THRID: =?utf-8?q?1598810387552220035?=
X-GMAIL-MSGID: =?utf-8?q?1598828408141130569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 April 2018 at 14:06, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Here is v4 of my patch-set to add support for EFI embedded fw to the kernel.
>
> Changes since v3:
> -Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
>  UEFI proper, so the EFI maintainers don't want us referring people to it
> -Use new EFI_BOOT_SERVICES flag
> -Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
>  file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
> -Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
>  EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
>  in firmware_loader/main.c
> -Properly call security_kernel_post_read_file() on the firmware returned
>  by efi_get_embedded_fw() to make sure that we are allowed to use it
>
> So I think this patch-set is getting close to ready for merging, which
> brings us to the question of how to merge this, I think that patches 1
> and 2 should probably both be merged through the same tree. Then an
> unmutable branch should be created on that tree, merged into the
> platform/x86 tree and then the last 3 patches can be merged through
> that tree.
>

I am perfectly happy to either ack the patches that fall under my
responsibility so they can be taken via another tree, or take the
whole thing via the EFI tree, whichever works for other maintainers.

> For the record, here is the coverletter of v2 of this patchset:
>
> The 3 most prominent changes in v2 are:
>
> 1) Add documentation describing the EFI embedded firmware mechanism to:
>    Documentation/driver-api/firmware/request_firmware.rst
>
> 2) Instead of having a single dmi_system_id array with its driver_data
>    members pointing to efi_embedded_fw_desc structs, have the drivers which
>    need EFI embedded-fw support export a dmi_system_id array and register
>    that with the EFI embedded-fw code
>
>    This series also includes the first driver to use this, in the form of
>    the touchscreen_dmi code (formerly silead_dmi) from drivers/platfrom/x86
>
> 3) As discussed during the review of v1 we want to make the firmware_loader
>    code fallback to EFI embedded-fw optional.  Rather the adding yet another
>    firmware_request_foo variant for this, with the risk of later also needing
>    firmware_request_foo_nowait, etc. variants I've decided to make the code
>    check if the device has a "efi-embedded-firmware" device-property bool set.
>
>    This also seemed better because the same driver may want to use the
>    fallback on some systems, but not on others since e.g. not all (x86)
>    systems with a silead touchscreen have their touchscreen firmware embedded
>    in their EFI.
>
>    Note that (as discussed) when the EFI fallback path is requested, the
>    usermodehelper fallback path is skipped.
>
> Here is the full changelog of patch 2/5 which is where most of the changes are:
>
> Changes in v2:
> -Rebased on driver-core/driver-core-next
> -Add documentation describing the EFI embedded firmware mechanism to:
>  Documentation/driver-api/firmware/request_firmware.rst
> -Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
>  fw support if this is set. This is an invisible option which should be
>  selected by drivers which need this
> -Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
>  from the efi-embedded-fw code, instead drivers using this are expected to
>  export a dmi_system_id array, with each entries' driver_data pointing to a
>  efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
> -Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
>  this avoids us messing with the EFI memmap and avoids the need to make
>  changes to efi_mem_desc_lookup()
> -Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
>  passed in device has the "efi-embedded-firmware" device-property bool set
> -Skip usermodehelper fallback when "efi-embedded-firmware" device-property
>  is set
>
> Patches 3-5 are new and implement using the EFI embedded-fw mechanism for
> Silead gslXXXX and Chipone icn8505 touchscreens on x86 devices.
>
> Regards,
>
> Hans
>
