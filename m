Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Uun+CdNmGVubEgAAmS7hNA
	; Thu, 07 Jun 2018 17:11:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81D58607E7; Thu,  7 Jun 2018 17:11:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRfE7EB2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4471606DD;
	Thu,  7 Jun 2018 17:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4471606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeFGRLp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:11:45 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40029 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeFGRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:11:43 -0400
Received: by mail-vk0-f67.google.com with SMTP id o71-v6so3382263vke.7;
        Thu, 07 Jun 2018 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MQBii6fzMCNd9+nplC2gu5xSqV/9y8kmgJKF6cizi8Y=;
        b=FRfE7EB2QRdaiHbE9nzhkZEa01myUiFYIDhMogzSSamwEcHIUl6fBhfpFfsoakS8qh
         q7+i92/oUpufew5lVumtcvMD+xo5z1+/8DMF838LdD133jOiwoxBhUWMHTj7Jjv9/+Ot
         VJ1QHz2STYf4Myh2cuP2D/HRg+ma+7QxYNTPRY3WdK4neEp0tvsVJBEyQV3xVUXS4+Il
         DWhc1a0tQas36Lpn5+9nBzSk8O3KLQAwy9ajbgRtOYEsrv5Y6SMWjakRKaFxHXavdMl7
         vY6HlmhAYgIKZF3ih9VmFwOW64TOVhZtEULxqu0wyBzNKRpsa/C/zUO8L9jIpcYB2kxz
         1zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MQBii6fzMCNd9+nplC2gu5xSqV/9y8kmgJKF6cizi8Y=;
        b=mvZ3qh+ZN4CwS5+C0v+NxabkewSTU/TWNSBT45Uwn2d4VO0153lMqEnXnwDY+4w+qA
         Nde5RjacQkmn8icBkek2U5y4T35gn2N7ZgHCVC6fIgYIzV1KN/VmYYfZUaPuwrXqPaL5
         rvyqheSXvj+hcyVrjwCnS/OtEtIPQ20soB/U3YOpsoXqJOUfmq9l9cMn7usFRw26SCwS
         RKF62u1Tgax0oGJLWq0p2bwArDYO5ihIQV84w4FazWwzOq/6FY0Sc4+ogjQY3RvJHGjk
         tMowBJGbzTmYdnJ+9n+Ba7yLNRoNtpOc7jthmx/UkNYesxAuUbPhqqf7YCylLnuKu7/G
         zlJQ==
X-Gm-Message-State: APt69E3HLLj3Lr5CSwoixRLG0JRFHndIr3U0WpHvEHu16xtFl+h9CUKm
        dG6SH+tHjfem8l/9qmhoeJR7jbtlewYHCZ2y62BIFA==
X-Google-Smtp-Source: ADUXVKLfqSpt3pG3cQrfxDfL1tllH410kxzZNJN7Yh0KRMKBbQPIulY3xyTJ6Ky4gBVRUw2uu7VxPmXhtP2ivk724q4=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr1718969vkc.26.1528391502520;
 Thu, 07 Jun 2018 10:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8f:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:11:41 -0700 (PDT)
In-Reply-To: <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com> <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Jun 2018 20:11:41 +0300
Message-ID: <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
Subject: Re: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared_Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 6:59 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> If the WSMT ACPI table is present and indicates that a fixed communication
> buffer should be used, use the firmware-specified buffer instead of
> allocating a buffer in memory for communications between the dcdbas driver
> and firmare.

>  config DCDBAS
>         tristate "Dell Systems Management Base Driver"
> -       depends on X86
> +       depends on X86 && ACPI

Hmm... I'm not sure about this dependency.
So, the question is do all users actually need this? How did it work
previously? How has this been tested in case when command line has
"acpi=off" (yes, this one just for sake of test, I don't believe it's
a real use case)?

>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/acpi.h>

Please, try to keep an order as much as possible.
For example, in given context this line should be before string.h (I
didn't check the actual file, perhaps even upper).

>  #include <asm/io.h>
>
>  #include "dcdbas.h"

>                 /* Calling Interface SMI */
> -               smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
> +               smi_cmd->ebx = smi_data_buf_phys_addr
> +                               + offsetof(struct smi_cmd, command_buffer);

Please, keep at least + on the previous line.
Also, I'm not sure what is the difference now. Especially for previous
users when this wasn't the part of the driver.
Some explanation needed.

> +static u8 checksum(u8 *buffer, u8 length)
> +{
> +       u8 sum = 0;
> +       u8 *end = buffer + length;
> +
> +       while (buffer < end)
> +               sum = (u8)(sum + *(buffer++));

Why not simple

sum += *buffer++;

?

> +       return sum;
> +}

And I would rather check if we have similar algoritms already in the
kernel which  we might re-use.

> +
> +static inline struct smm_eps_table *check_eps_table(u8 *addr)
> +{
> +       struct smm_eps_table *eps = (struct smm_eps_table *)addr;
> +

> +       if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)

I'm not sure about strings operation here.
I would rather do like with other magic constants: introduce hex value
and compare it as unsigned integer.

Also, it might be a warning, since \0 wasn't ever checked from the
string literal. Though, I'm not sure if it applicable to strncmp()
function (it's for strncpy for sure).

> +               return NULL;
> +
> +       if (checksum(addr, eps->length) != 0)
> +               return NULL;
> +
> +       return eps;
> +}
> +
> +static int dcdbas_check_wsmt(void)
> +{
> +       struct acpi_table_wsmt *wsmt = NULL;
> +       struct smm_eps_table *eps = NULL;
> +       u8 *addr;
> +
> +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
> +       if (!wsmt)
> +               return 0;
> +
> +       /* Check if WSMT ACPI table shows that protection is enabled */
> +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
> +           || !(wsmt->protection_flags
> +                & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> +               return 0;
> +
> +       /* Scan for EPS (entry point structure) */
> +       for (addr = (u8 *)__va(0xf0000);
> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table)) && !eps;

Perhaps better to do

for (...) {
 eps = ...();
 if (eps)
  break;
}

Also I've a feeling that 0xf0000 constant is defined already somewhere
under arch/x86/include/asm or evem include/linux.

> +            addr += 1)

+= 1?!
All tables I saw in BIOS are aligned with 16 bytes. Is it the case here?

Is there any other means to check if the table present? ACPI code?
Method / variable?

> +               eps = check_eps_table(addr);
> +
> +       if (!eps) {
> +               dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS found\n");
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * Get physical address of buffer and map to virtual address.
> +        * Table gives size in 4K pages, regardless of actual system page size.
> +        */

> +       if (eps->smm_comm_buff_addr + 8 > U32_MAX) {

if (upper_32_bits(..._addr + 8)) {

?

> +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
> +               return -EINVAL;
> +       }
> +       eps_buffer = (u8 *)memremap(eps->smm_comm_buff_addr,

Why casting?

> +                                    eps->num_of_4k_pages * 4096, MEMREMAP_WB);

This multiplication looks strange. Perhaps use PAGE_SIZE?

> +       if (!eps_buffer) {
> +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* First 8 bytes of buffer is for semaphore */
> +       smi_data_buf_phys_addr = (u32) eps->smm_comm_buff_addr + 8;

lower_32_bits() ?

> +       smi_data_buf = eps_buffer + 8;

> +       smi_data_buf_size = (unsigned long) min(eps->num_of_4k_pages * 4096 - 8,
> +                           (u64) ULONG_MAX);

This is too twisted code. First, it needs explanation.
Second, it might need some refactoring.

(Yes, I got the idea, but would it be better implementation?)

> +       max_smi_data_buf_size = smi_data_buf_size;
> +       wsmt_enabled = true;
> +       dev_info(&dcdbas_pdev->dev,
> +                "WSMT found, using firmware-provided SMI buffer.\n");
> +       return 1;
> +}

>  #define SMI_CMD_MAGIC                          (0x534D4931)
>
> +#define SMM_EPS_SIG                            "$SCB"

Just integer like above and put the sting as a comment.
(Side note: above magic also looks like string)

-- 
With Best Regards,
Andy Shevchenko
