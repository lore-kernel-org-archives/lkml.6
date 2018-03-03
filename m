Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCCUkF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:40:05 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35322 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeCCUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:40:03 -0500
X-Google-Smtp-Source: AG47ELsFfT17lRCvduq+B/7ag10R1e6GD95JA7KaabHs0kG19XFkNKI3Ney8mYQyP6vD1KMJ3OBNf1ZU1rd3EigYA30=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-mrMpgFVssUH1RXP6GAKuPNtQwwsCNTqv2Oa48FrU+Bg@mail.gmail.com>
References: <1516309264-23926-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180126211643.GB6520@codeblueprint.co.uk> <CAKv+Gu-mrMpgFVssUH1RXP6GAKuPNtQwwsCNTqv2Oa48FrU+Bg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 3 Mar 2018 20:40:01 +0000
Message-ID: <CAKv+Gu_eWymAuFqXiHiVk=Ys_w0UZvpVob6-vZ8yCGahsPNVqA@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Use mm_struct and switch_mm() instead of manually
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 January 2018 at 10:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 26 January 2018 at 21:16, Matt Fleming <matt@codeblueprint.co.uk> wrote:
>> On Thu, 18 Jan, at 01:01:04PM, Sai Praneeth Prakhya wrote:
>>> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>>>
>>> Presently, in x86, to invoke any efi function like
>>> efi_set_virtual_address_map() or any efi_runtime_service() the code path
>>> typically involves read_cr3() (save previous pgd), write_cr3()
>>> (write efi_pgd) and calling efi function. Likewise after returning from
>>> efi function the code path typically involves read_cr3() (save efi_pgd),
>>> write_cr3() (write previous pgd). We do this couple of times in efi
>>> subsystem of Linux kernel, instead we can use helper function
>>> efi_switch_mm() to do this. This improves readability and maintainability.
>>> Also, instead of maintaining a separate struct "efi_scratch" to store/restore
>>> efi_pgd, we can use mm_struct to do this.
>>
>> FWIW this series looks OK to me.
>>
>> Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
>
> Thanks Matt
>
> I know the x86 guys have been rather busy lately, so I will give them
> some more time to respond. If there are no objections raised, I will
> queue it for v4.17 in a couple of weeks.

Queued in linux-efi/next

Thanks all.
