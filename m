Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0ucWAzYgG1tRCQAAmS7hNA
	; Sat, 09 Jun 2018 01:04:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 804776089E; Sat,  9 Jun 2018 01:04:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJEVVfPr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A1F41602FC;
	Sat,  9 Jun 2018 01:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1F41602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeFIBE0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 21:04:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbeFIBEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 21:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QK2w9wEEYRoOTHXzQZeA9F18mRhFkLrDMPQ9uDFoQuI=; b=PJEVVfPrkosGFMfCKnhDC+o2u
        pno05DK368bPhBkV+9nrFpdg6wl1GRm8XEWo+aFzPhCwb037GwwLHZcu4BVqj7eweL2DyyzCQzVra
        fTRDIw+9mZ49aRVd3zgNOfQqv5bEsGDIaaCKgX7jyxRIleQtOFaDpTRSH6WcDwXz2RsUlvKtlU7H9
        +VsdMzqp0sWh5KQB6XcNgpN8Pc/VZRRiDXeZxwmwboAlQG92xHnQEoWPqW6X+Vr1hIgMYnZJXTsKi
        8dAWbiwfmwAEvHcDaQWxNVMAVxFf0FeWOaYJ4YzywsInl6EYyfg2ibfgcmsAacuqIAUiY2fByb25e
        R819CCAPw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRSIp-0007Q2-AV; Sat, 09 Jun 2018 01:04:23 +0000
Date: Fri, 8 Jun 2018 18:04:20 -0700
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared_Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
Message-ID: <20180609010420.GA112645@localhost.localdomain>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 08:11:41PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 7, 2018 at 6:59 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> > If the WSMT ACPI table is present and indicates that a fixed communication
> > buffer should be used, use the firmware-specified buffer instead of
> > allocating a buffer in memory for communications between the dcdbas driver
> > and firmare.
> 
> >  config DCDBAS
> >         tristate "Dell Systems Management Base Driver"
> > -       depends on X86
> > +       depends on X86 && ACPI


> 
> Hmm... I'm not sure about this dependency.
> So, the question is do all users actually need this? How did it work
> previously? How has this been tested in case when command line has
> "acpi=off" (yes, this one just for sake of test, I don't believe it's
> a real use case)?

Yeah... after the 4.16 and 4.17 KConfig fumbling around the SMBIOS
driver which intersected with this one.... this needs to be thoroughly
covered, tested, and thought through. Linus was.... generous in the
number of attempts it took us to get that right.

Did DCDBAS ever work on a system without ACPI?

> 
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/acpi.h>
> 
> Please, try to keep an order as much as possible.
> For example, in given context this line should be before string.h (I
> didn't check the actual file, perhaps even upper).
> 
> >  #include <asm/io.h>
> >
> >  #include "dcdbas.h"
> 
> >                 /* Calling Interface SMI */
> > -               smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
> > +               smi_cmd->ebx = smi_data_buf_phys_addr
> > +                               + offsetof(struct smi_cmd, command_buffer);
> 
> Please, keep at least + on the previous line.
> Also, I'm not sure what is the difference now. Especially for previous
> users when this wasn't the part of the driver.
> Some explanation needed.
> 
> > +static u8 checksum(u8 *buffer, u8 length)
> > +{
> > +       u8 sum = 0;
> > +       u8 *end = buffer + length;
> > +
> > +       while (buffer < end)
> > +               sum = (u8)(sum + *(buffer++));
> 
> Why not simple
> 
> sum += *buffer++;
> 
> ?
> 
> > +       return sum;
> > +}
> 
> And I would rather check if we have similar algoritms already in the
> kernel which  we might re-use.

Seems to be some options in lib/checksum.c to check.

> 
> > +
> > +static inline struct smm_eps_table *check_eps_table(u8 *addr)
> > +{
> > +       struct smm_eps_table *eps = (struct smm_eps_table *)addr;
> > +
> 
> > +       if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)
> 
> I'm not sure about strings operation here.
> I would rather do like with other magic constants: introduce hex value
> and compare it as unsigned integer.
> 
> Also, it might be a warning, since \0 wasn't ever checked from the
> string literal. Though, I'm not sure if it applicable to strncmp()
> function (it's for strncpy for sure).

I think we're OK here, and we're being consistent with the
dell-wmi-descriptor test for "DELL WMI". I don't recall if it was that
one or something else, but doing it in HEX ended up being more
confusing. The \0 isn't an issue since strncmp will only compare the n
(4) bytes.

> 
> > +               return NULL;
> > +
> > +       if (checksum(addr, eps->length) != 0)
> > +               return NULL;
> > +
> > +       return eps;
> > +}
> > +
> > +static int dcdbas_check_wsmt(void)
> > +{
> > +       struct acpi_table_wsmt *wsmt = NULL;
> > +       struct smm_eps_table *eps = NULL;
> > +       u8 *addr;
> > +
> > +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
> > +       if (!wsmt)
> > +               return 0;
> > +
> > +       /* Check if WSMT ACPI table shows that protection is enabled */
> > +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
> > +           || !(wsmt->protection_flags
> > +                & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> > +               return 0;
> > +
> > +       /* Scan for EPS (entry point structure) */
> > +       for (addr = (u8 *)__va(0xf0000);
> > +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table)) && !eps;
> 
> Perhaps better to do
> 
> for (...) {
>  eps = ...();
>  if (eps)
>   break;
> }
> 
> Also I've a feeling that 0xf0000 constant is defined already somewhere
> under arch/x86/include/asm or evem include/linux.

But... is it defined for this purpose? If not, I'd prefer it hardcoded
(or with a DEFINE).

> 
> > +            addr += 1)
> 
> += 1?!
> All tables I saw in BIOS are aligned with 16 bytes. Is it the case here?
> 
> Is there any other means to check if the table present? ACPI code?
> Method / variable?
> 
> > +               eps = check_eps_table(addr);
> > +
> > +       if (!eps) {
> > +               dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       /*
> > +        * Get physical address of buffer and map to virtual address.
> > +        * Table gives size in 4K pages, regardless of actual system page size.
> > +        */
> 
> > +       if (eps->smm_comm_buff_addr + 8 > U32_MAX) {
> 
> if (upper_32_bits(..._addr + 8)) {
> 
> ?
> 
> > +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
> > +               return -EINVAL;
> > +       }
> > +       eps_buffer = (u8 *)memremap(eps->smm_comm_buff_addr,
> 
> Why casting?
> 
> > +                                    eps->num_of_4k_pages * 4096, MEMREMAP_WB);
> 
> This multiplication looks strange. Perhaps use PAGE_SIZE?
> 
> > +       if (!eps_buffer) {
> > +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* First 8 bytes of buffer is for semaphore */
> > +       smi_data_buf_phys_addr = (u32) eps->smm_comm_buff_addr + 8;
> 
> lower_32_bits() ?
> 
> > +       smi_data_buf = eps_buffer + 8;
> 
> > +       smi_data_buf_size = (unsigned long) min(eps->num_of_4k_pages * 4096 - 8,
> > +                           (u64) ULONG_MAX);
> 
> This is too twisted code. First, it needs explanation.
> Second, it might need some refactoring.
> 
> (Yes, I got the idea, but would it be better implementation?)
> 
> > +       max_smi_data_buf_size = smi_data_buf_size;
> > +       wsmt_enabled = true;
> > +       dev_info(&dcdbas_pdev->dev,
> > +                "WSMT found, using firmware-provided SMI buffer.\n");
> > +       return 1;
> > +}
> 
> >  #define SMI_CMD_MAGIC                          (0x534D4931)
> >
> > +#define SMM_EPS_SIG                            "$SCB"
> 
> Just integer like above and put the sting as a comment.
> (Side note: above magic also looks like string)

Given the above, I think we can use the more recognizable string - since
that is clearly how they think of this label.

Otherwise, agree with a follow-up to all of Andy's feedback.

-- 
Darren Hart
VMware Open Source Technology Center
