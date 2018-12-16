Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96A0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7181A217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqiU3yfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeLPOr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:47:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37809 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:47:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so4909649plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=f18dgatpB3wRJ65lneIR+5EuDCU07Om7HwwqR4YA+ls=;
        b=cqiU3yfNqmAvzKBJvFBfA66XUcEpIPRHvlhviGtjCV06Z4L0El1su98WIquxjOw0Kr
         kfGbU/cMQ/9L30yPwZxYvb0eiZxWgoslhQJcqCvGnkGLBFvKg3Godp96Wt45zkoZNJST
         RGiNFesPxD2hNzIBuJDLKl0DzxVroCbofn2VGeVgdtAkih3i849m8T5/FU+U08ogLlS/
         62XrGOaHH86b//f1rF/HIARjKkkHquSWZR+koKIUNmEJwbXZsJ+tF4e48Bl6JtMPNyta
         i3kwLY/N4i9/aUwMQNAMipJVQ52PQa52cJcRF5sJU0fC2InV59sFKGXZjmnyanApvATu
         ThWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=f18dgatpB3wRJ65lneIR+5EuDCU07Om7HwwqR4YA+ls=;
        b=ivy/K9EiOrb0fOXT6REz5ksOwNVUTRRT20bctGOCByrVfSHXyD7P/gQXMC1ZNuF62T
         JR8TqAt5OGBtPSB44B/QppHqoPJE7FM2fJin7wB+fU/KBA7M+dAzkcnT+KgYTAv0T0vF
         tebGmWOrSbMfzpor+nQD/8+t4gEpwe27u3q909sTooUqTdkYpTqFdyT4cHup8YQYO0p9
         j1GRTg41JK5Oa6jqWd9QCzSluWDYVPW2miyGJjc3vJhgJrzYahxld1jo86j3jUHVbVw/
         B7CgKeByP4ppt35yKqt4qNx0P55gLa/ZI11Uh9lIZxhxmhqH+RL89qIQj7wQk/fsznGW
         8/9w==
X-Gm-Message-State: AA+aEWZjD8pluZQynWhE+xvXHxWl4rr9TQuH24fdogx+fhUOPDg07Pkf
        chBsXR0gkXshQ21UDdKtADo=
X-Google-Smtp-Source: AFSGD/WxVK81bpJmJRjhJqrrbXnz2HUfv725wRvVoU5hWnnjPxyiwS+/miGMDU+tmRAtc+hbJuDL4g==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr9305980plo.123.1544971676827;
        Sun, 16 Dec 2018 06:47:56 -0800 (PST)
Received: from localhost.localdomain (220-137-60-156.dynamic-ip.hinet.net. [220.137.60.156])
        by smtp.gmail.com with ESMTPSA id f6sm14059753pfg.188.2018.12.16.06.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:47:56 -0800 (PST)
From:   Jian-Lin Chen <lecopzer@gmail.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
Date:   Sun, 16 Dec 2018 22:47:15 +0800
Message-Id: <20181216144715.7486-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Lin Chen <lecopzer.chen@mediatek.com>


On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>  static inline void arch_local_irq_enable(void)
>  {
> -       asm volatile(
> -               "msr    daifclr, #2             // arch_local_irq_enable"
> -               :
> +       unsigned long unmasked = GIC_PRIO_IRQON;
> +

Should we need a WARN_ON() to check if the daif_I bit is masked, or
explicitly unmasked I bit here?

If I bit was masked and someone calls arch_local_irq_enable(), they still
couldn't recieve any interrupt.


> +       asm volatile(ALTERNATIVE(
> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
> +               "nop",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +               "dsb    sy",
> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (unmasked)
>                 : "memory");
>  }
>
>  static inline void arch_local_irq_disable(void)
>  {
> -       asm volatile(
> -               "msr    daifset, #2             // arch_local_irq_disable"
> -               :
> +       unsigned long masked = GIC_PRIO_IRQOFF;
> +
> +       asm volatile(ALTERNATIVE(
> +               "msr    daifset, #2             // arch_local_irq_disable",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",

May be a "dsb sy" here?

> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (masked)
>                 : "memory");
>  }

