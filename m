Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B843FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6712721A2A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 14:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRGZ4xDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6712721A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeHKQoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:44:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56065 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeHKQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:44:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so4557453wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ibE1WvLI6B4rksG3ZpPAf7+Ti4A9/6OpZcYa/kThsrQ=;
        b=vRGZ4xDSVRUbN+nFrfeDVjlaBQM3qXQRZTlNdEV21osS5jlFEI3LDNpEL4j1WccyEy
         Ziph9ByiXQZ78plPop4nbkFFeXuz9Y2bz5taHYCPOo6rsofWBugIyp3M1WEHz4dvED1S
         W0fEgW/EXNfIIJ5dGHLTmWgnooUu/m9rmZSfbt33BxkGXFKBGREWRlprdpOZbhGVPrxN
         o7EoXZzZC4pVa+9HYdXg5JiULeR3ZVhKmFEQzZcr0MLQC6qB+fNCmEpvE/cFadj8Tv9h
         RVXezkFciXor7e3awoFRneqUdUB0HxvM7viQ3CJX1+kaBogEVwevvUCUn+JKhLmHIkEx
         VSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibE1WvLI6B4rksG3ZpPAf7+Ti4A9/6OpZcYa/kThsrQ=;
        b=BLbA93xG0WqJl4GXKq36XMN3+nOUBpFJFtA9kioisD0FY2iR62ofHen0v91tzidRPx
         /TL/rdzoCKq9qWDLx/PNEP4Dhre1hD/jqJrERrvY7lskP99dc71opmwkXMdC2W+d2dhA
         rbpfRAgcRgYclmcQnPC5PFXUfot/nIPBTQ6c71XPQ5v6WhTXVzNZJ8Tog9GWnv51V6C+
         tOkQY2NpDbuFiz7K0664zRmv6BuPc+KUfO6SuNihNoQQi+W31EWzRBGUdu5PBm528t29
         EejhJY/d8pDvXfmkUXvXQ6vjAiJ2adiAWRzYD5PDNPXVvLgNMMl4GMBjBdlgYIg2GtdP
         TODQ==
X-Gm-Message-State: AOUpUlG8KsFKpHutBj/rau8MP3NIkYjSamrLGPzRu9axE4jOMnsh70hb
        NsqjcYbObjdmV+WL41PN/u0=
X-Google-Smtp-Source: AA+uWPwGmzpBoDi9VkRCk6ckwdeFe2HTBZX6120h31+Sd7azmLoi73fHCG7FXHvHG2J7zRCPGWF22g==
X-Received: by 2002:a1c:ea9c:: with SMTP id g28-v6mr3983089wmi.65.1533996583146;
        Sat, 11 Aug 2018 07:09:43 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t198-v6sm5070455wmd.16.2018.08.11.07.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 07:09:42 -0700 (PDT)
Subject: Re: [PATCH] ARM: spectre-v2: Try to set IBE bit for Cortex-A15 and
 Brahma-B15
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Luca Scalabrino <luca.scalabrino@arm.com>, marc.zyngier@arm.com,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20180607225804.28771-1-f.fainelli@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <e4db9ef9-398f-114a-b5a8-8d8de0b0f85e@gmail.com>
Date:   Sat, 11 Aug 2018 15:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607225804.28771-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 12:58 AM, Florian Fainelli wrote:
> Per the ARM reference manual for the Cortex-A15, The ACTLR:
> 
>  Is a read/write register.
> 
>  Common to the Secure and Non-secure states.
> 
>  Is only accessible from PL1 or higher, with access rights that depend
>  on the mode:
> 
>     * Read/write in Secure PL1 modes.
> 
>     * Read-only and write-ignored in Non-secure PL1 and PL2 modes
>       if NSACR.NS_SMP is 0.
> 
>     * Read/write in Non-secure PL1 and PL2 modes if NSACR.NS_SMP
>       is 1. In this case, all bits are write-ignored except for the SMP bit.
> 
> We can attempt to set this bit from within the kernel, which helps
> avoiding firmware side modifications to set the IBE bit when that is
> impractical. We do this within __v7_ca15mp_setup and __v7_b15mp_setup
> because by then we already took those labels because the processors we
> run on do match.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I believe this would help on selected R-Car Gen2 SoCs which have CA15
cores. Those cores are released from reset by Linux directly and jump to
the reset vector set up by Linux in Secure mode.

I was looking for a generic solution after discussing how to mitigate
the spectrev2 on such SoCs with Catalin on IRC and this seems to be one
option. There was also a suggestion that Russell is working on some sort
of generic solution too. Can you comment on that please ?

> ---
>  arch/arm/mm/proc-v7.S | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 6fe52819e014..a21cf3729efa 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -284,10 +284,16 @@ __v7_cr8mp_setup:
>  	b	1f
>  __v7_ca7mp_setup:
>  __v7_ca12mp_setup:
> +	b	2f
>  __v7_ca15mp_setup:
>  __v7_b15mp_setup:
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	mrc	p15, 0, r0, c1, c0, 1
> +	orr	r0, r0, #1			@ Enable IBE bit
> +	mcr	p15, 0, r0, c1, c0, 1
> +#endif
>  __v7_ca17mp_setup:
> -	mov	r10, #0
> +2:	mov	r10, #0
>  1:	adr	r0, __v7_setup_stack_ptr
>  	ldr	r12, [r0]
>  	add	r12, r12, r0			@ the local stack
> 


-- 
Best regards,
Marek Vasut
