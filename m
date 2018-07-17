Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46BBECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B132086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiPPiu6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B132086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeGQDnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:43:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34907 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQDnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:43:01 -0400
Received: by mail-io0-f194.google.com with SMTP id q4-v6so39880631iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TMOJhCt+cFMGjV6Yk9QKP7Wwn94pdyXOBWfixEDIA5c=;
        b=aiPPiu6O8zIJ7x3xpk1abad3ecFZZ4jAIIaQ9OvDMxPc/oK/AY6wLjZPNtJVa8ieg5
         jp4rlWP8jOxSY/0JV2zKqAAZopRfWVDW6CvwZd4lEVugR5Ng6ErcyZ51L6LAyE1DjYJH
         po9JCCwsJu9EhGKcu+MTHGNrS/DqBRqvMGR8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TMOJhCt+cFMGjV6Yk9QKP7Wwn94pdyXOBWfixEDIA5c=;
        b=Dx6aPJwbzjhFwbW9mrCn5sIntgQwoTSMjISV47347Gs/EcAFaWcz/jXTqzvy9P0TUq
         d9n+3CYAvAJATKRpd7dQNaPRtFwI5unxSdJs6e/S+tSjezx80727KsJ+CLn2h9AzABaN
         QaARMrE9CKfuTSzyAZIWfCQb72nZLMAcsILpLeqKUFSwb6sUp7t3fn19DqBPDOwqLpN9
         czckeEDm/WUnrNAZ9FPr43eqFWL6O5IR6wsBOgQH9U8524uYfl23fMRdxKzARYSZiWd1
         2HOGsMsHYE/1solbRhl7xQK+ab2Pqd84imL7gkXtsFNRUbCf9pGRra1kfFUhzvifkjcv
         5qsQ==
X-Gm-Message-State: AOUpUlHmslvckzpaMt+ZBhQisFc32xhn45icRkPqVQ8AwmsO0vBQmFsS
        zeg3IO8vtF1vwnfkfoKqXHiypR/gNHVb1t7PMUcU5Q==
X-Google-Smtp-Source: AAOMgpetph/EM0BN/NrppplLJOP1ZddxKokrKkFanJzRQ7O+rZDpSQ1Geto3KZQgSaUAd9CsY5IdigSXQA+TPSZpnWg=
X-Received: by 2002:a6b:5d1a:: with SMTP id r26-v6mr33414566iob.170.1531797158872;
 Mon, 16 Jul 2018 20:12:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 20:12:38
 -0700 (PDT)
In-Reply-To: <3b48a62e-8a5c-3e83-2935-03c9ab011403@amd.com>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
 <CAKv+Gu_3kD+7O4oR9751VH2CsG=+NmBY-Gypc25LFo9eT6m3RQ@mail.gmail.com> <3b48a62e-8a5c-3e83-2935-03c9ab011403@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 17 Jul 2018 11:12:38 +0800
Message-ID: <CAKv+Gu9OmTgoREKxvvK57ybF1JUfkNeVNa8efAHSau0EFzvbNg@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is active
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "# 4 . 15 . x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 03:15, Brijesh Singh <brijesh.singh@amd.com> wrote:
> Hi Ard,
>
>
>
> On 07/11/2018 05:00 AM, Ard Biesheuvel wrote:
>>
>> On 3 July 2018 at 15:32, Brijesh Singh <brijesh.singh@amd.com> wrote:
>>>
>>> SEV guest fails to update the UEFI runtime variables stored in the
>>> flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
>>> when SEV is active") unconditionally maps all the UEFI runtime data
>>> as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
>>> as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
>>> guest and hypervisor can access the data.
>>>
>>> Fixes: 1379edd59673 (x86/efi: Access EFI data as encrypted ...)
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Borislav Petkov <bp@suse.de>
>>> Cc: linux-efi@vger.kernel.org
>>> Cc: kvm@vger.kernel.org
>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Cc: Matt Fleming <matt@codeblueprint.co.uk>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: <stable@vger.kernel.org> # 4.15.x
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>   arch/x86/platform/efi/efi_64.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/platform/efi/efi_64.c
>>> b/arch/x86/platform/efi/efi_64.c
>>> index 77873ce..5f2eb32 100644
>>> --- a/arch/x86/platform/efi/efi_64.c
>>> +++ b/arch/x86/platform/efi/efi_64.c
>>> @@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t
>>> *md, u64 va)
>>>          if (!(md->attribute & EFI_MEMORY_WB))
>>>                  flags |= _PAGE_PCD;
>>>
>>> -       if (sev_active())
>>> +       if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
>>>                  flags |= _PAGE_ENC;
>>>
>>>          pfn = md->phys_addr >> PAGE_SHIFT;
>>
>>
>> Is it safe to only update this occurrence and not the one in
>> efi_runtime_update_mappings() ?
>>
>
>
> It's safe to update this occurrence only. The SEV support is added
> in recent EDK2 bios, and the version of bios provides the
> EFI_MEMORY_ATTRIBUTE_TABLE. Hence the efi_enabled(EFI_MEM_ATTR) check in
> efi_runtime_update_mappings() will always be true. When EFI_MEM_ATTR is
> set the code updates the mapping and returns (see below)
>
> void __init efi_runtime_update_mappings(void)
> {
>    .....
>    .....
>
>    /*
>     * Use the EFI Memory Attribute Table for mapping permissions if it
>     * exists, since it is intended to supersede EFI_PROPERTIES_TABLE.
>     */
>     if (efi_enabled(EFI_MEM_ATTR)) {
>         efi_memattr_apply_permissions(NULL, efi_update_mem_attr);
>         return;
>     }
>
>
>    ...
>
> }
>
> The EFI_MEMORY_ATTRIBUTE_TABLE table does not include MMIO regions, the
> table describes the memory protections to EFI runtime code and data
> regions only. Both EFI runtime code and data should be mapped as
> encrypted. Hence I skipped updating the efi_runtime_update_mappings().
>

Ok, thanks for clearing that up

Queued in efi/urgent
