Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308125-1527857619-2-14881937263546305190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527857619; b=PFGo9iHwtYU+mjvi9xnA4SvvNzhz+AR59Q8hS/MnqOTKpMfHAE
    QMR/1y7e7haPYsOE0Y5+1H8C3TGBzoTfYtZoHmTgf0ikM0xURKyQW910l1v9DbdG
    JmPseMpTj1rEnzOY+A7/8AOsm3cbuP/reypBr0u3qgo4hONLgNtCCRmskBn0nIR3
    nmWGR6HRfAcN95THbdTeALqCdpbiuGAGjC4bLeJarnA2T08rPGfFkgWnkGw6Uj4x
    t4wuoywxdWhzj/sWRS0x40d6JhNW62RlQzAi769rKbBcUQL5W91VbNylVgs8KHs2
    3EqgXmxKFkwRRUiDy9kFgDwDBTZCVlKoN+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527857619; bh=hGbTc1g+jgbI+uU2Oo6ZGePfs7HFAv
    Ek/uPG9iATaGc=; b=CWcbpD+W7+RsmIBuIVSCAuJQ2EBkYxWN0/rlRavrufMD0d
    +US67GZeONU7/I/jlDcJpSZzy/00bPwAtaU3ivLwxs7HkNh1UuIl2g2PEV8YwwdJ
    XLoGuIZMSWu/gNgT14ddoT2rD+x8wIbAYPgWeeT9KOS3Ty8L4dXOCm4y0gOdbKYP
    0PNq3FHAac4aNRI+mQrIotgUrDJEx/exvaGtmQhsznzEbKBkeJ7J7rYnY+shg56+
    1zxbv5p9zXXeg1+bf8Dg37N/UHs/bzXzTBb2oNgz4Tn4q44xJcyGA0nQeiDJB1It
    FkYuHfju+tu0otRtubY2jYb/e6n/4LNlYVrje+YA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEcW5QBHoLFeeALggfrrCtZ+AGSG+ecvahoUgtvDqbRz7m4sAyqbwk9+bNxlWYYU5GpBlc5MfhVgbO2/sd8tTK7949swoCk5k/s9x2U8v8Kam/qFgaS6
    TaMzkDnyvvwUxOhimMXPkIFV1CxKzd6iDwLyZAh2qzSeiz3KGFXoSwMclh7E9Zv4tNVKbObnBjAPJ5vWfZPbc2eEiCes1vGBCt3jcZQSlQEM2sWFu0SaLNlZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=VwQbUJbxAAAA:8
    a=9zuaeKyTgA1b66mqZe8A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeFAMxi (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 08:53:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751769AbeFAMxh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 1 Jun 2018 08:53:37 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
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
Subject: [PATCH v6 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
Date: Fri,  1 Jun 2018 14:53:25 +0200
Message-Id: <20180601125330.25054-1-hdegoede@redhat.com>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is v6 of my patch-set to add support for EFI embedded fw to the kernel.

This patch-set applies on top of the "[PATCH v7 00/14] firmware_loader
changes for v4.18" series from mcgrof.

It now also depends on the series from Andy Lutomirski which allow using the
sha256 code in a standalone manner. Andy what is the status of those?

Changes since v5:
-Rework code to remove casts from if (prefix == mem) comparison
-Use SHA256 hashes instead of crc32 sums
-Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
-Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
 to check if this is allowed before looking at EFI embedded fw
-Document why we are not using the PI Firmware Volume protocol

For reference I've included the coverletter from v4 (which includes
previous covverletters) below.

Regards,

Hans


Previous coverletter:

Here is v5 of my patch-set to add support for EFI embedded fw to the kernel.

Changes since v4:
-Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

So I think this patch-set is getting close to ready for merging, which
brings us to the question of how to merge this, I think that patches 1
and 2 should probably both be merged through the same tree. Then an
unmutable branch should be created on that tree, merged into the
platform/x86 tree and then the last 3 patches can be merged through
that tree.

Ard has already indicated he is fine with the EFI bits going upstream
through another tree, so perhaps patches 1-2 can be merged through the
firmware-loader-tree and then do an unmutable branch on the
firmware-loader-tree for the platform/x86 tree to merge?

I don't think taking all 5 through 1 tree is a good idea because of
the file rename under platform/x86.


For the record here are the cover letters of the previous versions:

Changes since v3:
-Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
 UEFI proper, so the EFI maintainers don't want us referring people to it
-Use new EFI_BOOT_SERVICES flag
-Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
 file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
-Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
 EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
 in firmware_loader/main.c
-Properly call security_kernel_post_read_file() on the firmware returned
 by efi_get_embedded_fw() to make sure that we are allowed to use it

The 3 most prominent changes in v2 are:

1) Add documentation describing the EFI embedded firmware mechanism to:
   Documentation/driver-api/firmware/request_firmware.rst

2) Instead of having a single dmi_system_id array with its driver_data
   members pointing to efi_embedded_fw_desc structs, have the drivers which
   need EFI embedded-fw support export a dmi_system_id array and register
   that with the EFI embedded-fw code

   This series also includes the first driver to use this, in the form of
   the touchscreen_dmi code (formerly silead_dmi) from drivers/platfrom/x86

3) As discussed during the review of v1 we want to make the firmware_loader
   code fallback to EFI embedded-fw optional.  Rather the adding yet another
   firmware_request_foo variant for this, with the risk of later also needing
   firmware_request_foo_nowait, etc. variants I've decided to make the code
   check if the device has a "efi-embedded-firmware" device-property bool set.

   This also seemed better because the same driver may want to use the
   fallback on some systems, but not on others since e.g. not all (x86)
   systems with a silead touchscreen have their touchscreen firmware embedded
   in their EFI.

   Note that (as discussed) when the EFI fallback path is requested, the
   usermodehelper fallback path is skipped.

Here is the full changelog of patch 2/5 which is where most of the changes are:

Changes in v2:
-Rebased on driver-core/driver-core-next
-Add documentation describing the EFI embedded firmware mechanism to:
 Documentation/driver-api/firmware/request_firmware.rst
-Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
 fw support if this is set. This is an invisible option which should be
 selected by drivers which need this
-Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
 from the efi-embedded-fw code, instead drivers using this are expected to
 export a dmi_system_id array, with each entries' driver_data pointing to a
 efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
-Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
 this avoids us messing with the EFI memmap and avoids the need to make
 changes to efi_mem_desc_lookup()
-Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
 passed in device has the "efi-embedded-firmware" device-property bool set
-Skip usermodehelper fallback when "efi-embedded-firmware" device-property
 is set

Patches 3-5 are new and implement using the EFI embedded-fw mechanism for
Silead gslXXXX and Chipone icn8505 touchscreens on x86 devices.

