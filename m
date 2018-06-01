Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4066823-1527896445-2-12587050842160234705
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527896445; b=cLgtIPuTCSnQ5I2iTfudSObB4FWFJ4ItSRaQ4fPVrkvQl5wgWO
    ShpsKSxMrE/ULTNh0ph2KMT0lsxNh+7NxKg0idioJQAdo4y9XbYXLYeysG3c5jnw
    fbBrE9R7VoFE81fOm6GfY0U3f3aU1j1BWborxZ1W7gLbKPQrKxjet2/5yKA6iOlq
    pHRqtvfB2RW6esC1IkF/snUT6Yc8i9v/H4rSm1PGg2qcsDiL7ocm9bQ1iG3rJ0ws
    cqjUZCVIk5To78K/Ud2ziajVYFQG/h9uALH01HRfNNcp3hmhy2UDw4hjK86aq1pA
    jcNVit7tuJefQdmlBlIwxzeYvxysv4ncCbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527896445;
    bh=3nFG6VYZmRuJhHcmmNrtYM6CyGj4jazL2hOEh0d6Plw=; b=d95m/xlI6zoz
    c/KFuDzALCQ9kzWGtAI3D4rgucDr19cJ20eACUdAW7+KSrTEfFoY7IbjNcDLuU4X
    4JhWGbGvdIk2ORdHFte6/yRX4qsLFGqazweiU/d4Z5szjxsAJH1kcbUTVaIoQsUj
    n2Yh8MU7GivgC7T7KDQsZ/1xwg7//rNiaLty4WR8pxMtNcTe60Iac3m8Mt9t5lPf
    bEtxQ4HHL3LmJbjrXZiDTDlvXaZiIifRSXsVPNyx5jLTKrXrScAe6Vba2Nrqwyv5
    IlcA4lGEOpxHdsi/eGW6kbYNmuswM8A84kfcBiZuLOq8A3mp/8wNp122+ipuFXuw
    36KhsQCHFA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=0nS+71sy
    header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=0nS+71sy
      header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDkgbkZefN/9xYSo2Z9l8XHO4bh+dO6DxEhsLE4eEOAMD7GJgV7oHZJXqt4v7uJx+jUgHZEwSb+3rjGS80syUsirAcr5E3FF+qkrK/N8agP+BgRL0Mmp
    lrGdLRFGRE1B8pUAz6JdZgAh/4u3FslZ8dfDHhkgE9/p1pyKZvk55Eb3XMLGX4tPOL7K72JUOW3eQEgovz2O+DW9s+W6Rh3Ga1OG47+Im00X1at/u7n5djnw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=hUZ1mdSGup-a1UbKiioA:9
    a=3--2mvxv3_uunQtn:21 a=CsftYmSmoV1T8U3i:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeFAXkn (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 19:40:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45052 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFAXkm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Jun 2018 19:40:42 -0400
Subject: Re: [PATCH v6 2/5] efi: Add embedded peripheral firmware support
To: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc: Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, bjorn.andersson@linaro.org,
        Torsten Duwe <duwe@suse.de>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180601125330.25054-1-hdegoede@redhat.com>
 <20180601125330.25054-3-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ed05117-0566-52a2-5a09-c71dfd1fe632@infradead.org>
Date: Fri, 1 Jun 2018 16:40:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601125330.25054-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/01/2018 05:53 AM, Hans de Goede wrote:
> 
> Reported-by: Dave Olsthoorn <dave@bewaar.me>
> Suggested-by: Peter Jones <pjones@redhat.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> ---
>  .../driver-api/firmware/request_firmware.rst  |  76 +++++++++
>  drivers/base/firmware_loader/Makefile         |   1 +
>  drivers/base/firmware_loader/fallback.h       |  12 ++
>  drivers/base/firmware_loader/fallback_efi.c   |  56 +++++++
>  drivers/base/firmware_loader/main.c           |   2 +
>  drivers/firmware/efi/Kconfig                  |   3 +
>  drivers/firmware/efi/Makefile                 |   1 +
>  drivers/firmware/efi/embedded-firmware.c      | 148 ++++++++++++++++++
>  include/linux/efi.h                           |   6 +
>  include/linux/efi_embedded_fw.h               |  25 +++
>  include/linux/fs.h                            |   1 +
>  init/main.c                                   |   3 +
>  12 files changed, 334 insertions(+)
>  create mode 100644 drivers/base/firmware_loader/fallback_efi.c
>  create mode 100644 drivers/firmware/efi/embedded-firmware.c
>  create mode 100644 include/linux/efi_embedded_fw.h
> 
> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
> index f62bdcbfed5b..66ab91f3357d 100644
> --- a/Documentation/driver-api/firmware/request_firmware.rst
> +++ b/Documentation/driver-api/firmware/request_firmware.rst
> @@ -73,3 +73,79 @@ If something went wrong request_firmware() returns non-zero and fw_entry
>  is set to NULL. Once your driver is done with processing the firmware it
>  can call call release_firmware(fw_entry) to release the firmware image
>  and any related resource.
> +
> +EFI embedded firmware support
> +=============================
> +
> +On some devices the system's EFI code / ROM may contain an embedded copy
> +of firmware for some of the system's integrated peripheral devices and
> +the peripheral's Linux device-driver needs to access this firmware.
> +
> +A device driver which needs this can describe the firmware it needs
> +using an efi_embedded_fw_desc struct:
> +
> +.. kernel-doc:: include/linux/efi_embedded_fw.h
> +   :functions: efi_embedded_fw_desc
> +
> +The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE memory
> +segments for an eight byte sequence matching prefix, if the prefix is found it

                                                prefix; if

> +then does a crc32 over length bytes and if that matches makes a copy of length
> +bytes and adds that to its list with found firmwares.
> +
> +To avoid doing this somewhat expensive scan on all systems, dmi matching is
> +used. Drivers are expected to export a dmi_system_id array, with each entries'
> +driver_data pointing to an efi_embedded_fw_desc.
> +
> +To register this array with the efi-embedded-fw code, a driver needs to:
> +
> +1. Always be builtin to the kernel or store the dmi_system_id array in a
> +   separate object file which always gets builtin.
> +
> +2. Add an extern declaration for the dmi_system_id array to
> +   include/linux/efi_embedded_fw.h.
> +
> +3. Add the dmi_system_id array to the embedded_fw_table in
> +   drivers/firmware/efi/embedded-firmware.c wrapped in a #ifdef testing that
> +   the driver is being builtin.
> +
> +4. Add "select EFI_EMBEDDED_FIRMWARE if EFI_STUB" to its Kconfig entry.
> +
> +The request_firmware() function will always first try to load firmware with
> +the specified name directly from the disk, so the EFI embedded-fw can always
> +be overridden by placing a file under /lib/firmare.

                                         /lib/firmware.

> +
> +To make request_firmware() fallback to trying EFI embedded firmwares after this,
> +the driver must set a boolean "efi-embedded-firmware" device-property on the
> +device before passing it to request_firmware(). Note that this disables the
> +usual usermodehelper fallback, so you may want to only set this on systems
> +which match your dmi_system_id array.
> +
> +Once the device-property is set, the driver can use the regular
> +request_firmware() function to get the firmware, using the name filled in
> +in the efi_embedded_fw_desc.
> +
> +Note that:
> +
> +1. The code scanning for EFI embbedded-firmware runs near the end
> +   of start_kernel(), just before calling rest_init(). For normal drivers and
> +   subsystems using subsys_initcall() to register themselves this does not
> +   matter. This means that code running earlier cannot use EFI
> +   embbedded-firmware.
> +
> +2. ATM the EFI embedded-fw code assumes that firmwares always start at an offset

s/ATM/At the moment/

> +   which is a multiple of 8 bytes, if this is not true for your case send in

                               bytes; if

> +   a patch to fix this.
> +
> +3. ATM the EFI embedded-fw code only works on x86 because other archs free

At the moment

> +   EFI_BOOT_SERVICES_CODE before the EFI embedded-fw code gets a chance to
> +   scan it.
> +
> +4. The current brute-force scanning of EFI_BOOT_SERVICES_CODE is an ad-hoc
> +   brute-force solution. There has been discussion to use the PI spec's
> +   Firmware Volume protocol. This has been rejected because the FV Protocol
> +   relies on *internal* interfaces of PI spec, and:
> +   1. The The PI spec does not define firmware at all
> +   2. The internal interfaces of PI Spec does not guarantee any backward
> +      compatibility. Any implementation details in FV may be subject to change,
> +      and may vary system to system. Supporting the FV Protocol would be
> +      difficult as it is purposely ambiguous.

What/where is this PI spec?

thanks,
-- 
~Randy
