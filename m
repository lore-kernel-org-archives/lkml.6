Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeC3LZ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:25:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53982 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC3LZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:25:25 -0400
X-Google-Smtp-Source: AIpwx48+zLB4vlx4ytRY+RaxIP/wE8JKW/92jIshtqaUt7q00BO4q6qeMwhnTaGhuIbq3bLYw6lbI6WHkfNdESd9cgc=
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB19162707D0F98D1A061F0A7AF8A20@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com> <20180324184940.19762-4-Yazen.Ghannam@amd.com>
 <20180329105448.GB29198@pd.tnic> <DM5PR12MB19162707D0F98D1A061F0A7AF8A20@DM5PR12MB1916.namprd12.prod.outlook.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Mar 2018 12:25:23 +0100
Message-ID: <CAKv+Gu_6D03iGvxsmiQS_ODET2cv4f7kVsK5S5EKhiVN1YxRaw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info Structure
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 March 2018 at 14:53, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: Borislav Petkov <bp@alien8.de>
>> Sent: Thursday, March 29, 2018 6:55 AM
>> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
>> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> ard.biesheuvel@linaro.org; x86@kernel.org; tony.luck@intel.com
>> Subject: Re: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
>> Structure
>>
>> On Sat, Mar 24, 2018 at 01:49:35PM -0500, Yazen Ghannam wrote:
>> > From: Yazen Ghannam <yazen.ghannam@amd.com>
>> >
>> > Print the fields in the IA32/X64 Processor Error Info Structure.
>> >
>> > Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
>> > Structure.
>> >
>> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> > ---
>> > Link:
>> > https://lkml.kernel.org/r/20180226193904.20532-4-
>> Yazen.Ghannam@amd.com
>> >
>> > v2->v3:
>> > * Fix table number in commit message.
>> > * Don't print raw validation bits.
>> >
>> > v1->v2:
>> > * Add parantheses around "bits" expression in macro.
>> > * Fix indentation on multi-line statements.
>> >
>> >  drivers/firmware/efi/cper-x86.c | 50
>> +++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 50 insertions(+)
>> >
>> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
>> x86.c
>> > index 863f0cd2a0ff..a9ab3bbf7986 100644
>> > --- a/drivers/firmware/efi/cper-x86.c
>> > +++ b/drivers/firmware/efi/cper-x86.c
>> > @@ -3,15 +3,28 @@
>> >
>> >  #include <linux/cper.h>
>> >
>> > +#define INDENT_SP  " "
>>
>> There's that thing again. So it was a total waste of time discussing
>> this last time. So let me save my time this time:
>>
>> NAKed-by: Borislav Petkov <bp@suse.de>
>>
>
> IIRC, the arguments for keeping this are
> 1) convention for CPER
> 2) code readability
>
> The argument against was
> 1) it's dumb
>
> So I decided to keep it. I don't really mind either way so I'll change it
> if there's a second opinion.
>

Yes, please change it.
