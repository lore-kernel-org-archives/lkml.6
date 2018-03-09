Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeCIJ4I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:56:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33737 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeCIJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:56:06 -0500
X-Google-Smtp-Source: AG47ELuRv+Xb5itE3S9z/FPYRyMJdNYV2I0NxohCgWaYRqC583EUWM63JLCTi+nO2px/K2IFJdtstrru4TesmcVmd90=
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F2E581F50@ORSMSX114.amr.corp.intel.com>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
 <20180308080020.22828-8-ard.biesheuvel@linaro.org> <20180309074034.put3ko6zxmaoizzr@gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F2E581F50@ORSMSX114.amr.corp.intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 9 Mar 2018 09:56:05 +0000
Message-ID: <CAKv+Gu_Yk1KHbKp940WufNLWU_WnRnThn+=rOJ=Lo6C7j3gqPw@mail.gmail.com>
Subject: Re: [PATCH 07/12] efi: Use efi_mm in x86 as well as ARM
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 March 2018 at 08:37, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>> > diff --git a/include/linux/efi.h b/include/linux/efi.h index
>> > f5083aa72eae..f1b7d68ac460 100644
>> > --- a/include/linux/efi.h
>> > +++ b/include/linux/efi.h
>> > @@ -966,6 +966,8 @@ extern struct efi {
>> >     unsigned long flags;
>> >  } efi;
>> >
>> > +extern struct mm_struct efi_mm;
>> > +
>> >  static inline int
>> >  efi_guidcmp (efi_guid_t left, efi_guid_t right)  {
>>
>> Ugh, I can see three problems with this patch:
>>
>> 1)
>>
>> Why is the low level asm/efi.h header polluted with two of the biggest header
>> files in existence, to add a type to _another_ header (efi.h)?
>>
>> 2)
>>
>> Why is <linux/sched/task.h> included if what is being relied on is mm_struct?
>>
>> 3)
>>
>> But even <linux/sched/mm.h> looks unnecessary in efi.h, a simple forward
>> declaration of mm_struct would do ...
>>
>> The high level MM and sched headers should be added to the actual .c files that
>> make use of them.
>
> Ok, makes sense.
> Sorry! for that. I will fix the issues.
>

I have some other fixups to do, so if this is as easy as it seems
(remove the #includes and add the forward declaration), I can fix it
up and resend it for you.
