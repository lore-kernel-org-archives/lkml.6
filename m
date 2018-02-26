Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeBZQGC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:06:02 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42313 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeBZQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:06:01 -0500
X-Google-Smtp-Source: AG47ELswZzlGkKtQjYBVaWEd1rQBHzpVan4fx8EGyZxsB1dVWj/AIvcN3z1ui7hvpn+AfmliBPFaU7O3KVsZ1q46O/E=
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB1916F87127E0C2EF6F042247F8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-9-Yazen.Ghannam@amd.com>
 <CAKv+Gu_kwJTxsmmQSAMKgSmK6w_-BhqBTnv3Sqv-K1TCYq4X-Q@mail.gmail.com> <DM5PR12MB1916F87127E0C2EF6F042247F8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 26 Feb 2018 16:06:00 +0000
Message-ID: <CAKv+Gu9yHZEd5JjrmYVqb6ESCR5rP0kYZCNeAcy1kuYpjxJ7jQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2018 at 16:05, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
>> Sent: Saturday, February 24, 2018 11:46 AM
>> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
>> Cc: linux-efi@vger.kernel.org; Linux Kernel Mailing List <linux-
>> kernel@vger.kernel.org>; Borislav Petkov <bp@suse.de>; the arch/x86
>> maintainers <x86@kernel.org>
>> Subject: Re: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
>>
>> On 23 February 2018 at 20:03, Yazen Ghannam
>> <Yazen.Ghannam@amd.com> wrote:
>> > From: Yazen Ghannam <yazen.ghannam@amd.com>
>> >
>> > Print the fields of the IA32/X64 Context Information structure.
>> >
>> > Print the "Register Array" as raw values. Some context types are defined
>> > in the UEFI spec, so more detailed decoded may be added in the future.
>> >
>> > Based on UEFI 2.7 section N.2.4.2.2 IA32/X64 Processor Context
>> > Information Structure.
>> >
>> > Cc: <stable@vger.kernel.org> # 4.16.x
>> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> > ---
>> >  drivers/firmware/efi/cper-x86.c | 55
>> +++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 55 insertions(+)
>> >
>> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
>> x86.c
>> > index 02b1b424f537..bb6cef0b5e53 100644
>> > --- a/drivers/firmware/efi/cper-x86.c
>> > +++ b/drivers/firmware/efi/cper-x86.c
>> > @@ -13,6 +13,7 @@
>> >  #define VALID_LAPIC_ID                 BIT_ULL(0)
>> >  #define VALID_CPUID_INFO               BIT_ULL(1)
>> >  #define VALID_PROC_ERR_INFO_NUM(bits)  ((bits & GENMASK_ULL(7, 2))
>> >> 2)
>> > +#define VALID_PROC_CNXT_INFO_NUM(bits) ((bits & GENMASK_ULL(13,
>> 8)) >> 8)
>>
>> Parens
>>
>> Also, CNXT isn't really idiomatic when abbreviating 'context' (and you
>> use CTX below as well)
>>
>
> The UEFI spec uses PROC_CONTEXT_INFO_NUM.
>
> Would you prefer 1 or 2 below?
> 1) VALID_PROC_CONTEXT_INFO_NUM
> 2) VALID_PROC_CTX_INFO_NUM
>

Let's go with 2) since you're already using CTX in numerous places.
