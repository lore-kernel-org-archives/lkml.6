Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeB0Pbx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:31:53 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:54342 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeB0Pbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:31:51 -0500
X-Google-Smtp-Source: AG47ELvRP99adh8GyD2on7lijAbERSObFi2ydVK3xt+Qdt31ahZspfw6Z6eov0h8R3GBxwf+sJxLW0DMkczyic9U3bQ=
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB191643165F74F3BDB469C5BCF8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com> <20180226193904.20532-5-Yazen.Ghannam@amd.com>
 <20180227143020.GG26382@pd.tnic> <DM5PR12MB191643165F74F3BDB469C5BCF8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 27 Feb 2018 15:31:50 +0000
Message-ID: <CAKv+Gu_yyshaM5XQ+SRAaFAA+CDVOxfZQAsE_1TZsyKYjTi3_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Borislav Petkov <bp@suse.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2018 at 15:28, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: Borislav Petkov [mailto:bp@suse.de]
>> Sent: Tuesday, February 27, 2018 9:30 AM
>> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
>> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> ard.biesheuvel@linaro.org; x86@kernel.org
>> Subject: Re: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error
>> Structure GUIDs
>>
>> On Mon, Feb 26, 2018 at 01:39:00PM -0600, Yazen Ghannam wrote:
>> > @@ -45,6 +81,11 @@ void cper_print_proc_ia(const char *pfx, const struct
>> cper_sec_proc_ia *proc)
>> >             printk("%sError Structure Type: %pUl\n", newpfx,
>> >                    &err_info->err_type);
>> >
>> > +           err_type = cper_get_err_type(&err_info->err_type);
>> > +           printk("%sError Structure Type: %s\n", newpfx,
>> > +                  err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
>> > +                  cper_proc_error_type_strs[err_type] : "unknown");
>>
>> Ah, there it is, much better. Now this tells us what component it is.
>>
>> So cper-arm.c does the same thing and there's a similar thing in cper.c -
>> cper_print_proc_generic().
>>
>> Let's not tri-plicate that code pls and have a generic function instead.
>>
>
> Sure, I can do that.
>
> Ard, is this okay?
>

Yes, please, but only if there's something to gain by it.
