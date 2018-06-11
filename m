Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id to8OHSeHHlv5OgAAmS7hNA
	; Mon, 11 Jun 2018 14:30:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C800607A4; Mon, 11 Jun 2018 14:30:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDJbc9Rh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DC3BF60792;
	Mon, 11 Jun 2018 14:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC3BF60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934661AbeFKOaj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:30:39 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33976 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeFKOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:30:34 -0400
Received: by mail-ot0-f194.google.com with SMTP id r18-v6so9540575otk.1;
        Mon, 11 Jun 2018 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nmqshy6WGRqVGcDrXqIcY8Bw7qKVCVfqVIvchiBIHGY=;
        b=TDJbc9RhRs3pjH+x0cp9QIAdm4dONt+sTOuTFGdhKB4MDYjO/hZhHv45C2aAo/jWUj
         k1LZXPPafVJDCUV5KGzQo+QjHnmXv4lsfF3k9pYzXXfLdLg4UGxrZv5ZSJgZaB31yDO1
         z398LPObZfd/yFTSGy+O5HrbePMKtToFd7LG6eCGkBJ2MfWA7PCD6t1ZOQYy9I0uh6gh
         FzusL+HmLWom0vWmmmKZcgGh5KYQ9HFlBAa9ePlTIZ+iosa1iGPtTxV7geKYIjXMIdjy
         I5ocewEamwBcheeb6Q//cJIDOpxm3P/VpFymxvC4sVlvYgahYZSrZD6DXdKmpstz+Poq
         gCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nmqshy6WGRqVGcDrXqIcY8Bw7qKVCVfqVIvchiBIHGY=;
        b=mD+ujBsBwwIwNp8ZzaB97c73rZ80a5BkH9MIXuUj2GANACKGSX9954g3qNt5lcIF4J
         va3dIGp2fTzrBHHA4R0SiJfVFAcAAdKGVO5sNFjjnfcRx0wUWN0aPAFf8OhB7acmHYd+
         xp/tUj3FG3whrWkYWbXRn2qVexrqGw1vHHY/xjgR3lV1a8yX2+HGOTGuMvBnkIEk//SI
         cJj9h5Yn3BkCYAZq8ZU+1L7aw6SrLRVcuvhn8pjrC2UPm9GCbKT0WBIZ/CliaFk4AMh+
         QiCKdutfQ8VnqfBsxJdjvEaqfb+ve8NSR9Jh1TJsnaW5YTGUanj/2ZmWuE0u+3wE4LFV
         imTQ==
X-Gm-Message-State: APt69E2+VKczRz6qEcA4jn7nBPV31sSP/TtGEsKrEqBIUFSIpxusFkZx
        ytWAtHzpqBNS4OabKlxbYWOSIGZr
X-Google-Smtp-Source: ADUXVKLCTTMn0OSRpVCPxvGHfTuwDKIe6VIzT3rm1TxFob/MX/9wk5KxjlMpP5q/Vt/De4Q/Z8TCDQ==
X-Received: by 2002:a9d:51c1:: with SMTP id d1-v6mr9372613oth.384.1528727433473;
        Mon, 11 Jun 2018 07:30:33 -0700 (PDT)
Received: from [192.168.0.2] (cpe-24-27-59-32.austin.res.rr.com. [24.27.59.32])
        by smtp.gmail.com with ESMTPSA id q45-v6sm8873971otg.56.2018.06.11.07.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 07:30:32 -0700 (PDT)
Subject: Re: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared_Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <e3418e89-a061-7326-811d-138a71f878d0@gmail.com>
Date: Mon, 11 Jun 2018 09:30:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180609010420.GA112645@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 180611-0, 06/11/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2018 8:04 PM, Darren Hart wrote:
> On Thu, Jun 07, 2018 at 08:11:41PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 7, 2018 at 6:59 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>> If the WSMT ACPI table is present and indicates that a fixed communication
>>> buffer should be used, use the firmware-specified buffer instead of
>>> allocating a buffer in memory for communications between the dcdbas driver
>>> and firmare.
>>
>>>  config DCDBAS
>>>         tristate "Dell Systems Management Base Driver"
>>> -       depends on X86
>>> +       depends on X86 && ACPI
> 
> 
>>
>> Hmm... I'm not sure about this dependency.
>> So, the question is do all users actually need this? How did it work
>> previously? How has this been tested in case when command line has
>> "acpi=off" (yes, this one just for sake of test, I don't believe it's
>> a real use case)?
> 
> Yeah... after the 4.16 and 4.17 KConfig fumbling around the SMBIOS
> driver which intersected with this one.... this needs to be thoroughly
> covered, tested, and thought through. Linus was.... generous in the
> number of attempts it took us to get that right.
> 
> Did DCDBAS ever work on a system without ACPI?
> 

It appears to compile ok without ACPI enabled... looks like acpi_get_table
just returns a constant when CONFIG_ACPI isn't there, which makes all the WSMT
stuff get optimized out.  So I don't guess we even need an "#ifdef CONFIG_ACPI".

>>
>>>  #include <linux/string.h>
>>>  #include <linux/types.h>
>>>  #include <linux/mutex.h>
>>> +#include <linux/acpi.h>
>>
>> Please, try to keep an order as much as possible.
>> For example, in given context this line should be before string.h (I
>> didn't check the actual file, perhaps even upper).
>>
>>>  #include <asm/io.h>
>>>
>>>  #include "dcdbas.h"
>>
>>>                 /* Calling Interface SMI */
>>> -               smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
>>> +               smi_cmd->ebx = smi_data_buf_phys_addr
>>> +                               + offsetof(struct smi_cmd, command_buffer);
>>
>> Please, keep at least + on the previous line.
>> Also, I'm not sure what is the difference now. Especially for previous
>> users when this wasn't the part of the driver.
>> Some explanation needed.
>>

I'll fix this.

>>> +static u8 checksum(u8 *buffer, u8 length)
>>> +{
>>> +       u8 sum = 0;
>>> +       u8 *end = buffer + length;
>>> +
>>> +       while (buffer < end)
>>> +               sum = (u8)(sum + *(buffer++));
>>
>> Why not simple
>>
>> sum += *buffer++;
>>
>> ?
>>
>>> +       return sum;
>>> +}
>>
>> And I would rather check if we have similar algoritms already in the
>> kernel which  we might re-use.
> 
> Seems to be some options in lib/checksum.c to check.
> 

I couldn't find anything in checksum.c or elsewhere that I could just
include that would do a byte checksum, not a word.  I copied this code
from acpi_tb_checksum (in drivers/acpi/acpica/tbprint.c), but I can
shorten it as suggested.

>>
>>> +
>>> +static inline struct smm_eps_table *check_eps_table(u8 *addr)
>>> +{
>>> +       struct smm_eps_table *eps = (struct smm_eps_table *)addr;
>>> +
>>
>>> +       if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)
>>
>> I'm not sure about strings operation here.
>> I would rather do like with other magic constants: introduce hex value
>> and compare it as unsigned integer.
>>
>> Also, it might be a warning, since \0 wasn't ever checked from the
>> string literal. Though, I'm not sure if it applicable to strncmp()
>> function (it's for strncpy for sure).
> 
> I think we're OK here, and we're being consistent with the
> dell-wmi-descriptor test for "DELL WMI". I don't recall if it was that
> one or something else, but doing it in HEX ended up being more
> confusing. The \0 isn't an issue since strncmp will only compare the n
> (4) bytes.
> 
>>
>>> +               return NULL;
>>> +
>>> +       if (checksum(addr, eps->length) != 0)
>>> +               return NULL;
>>> +
>>> +       return eps;
>>> +}
>>> +
>>> +static int dcdbas_check_wsmt(void)
>>> +{
>>> +       struct acpi_table_wsmt *wsmt = NULL;
>>> +       struct smm_eps_table *eps = NULL;
>>> +       u8 *addr;
>>> +
>>> +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
>>> +       if (!wsmt)
>>> +               return 0;
>>> +
>>> +       /* Check if WSMT ACPI table shows that protection is enabled */
>>> +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
>>> +           || !(wsmt->protection_flags
>>> +                & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
>>> +               return 0;
>>> +
>>> +       /* Scan for EPS (entry point structure) */
>>> +       for (addr = (u8 *)__va(0xf0000);
>>> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table)) && !eps;
>>
>> Perhaps better to do
>>
>> for (...) {
>>  eps = ...();
>>  if (eps)
>>   break;
>> }
>>
>> Also I've a feeling that 0xf0000 constant is defined already somewhere
>> under arch/x86/include/asm or evem include/linux.
> 
> But... is it defined for this purpose? If not, I'd prefer it hardcoded
> (or with a DEFINE).
> 
>>
>>> +            addr += 1)
>>
>> += 1?!
>> All tables I saw in BIOS are aligned with 16 bytes. Is it the case here?
>>
>> Is there any other means to check if the table present? ACPI code?
>> Method / variable?
>>

The spec doesn't say this will be aligned with 16 bytes.  It says "Pointer to
this memory region is published through a reference anchor structure SMM_EPS
located in the F-Block physical memory range anywhere between F0000h – FFFFFh.
OS driver or application needs to scan for this structure with signature “$SCB”
in the above mentioned memory range."

>>> +               eps = check_eps_table(addr);
>>> +
>>> +       if (!eps) {
>>> +               dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS found\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       /*
>>> +        * Get physical address of buffer and map to virtual address.
>>> +        * Table gives size in 4K pages, regardless of actual system page size.
>>> +        */
>>
>>> +       if (eps->smm_comm_buff_addr + 8 > U32_MAX) {
>>
>> if (upper_32_bits(..._addr + 8)) {
>>
>> ?
>>
>>> +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
>>> +               return -EINVAL;
>>> +       }
>>> +       eps_buffer = (u8 *)memremap(eps->smm_comm_buff_addr,
>>
>> Why casting?
>>

Oops, I'll fix that.

>>> +                                    eps->num_of_4k_pages * 4096, MEMREMAP_WB);
>>
>> This multiplication looks strange. Perhaps use PAGE_SIZE?
>>
>>> +       if (!eps_buffer) {
>>> +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       /* First 8 bytes of buffer is for semaphore */
>>> +       smi_data_buf_phys_addr = (u32) eps->smm_comm_buff_addr + 8;
>>
>> lower_32_bits() ?
>>
>>> +       smi_data_buf = eps_buffer + 8;
>>
>>> +       smi_data_buf_size = (unsigned long) min(eps->num_of_4k_pages * 4096 - 8,
>>> +                           (u64) ULONG_MAX);
>>
>> This is too twisted code. First, it needs explanation.
>> Second, it might need some refactoring.
>>
>> (Yes, I got the idea, but would it be better implementation?)
>>

Yes this is pretty bad, I'll change it.

>>> +       max_smi_data_buf_size = smi_data_buf_size;
>>> +       wsmt_enabled = true;
>>> +       dev_info(&dcdbas_pdev->dev,
>>> +                "WSMT found, using firmware-provided SMI buffer.\n");
>>> +       return 1;
>>> +}
>>
>>>  #define SMI_CMD_MAGIC                          (0x534D4931)
>>>
>>> +#define SMM_EPS_SIG                            "$SCB"
>>
>> Just integer like above and put the sting as a comment.
>> (Side note: above magic also looks like string)
> 
> Given the above, I think we can use the more recognizable string - since
> that is clearly how they think of this label.
> 
> Otherwise, agree with a follow-up to all of Andy's feedback.
> 

I'll make the suggested changes and submit a new version.  Thank you all for
taking the time to review this!
