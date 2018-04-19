Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeDSKHO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:07:14 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34484 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeDSKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:07:12 -0400
X-Google-Smtp-Source: AB8JxZo188JhyLInTjTI9jBJHovo6+E9sQNE9F6Z65pUQacXV/Rb2HvHR2d0KO8O0GhfU9FerZybWdtdv0/WnJrf4kw=
MIME-Version: 1.0
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 19 Apr 2018 12:07:11 +0200
Message-ID: <CAKv+Gu8f2VCYDzpR9DPFhS-FYiOyjPDikOZWCejdS1rcDi5A_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Decode IA32/X64 CPER
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 April 2018 at 17:06, Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> This series adds decoding for the IA32/X64 Common Platform Error Record.
>
> Patch 1 fixes the IA32/X64 Processor Error Section definition to match
> the UEFI spec.
>
> Patches 2-8 add the new decoding. The patches incrementally add the
> decoding starting from the top-level "Error Section". Hopefully, this
> will make reviewing a bit easier compared to one large patch.
>
> The formatting of the field names and options is taken from the UEFI
> spec. I tried to keep everything the same to make searching easier.
>
> The patches were written to the UEFI 2.7 spec though the definition of
> the IA32/X64 CPER seems to be the same as when it was introduced in
> the UEFI 2.1 spec.
>
> Link:
> https://lkml.kernel.org/r/20180324184940.19762-1-Yazen.Ghannam@amd.com
>

Queued in linux-efi/next

Thanks Yazen


> Changes V3 to V4:
> * Drop INDENT_SP use.
>
> Changes V2 to V3:
> * Fix table numbers in commit messages.
> * Don't print raw validation bits.
> * Only print GUID for unknown error types.
>
> Changes V1 to V2:
> * Remove stable request for all patches.
> * Address Ard's comments on formatting and other issues.
> * In Patch 8, always print context info even if the type is not
>   recognized.
>
> Yazen Ghannam (8):
>   efi: Fix IA32/X64 Processor Error Record definition
>   efi: Decode IA32/X64 Processor Error Section
>   efi: Decode IA32/X64 Processor Error Info Structure
>   efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
>   efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
>   efi: Decode additional IA32/X64 Bus Check fields
>   efi: Decode IA32/X64 MS Check structure
>   efi: Decode IA32/X64 Context Info structure
>
>  drivers/firmware/efi/Kconfig    |   5 +
>  drivers/firmware/efi/Makefile   |   1 +
>  drivers/firmware/efi/cper-x86.c | 356 ++++++++++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper.c     |  10 ++
>  include/linux/cper.h            |   4 +-
>  5 files changed, 375 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/cper-x86.c
>
> --
> 2.14.1
>
