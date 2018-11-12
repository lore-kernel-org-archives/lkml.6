Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85381C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411E0214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpOMmCUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411E0214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbeKLPQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:16:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42791 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeKLPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:16:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id u5-v6so2549136wrn.9;
        Sun, 11 Nov 2018 21:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ygI1nEibK6roHhTArsv9QZqnNQ2KbKNxxMQb9ZwoOiE=;
        b=rpOMmCUA9wch0oyn3o6tRb4iJnMbAc+f97a8qbQ/AtL/0ihZrGWA+BYt93Ity2EVVD
         JkzIQWTRPhOdkeGauXHxr4n2z3PYK7ELBn7y5JzUhik/2in1VGjEf/xYNpI3UR+eS5RL
         Zj7Hk2kmmprCuRDf4ZEwr9l7wHU4gDo/GEuIn1rsMD8QtWAXdSvB2oY1TyBiHy+40rEI
         flsJu9UF2lo9ur64zoXpqT0jKCcimh09nldoo40VqJ57G4nSHJ4oi3HgawjY3l4fPr9E
         I8k4jjkouye19NO9Fd6k0a+dv0FfENFFy4spwlgwhQpP/ZfoyZce2305T9V75pcZnAya
         6uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ygI1nEibK6roHhTArsv9QZqnNQ2KbKNxxMQb9ZwoOiE=;
        b=c8YMku+64dihJCb1f/gJhcljrQfWCg9uqXJPt0tITZcfYOeRzdfJWaVWpblxGshaRf
         okPcNrjyfEsU1psrCbiWW/DzrKSsk2zybwL3XhKBh8MqAgjOdtSX3WDpRhVXBGtg4zle
         Uczh9qwbeb/wpAKfxnbQLet+Cn2nmxiIJXl+bgGCvgX9XRtiLg/TNi2fIj5RTzdilCwV
         fPKINVYKEhtlm5B46OOYghzuLH08+Pe3Xl6UvDWXswDDMrgEBKTTShGyOdFz8CA3ptkz
         QVQgtqtdJ6mqDLHujVXmLTN38lC41taxEOlOlGXH1iXd85JCp/FqniaJegy8J43r/aAu
         Hgcg==
X-Gm-Message-State: AGRZ1gJTjD5rel9PNZZcjsu3FfisvJD7+3kJ5yfSM+xSQm3pDlYGr+8H
        W/As8lNa4McUXz4SMRpZ39g=
X-Google-Smtp-Source: AJdET5c82CRMrk6mbya9g9Lh67Ys39+j0Pi/kTqkePlMexrFs3cKB6DkID+zEOeZ+DNRLD0PbB+ewA==
X-Received: by 2002:adf:ff91:: with SMTP id j17-v6mr14661707wrr.214.1542000296429;
        Sun, 11 Nov 2018 21:24:56 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t13-v6sm9497700wrn.22.2018.11.11.21.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:24:55 -0800 (PST)
Date:   Mon, 12 Nov 2018 06:24:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     hpa@zytor.com, tglx@linutronix.de, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, matz@suse.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:ras/core] x86/mce: Fix -Wmissing-prototypes warnings
Message-ID: <20181112052453.GA126795@gmail.com>
References: <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
 <tip-d813dfb28641306f66cf1e2c3586f39ab4f84b27@git.kernel.org>
 <20181110141647.GA20073@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181110141647.GA20073@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@suse.de> wrote:

> Fix an actual bug too which the warning triggered:
> 
>   arch/x86/kernel/cpu/mcheck/therm_throt.c:395:39: error: conflicting \
>   types for ‘smp_thermal_interrupt’
>    asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
>                                          ^~~~~~~~~~~~~~~~~~~~~

>   In file included from arch/x86/kernel/cpu/mcheck/therm_throt.c:29:
>   ./arch/x86/include/asm/traps.h:107:17: note: previous declaration of \
> 	  ‘smp_thermal_interrupt’ was here
>    asmlinkage void smp_thermal_interrupt(void);
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Yi Wang <wang.yi59@zte.com.cn>
> Cc: Michael Matz <matz@suse.de>
> Cc: x86@kernel.org
> Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de
> ---
>  arch/x86/include/asm/traps.h             | 6 +++---
>  arch/x86/kernel/cpu/mcheck/mce_amd.c     | 5 +++--
>  arch/x86/kernel/cpu/mcheck/therm_throt.c | 1 +
>  arch/x86/kernel/cpu/mcheck/threshold.c   | 3 ++-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 3de69330e6c5..9ea54a764a8e 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -104,9 +104,9 @@ extern int panic_on_unrecovered_nmi;
>  
>  void math_emulate(struct math_emu_info *);
>  #ifndef CONFIG_X86_32
> -asmlinkage void smp_thermal_interrupt(void);
> -asmlinkage void smp_threshold_interrupt(void);
> -asmlinkage void smp_deferred_error_interrupt(void);
> +asmlinkage void smp_thermal_interrupt(struct pt_regs *);
> +asmlinkage void smp_threshold_interrupt(struct pt_regs *);
> +asmlinkage void smp_deferred_error_interrupt(struct pt_regs *);

Nit: please use full declarations in prototypes, i.e. 'struct pt_regs 
*regs' or so. Much of traps.h does this wrong so I guess this should be a 
separate cleanup patch.

> +asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(struct pt_regs *r)

> +asmlinkage __visible void __irq_entry smp_threshold_interrupt(struct pt_regs *r)

Please use the canonical name, i.e. 'regs'.

Thanks,

	Ingo
