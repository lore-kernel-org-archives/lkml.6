Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9086C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE772082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOKTLlj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE772082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeJZDAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:00:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32779 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeJZDAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:00:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so9167652ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjvIOtQuYHpw8e+zEeJC3R3Q1gMj08i3dVP41KySk20=;
        b=JOKTLlj3Hcsc/UnjN3eGvSIxQNwXdwZsil9t2WGDWrNHxHqajeZF8P/Sn/PK3wpjOf
         2xL47D4dKM/an/jqaixuumzuEXtKz87bNxHR4RyMDvANuMnaJjagAorMRgdtZnu/qx23
         9w36IiIAnCGrN7+KbTN8z0fdTG5LeHeXAvUlJGT6fYizSj3U8x7i6Jxjzmyuypm1S3Ei
         4cSBKkAjl6A6xgUkFySP8cb/14/rjEz3aFkEJWau9aX7dYo1Hbbpujip5UajLkp2T229
         sQPkSRMOTlCF5KTh0hZvLbzgYj1yJIqK43Bhye77JDCgktPW/iSBmV6dCRPmh5iVKUMv
         dqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjvIOtQuYHpw8e+zEeJC3R3Q1gMj08i3dVP41KySk20=;
        b=HlHPf6Nr1vr58VMjGGE4H2foEPdMQGQaHD8sBUi2UytnMsWtLArc5xZEGnbDzKz8gk
         xDxykgaq8UYPxPq7n933Hl2G3JythQFeQzr1HUFRWsobbm/6GQv9R/FSlELUTDzJ/Cg6
         G/rhSwDeQh5pF0v6zxPfM0U7vq3P0e7CYhrc9Ij6hZUg+hHij+aiNLScSWj89EE+clVy
         E5XcBxFLgwGAekTb2c4YPVbzsSttdPA+strAUEnOaluoPXJ9uX7TzzZFqXCb5P23ZrfA
         ZNhQk7YxBt3eeNKT7aDUCX+o4hZSiSWtqUERrUw54Nct6kLNOIs517ltYSJDsv/JxfZG
         MzHQ==
X-Gm-Message-State: AGRZ1gLLGc/hmCSNiCDOp9D/9jNb6okw+dpMW2vUfkgAkmHi9om/WiDd
        9W5FBcaEFj6aHoB/w9gUmyA/hwRYeEL13GoFV4g=
X-Google-Smtp-Source: AJdET5cjTqPxonbNtoLbL5mWP0ZFll6m0vBlwup6x0NHjHxEPUcT5BK6qhqCBh0mrthyGa1VwmvllZT5PoORLzPlPms=
X-Received: by 2002:a2e:5b:: with SMTP id 88-v6mr215521lja.111.1540492013640;
 Thu, 25 Oct 2018 11:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181025180957.7900-1-f.fainelli@gmail.com>
In-Reply-To: <20181025180957.7900-1-f.fainelli@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 26 Oct 2018 00:00:09 +0530
Message-ID: <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS disabled
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ebiederm@xmission.com, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:40 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Some software such as perf makes unconditional use of the special
> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> enabled in the kernel.
>
> Facilitate the debugging of such situations by printing a debug message
> to the kernel log showing the task name and the faulting address.
>
> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/fault.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f4ea4c62c613..f17471fbc1c4 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>                 show_regs(regs);
>         }
>  #endif
> +#ifndef CONFIG_KUSER_HELPERS

Just have one doubt, if the condition is "#ifdef CONFIG_KUSER_HELPER"
as commit message suggests the scenario is valid when CONFIG_KUSER_HELPER
is enabled ? No ?

> +       if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
> +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
> +                      tsk->comm, addr);
> +#endif
>
>         tsk->thread.address = addr;
>         tsk->thread.error_code = fsr;
> --
> 2.17.1
>
