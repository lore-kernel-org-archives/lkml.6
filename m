Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F198C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9938249D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdq2KwID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9938249D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeF0XwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:52:10 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41492 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeF0XwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:52:09 -0400
Received: by mail-ua0-f195.google.com with SMTP id z12-v6so2277215uac.8;
        Wed, 27 Jun 2018 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qFB7HbV7vKQNqH5ekWFosjaRSMDvhI2uOvwjxFR7XXY=;
        b=Hdq2KwIDp8B24vmqBBxliUwiMb8qtTn6NBIh5kXjZzm3hbFFNEgZfWn1oNTrMB+/oD
         LpYaEY/zlQulPNHDqv4sPsVJHXVpBg8zIL+veD3q08huoUbLwQamrld+VLMuFo1rQMIK
         taT2IAAMJSh6d5Ct4ww7Xdz/MhAik5GPa3jHCGzmaoxTPK084EbvXacgQyiEBv4PBlSt
         nxUoNnKi7KvgDfmjj4qiyhwl+CHXZdHTXPFc20DC6YOA6o0hiDp7N2xi8uxJd2pEJ4Uy
         ESkQE1J+UFIDpeuRjCaxQqdfoyYkglbByB0/rLZy6wlGalRzeo+vKTBFmXBQc9atOSaY
         Bd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qFB7HbV7vKQNqH5ekWFosjaRSMDvhI2uOvwjxFR7XXY=;
        b=SvudFj6yQF/xchq3bL/JsHn9Da45JZYTU5is0ZcEtLLCXj4PvGHhlefHrWODDdkjj7
         aGlKrM+KbhJ21Swylu983mnRoZkoOfe6Yv/Ay9LX3gBRUuoQR8xHfjCdY2Z9GNeobXtt
         cFgCLwMpf135ahZKfcp+KMNQTlSNBRqWpx4lLaX4f2MKxyxikpdIWgbbevcnZP02bCLv
         JdXI/EbC0s0XFIOgO3Bw6TzA5lkYuCNW3gAbkn9Up/XrhVC6+96JaIvMrbTTEizKGknl
         aIja2nOlejB3g+QEcMTDSuLndMdGijCJ8ZCMyjFD08cR+wr/uT0G2+2srEsLULKCdaDU
         jBjw==
X-Gm-Message-State: APt69E23U4F3PVDbYFz+ZTNgf7JlOYGqxBtU1cbKhG1kwWuTc/mXdgzh
        F49PcgRCoMIpkbzgW8TrI1mJDVUXoi+Fj37IVIw=
X-Google-Smtp-Source: AAOMgpfpxv//XDYOEF1kc/cTuHTMfWvah2HDpk0h5qpiqohAxUo3orX+dOFxR/JMpDVU5Pf5TEXTcUIZHvescgKgRs0=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr4465057ual.28.1530143528103;
 Wed, 27 Jun 2018 16:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8f4e:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 16:52:06
 -0700 (PDT)
In-Reply-To: <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain> <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com> <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com> <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 02:52:06 +0300
Message-ID: <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 1:31 AM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> On 6/14/2018 12:25 PM, Andy Shevchenko wrote:
>> On Thu, Jun 14, 2018 at 5:22 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>> On 6/13/2018 3:54 AM, Andy Shevchenko wrote:
>>
>>>>> +                * Provide physical address of command buffer field within
>>>>> +                * the struct smi_cmd... can't use virt_to_phys on smi_cmd
>>>>> +                * because address may be from memremap.
>>>>
>>>> Wait, memremap() might return a virtual address. How we be sure that
>>>> we got still physical address here?
>>
>>> Before this patch, the address in smi_cmd always came from an alloc, so
>>> virt_to_phys() was used to get the physical address here.  With WSMT, we
>>> could be using a BIOS-provided buffer for SMI, in which case the address in
>>> smi_cmd will come from memremap(), so we can't use virt_to_phys() on it.
>>> So instead I changed this to use the physical address of smi_data_buf that
>>> is stored in smi_data_buf_phys_addr, which will be valid regardless of how
>>> the address of smi_data_buf was generated.
>>
>> Yes, but what does guarantee that memremap() will return you still
>> physical address?

> Sorry, I'm not sure I understand the question.
>
> Up to now, this driver always just allocated a buffer from main memory that
> it used to send/receive information from BIOS when it generated a SMI.  That's
> what smi_cmd points to where this comment is.  And it was safe to use
> virt_to_phys() on this address.
>
> With this patch, though, the driver may now be using a buffer that isn't part
> of main memory--it could now be using a buffer that BIOS provided the physical
> address for, and this would not be part of main memory.

Hmm... But is it CPU address or bus address what BIOS provides?

If it's a CPU address why do you need to call memremap() on it in the
first place?
I could guess that you want to access it from CPU side and rather
would get faults.

>  So smi_cmd may contain
> a virtual address that memremap() provided.  And because memremap() is just
> like ioremap(), the driver can no longer use virt_to_phys(smi_cmd) to get the
> physical address of the buffer.

Yes, and ioremap() is dedicated for the resources that are not
available directly by the memory accesses, but rather require some bus
transactions (like MMIO).

>
> My comment is just pointing that out... I was trying to say, "the code can't
> use virt_to_phys(smi_cmd) to get the virtual address here".
>

Please, add bits from above paragraphs to elaborate this in the comment.

> memremap() should always return a virtual address that points to the physical
> address we send it (unless it fails of course).

>>>>> +       /* Scan for EPS (entry point structure) */
>>>>> +       for (addr = (u8 *)__va(0xf0000);
>>>>> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
>>>>
>>>>> +            addr += 1) {
>>>>
>>>> This wasn't commented IIRC and changed. So, why?
>>
>>> I changed this is response to your earlier comment (7 june)... you had pointed
>>> out that it would be better if I put an "if (eps) break;" inside the for loop
>>> instead of having "&& !eps" in the condition of the for loop.  I put the note
>>> "Changed loop searching 0xf0000 to be more readable" in the list of changes for
>>> patch version v3 to cover this change.
>>
>> Thanks, but here I meant += 1 vs += 16 step.
>>
>
> Sorry, I thought I had answered this earlier.  The spec does not say that the EPS
> table will be on a 16-byte boundary.  And I just added a printk in this driver to
> see where it is on the system I had at hand, and it isn't on a 16-byte boundary:

Oh, that's sad.

Btw, does XSDT have a link to this table?

> [ 4680.192542] dcdbas - EPS table at 000000005761efb7

Can you, by the way, dump some bytes around this address, using
print_hex_dump_bytes();

where the adrress is aligned to let say 32 byte boundary and size like 64 bytes?

> [ 4680.194012] dcdbas dcdbas: WSMT found, using firmware-provided SMI buffer.
> [ 4680.195327] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.3)

OK, now the most important question, did you investigate "SMM
Communication ACPI Table"?
Can you utilize information in it?

-- 
With Best Regards,
Andy Shevchenko
