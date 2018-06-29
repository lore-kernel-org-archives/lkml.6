Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884CA27C85
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsRcOkMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884CA27C85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936082AbeF2S5B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:57:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45242 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbeF2S47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:56:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id m2-v6so1398301oim.12;
        Fri, 29 Jun 2018 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azU3Ux/szIlUeWx6CdScnoe2s3Y61kaPLlyZdnvmRH0=;
        b=OsRcOkMZnM0XINH3YviSXSneN5ZpsIUk3RXLBYP9Cb4g0bduafKzLU0wGBzvHDyVBa
         y08HGSyWeCvtOvPXfV23/ybK6nLGy0goHJ6EX9VKptO/8YHuyERkaT9HgRrENrJVSU1O
         T6LsynKxyNkInZK7Xe7xBrhVnZ82oQm4mWfhe1Qx86ebolc8LxkphTr2kc9VqdAQPDsk
         H1jrjEmeTtmYviHYoMA5GfsFqT109eqcOrmo48T09jDLDQAOIFi1nx2GeOr/ws5AMGaB
         h2aM3xmkLoYBYSjwy60wS+IK5TxQzmFkemgPknSHt7zZ/cBv87kCnoqeQOsOi2+XAZUs
         3vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azU3Ux/szIlUeWx6CdScnoe2s3Y61kaPLlyZdnvmRH0=;
        b=fERE0lXwVMTzjRam0w5MPz4EDgnEcWrS4QcT98szQe0t6AGrh2TNILA13/2IpS5Bq1
         kt+7rjcDY7X/fYlABoeWK6Th1x0LMUjn+NRCHdocmuFHSKmwX5cRXq//zT+GW+cRw8GR
         9pZh01vn4qdCzs8ATJYvKSKnE9067BxZMiPnnqjFrVi3QKX/L6NiD2pEtfxyAsmjnljU
         YpyEKT87qF5vDucm6Az7pBRWsUFy5wqg7xbmFPxyb/AvmO/5fqhHwrkSjB+gb1k+l7ao
         ifm57WFaOQFjScll5zK+DM4Pj8sZ0PlUVaJ5ZHEmXY6USbzNcIf4Px6JuSb3mFOzAkch
         jcng==
X-Gm-Message-State: APt69E0CFiBwSswH5R7cfqXQVvGJ0vLHWmByHjNfECC6EICetr9kcZJT
        GpcXLAHaG811lBXtBL8TBxIEw3ysXkU=
X-Google-Smtp-Source: AAOMgpfbycFYxdB6ij8kOmFbHt4IrE5GA1+cUcpU6MwiemDnZ/qKhnzoOOqysBJ1NasIL4BCJaH6oQ==
X-Received: by 2002:aca:3703:: with SMTP id e3-v6mr8514188oia.222.1530298617899;
        Fri, 29 Jun 2018 11:56:57 -0700 (PDT)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id k133-v6sm4701816oia.36.2018.06.29.11.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:56:56 -0700 (PDT)
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
 <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
 <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
Date:   Fri, 29 Jun 2018 13:56:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 06:52 PM, Andy Shevchenko wrote:
> On Fri, Jun 15, 2018 at 1:31 AM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>> On 6/14/2018 12:25 PM, Andy Shevchenko wrote:
>>> On Thu, Jun 14, 2018 at 5:22 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>>> On 6/13/2018 3:54 AM, Andy Shevchenko wrote:
>>>
>>>>>> +                * Provide physical address of command buffer field within
>>>>>> +                * the struct smi_cmd... can't use virt_to_phys on smi_cmd
>>>>>> +                * because address may be from memremap.
>>>>>
>>>>> Wait, memremap() might return a virtual address. How we be sure that
>>>>> we got still physical address here?
>>>
>>>> Before this patch, the address in smi_cmd always came from an alloc, so
>>>> virt_to_phys() was used to get the physical address here.  With WSMT, we
>>>> could be using a BIOS-provided buffer for SMI, in which case the address in
>>>> smi_cmd will come from memremap(), so we can't use virt_to_phys() on it.
>>>> So instead I changed this to use the physical address of smi_data_buf that
>>>> is stored in smi_data_buf_phys_addr, which will be valid regardless of how
>>>> the address of smi_data_buf was generated.
>>>
>>> Yes, but what does guarantee that memremap() will return you still
>>> physical address?
> 
>> Sorry, I'm not sure I understand the question.
>>
>> Up to now, this driver always just allocated a buffer from main memory that
>> it used to send/receive information from BIOS when it generated a SMI.  That's
>> what smi_cmd points to where this comment is.  And it was safe to use
>> virt_to_phys() on this address.
>>
>> With this patch, though, the driver may now be using a buffer that isn't part
>> of main memory--it could now be using a buffer that BIOS provided the physical
>> address for, and this would not be part of main memory.
> 
> Hmm... But is it CPU address or bus address what BIOS provides?
> 
> If it's a CPU address why do you need to call memremap() on it in the
> first place?
> I could guess that you want to access it from CPU side and rather
> would get faults.
> 

The BIOS-provided EPS provides the physical (bus) address of the fixed SMI buffer.
This memory will be of type EfiReservedMemoryType, so it will not be usable RAM
to the linux kernel and won't already be mapped.

>>  So smi_cmd may contain
>> a virtual address that memremap() provided.  And because memremap() is just
>> like ioremap(), the driver can no longer use virt_to_phys(smi_cmd) to get the
>> physical address of the buffer.
> 
> Yes, and ioremap() is dedicated for the resources that are not
> available directly by the memory accesses, but rather require some bus
> transactions (like MMIO)>>
>> My comment is just pointing that out... I was trying to say, "the code can't
>> use virt_to_phys(smi_cmd) to get the virtual address here".
>>
> 
> Please, add bits from above paragraphs to elaborate this in the comment.
> 

No problem, will do.

>> memremap() should always return a virtual address that points to the physical
>> address we send it (unless it fails of course).
> 
>>>>>> +       /* Scan for EPS (entry point structure) */
>>>>>> +       for (addr = (u8 *)__va(0xf0000);
>>>>>> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
>>>>>
>>>>>> +            addr += 1) {
>>>>>
>>>>> This wasn't commented IIRC and changed. So, why?
>>>
>>>> I changed this is response to your earlier comment (7 june)... you had pointed
>>>> out that it would be better if I put an "if (eps) break;" inside the for loop
>>>> instead of having "&& !eps" in the condition of the for loop.  I put the note
>>>> "Changed loop searching 0xf0000 to be more readable" in the list of changes for
>>>> patch version v3 to cover this change.
>>>
>>> Thanks, but here I meant += 1 vs += 16 step.
>>>
>>
>> Sorry, I thought I had answered this earlier.  The spec does not say that the EPS
>> table will be on a 16-byte boundary.  And I just added a printk in this driver to
>> see where it is on the system I had at hand, and it isn't on a 16-byte boundary:
> 
> Oh, that's sad.
> 
> Btw, does XSDT have a link to this table?
> 

The XSDT has a link to the WSMT table, but not to the EPS table that actually has
the address of the buffer that BIOS provides.  The EPS table isn't an ACPI table,
it's just a Dell-defined table.

I did realize that the debug code that printed the address of the EPS table was not
working right, and the table on my system is actually 16-byte aligned.  However,
the documentation on the EPS does not specify that it will be 16-byte aligned, so I
don't think the driver should make that assumption, especially since scanning a 64K
region byte by byte should take very little extra time over scanning every 16th byte.

>> [ 4680.192542] dcdbas - EPS table at 000000005761efb7
> 
> Can you, by the way, dump some bytes around this address, using
> print_hex_dump_bytes();
> 
> where the adrress is aligned to let say 32 byte boundary and size like 64 bytes?
> 

I guess this isn't needed since the table on my system actually is 16-byte aligned.

>> [ 4680.194012] dcdbas dcdbas: WSMT found, using firmware-provided SMI buffer.
>> [ 4680.195327] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.3)
> 
> OK, now the most important question, did you investigate "SMM
> Communication ACPI Table"?
> Can you utilize information in it?
> 

Dell BIOS does not provide a "SMM Communication ACPI Table", just the EPS.  It appears
that the "SMM Communication ACPI Table" is deprecated in the UEFI 2.7 spec.  Also, the
dcdbas driver is for Dell systems only.
