Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ztKiCYIiHFvhOAAAmS7hNA
	; Sat, 09 Jun 2018 18:57:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 748B9608BF; Sat,  9 Jun 2018 18:57:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBc6Z9YH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CD520601C3;
	Sat,  9 Jun 2018 18:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD520601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeFIS5W (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 14:57:22 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41304 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeFIS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 14:57:20 -0400
Received: by mail-ua0-f193.google.com with SMTP id a5-v6so11027644uao.8;
        Sat, 09 Jun 2018 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KMMf5whXgJuSzRvw1L2xeU3Xgit1w7SUxy6Ru9jUuQM=;
        b=eBc6Z9YHf74p6CgJEFjmpIub/yhqWs0buDvFyZq4Vfy3FzIFg3s7d34jri+jZSD4B+
         4omNQLuqL98fbdmzVhxCGob/C8Q8677NIt+P37YWZ7Dx+PCV5HDQVH10HY3MhtPPIgbB
         1I0llVGL5pB7Q8LlAE+a/dy6hqJ2gCxc52rhTj5mcdR0Xu47YbbTSgAunUxPWSEBRa73
         b99kE5y3x1iRaRbjQGEv3Pw55vyppmciiAaEUakFnz8LfX9q6/8/lXvkphTAT6WcqIED
         u5tcValEWiLfkqU0DafIFQYrQNt9ujD274U1alRt2JhHD3onlPuyiL9/F8J4dFeMs2Kd
         9C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KMMf5whXgJuSzRvw1L2xeU3Xgit1w7SUxy6Ru9jUuQM=;
        b=uVceSHvIv0394zKtuZVhbxQm++a0ymu+wa7mwrFsk8D/ALy6JeRT2GqVrdy6b/VsA/
         x0qLceOPF2WheRCuWtO+TqqRPX6hljOScSmflBxoHUbeIGllguHlAi1jro8mGhBejGDe
         mENMA/LssbiX0jpV03/jEioez+4tr2Kvr4K/LLvcnDOuU/W0cmXFjNXhlNiMOlnxC7Pm
         mR+ARV6ATK0TsuxKDigQLlb3zR6MYRRFxsghZaHjrBcmu/3Q7gsiA9pVovjQ+h/Qg9bV
         R9a1RGu0wwUsHUyJpbY/TSgx0Y64Z9kjajWhQ+bIHmf5Yyc46vZl57Z/qNmliUDJRih2
         YufA==
X-Gm-Message-State: APt69E2QFBH6vOg7CFUNaYf8rU99HKVxN9TZzTCQz6yA0oYnoP8DLP9P
        k0f3M6QDMRjFIsHmmWrbKJA7YdeDLR6RAjWq47g=
X-Google-Smtp-Source: ADUXVKI7QNXLEH0DzT9vZ01QMEyO0zs0D4S1pZupyRvAJAXlIiVkocCLb5xNz+fYKta8v8hQP6Jp6dZFZMbQCHXMNtc=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr7347535uae.199.1528570640173;
 Sat, 09 Jun 2018 11:57:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 11:57:19 -0700 (PDT)
In-Reply-To: <20180609010420.GA112645@localhost.localdomain>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Jun 2018 21:57:19 +0300
Message-ID: <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
Subject: Re: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
To: Darren Hart <dvhart@infradead.org>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared_Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 4:04 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Thu, Jun 07, 2018 at 08:11:41PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 7, 2018 at 6:59 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:

>> > +static inline struct smm_eps_table *check_eps_table(u8 *addr)
>> > +{
>> > +       struct smm_eps_table *eps = (struct smm_eps_table *)addr;
>> > +
>>
>> > +       if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)
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

Yeah, consistency is usually a priority over style. Though in the
context below I see also magic numbers instead of strings.
I have no strong opinion here which one is better to follow.

>> Also I've a feeling that 0xf0000 constant is defined already somewhere
>> under arch/x86/include/asm or evem include/linux.
>
> But... is it defined for this purpose? If not, I'd prefer it hardcoded
> (or with a DEFINE).

OK, I did a research, and the following is the result.

arch/x86/kernel/mpparse.c:636:      smp_scan_config(0xF0000, 0x10000))
arch/x86/kernel/probe_roms.c:27:        .start  = 0xf0000,

arch/x86/pci/irq.c:91: *  Search 0xf0000 -- 0xfffff for the PCI IRQ
Routing Table.
arch/x86/pci/irq.c:105: for (addr = (u8 *) __va(0xf0000); addr < (u8
*) __va(0x100000); addr += 16) {

arch/x86/platform/geode/alix.c:34:#define BIOS_SIGNATURE_TINYBIOS
         0xf0000
arch/x86/platform/olpc/olpc-xo1-pm.c:36:} ofw_bios_entry = { 0xF0000 +
PAGE_OFFSET, __KERNEL_CS };
arch/x86/platform/ts5500/ts5500.c:103:  bios = ioremap(0xf0000, 0x10000);

Perhaps it would be a good idea to introduce such constant in the future.

Note mpparse.c and irq.c, that's similar purpose of the address range.

>> >  #define SMI_CMD_MAGIC                          (0x534D4931)
>> >
>> > +#define SMM_EPS_SIG                            "$SCB"
>>
>> Just integer like above and put the sting as a comment.
>> (Side note: above magic also looks like string)
>
> Given the above, I think we can use the more recognizable string - since
> that is clearly how they think of this label.

OK with me!

-- 
With Best Regards,
Andy Shevchenko
