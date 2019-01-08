Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A81C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0851A206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="f5IldSnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfAHL74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:59:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43213 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:59:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so3741513wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6+Mdwry/rSeNTTRL+5i0V1ZgR5fjtkD/lW5yWIBnyo=;
        b=f5IldSnJurHNa6rFqFFW58ThEuVg2vlbYLSEegNPjHWLMeYU2rcjq+arEMlM8Y4HOP
         L4bYcXrP3XebpSyjj7lft1Z3wMXi4JJtk9UrqPzgyNRPTuPHkov8+4uyqDsTjBUsKunm
         dIYdmV/z1k0bSsqLu/MKMvwO6HtWX5dDfAEd1f8kgxptFve2liCSRvZTV7rRat1GyTMz
         K/UkgyJIUAl/aENh8tDqiIjp4OeBQPghCumvDwrQzkXmd/j9DRRSKDIXcczRs6FbTKwY
         q8iqhELiv4DboqPVxhh3GnKuWdDx/F0VKPpritk2ZPvyx/zZ0F7qviWIbxbTOkB0c9vs
         bzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6+Mdwry/rSeNTTRL+5i0V1ZgR5fjtkD/lW5yWIBnyo=;
        b=mqrY7kc6AeNFf9OpKBn7xzzEsYp2ku0NE3dmuzRmSq4y1EOhkmjdyfaAN2bbKWkpzH
         JrANidIMH3UIoXl48QDq23ATHb4fHQ/92eUPTttMAhYiwni0SUrWAXFW6g76bA/jDwWR
         Mt9SPT0bHflrkNzqJAM7eQrxZyNCp91qJzM3EJdH9f6tSFmdlEjnQN9ed4Rx2k9hB8wI
         Q6Gjy4oFHdSYuCBIZ9KAk2E+hTCj2HUh6pqQqILRXRHSEGYXZct0qUyHqsTyFGC7mFBH
         jJjHgKj3IA2WFGdlf6WsLy+BlOvzPX29W9Oes9Bi3nAvHGQuPXFA7hurhX1r8tUJYYRr
         U6xw==
X-Gm-Message-State: AJcUukc55dlXpWpan+KWtrRw6dpF3fYAEjBCRdzSswz+lrwiuLVDZqKa
        bFzluTsa5VpnXDgL53o0mT7YLdo2GOOxfkZgDUNk4g==
X-Google-Smtp-Source: ALg8bN4BkLPPVyO6mW0KyeS9UjJb7zJa2j7y4dwv2ao+tTtg2sFvGiYI6kgPZ+dsNLqgucK3IULizXWwMNBdy+29tW8=
X-Received: by 2002:adf:91a3:: with SMTP id 32mr1107409wri.99.1546948794020;
 Tue, 08 Jan 2019 03:59:54 -0800 (PST)
MIME-Version: 1.0
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com> <1546940318-9752-8-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1546940318-9752-8-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:29:43 +0530
Message-ID: <CAAhSdy17H_XpDea9bowUoinVmb17p8+ZAzZ7cyFuDfFDJ-LwaA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] RISC-V: Check and continue in case of an invalid cpuid.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer, commit prefix "irqchip/irq-sifive-plic:" instead of "RISC-V:"

On Tue, Jan 8, 2019 at 3:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> riscv_hartid_to_cpuid can return invalid cpuid for a hart
> that is present in DT but was never brought up.
>
> Print the appropriate warning message and continue.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 357e9daf..254ecd76 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -237,6 +237,11 @@ static int __init plic_init(struct device_node *node,
>                 }
>
>                 cpu = riscv_hartid_to_cpuid(hartid);
> +               if (cpu < 0) {
> +                       pr_warn("Invalid cpuid for context %d\n", i);
> +                       continue;
> +               }
> +
>                 handler = per_cpu_ptr(&plic_handlers, cpu);
>                 handler->present = true;
>                 handler->ctxid = i;
> --
> 2.7.4
>

Otherwise, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
