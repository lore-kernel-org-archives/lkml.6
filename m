Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965555AbeBMSkv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:40:51 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36349 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965530AbeBMSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:40:50 -0500
X-Google-Smtp-Source: AH8x2275Q+WC63hp8Xp6lskGoPb8eSQCWmNwRAJvtId9UrWxAiwoRCtfZGGtAZx30fMVc+RPt69Po2pykd4bVJIR+4k=
MIME-Version: 1.0
In-Reply-To: <20180213180707.einsznaoghtctkqn@gmail.com>
References: <1516847386-5291-1-git-send-email-baijiaju1990@gmail.com> <20180213180707.einsznaoghtctkqn@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Feb 2018 18:40:48 +0000
Message-ID: <CAKv+Gu-XAOETMCtmePeBKJYbf1EoB2K9BeN0ja0UPXa9ho175A@mail.gmail.com>
Subject: Re: [PATCH] x86: efi: Replace GFP_ATOMIC with GFP_KERNEL in efi_query_variable_store
To: Ingo Molnar <mingo@kernel.org>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 February 2018 at 18:07, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
>> The function kzalloc here is not called in atomic context.
>> If nonblocking in efi_query_variable_store is true,
>> namely it is in atomic context, efi_query_variable_store will return before
>> this kzalloc is called.
>> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>  arch/x86/platform/efi/quirks.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index 8a99a2e..b6dcb52 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -177,7 +177,7 @@ efi_status_t efi_query_variable_store(u32 attributes, unsigned long size,
>>                * that by attempting to use more space than is available.
>>                */
>>               unsigned long dummy_size = remaining_size + 1024;
>> -             void *dummy = kzalloc(dummy_size, GFP_ATOMIC);
>> +             void *dummy = kzalloc(dummy_size, GFP_KERNEL);
>
> Looks good to me!
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>

Queued in linux-efi/next

Thanks all.
