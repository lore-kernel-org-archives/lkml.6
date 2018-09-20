Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A9D21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YgYmTi2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A9D21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeIUCqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:46:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51271 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUCqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:46:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id y2-v6so911256wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hm3bFKzihrL7uYqay8Ok08MgSH4jDluIxDXLSzrc4ME=;
        b=YgYmTi2VnnK+pW2faRajzZ7WmYDK3ad12Vooo6vDecNTL5g9cOBiW1F+866fCLq2LU
         a2/J+/MiOsB6enAp+7tRwuhIbsjDqkcen5tz0J+pgNFYLkt59gCcRCeitveWwIvBKDGr
         hyi0Z+PKHxlUfU0psEQJQ7ZJIo22vlrmxJ0JC0z9SV/VBuO5ZeQEXOOLbvIuMkUReU8W
         d5/qEDkr/0KACvhFVIUnQJg8HUAwWA5lUJfYPCy8Engr12FPE96RboqG+r3V/g1IaBuu
         s1wAB9GBUCpTxizCGt8GZIHl5I/IGvHI4N7QKC2Ni7SoRA6/JBQCiLVggr62/DbXelhj
         MNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hm3bFKzihrL7uYqay8Ok08MgSH4jDluIxDXLSzrc4ME=;
        b=uSdxa4TYcCD6hnay0FSpCjtIanr4IiW5+HIsP67iUt0kEaUs/hgTfdqzXLohrOUt2P
         8ZdcRhtSEl4Y64zNGFaO4dfMzGlcVjWouAFELEfDHwIr2IPEsidn8tjKwIObR0X8pnwb
         7VDotl3AHtOoWWnJV2r2Ok6nvL7T5LkDDcYl7gu9wujD6cocokdw0OPryWOFq9N0OVIr
         KANiDlaYcmoXKT1eC8AWrLK6waP1b0JRp8TKrQWPaLxOd77DzSp9NvsyLYgXLcVrp5zx
         WmF6iaybNOIuV4KDU+6W3AO0NZRbww/vgcwHl0vBt8O/hawEdq/pVehTa6voQIOYC1l6
         EEWw==
X-Gm-Message-State: APzg51CMDTlKK3i9Fh4Vds2ILLAKUdtjbkbAAk/ar/NGBSIsNnBKi54K
        8IlrqltDRkq4AYz9X1xoPbto+j4XHb9DTR/sk3+GpQ==
X-Google-Smtp-Source: ANB0VdYmbdeZCtQAXaQyGznzlnktI72FuCcaqaU1VFNbbwJIY8tkKjd65a4a84zwFIy8Lk+evhcVqOuZqcleSyaTxHA=
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr4426803wmc.48.1537477272990;
 Thu, 20 Sep 2018 14:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <1537476292-28056-1-git-send-email-tedheadster@gmail.com>
In-Reply-To: <1537476292-28056-1-git-send-email-tedheadster@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 20 Sep 2018 14:01:00 -0700
Message-ID: <CALCETrX8J9-JG5kqppFLTZSnr0S=mGAmLqLcHzdtKmRNDXZ49w@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Enable cpuid instruction on Cyrix 6x86/6x86L processors
To:     Matthew Whitehead <tedheadster@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 1:45 PM Matthew Whitehead <tedheadster@gmail.com> wrote:
>
> On power up, the cpuid instruction is disabled on Cyrix 6x86 and 6x86L
> processors and it needs to be enabled. There is code to do this, but it
> does not work because it uses the broken {set,get}Cx86_old() macros.
>
> There are comments in processor-cyrix.h advising you to _not_ make calls
> using the deprecated macros in this style:
>
>   setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
>
> This is because it expands the macro into a non-functioning calling
> sequence. The new macros fix this problem, so we use them instead.
>
> We also need to forcibly enable X86_FEATURE_CPUID. This is because
> early_identify_cpu() does not know that the call to
> identify_cpu_without_cpuid() actually enables the cpuid instruction in the
> odd Cyrix case, and it turns X86_FEATURE_CPUID off after it has just been
> enabled on the processor.
>
> This was tested on actual Cyrix hardware.
>
> Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
> ---
>  arch/x86/kernel/cpu/cyrix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
> index 8949b7a..e603cc5 100644
> --- a/arch/x86/kernel/cpu/cyrix.c
> +++ b/arch/x86/kernel/cpu/cyrix.c
> @@ -437,10 +437,11 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
>                         /* enable MAPEN  */
>                         setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
>                         /* enable cpuid  */
> -                       setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
> +                       setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80);

Fine with me.

>                         /* disable MAPEN */
>                         setCx86(CX86_CCR3, ccr3);
>                         local_irq_restore(flags);
> +                       setup_force_cpu_cap(X86_FEATURE_CPUID);

I don't think this is right.  This called from here:

        /* cyrix could have cpuid enabled via c_identify()*/
        if (have_cpuid_p()) {
                cpu_detect(c);
                get_cpu_vendor(c);
                get_cpu_cap(c);
                get_cpu_address_sizes(c);
                setup_force_cpu_cap(X86_FEATURE_CPUID);

                if (this_cpu->c_early_init)
                        this_cpu->c_early_init(c);

                c->cpu_index = 0;
                filter_cpuid_features(c, false);

                if (this_cpu->c_bsp_init)
                        this_cpu->c_bsp_init(c);
        } else {
                identify_cpu_without_cpuid(c);  <-- here
                setup_clear_cpu_cap(X86_FEATURE_CPUID);
        }

and it won't do what it should do.  I would instead restructure the code:

if (!have_cpuid_p())
  identify_cpu_without_cpuid(c);

/* cyrix could have cpuid enabled via c_identify() */
if (have_cpuid_p()) {
  cpu_detect();
  ...
} else {
  setup_clear_cpu_cal(X86_FEATURE_CPUID);
}

and then re-test, of course, to make sure that the Cyrix
identification code actually works when it gets re-invoked with CPUID
on.

--Andy
